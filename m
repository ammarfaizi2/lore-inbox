Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269671AbTGULXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 07:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbTGULW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 07:22:59 -0400
Received: from dp.samba.org ([66.70.73.150]:28141 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269671AbTGULWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 07:22:55 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Re: Remove chatty printk on CPU bringup.
Date: Mon, 21 Jul 2003 21:28:09 +1000
Message-Id: <20030721113757.489C32C6B8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Only having one processor is not an error.  It still happens to some
  people: let's not deprive them of their bogomips printk as well --RR ]


From:  Nick Piggin <piggin@cyberone.com.au>

  
  Rusty Russell wrote:
  
  >In message <3F092E1F.7060406@cyberone.com.au> you write:
  >
  >>Hi Rusty,
  >>That reminds me of this minor irritation. Maybe you
  >>could get it applied. _Or_, do the else block
  >>unconditionally - which would get a more consistent
  >>output. Either way I fail to see how its an error.
  >>
  >
  >Hmm, this means an SMP configuration is found, but there's only one
  >CPU.  Does this actually happen for you?
  >
  
  I test with SMP kernels on that computer I use at IBM. That
  is how I came across the error.
  
  >
  >If so, agreed.  My crash box is SMP: can you eliminate that branch
  >entirely and do a test boot for me?
  >
  I don't have a UP here to test with, and the test doesn't
  trigger with nosmp. Anyway the following compiles and boots
  on SMP.
  

--- trivial-2.5.75-bk3/arch/i386/kernel/smpboot.c.orig	2003-07-21 21:22:56.000000000 +1000
+++ trivial-2.5.75-bk3/arch/i386/kernel/smpboot.c	2003-07-21 21:22:56.000000000 +1000
@@ -937,6 +937,7 @@
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit, kicked;
+	unsigned long bogosum = 0;
 
 	/*
 	 * Setup boot CPU information
@@ -1050,24 +1051,23 @@
 	 */
 
 	Dprintk("Before bogomips.\n");
-	if (!cpucount) {
-		printk(KERN_ERR "Error: only one processor found.\n");
-	} else {
-		unsigned long bogosum = 0;
-		for (cpu = 0; cpu < NR_CPUS; cpu++)
-			if (cpu_callout_map & (1<<cpu))
-				bogosum += cpu_data[cpu].loops_per_jiffy;
-		printk(KERN_INFO "Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
-			cpucount+1,
-			bogosum/(500000/HZ),
-			(bogosum/(5000/HZ))%100);
-		Dprintk("Before bogocount - setting activated=1.\n");
-	}
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+		if (cpu_callout_map & (1<<cpu))
+			bogosum += cpu_data[cpu].loops_per_jiffy;
+	printk(KERN_INFO
+		"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
+		cpucount+1,
+		bogosum/(500000/HZ),
+		(bogosum/(5000/HZ))%100);
+	Dprintk("Before bogocount - setting activated=1.\n");
 
 	if (smp_b_stepping)
 		printk(KERN_WARNING "WARNING: SMP operation may be unreliable with B stepping processors.\n");
 
-	/* Don't taint if we are running SMP kernel on a single non-MP approved Athlon  */
+	/*
+	 * Don't taint if we are running SMP kernel on a single non-MP
+	 * approved Athlon
+	 */
 	if (tainted & TAINT_UNSAFE_SMP) {
 		if (cpucount)
 			printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Nick Piggin <piggin@cyberone.com.au>: Re: [TRIVIAL] Remove chatty printk on CPU bringup.
