Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUAXA2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUAXA2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:28:39 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:47274 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266807AbUAXA2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:28:36 -0500
Subject: [PATCH] use-tsc-for-delay_pmtmr.patch
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, vojtech@suse.cz
In-Reply-To: <1074886056.12447.36.camel@localhost>
References: <20040123013740.58a6c1f9.akpm@osdl.org>
	 <20040123160152.GA18073@ss1000.ms.mff.cuni.cz>
	 <20040123161946.GA6934@ucw.cz>  <1074886056.12447.36.camel@localhost>
Content-Type: text/plain
Message-Id: <1074904017.12446.159.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 23 Jan 2004 16:26:57 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 11:27, john stultz wrote:
> If that is going to cause problems, then we'll need to pull out the
> use-pmtmr-for-delay_pmtmr patch. I guess our only option is then to use
> the TSC for delay_pmtrm() (as a loop based delay fails in other cases).
> I'll write that up and send it your way, Andrew. 

Andrew, 
	Here's the patch to replace use-pmtmr-for-delay_pmtmr. It simply uses
the TSC for delay_pmtmr much as delay_tsc does.  The only gottcha is
that __delay will be affected by cpu-frequency changes (much as the
existing loop based delay) until I hook in the cpufreq notificaiton into
the ACPI PM timesource code. I'll get to that issue early next week
(sorry, I had a few other things I had to finish today). 
Let me know if this solves the APIC trouble on your system and if so,
I'd be interested to see how it works in -mm. 

thanks
-john

diff -Nru a/arch/i386/kernel/timers/timer_pm.c b/arch/i386/kernel/timers/timer_pm.c
--- a/arch/i386/kernel/timers/timer_pm.c	Fri Jan 23 13:57:38 2004
+++ b/arch/i386/kernel/timers/timer_pm.c	Fri Jan 23 13:57:38 2004
@@ -73,6 +73,10 @@
 	if (!pmtmr_ioport)
 		return -ENODEV;
 
+	/* we use the TSC for delay_pmtmr, so make sure it exists */
+	if (!cpu_has_tsc)
+		return -ENODEV;
+
 	/* "verify" this timing source */
 	value1 = read_pmtmr();
 	for (i = 0; i < 10000; i++) {
@@ -173,23 +177,16 @@
 	return ret;
 }
 
-static void delay_pmtmr(unsigned long total_loops)
+static void delay_pmtmr(unsigned long loops)
 {
-	u32 then, now;
-	unsigned long loops;
+	unsigned long bclock, now;
 	
-	do{
-		if (total_loops > ACPI_PM_MASK)
-			loops = ACPI_PM_MASK;
-		else
-			loops =  total_loops;
-		total_loops -= loops;
-		
-		then = read_pmtmr();
-		do{ 
-			now = read_pmtmr();
-		} while (((now - then)&ACPI_PM_MASK) < loops);
-	} while (total_loops);
+	rdtscl(bclock);
+	do
+	{
+		rep_nop();
+		rdtscl(now);
+	} while ((now-bclock) < loops);
 }
 
 


