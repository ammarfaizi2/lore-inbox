Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315378AbSEGH1T>; Tue, 7 May 2002 03:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSEGH1T>; Tue, 7 May 2002 03:27:19 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54151 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315378AbSEGH1O>; Tue, 7 May 2002 03:27:14 -0400
Date: Tue, 7 May 2002 13:00:19 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] smp_call_function change
Message-ID: <20020507130019.A24402@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My earlier patch fixed only i386. As per Dave Miller's suggestion, 
I have fixed smp_call_function for other smp architectures too.

Description
-----------
Going by the documentation and use of _bh version of spin_lock(),
smp_call_function() is allowed to be called from BH context,
We can run into a deadlock with some locks if we do so.
This because reader-writer locks can sometimes be used optimally
by not disabling irqs while taking the reader side if only the
reader side of the lock is taken from irq context.

      CPU #0                                CPU #1

      read_lock(&tasklist_lock)
                                       write_lock_irq(&tasklist_lock)
                                       [spins with interrupt disabled]
      [Interrupted by BH]
      smp_call_function() for BH
           handler
                                       [ doesn't take the IPI]

So, cpu #1 doesn't take the IPI and cpu #0 spinwaits
for the IPI handler to start, resulting in a deadlock.

The last time I looked, I couldn't see smp_call_function() being
called from BH context anywhere. So, there is no immediate problem.
However it seems right to correct the documentation and also not
disable BH while taking the call lock since it isn't necessary.
This patch does exactly that.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

smp_call_func-2.5.14-1.patch
----------------------------

diff -urN linux-2.5.14-base/arch/alpha/kernel/smp.c linux-2.5.14-smp_call_func/arch/alpha/kernel/smp.c
--- linux-2.5.14-base/arch/alpha/kernel/smp.c	Mon May  6 09:07:58 2002
+++ linux-2.5.14-smp_call_func/arch/alpha/kernel/smp.c	Tue May  7 12:30:04 2002
@@ -871,6 +871,8 @@
  *
  * Does not return until remote CPUs are nearly ready to execute <func>
  * or are or have executed.
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
  */
 
 int
diff -urN linux-2.5.14-base/arch/i386/kernel/smp.c linux-2.5.14-smp_call_func/arch/i386/kernel/smp.c
--- linux-2.5.14-base/arch/i386/kernel/smp.c	Mon May  6 09:07:54 2002
+++ linux-2.5.14-smp_call_func/arch/i386/kernel/smp.c	Tue May  7 12:28:53 2002
@@ -540,7 +540,7 @@
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
  *
  * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler, you may call it from a bottom half handler.
+ * hardware interrupt handler or from a bottom half handler.
  */
 {
 	struct call_data_struct data;
@@ -556,7 +556,7 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 	call_data = &data;
 	wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
@@ -569,7 +569,7 @@
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			barrier();
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 
 	return 0;
 }
diff -urN linux-2.5.14-base/arch/ia64/kernel/smp.c linux-2.5.14-smp_call_func/arch/ia64/kernel/smp.c
--- linux-2.5.14-base/arch/ia64/kernel/smp.c	Mon May  6 09:08:02 2002
+++ linux-2.5.14-smp_call_func/arch/ia64/kernel/smp.c	Tue May  7 12:31:06 2002
@@ -283,8 +283,8 @@
  * Does not return until remote CPUs are nearly ready to execute <func> or are or have
  * executed.
  *
- * You must not call this function with disabled interrupts or from a hardware interrupt
- * handler, you may call it from a bottom half handler.
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
  */
 int
 smp_call_function (void (*func) (void *info), void *info, int nonatomic, int wait)
@@ -302,7 +302,7 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 
 	call_data = &data;
 	mb();	/* ensure store to call_data precedes setting of IPI_CALL_FUNC */
@@ -317,7 +317,7 @@
 			barrier();
 	call_data = NULL;
 
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 	return 0;
 }
 
diff -urN linux-2.5.14-base/arch/mips/kernel/smp.c linux-2.5.14-smp_call_func/arch/mips/kernel/smp.c
--- linux-2.5.14-base/arch/mips/kernel/smp.c	Mon May  6 09:07:56 2002
+++ linux-2.5.14-smp_call_func/arch/mips/kernel/smp.c	Tue May  7 12:31:56 2002
@@ -192,6 +192,8 @@
  * The caller of this wants the passed function to run on every cpu.  If wait
  * is set, wait until all cpus have finished the function before returning.
  * The lock is here to protect the call structure.
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
  */
 int smp_call_function (void (*func) (void *info), void *info, int retry, 
 								int wait)
@@ -203,7 +205,7 @@
 		return 0;
 	}
 
-	spin_lock_bh(&smp_fn_call.lock);
+	spin_lock(&smp_fn_call.lock);
 
 	atomic_set(&smp_fn_call.finished, 0);
 	smp_fn_call.fn = func;
@@ -220,7 +222,7 @@
 		while(atomic_read(&smp_fn_call.finished) != cpus) {}
 	}
 
-	spin_unlock_bh(&smp_fn_call.lock);
+	spin_unlock(&smp_fn_call.lock);
 	return 0;
 }
 
diff -urN linux-2.5.14-base/arch/ppc/kernel/smp.c linux-2.5.14-smp_call_func/arch/ppc/kernel/smp.c
--- linux-2.5.14-base/arch/ppc/kernel/smp.c	Mon May  6 09:08:06 2002
+++ linux-2.5.14-smp_call_func/arch/ppc/kernel/smp.c	Tue May  7 12:33:19 2002
@@ -209,7 +209,7 @@
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
  *
  * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler, you may call it from a bottom half handler.
+ * hardware interrupt handler or from a bottom half handler.
  */
 {
 	if (smp_num_cpus <= 1)
@@ -237,7 +237,7 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 	call_data = &data;
 	/* Send a message to all other CPUs and wait for them to respond */
 	smp_message_pass(target, PPC_MSG_CALL_FUNCTION, 0, 0);
@@ -269,7 +269,7 @@
 	ret = 0;
 
  out:
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 	return ret;
 }
 
diff -urN linux-2.5.14-base/arch/ppc64/kernel/smp.c linux-2.5.14-smp_call_func/arch/ppc64/kernel/smp.c
--- linux-2.5.14-base/arch/ppc64/kernel/smp.c	Mon May  6 09:08:05 2002
+++ linux-2.5.14-smp_call_func/arch/ppc64/kernel/smp.c	Tue May  7 12:34:17 2002
@@ -466,7 +466,7 @@
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
  *
  * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler, you may call it from a bottom half handler.
+ * hardware interrupt handler or from a bottom half handler.
  */
 int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
 			int wait)
@@ -486,7 +486,7 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 	call_data = &data;
 	/* Send a message to all other CPUs and wait for them to respond */
 	smp_message_pass(MSG_ALL_BUT_SELF, PPC_MSG_CALL_FUNCTION, 0, 0);
@@ -530,7 +530,7 @@
 
  out:
 	HMT_medium();
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 	return ret;
 }
 
diff -urN linux-2.5.14-base/arch/s390/kernel/smp.c linux-2.5.14-smp_call_func/arch/s390/kernel/smp.c
--- linux-2.5.14-base/arch/s390/kernel/smp.c	Mon May  6 09:07:52 2002
+++ linux-2.5.14-smp_call_func/arch/s390/kernel/smp.c	Tue May  7 12:34:52 2002
@@ -146,7 +146,7 @@
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
  *
  * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler, you may call it from a bottom half handler.
+ * hardware interrupt handler or from a bottom half handler.
  */
 {
 	struct call_data_struct data;
@@ -162,7 +162,7 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 	call_data = &data;
 	/* Send a message to all other CPUs and wait for them to respond */
         smp_ext_bitcall_others(ec_call_function);
@@ -174,7 +174,7 @@
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			barrier();
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 
 	return 0;
 }
diff -urN linux-2.5.14-base/arch/s390x/kernel/smp.c linux-2.5.14-smp_call_func/arch/s390x/kernel/smp.c
--- linux-2.5.14-base/arch/s390x/kernel/smp.c	Mon May  6 09:08:03 2002
+++ linux-2.5.14-smp_call_func/arch/s390x/kernel/smp.c	Tue May  7 12:35:45 2002
@@ -146,7 +146,7 @@
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
  *
  * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler, you may call it from a bottom half handler.
+ * hardware interrupt handler or from a bottom half handler.
  */
 {
 	struct call_data_struct data;
@@ -162,7 +162,7 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 	call_data = &data;
 	/* Send a message to all other CPUs and wait for them to respond */
         smp_ext_bitcall_others(ec_call_function);
@@ -174,7 +174,7 @@
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			barrier();
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 
 	return 0;
 }
diff -urN linux-2.5.14-base/arch/sparc64/kernel/smp.c linux-2.5.14-smp_call_func/arch/sparc64/kernel/smp.c
--- linux-2.5.14-base/arch/sparc64/kernel/smp.c	Mon May  6 09:07:52 2002
+++ linux-2.5.14-smp_call_func/arch/sparc64/kernel/smp.c	Tue May  7 12:36:51 2002
@@ -551,6 +551,10 @@
 
 extern unsigned long xcall_call_function;
 
+/*
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
 int smp_call_function(void (*func)(void *info), void *info,
 		      int nonatomic, int wait)
 {
@@ -566,7 +570,7 @@
 	atomic_set(&data.finished, 0);
 	data.wait = wait;
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 
 	call_data = &data;
 
@@ -584,12 +588,12 @@
 		udelay(1);
 	}
 
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 
 	return 0;
 
 out_timeout:
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 	printk("XCALL: Remote cpus not responding, ncpus=%d finished=%d\n",
 	       smp_num_cpus - 1, atomic_read(&data.finished));
 	return 0;
diff -urN linux-2.5.14-base/arch/x86_64/kernel/smp.c linux-2.5.14-smp_call_func/arch/x86_64/kernel/smp.c
--- linux-2.5.14-base/arch/x86_64/kernel/smp.c	Mon May  6 09:07:57 2002
+++ linux-2.5.14-smp_call_func/arch/x86_64/kernel/smp.c	Tue May  7 12:37:40 2002
@@ -380,7 +380,7 @@
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
  *
  * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler, you may call it from a bottom half handler.
+ * hardware interrupt handler or from a bottom half handler.
  */
 {
 	struct call_data_struct data;
@@ -396,7 +396,7 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 	call_data = &data;
 	wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
@@ -409,7 +409,7 @@
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			barrier();
-	spin_unlock_bh(&call_lock);
+	spin_unlock(&call_lock);
 
 	return 0;
 }
