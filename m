Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbTAUJMa>; Tue, 21 Jan 2003 04:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTAUJMa>; Tue, 21 Jan 2003 04:12:30 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:59280
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266809AbTAUJMT>; Tue, 21 Jan 2003 04:12:19 -0500
Date: Tue, 21 Jan 2003 04:21:02 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Alan <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] smp_call_function_mask
In-Reply-To: <Pine.LNX.4.44.0301210304210.2653-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0301210318540.2653-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Zwane Mwaikambo wrote:

> On Tue, 21 Jan 2003, Manfred Spraul wrote:
> 
> > from 2.5.52, <asm-i386/atomic.h>
> >     #define atomic_read(v)          ((v)->counter)
> > AFAIK atomic_read never contained locked bus cycles.
> > 
> > Btw, Zwane, what about removing non_atomic from the prototype?
> 
> The funny thing is, there are about 3 different versions of 
> smp_call_function and removing nonatomic would reduce the argument count 

I was actually thinking about smp_call_function_mask type functions.

> (there are some architectures which use 'retry' in nonatomic's place) and 
> i'm a bit wary of making other archs bend over for i386 these days. 
> Perhaps renaming it to __unused or something similarly obvious.

I renamed the function to smp_call_function_on_cpu like its Alpha 
counterpart, we could also reuse it to deliver to all CPUs but it might be 
faster to just send one broadcast message in that case on some 
architectures.

Something like this?

Index: linux-2.5.59/include/linux/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/linux/smp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.h
--- linux-2.5.59/include/linux/smp.h	17 Jan 2003 11:15:51 -0000	1.1.1.1
+++ linux-2.5.59/include/linux/smp.h	21 Jan 2003 08:13:43 -0000
@@ -54,6 +54,12 @@
 			      int retry, int wait);
 
 /*
+ * Call a function on a single or group of processors
+ */
+extern int smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry,
+                              int wait, unsigned long mask);
+
+/*
  * True once the per process idle is forked
  */
 extern int smp_threads_ready;
@@ -96,6 +102,7 @@
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
 #define smp_call_function(func,info,retry,wait)	({ 0; })
+#define smp_call_function_on_cpu(func,info,retry,wait) ({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define cpu_online_map				1
Index: linux-2.5.59/arch/i386/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/i386/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/i386/kernel/smp.c	17 Jan 2003 11:14:42 -0000	1.1.1.1
+++ linux-2.5.59/arch/i386/kernel/smp.c	21 Jan 2003 08:26:58 -0000
@@ -545,6 +545,63 @@
 	return 0;
 }
 
+/*
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @retry: currently unused
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry,
+			int wait, unsigned long mask)
+{
+	struct call_data_struct data;
+	int num_cpus = hweight32(mask), cpu;
+
+	if (num_cpus == 0)
+		return -EINVAL;
+
+	cpu = get_cpu();
+	if ((1UL << cpu) & mask) {
+		put_cpu_no_resched();
+		return -EINVAL;
+	}
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	spin_lock(&call_lock);
+	call_data = &data;
+	wmb();
+
+	/* Send a message to the CPUs in the mask and wait for them to respond */
+	send_IPI_mask_sequence(mask, CALL_FUNCTION_VECTOR);
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != num_cpus)
+		cpu_relax();
+
+	if (wait)
+		while (atomic_read(&data.finished) != num_cpus)
+			cpu_relax();
+	spin_unlock(&call_lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
 static void stop_this_cpu (void * dummy)
 {
 	/*
Index: linux-2.5.59/arch/ia64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/ia64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/ia64/kernel/smp.c	17 Jan 2003 11:15:16 -0000	1.1.1.1
+++ linux-2.5.59/arch/ia64/kernel/smp.c	21 Jan 2003 08:30:41 -0000
@@ -230,27 +230,32 @@
 }
 
 /*
- * Run a function on another CPU
- *  <func>	The function to run. This must be fast and non-blocking.
- *  <info>	An arbitrary pointer to pass to the function.
- *  <nonatomic>	Currently unused.
- *  <wait>	If true, wait until function has completed on other CPUs.
- *  [RETURNS]   0 on success, else a negative status code.
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
  *
- * Does not return until the remote CPU is nearly ready to execute <func>
- * or is or has executed.
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @retry: currently unused.
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
  */
 
 int
-smp_call_function_single (int cpuid, void (*func) (void *info), void *info, int nonatomic,
-			  int wait)
+smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry,
+			  int wait, unsigned long mask)
 {
 	struct call_data_struct data;
-	int cpus = 1;
+	int num_cpus = hweight64(mask), cpu, i;
 
-	if (cpuid == smp_processor_id()) {
-		printk("%s: trying to call self\n", __FUNCTION__);
-		return -EBUSY;
+	cpu = get_cpu();
+	if (((1UL << cpu) & mask) || num_cpus == 0) {
+		put_cpu_no_resched();
+		return -EINVAL;
 	}
 
 	data.func = func;
@@ -264,19 +269,29 @@
 
 	call_data = &data;
 	mb();	/* ensure store to call_data precedes setting of IPI_CALL_FUNC */
-  	send_IPI_single(cpuid, IPI_CALL_FUNC);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << i) & mask))
+			send_IPI_single(i, IPI_CALL_FUNC);
+	}
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
+	while (atomic_read(&data.started) != num_cpus)
 		barrier();
 
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
+		while (atomic_read(&data.finished) != num_cpus)
 			barrier();
 	call_data = NULL;
 
 	spin_unlock_bh(&call_lock);
+	put_cpu_no_resched();
 	return 0;
+}
+
+int smp_call_function_single (int cpuid, void (*func) (void *info), void *info,
+			      int nonatomic, int wait)
+{
+	return smp_call_function_on_cpu(func, info, nonatomic, wait, 1UL << cpuid);
 }
 
 /*
Index: linux-2.5.59/arch/mips/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/mips/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/mips/kernel/smp.c	17 Jan 2003 11:14:52 -0000	1.1.1.1
+++ linux-2.5.59/arch/mips/kernel/smp.c	21 Jan 2003 08:45:45 -0000
@@ -224,6 +224,54 @@
 	return 0;
 }
 
+/*
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @retry: currently unused
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry, 
+			      int wait, unsigned long mask)
+{
+	int cpu, i, num_cpus = hweight32(mask);
+
+	cpu = get_cpu();
+	if (((1UL << cpu) & mask) || num_cpus == 0) {
+		put_cpu_no_resched();
+		return -EINVAL;
+	}
+
+	spin_lock(&smp_fn_call.lock);
+
+	atomic_set(&smp_fn_call.finished, 0);
+	smp_fn_call.fn = func;
+	smp_fn_call.data = info;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << i) & mask))
+			/* Call the board specific routine */
+			core_call_function(i);
+	}
+
+	if (wait) {
+		while(atomic_read(&smp_fn_call.finished) != num_cpus) {}
+	}
+
+	spin_unlock(&smp_fn_call.lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
 void synchronize_irq(void)
 {
 	panic("synchronize_irq");
Index: linux-2.5.59/arch/parisc/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/parisc/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/parisc/kernel/smp.c	17 Jan 2003 11:15:15 -0000	1.1.1.1
+++ linux-2.5.59/arch/parisc/kernel/smp.c	21 Jan 2003 09:15:43 -0000
@@ -371,7 +371,88 @@
 	return 0;
 }
 
+/*
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @retry: If true keep retrying till ready
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ */
 
+int
+smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry, int wait,
+			  unsigned long mask)
+{
+	struct smp_call_struct data;
+	long timeout;
+	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	int num_cpus = hweight64(mask), cpu, i, ret;
+	
+	cpu = get_cpu();
+	if (((1UL << cpu) & mask) || num_cpus == 0) {
+		ret = -EINVAL
+		goto out;
+	}
+
+	data.func = func;
+	data.info = info;
+	data.wait = wait;
+	atomic_set(&data.unstarted_count, num_cpus);
+	atomic_set(&data.unfinished_count, num_cpus);
+
+	if (retry) {
+		spin_lock (&lock);
+		while (smp_call_function_data != 0)
+			barrier();
+	}
+	else {
+		spin_lock (&lock);
+		if (smp_call_function_data) {
+			spin_unlock (&lock);
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+
+	smp_call_function_data = &data;
+	spin_unlock (&lock);
+	
+	/*  Send a message to the target CPUs and wait */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && (mask & (1UL << i)))
+			send_IPI_single(i, IPI_CALL_FUNC);
+	}
+
+	/*  Wait for response  */
+	timeout = jiffies + HZ;
+	while ( (atomic_read (&data.unstarted_count) > 0) &&
+		time_before (jiffies, timeout) )
+		barrier ();
+
+	/* We either got one or timed out. Release the lock */
+
+	mb();
+	smp_call_function_data = NULL;
+	if (atomic_read (&data.unstarted_count) > 0) {
+		printk(KERN_CRIT "SMP CALL FUNCTION TIMED OUT! (cpu=%d)\n",
+		      cpu);
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	while (wait && atomic_read (&data.unfinished_count) > 0)
+			barrier ();
+	ret = 0;
+out:
+	put_cpu_no_resched();
+	return ret;
+}
 
 /*
  *	Setup routine for controlling SMP activation
Index: linux-2.5.59/arch/ppc/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/ppc/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/ppc/kernel/smp.c	17 Jan 2003 11:14:47 -0000	1.1.1.1
+++ linux-2.5.59/arch/ppc/kernel/smp.c	21 Jan 2003 08:46:48 -0000
@@ -266,6 +266,81 @@
 	return ret;
 }
 
+/*
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @retry: currently unused
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+static int smp_call_function_on_cpu(void (*func) (void *info), void *info,
+			       int retry, int wait, unsigned long mask)
+{
+	struct call_data_struct data;
+	int ret = -1;
+	int timeout;
+	int i, cpu, num_cpus = hweight32(mask);
+
+	if (num_cpus == 0 || )
+		return -EINVAL;
+
+	cpu = get_cpu();
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	spin_lock(&call_lock);
+	call_data = &data;
+	/* Send a message to all other CPUs and wait for them to respond */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << i) & mask))
+			smp_message_pass(i, PPC_MSG_CALL_FUNCTION, 0, 0);
+	}
+
+	/* Wait for response */
+	timeout = 1000000;
+	while (atomic_read(&data.started) != num_cpus) {
+		if (--timeout == 0) {
+			printk("smp_call_function on cpu %d: other cpus not responding (%d)\n",
+			       cpu, atomic_read(&data.started));
+			goto out;
+		}
+		barrier();
+		udelay(1);
+	}
+
+	if (wait) {
+		timeout = 1000000;
+		while (atomic_read(&data.finished) != num_cpus) {
+			if (--timeout == 0) {
+				printk("smp_call_function on cpu %d: other cpus not finishing (%d/%d)\n",
+				       cpu, atomic_read(&data.finished), atomic_read(&data.started));
+				goto out;
+			}
+			barrier();
+			udelay(1);
+		}
+	}
+	ret = 0;
+
+ out:
+	spin_unlock(&call_lock);
+	pu_cpu_no_resched();
+	return ret;
+}
+
 void smp_call_function_interrupt(void)
 {
 	void (*func) (void *info) = call_data->func;
Index: linux-2.5.59/arch/ppc64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/ppc64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/ppc64/kernel/smp.c	17 Jan 2003 11:14:53 -0000	1.1.1.1
+++ linux-2.5.59/arch/ppc64/kernel/smp.c	21 Jan 2003 08:52:29 -0000
@@ -528,6 +528,94 @@
 	return ret;
 }
 
+/*
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @retry: currently unused
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry,
+		       int wait, unsigned long mask)
+{ 
+	struct call_data_struct data;
+	int ret = -1, cpu, i, num_cpus = hweight64(mask);
+	unsigned long timeout;
+
+	if (num_cpus == 0)
+		return 0; /* -EINVAL */
+
+	cpu = get_cpu();
+	if ((1UL << cpu) & mask) {
+		put_cpu_no_resched();
+		return 0; /* -EINVAL */
+	}
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	spin_lock(&call_lock);
+	call_data = &data;
+	wmb();
+	/* Send a message to all other CPUs and wait for them to respond */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << i) & mask))
+			smp_message_pass(i, PPC_MSG_CALL_FUNCTION, 0, 0);
+	}
+
+	/* Wait for response */
+	timeout = SMP_CALL_TIMEOUT;
+	while (atomic_read(&data.started) != num_cpus) {
+		HMT_low();
+		if (--timeout == 0) {
+			if (debugger)
+				debugger(0);
+			printk("smp_call_function on cpu %d: other cpus not "
+			       "responding (%d)\n", cpu,
+			       atomic_read(&data.started));
+			goto out;
+		}
+	}
+
+	if (wait) {
+		timeout = SMP_CALL_TIMEOUT;
+		while (atomic_read(&data.finished) != num_cpus) {
+			HMT_low();
+			if (--timeout == 0) {
+				if (debugger)
+					debugger(0);
+				printk("smp_call_function on cpu %d: other "
+				       "cpus not finishing (%d/%d)\n",
+				       cpu,
+				       atomic_read(&data.finished),
+				       atomic_read(&data.started));
+				goto out;
+			}
+		}
+	}
+
+	ret = 0;
+
+out:
+	HMT_medium();
+	spin_unlock(&call_lock);
+	put_cpu_no_resched();
+	return ret;
+}
+
 void smp_call_function_interrupt(void)
 {
 	void (*func) (void *info) = call_data->func;
Index: linux-2.5.59/arch/s390/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/s390/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/s390/kernel/smp.c	17 Jan 2003 11:15:18 -0000	1.1.1.1
+++ linux-2.5.59/arch/s390/kernel/smp.c	21 Jan 2003 09:05:41 -0000
@@ -148,6 +148,65 @@
 	return 0;
 }
 
+/*
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @retry: currently unused
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry,
+			int wait, unsigned long mask)
+{
+	struct call_data_struct data;
+	int i, cpu, num_cpus = hweight32(mask);
+
+	/* FIXME: get cpu lock -hc */
+	if (num_cpus == 0)
+		return 0;
+
+	cpu = get_cpu();
+	if ((1UL << cpu) & mask) {
+		put_cpu_no_resched();
+		return 0;
+	}
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	spin_lock(&call_lock);
+	call_data = &data;
+	/* Send a message to all other CPUs and wait for them to respond */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << cpu) && mask))
+			smp_ext_bitcall(i, ec_call_function);
+	}
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != num_cpus)
+		barrier();
+
+	if (wait)
+		while (atomic_read(&data.finished) != num_cpus)
+			barrier();
+	spin_unlock(&call_lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
 static inline void do_send_stop(void)
 {
         u32 dummy;
Index: linux-2.5.59/arch/sparc64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/sparc64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/sparc64/kernel/smp.c	17 Jan 2003 11:14:42 -0000	1.1.1.1
+++ linux-2.5.59/arch/sparc64/kernel/smp.c	21 Jan 2003 08:27:21 -0000
@@ -534,6 +534,68 @@
 	return 0;
 }
 
+/*
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @retry: currently unused
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+int smp_call_function_on_cpu(void (*func)(void *info), void *info,
+		      int retry, int wait, unsigned long mask)
+{
+	struct call_data_struct data;
+	int num_cpus = hweight32(mask), cpu;
+	long timeout;
+
+	cpu = get_cpu();
+	if (((1UL << cpu) & mask) || num_cpus == 0)
+		goto out;
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.finished, 0);
+	data.wait = wait;
+
+	spin_lock(&call_lock);
+
+	call_data = &data;
+
+	smp_cross_call_masked(&xcall_call_function, 0, 0, 0, mask);
+
+	/* 
+	 * Wait for target cpus to complete function or at
+	 * least snap the call data.
+	 */
+	timeout = 1000000;
+	while (atomic_read(&data.finished) != num_cpus) {
+		if (--timeout <= 0)
+			goto out_timeout;
+		barrier();
+		udelay(1);
+	}
+
+	spin_unlock(&call_lock);
+	goto out;
+
+out_timeout:
+	spin_unlock(&call_lock);
+	printk("XCALL: Remote cpus not responding, ncpus=%d finished=%d\n",
+	       num_cpus, atomic_read(&data.finished));
+out:
+	put_cpu_no_resched();
+	return 0;
+}
+
 void smp_call_function_client(int irq, struct pt_regs *regs)
 {
 	void (*func) (void *info) = call_data->func;
Index: linux-2.5.59/arch/um/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/um/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/um/kernel/smp.c	17 Jan 2003 11:14:54 -0000	1.1.1.1
+++ linux-2.5.59/arch/um/kernel/smp.c	21 Jan 2003 09:14:39 -0000
@@ -254,6 +254,42 @@
 	atomic_inc(&scf_finished);
 }
 
+int smp_call_function_on_cpu(void (*_func)(void *info), void *_info, int retry, 
+		      int wait, unsigned long mask)
+{
+	int i, cpu, num_cpus = hweight32(mask);
+
+	if (num_cpus == 0)
+		return 0;
+
+	cpu = get_cpu();
+	if ((1UL << cpu) && mask) {
+		put_cpu_no_resched();
+		return 0;
+	}
+	
+	spin_lock_bh(&call_lock);
+	atomic_set(&scf_started, 0);
+	atomic_set(&scf_finished, 0);
+	func = _func;
+	info = _info;
+
+	for (i=0;i<NR_CPUS;i++)
+		if(cpu_online(i) && ((1UL << i) & mask))
+			write(cpu_data[i].ipi_pipe[1], "C", 1);
+
+	while (atomic_read(&scf_started) != num_cpus)
+		barrier();
+
+	if (wait)
+		while (atomic_read(&scf_finished) != num_cpus)
+			barrier();
+
+	spin_unlock_bh(&call_lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
 int smp_call_function(void (*_func)(void *info), void *_info, int nonatomic, 
 		      int wait)
 {
Index: linux-2.5.59/arch/x86_64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/x86_64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/x86_64/kernel/smp.c	17 Jan 2003 11:14:53 -0000	1.1.1.1
+++ linux-2.5.59/arch/x86_64/kernel/smp.c	21 Jan 2003 08:58:31 -0000
@@ -431,6 +431,63 @@
 	return 0;
 }
 
+/*
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @retry: currently unused
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry,
+			int wait, unsigned long mask)
+{
+	struct call_data_struct data;
+	int i, cpu, num_cpus = hweight64(mask);
+
+	if (num_cpus == 0)
+		return 0;
+
+	cpu = get_cpu();
+	if ((1UL << cpu) & mask) {
+		put_cpu_no_resched();
+		return 0;
+	}
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	spin_lock(&call_lock);
+	call_data = &data;
+	wmb();
+
+	/* Send a message to all other CPUs and wait for them to respond */
+	send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != num_cpus)
+		barrier();
+
+	if (wait)
+		while (atomic_read(&data.finished) != num_cpus)
+			barrier();
+	spin_unlock(&call_lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
 static void stop_this_cpu (void * dummy)
 {
 	/*
-- 
function.linuxpower.ca

