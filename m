Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262840AbTCSA1a>; Tue, 18 Mar 2003 19:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262846AbTCSA1a>; Tue, 18 Mar 2003 19:27:30 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262840AbTCSA13>;
	Tue, 18 Mar 2003 19:27:29 -0500
Subject: [PATCH] boot time parameter to turn of TSC usage
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jerry Cooperstein <coop@axian.com>
In-Reply-To: <20030319002119.GA5351@p3.attbi.com>
References: <20030318190557.GA14447@p3.attbi.com>
	 <1048019543.6294.3.camel@dell_ss3.pdx.osdl.net>
	 <20030318205907.GB4081@p3.attbi.com>
	 <200303182340.h2INeE4r098586@northrelay04.pok.ibm.com>
	 <20030319002119.GA5351@p3.attbi.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1048034299.6296.85.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Mar 2003 16:38:20 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For machines that don't want to cooperate and have bad TSC counter and/or
change CPU frequency without change support.

This fixes the problem on Jerry Cooperstein's PIII laptop.
Could be useful for other people and tech support situations.

Please consider applying.
Thanks
Steve


diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 18 15:28:10 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 18 15:28:10 2003
@@ -15,6 +15,7 @@
 #include <asm/processor.h>
 
 int tsc_disable __initdata = 0;
+static int tsc_clock_disable __initdata = 0;
 
 extern spinlock_t i8253_lock;
 
@@ -241,6 +242,13 @@
 };
 #endif
 
+/* Don't use TSC for time of day clock */
+static int __init tsc_noclock_setup(char *str)
+{
+	tsc_clock_disable = 1;
+	return 1;
+}
+__setup("notsclock", tsc_noclock_setup);
 
 static int init_tsc(void)
 {
@@ -273,7 +281,7 @@
 	cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
 
-	if (cpu_has_tsc) {
+	if (cpu_has_tsc && !tsc_clock_disable) {
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;



