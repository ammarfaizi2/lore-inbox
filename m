Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTIYRWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbTIYRVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:21:54 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:39814 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261334AbTIYRRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:17:52 -0400
Date: Thu, 25 Sep 2003 19:17:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/19): system tick misaccounting.
Message-ID: <20030925171710.GF2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix system tick misaccounting problem.

diffstat:
 arch/s390/kernel/entry.S       |   26 ++++----------------------
 arch/s390/kernel/entry64.S     |   26 ++++----------------------
 arch/s390/kernel/s390_ext.c    |   28 +++++++++++++++++++++++-----
 arch/s390/kernel/time.c        |   21 ++++++++++-----------
 drivers/s390/block/dasd_diag.c |    4 +---
 drivers/s390/char/sclp.c       |    2 --
 drivers/s390/cio/cio.c         |    6 ++++--
 include/asm-s390/hardirq.h     |    1 +
 include/asm-s390/lowcore.h     |    8 ++++++--
 9 files changed, 53 insertions(+), 69 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Thu Sep 25 18:33:25 2003
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Thu Sep 25 18:33:25 2003
@@ -515,12 +515,9 @@
 	SAVE_ALL_BASE
         SAVE_ALL __LC_IO_OLD_PSW,0
         GET_THREAD_INFO           # load pointer to task_struct to R9
+	stck	__LC_INT_CLOCK
         l       %r1,BASED(.Ldo_IRQ)        # load address of do_IRQ
         la      %r2,SP_PTREGS(%r15) # address of register-save area
-        sr      %r3,%r3
-        icm     %r3,3,__LC_SUBCHANNEL_NR   # load subchannel nr & extend to int
-        l       %r4,__LC_IO_INT_PARM       # load interruption parm
-	l       %r5,__LC_IO_INT_WORD       # load interruption word
         basr    %r14,%r1          # branch to standard irq handler
 
 io_return:
@@ -609,26 +606,11 @@
 	SAVE_ALL_BASE
         SAVE_ALL __LC_EXT_OLD_PSW,0
         GET_THREAD_INFO                # load pointer to task_struct to R9
+	stck	__LC_INT_CLOCK
+	la	%r2,SP_PTREGS(%r15)    # address of register-save area
+	lh	%r3,__LC_EXT_INT_CODE  # get interruption code
 	l	%r1,BASED(.Ldo_extint)
 	basr	%r14,%r1
-	lh	%r6,__LC_EXT_INT_CODE  # get interruption code
-	lr	%r1,%r6		       # calculate index = code & 0xff
-	n	%r1,BASED(.Lc0xff)
-	sll	%r1,2
-	l	%r7,BASED(.Lext_hash)
-	l	%r7,0(%r1,%r7)	       # get first list entry for hash value
-	ltr	%r7,%r7		       # == NULL ?
-	bz	BASED(io_return)       # yes, nothing to do, exit
-ext_int_loop:
-	ch	%r6,8(%r7)	       # compare external interrupt code
-	bne	BASED(ext_int_next)
-	l	%r1,4(%r7)	       # get handler address
-	la	%r2,SP_PTREGS(%r15)    # address of register-save area
-	lr	%r3,%r6		       # interruption code
-	basr	%r14,%r1	       # call handler
-ext_int_next:
-	icm	%r7,15,0(%r7)	       # next list entry
-	bnz	BASED(ext_int_loop)
 	b	BASED(io_return)
 
 /*
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Thu Sep 25 18:33:25 2003
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Thu Sep 25 18:33:25 2003
@@ -552,10 +552,8 @@
 io_int_handler:
         SAVE_ALL __LC_IO_OLD_PSW,0
         GET_THREAD_INFO                # load pointer to task_struct to R9
+	stck	__LC_INT_CLOCK
         la      %r2,SP_PTREGS(%r15)    # address of register-save area
-	llgh    %r3,__LC_SUBCHANNEL_NR # load subchannel number
-        llgf    %r4,__LC_IO_INT_PARM   # load interruption parm
-        llgf    %r5,__LC_IO_INT_WORD   # load interruption word
 	brasl   %r14,do_IRQ            # call standard irq handler
 
 io_return:
@@ -640,26 +638,10 @@
 ext_int_handler:
         SAVE_ALL __LC_EXT_OLD_PSW,0
         GET_THREAD_INFO                # load pointer to task_struct to R9
-	brasl   %r14,do_extint
-	llgh	%r6,__LC_EXT_INT_CODE  # get interruption code
-	lgr	%r1,%r6		       # calculate index = code & 0xff
-	nill	%r1,0xff
-	sll	%r1,3
-	larl	%r7,ext_int_hash
-	lg	%r7,0(%r1,%r7)	       # get first list entry for hash value
-	ltgr	%r7,%r7		       # == NULL ?
-	jz	io_return	       # yes, nothing to do, exit
-ext_int_loop:
-	ch	%r6,16(%r7)	       # compare external interrupt code
-	jne	ext_int_next
-	lg	%r1,8(%r7)	       # get handler address
+	stck	__LC_INT_CLOCK
 	la	%r2,SP_PTREGS(%r15)    # address of register-save area
-	lgr	%r3,%r6		       # interruption code
-	basr	%r14,%r1	       # call handler
-ext_int_next:
-	lg	%r7,0(%r7)	       # next list entry
-	ltgr	%r7,%r7
-	jnz	ext_int_loop
+	llgh	%r3,__LC_EXT_INT_CODE  # get interruption code
+	brasl   %r14,do_extint
 	j	io_return
 
 /*
diff -urN linux-2.6/arch/s390/kernel/s390_ext.c linux-2.6-s390/arch/s390/kernel/s390_ext.c
--- linux-2.6/arch/s390/kernel/s390_ext.c	Mon Sep  8 21:50:03 2003
+++ linux-2.6-s390/arch/s390/kernel/s390_ext.c	Thu Sep 25 18:33:25 2003
@@ -26,7 +26,8 @@
  */
 ext_int_info_t *ext_int_hash[256] = { 0, };
 
-int register_external_interrupt(__u16 code, ext_int_handler_t handler) {
+int register_external_interrupt(__u16 code, ext_int_handler_t handler)
+{
         ext_int_info_t *p;
         int index;
 
@@ -42,7 +43,8 @@
 }
 
 int register_early_external_interrupt(__u16 code, ext_int_handler_t handler,
-				      ext_int_info_t *p) {
+				      ext_int_info_t *p)
+{
         int index;
 
         if (p == NULL)
@@ -55,7 +57,8 @@
         return 0;
 }
 
-int unregister_external_interrupt(__u16 code, ext_int_handler_t handler) {
+int unregister_external_interrupt(__u16 code, ext_int_handler_t handler)
+{
         ext_int_info_t *p, *q;
         int index;
 
@@ -79,7 +82,8 @@
 }
 
 int unregister_early_external_interrupt(__u16 code, ext_int_handler_t handler,
-					ext_int_info_t *p) {
+					ext_int_info_t *p)
+{
 	ext_int_info_t *q;
 	int index;
 
@@ -101,9 +105,23 @@
 	return 0;
 }
 
-void do_extint(void)
+void do_extint(struct pt_regs *regs, unsigned short code)
 {
+        ext_int_info_t *p;
+        int index;
+
+	irq_enter();
+	if (S390_lowcore.int_clock >= S390_lowcore.jiffy_timer)
+		account_ticks(regs);
 	kstat_cpu(smp_processor_id()).irqs[EXTERNAL_INTERRUPT]++;
+        index = code & 0xff;
+	for (p = ext_int_hash[index]; p; p = p->next) {
+		if (likely(p->code == code)) {
+			if (likely(p->handler))
+				p->handler(regs, code);
+		}
+	}
+	irq_exit();
 }
 
 EXPORT_SYMBOL(register_external_interrupt);
diff -urN linux-2.6/arch/s390/kernel/time.c linux-2.6-s390/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	Thu Sep 25 18:33:22 2003
+++ linux-2.6-s390/arch/s390/kernel/time.c	Thu Sep 25 18:33:25 2003
@@ -166,28 +166,29 @@
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static void do_comparator_interrupt(struct pt_regs *regs, __u16 error_code)
+void account_ticks(struct pt_regs *regs)
 {
 	__u64 tmp;
 	__u32 ticks;
 
 	/* Calculate how many ticks have passed. */
-	tmp = get_clock() - S390_lowcore.jiffy_timer;
-	if (tmp >= 2*CLK_TICKS_PER_JIFFY) {  /* more than one tick ? */
-		ticks = __calculate_ticks(tmp);
+	tmp = S390_lowcore.int_clock - S390_lowcore.jiffy_timer;
+	if (tmp >= 2*CLK_TICKS_PER_JIFFY) {  /* more than two ticks ? */
+		ticks = __calculate_ticks(tmp) + 1;
 		S390_lowcore.jiffy_timer +=
 			CLK_TICKS_PER_JIFFY * (__u64) ticks;
+	} else if (tmp >= CLK_TICKS_PER_JIFFY) {
+		ticks = 2;
+		S390_lowcore.jiffy_timer += 2*CLK_TICKS_PER_JIFFY;
 	} else {
 		ticks = 1;
 		S390_lowcore.jiffy_timer += CLK_TICKS_PER_JIFFY;
 	}
 
 	/* set clock comparator for next tick */
-	tmp = S390_lowcore.jiffy_timer + CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
+	tmp = S390_lowcore.jiffy_timer + CPU_DEVIATION;
         asm volatile ("SCKC %0" : : "m" (tmp));
 
-	irq_enter();
-
 #ifdef CONFIG_SMP
 	/*
 	 * Do not rely on the boot cpu to do the calls to do_timer.
@@ -215,8 +216,6 @@
 	while (ticks--)
 		do_timer(regs);
 #endif
-
-	irq_exit();
 }
 
 /*
@@ -228,7 +227,7 @@
 	__u64 timer;
 
 	timer = jiffies_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
-	S390_lowcore.jiffy_timer = timer;
+	S390_lowcore.jiffy_timer = timer + CLK_TICKS_PER_JIFFY;
 	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
 	asm volatile ("SCKC %0" : : "m" (timer));
         /* allow clock comparator timer interrupt */
@@ -275,7 +274,7 @@
                                 -xtime.tv_sec, -xtime.tv_nsec);
 
         /* request the 0x1004 external interrupt */
-        if (register_early_external_interrupt(0x1004, do_comparator_interrupt,
+        if (register_early_external_interrupt(0x1004, 0,
 					      &ext_int_info_timer) != 0)
                 panic("Couldn't request external interrupt 0x1004");
 
diff -urN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-s390/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	Mon Sep  8 21:49:51 2003
+++ linux-2.6-s390/drivers/s390/block/dasd_diag.c	Thu Sep 25 18:33:25 2003
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.31 $
+ * $Revision: 1.32 $
  */
 
 #include <linux/config.h>
@@ -170,7 +170,6 @@
 	ip = S390_lowcore.ext_params;
 
 	cpu = smp_processor_id();
-	irq_enter();
 
 	if (!ip) {		/* no intparm: unsolicited interrupt */
 		MESSAGE(KERN_DEBUG, "%s", "caught unsolicited interrupt");
@@ -218,7 +217,6 @@
 	dasd_schedule_bh(device);
 
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
-	irq_exit();
 }
 
 static int
diff -urN linux-2.6/drivers/s390/char/sclp.c linux-2.6-s390/drivers/s390/char/sclp.c
--- linux-2.6/drivers/s390/char/sclp.c	Mon Sep  8 21:50:08 2003
+++ linux-2.6-s390/drivers/s390/char/sclp.c	Thu Sep 25 18:33:25 2003
@@ -293,7 +293,6 @@
 	finished_sccb = ext_int_param & EXT_INT_SCCB_MASK;
 	evbuf_pending = ext_int_param & (EXT_INT_EVBUF_PENDING |
 					 EXT_INT_STATECHANGE_PENDING);
-	irq_enter();
 	req = NULL;
 	if (finished_sccb != 0U) {
 		list_for_each(l, &sclp_req_queue) {
@@ -321,7 +320,6 @@
 	spin_unlock(&sclp_lock);
 	/* and start next request on the queue */
 	sclp_start_request();
-	irq_exit();
 }
 
 /*
diff -urN linux-2.6/drivers/s390/cio/cio.c linux-2.6-s390/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	Thu Sep 25 18:33:23 2003
+++ linux-2.6-s390/drivers/s390/cio/cio.c	Thu Sep 25 18:33:25 2003
@@ -588,13 +588,15 @@
  *
  */
 void
-do_IRQ (struct pt_regs regs)
+do_IRQ (struct pt_regs *regs)
 {
 	struct tpi_info *tpi_info;
 	struct subchannel *sch;
 	struct irb *irb;
 
 	irq_enter ();
+	if (S390_lowcore.int_clock >= S390_lowcore.jiffy_timer)
+		account_ticks(regs);
 	/*
 	 * Get interrupt information from lowcore
 	 */
@@ -663,7 +665,7 @@
 	do {
 		spin_unlock(&console_subchannel.lock);
 		if (!cio_tpi())
-			udelay (100);
+			cpu_relax();
 		spin_lock(&console_subchannel.lock);
 	} while (console_subchannel.schib.scsw.actl != 0);
 	/*
diff -urN linux-2.6/include/asm-s390/hardirq.h linux-2.6-s390/include/asm-s390/hardirq.h
--- linux-2.6/include/asm-s390/hardirq.h	Thu Sep 25 18:33:25 2003
+++ linux-2.6-s390/include/asm-s390/hardirq.h	Thu Sep 25 18:33:25 2003
@@ -87,6 +87,7 @@
 	
 
 extern void do_call_softirq(void);
+extern void account_ticks(struct pt_regs *);
 
 #define invoke_softirq() do_call_softirq()
 
diff -urN linux-2.6/include/asm-s390/lowcore.h linux-2.6-s390/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	Thu Sep 25 18:33:25 2003
+++ linux-2.6-s390/include/asm-s390/lowcore.h	Thu Sep 25 18:33:25 2003
@@ -66,6 +66,7 @@
 #define __LC_IPLDEV                     0xC7C
 #define __LC_JIFFY_TIMER		0xC80
 #define __LC_CURRENT			0xC90
+#define __LC_INT_CLOCK			0xC98
 #else /* __s390x__ */
 #define __LC_KERNEL_STACK               0xD40
 #define __LC_ASYNC_STACK                0xD48
@@ -74,6 +75,7 @@
 #define __LC_IPLDEV                     0xDB8
 #define __LC_JIFFY_TIMER		0xDC0
 #define __LC_CURRENT			0xDD8
+#define __LC_INT_CLOCK			0xDE8
 #endif /* __s390x__ */
 
 #define __LC_PANIC_MAGIC                0xE00
@@ -174,7 +176,8 @@
 	__u32        percpu_offset;            /* 0xc8c */
 	__u32        current_task;	       /* 0xc90 */
 	__u32        softirq_pending;	       /* 0xc94 */
-        __u8         pad11[0xe00-0xc98];       /* 0xc98 */
+	__u64        int_clock;                /* 0xc98 */
+        __u8         pad11[0xe00-0xca0];       /* 0xca0 */
 
         /* 0xe00 is used as indicator for dump tools */
         /* whether the kernel died with panic() or not */
@@ -252,7 +255,8 @@
 	__u64        percpu_offset;            /* 0xdd0 */
 	__u64        current_task;	       /* 0xdd8 */
 	__u64        softirq_pending;	       /* 0xde0 */
-        __u8         pad12[0xe00-0xde8];       /* 0xde8 */
+	__u64        int_clock;                /* 0xde8 */
+        __u8         pad12[0xe00-0xdf0];       /* 0xdf0 */
 
         /* 0xe00 is used as indicator for dump tools */
         /* whether the kernel died with panic() or not */
