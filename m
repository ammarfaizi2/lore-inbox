Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbRGQBGN>; Mon, 16 Jul 2001 21:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267400AbRGQBGD>; Mon, 16 Jul 2001 21:06:03 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:14562 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265385AbRGQBFz>; Mon, 16 Jul 2001 21:05:55 -0400
Message-ID: <3B538FD4.9D4A0705@uow.edu.au>
Date: Tue, 17 Jul 2001 11:07:32 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
CC: linux-kernel@vger.kernel.org
Subject: Re: Too much memory causes crash when reading/writing to disk
In-Reply-To: <200107161539.JAA183448@ibg.colorado.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Lessem wrote:
> 
> I have done a bit more work on the problem I reported in my message
> "Crashes reading and writing to disk".  To recap, on a machine with
> 8GB of RAM, either
> 
> dd if=/dev/zero bs=1G count=10 | split -b 1073741824
> 
> or
> 
> find /bigfulldisk -type f -exec cat {} \; > /dev/null
> 
> can reliably cause a crash.

It seems that one of your CPUs is stuck in an interrupt
routine.  Could you please try running with the below
patch?  Feed the output through ksymoops.

Also (but separately) try enabling the NMI watchdog with
the `nmi_watchdog=1' kernel boot parameter.

This one will be hard to hunt down.


--- linux-2.4.7-pre6/arch/i386/kernel/irq.c	Wed Jul  4 18:21:24 2001
+++ lk-ext3/arch/i386/kernel/irq.c	Tue Jul 17 11:03:54 2001
@@ -280,7 +280,7 @@ static inline void wait_on_irq(int cpu)
 
 		for (;;) {
 			if (!--count) {
-				show("wait_on_irq");
+				show_trace_smp();
 				count = ~0;
 			}
 			__sti();
--- linux-2.4.7-pre6/arch/i386/kernel/traps.c	Wed Jul  4 18:21:24 2001
+++ lk-ext3/arch/i386/kernel/traps.c	Tue Jul 17 11:04:58 2001
@@ -101,7 +101,7 @@ void show_trace(unsigned long * stack)
 	if (!stack)
 		stack = (unsigned long*)&stack;
 
-	printk("Call Trace: ");
+	printk(KERN_DEBUG "Call Trace: ");
 	i = 1;
 	module_start = VMALLOC_START;
 	module_end = VMALLOC_END;
@@ -119,8 +119,10 @@ void show_trace(unsigned long * stack)
 		if (((addr >= (unsigned long) &_stext) &&
 		     (addr <= (unsigned long) &_etext)) ||
 		    ((addr >= module_start) && (addr <= module_end))) {
-			if (i && ((i % 8) == 0))
-				printk("\n       ");
+			if (i && ((i % 8) == 0)) {
+				printk("\n");
+				printk(KERN_DEBUG "       ");
+			}
 			printk("[<%08lx>] ", addr);
 			i++;
 		}
@@ -153,13 +155,50 @@ void show_stack(unsigned long * esp)
 	for(i=0; i < kstack_depth_to_print; i++) {
 		if (((long) stack & (THREAD_SIZE-1)) == 0)
 			break;
-		if (i && ((i % 8) == 0))
-			printk("\n       ");
+		if (i && ((i % 8) == 0)) {
+			printk("\n");
+			printk(KERN_DEBUG "       ");
+		}
 		printk("%08lx ", *stack++);
 	}
 	printk("\n");
 	show_trace(esp);
 }
+
+static void show_trace_local(void)
+{
+	printk(KERN_DEBUG "CPU %d:\n", smp_processor_id());
+	show_trace(0);
+}
+
+#ifdef CONFIG_SMP
+static atomic_t trace_cpu;
+
+static void show_trace_one(void *dummy)
+{
+	while (atomic_read(&trace_cpu) != smp_processor_id())
+		;
+	show_trace_local();
+	atomic_inc(&trace_cpu);
+	while (atomic_read(&trace_cpu) != smp_num_cpus)
+		;
+}
+
+void show_trace_smp(void)
+{
+	atomic_set(&trace_cpu, 0);
+	smp_call_function(show_trace_one, 0, 1, 0);
+	show_trace_one(0);
+}
+
+#else
+
+void show_trace_smp(void)
+{
+	show_trace_local();
+}
+
+#endif
 
 static void show_registers(struct pt_regs *regs)
 {
