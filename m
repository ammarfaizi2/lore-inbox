Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbSLTIf3>; Fri, 20 Dec 2002 03:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267749AbSLTIf3>; Fri, 20 Dec 2002 03:35:29 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5627 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267748AbSLTIf1>;
	Fri, 20 Dec 2002 03:35:27 -0500
Message-ID: <3E02D81F.13A5A59D@mvista.com>
Date: Fri, 20 Dec 2002 00:43:11 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]Timer list init is done AFTER use
Content-Type: multipart/mixed;
 boundary="------------551DA302186A31CC7FFCFC07"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------551DA302186A31CC7FFCFC07
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On SMP systems the timer list init is done by way of a
cpu_notifier call.  This has two problems:

1.) Timers are started WAY before the cpu_notifier call
chain is executed.  In particular the console blanking timer
is deleted and inserted every time printk() is called.  That
this does not fail is only because the kernel has yet to
protect location zero.

2.) This notifier is called when a cpu comes up.  I suspect
that initializing the timer list when a hot swap of a cpu is
done is NOT the right thing to do.  In any case, if this is
a desired action, the list still needs to be initialized
prior to its use.

The attached patch initializes all the timer lists at
init_timers time and does not put code in the notify list.
--
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------551DA302186A31CC7FFCFC07
Content-Type: text/plain; charset=us-ascii;
 name="timer-init-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timer-init-fix.patch"

--- linux-2.5.52-bk4-org/kernel/timer.c~	Thu Dec 19 12:13:18 2002
+++ linux/kernel/timer.c	Fri Dec 20 00:38:15 2002
@@ -1150,7 +1150,7 @@
 	return 0;
 }
 
-static void __devinit init_timers_cpu(int cpu)
+static void __init init_timers_cpu(int cpu)
 {
 	int j;
 	tvec_base_t *base;
@@ -1167,29 +1167,12 @@
 		INIT_LIST_HEAD(base->tv1.vec + j);
 }
 	
-static int __devinit timer_cpu_notify(struct notifier_block *self, 
-				unsigned long action, void *hcpu)
-{
-	long cpu = (long)hcpu;
-	switch(action) {
-	case CPU_UP_PREPARE:
-		init_timers_cpu(cpu);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block __devinitdata timers_nb = {
-	.notifier_call	= timer_cpu_notify,
-};
-
 
 void __init init_timers(void)
 {
-	timer_cpu_notify(&timers_nb, (unsigned long)CPU_UP_PREPARE,
-				(void *)(long)smp_processor_id());
-	register_cpu_notifier(&timers_nb);
+	int cpu;
+	for (cpu = 0; cpu < NR_CPUS; cpu++){
+		init_timers_cpu(cpu);
+	}
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq, NULL);
 }


--------------551DA302186A31CC7FFCFC07--

