Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTI2GPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 02:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbTI2GPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 02:15:25 -0400
Received: from dyn-ctb-203-221-72-163.webone.com.au ([203.221.72.163]:6150
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262850AbTI2GPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 02:15:22 -0400
Message-ID: <3F77CDF4.7030905@cyberone.com.au>
Date: Mon, 29 Sep 2003 16:15:16 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove bogus UP on SMP kernel error
Content-Type: multipart/mixed;
 boundary="------------000800080600070508010408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000800080600070508010408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes a bogus error message in the bogomips reporting code
when running an SMP kernel on UP. It makes the output consistent with what
you see on an SMP box. I noticed this while testing, but it recently
annoyed me again when booting a knoppix CD - its the first line you'll
see.


--------------000800080600070508010408
Content-Type: text/plain;
 name="smp-no-up-err"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp-no-up-err"

--- linux-2.6/arch/i386/kernel/smpboot.c.orig	2003-08-25 20:28:34.000000000 +1000
+++ linux-2.6/arch/i386/kernel/smpboot.c	2003-09-01 14:02:45.000000000 +1000
@@ -937,6 +937,7 @@ int cpu_sibling_map[NR_CPUS] __cacheline
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit, kicked;
+	unsigned long bogosum = 0;
 
 	/*
 	 * Setup boot CPU information
@@ -1048,26 +1049,25 @@ static void __init smp_boot_cpus(unsigne
 	/*
 	 * Allow the user to impress friends.
 	 */
-
 	Dprintk("Before bogomips.\n");
-	if (!cpucount) {
-		printk(KERN_ERR "Error: only one processor found.\n");
-	} else {
-		unsigned long bogosum = 0;
-		for (cpu = 0; cpu < NR_CPUS; cpu++)
-			if (cpu_isset(cpu, cpu_callout_map))
-				bogosum += cpu_data[cpu].loops_per_jiffy;
-		printk(KERN_INFO "Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
-			cpucount+1,
-			bogosum/(500000/HZ),
-			(bogosum/(5000/HZ))%100);
-		Dprintk("Before bogocount - setting activated=1.\n");
-	}
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+		if (cpu_isset(cpu, cpu_callout_map))
+			bogosum += cpu_data[cpu].loops_per_jiffy;
+	printk(KERN_INFO
+		"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
+		cpucount+1,
+		bogosum/(500000/HZ),
+		(bogosum/(5000/HZ))%100);
+	
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

--------------000800080600070508010408--

