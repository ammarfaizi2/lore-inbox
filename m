Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSGAUAm>; Mon, 1 Jul 2002 16:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSGAUAm>; Mon, 1 Jul 2002 16:00:42 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:25509 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316437AbSGAUAk>; Mon, 1 Jul 2002 16:00:40 -0400
Date: Mon, 1 Jul 2002 22:02:59 +0200
From: Andi Kleen <ak@muc.de>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Machine check fixes for i386/v2.5
Message-ID: <20020701220259.A22080@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some fixes for CONFIG_X86_MCE_NONFATAL

Calling smp_call_function from interrupt context is forbidden

Unless I'm mistaken it would BUG on any box with more than two CPUs because
it would expect smp_call_function callback to run only on a single CPU??

Also handle the Hammer.

Untested of course.

-Andi



--- linux/arch/i386/kernel/bluesmoke.c	Wed Jun 19 07:38:18 2002
+++ linux-2.5.24-work/arch/i386/kernel/bluesmoke.c	Mon Jul  1 21:58:22 2002
@@ -273,9 +273,6 @@
 {
 	u32 low, high;
 	int i;
-	unsigned int *cpu = info;
-
-	BUG_ON (*cpu != smp_processor_id());
 
 	for (i=0; i<banks; i++) {
 		rdmsr(MSR_IA32_MC0_STATUS+i*4, low, high);
@@ -293,24 +290,32 @@
 	}
 }
 
+static struct tq_struct mce_task = { 
+	routine: do_mce_timer	
+};
+
+static void do_mce_timer(void *data)
+{ 
+	preempt_disable(); 
+	mce_checkregs(NULL);
+	smp_call_function (mce_checkregs, NULL, 1, 1);
+	preempt_enable();
+	mce_timer.expires = jiffies + MCE_RATE;
+	add_timer (&mce_timer);
+} 
 
 static void mce_timerfunc (unsigned long data)
 {
-	unsigned int i;
-
-	for (i=0; i<NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
-		if (i == smp_processor_id())
-			mce_checkregs(&i);
-		else
-			smp_call_function (mce_checkregs, &i, 1, 1);
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) { 
+		schedule_task(&mce_task); 
+		return;
 	}
-
-	/* Refresh the timer. */
+#endif
+	mce_checkregs(NULL);
 	mce_timer.expires = jiffies + MCE_RATE;
 	add_timer (&mce_timer);
-}
+}	
 #endif
 
 
@@ -446,7 +451,7 @@
 	{
 		case X86_VENDOR_AMD:
 			/* AMD K7 machine check is Intel like */
-			if(c->x86 == 6) {
+			if(c->x86 == 6 || c->x86 == 15) {
 				intel_mcheck_init(c);
 #ifdef CONFIG_X86_MCE_NONFATAL
 				if (timerset == 0) {
