Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbUBNBYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 20:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUBNBYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 20:24:49 -0500
Received: from gizmo08ps.bigpond.com ([144.140.71.18]:385 "HELO
	gizmo08ps.bigpond.com") by vger.kernel.org with SMTP
	id S264507AbUBNBYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 20:24:35 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround instead of apic ack delay.
Date: Sat, 14 Feb 2004 11:24:50 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>
References: <200402120122.06362.ross@datscreative.com.au> <402CB24E.3070105@gmx.de> <200402140041.17584.ross@datscreative.com.au>
In-Reply-To: <200402140041.17584.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ijXLAtQb19Zmf0h"
Message-Id: <200402141124.50880.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ijXLAtQb19Zmf0h
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 14 February 2004 00:41, Ross Dickson wrote:
> On Friday 13 February 2004 21:17, Prakash K. Cheemplavam wrote:
> > Hi,
> > 
> > I am just testing this patch with latest 2.6.3-rc2-mm1. It works in that 
> > sense, that my machine doesn't lock up of APIC issue. (If it locks up - 
> > hasn't done yet - then because of something else, I am currently 
> > discssing it in another thread...)
> > 
> > But it doesn't work in the sense of cooling my machine down. Though 
> > athcool reports disconnect is activated it behaves like it is not, ie, 
> > turning disconnect off makes no difference in temperatures. Your old 
> > tack patch in conjunction with 2.6.2-rc1 (linus) works like a charm, ie 
> > no lock-ups and less temp.
> > 
> 
> Thanks Prakash for testing it and spotting thermal problem.
> 
> Here are some temperatures from my machine read from the bios on reboot.
> I gave it minimal activity for the minutes prior to reboot.
> 
> Win98, 47C
> XPHome, 42C
> Patched Linux 2.4.24 (1000Hz), 40C
> Patched Linux 2.6.3-rc1-mm1, 53C  OUCH!
> 
> Sorry, I will have to go through my latest patch and see why the temp differs
> so much between 2.4 and 2.6. I currently use patched 2.4.24 with Suse 8.2 for
> convenience. When it stopped the lockups on 2.6 I thought the 2.6 was
> working the same way. 
> 

Found the problem for 2.6

After fixing it the 2.6 temperature is
Patched Linux 2.6.3-rc1-mm1, 38C
Ambient today is 1C cooler also.

The fix is to put the brackets back on "!need_resched()"  so that we call
the function and test its return value - not just test the function pointer!

Should be as follows:

static void c1halt_idle(void)
{
	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
		local_irq_disable();
		/* only hlt disconnect if more than 1.6% of apic interval remains */
		if( (!need_resched() ) &&
			(apic_read(APIC_TMCCT) > (apic_read(APIC_TMICT)>>6))) {
			ndelay(500); /* helps nforce2 but adds 0.5us hard int latency */
			safe_halt();  /* nothing better to do until we wake up */
		}
		else
			local_irq_enable();
	}
}

Again attached in tarball, 2.4 patch was not changed.

Revision1 patch for 2.6.3-rc1-mm1:

---CUTHERE---
--- linux-2.6.3-rc1-mm1/arch/i386/kernel/process.c	2004-02-11 21:29:49.000000000 +1000
+++ linux-2.6.3-rc1-mm1-nf/arch/i386/kernel/process.c	2004-02-11 23:44:04.000000000 +1000
@@ -50,10 +50,11 @@
 #include <asm/desc.h>
 #include <asm/atomic_kmap.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#include <asm/apic.h>
 
 #include <linux/irq.h>
 #include <linux/err.h>
 
 #include <asm/tlbflush.h>
@@ -92,11 +93,11 @@ EXPORT_SYMBOL(enable_hlt);
 
 /*
  * We use this if we don't have any better
  * idle routine..
  */
-void default_idle(void)
+static void default_idle(void)
 {
 	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
 		local_irq_disable();
 		if (!need_resched())
 			safe_halt();
@@ -104,10 +105,29 @@ void default_idle(void)
 			local_irq_enable();
 	}
 }
 
 /*
+ * We use this to avoid nforce2 lockups
+ * Reduces frequency of C1 disconnects
+ */
+static void c1halt_idle(void)
+{
+	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
+		local_irq_disable();
+		/* only hlt disconnect if more than 1.6% of apic interval remains */
+		if( (!need_resched()) &&
+			(apic_read(APIC_TMCCT) > (apic_read(APIC_TMICT)>>6))) {
+			ndelay(500); /* helps nforce2 but adds 0.5us hard int latency */
+			safe_halt();  /* nothing better to do until we wake up */
+		}
+		else
+			local_irq_enable();
+	}
+}
+
+/*
  * On SMP it's slightly faster (but much more power-consuming!)
  * to poll the ->work.need_resched flag instead of waiting for the
  * cross-CPU IPI to arrive. Use this option with caution.
  */
 static void poll_idle (void)
@@ -195,20 +215,18 @@ static inline void check_cpu_quiescent(v
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
  * low exit latency (ie sit in a loop waiting for
  * somebody to say that they'd like to reschedule)
  */
+static void (*idle)(void);
 void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			void (*idle)(void) = pm_idle;
-
 			if (!idle)
-				idle = default_idle;
-
+				idle = pm_idle ? pm_idle : default_idle;
 			check_cpu_quiescent();
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
 		}
 		schedule();
@@ -260,16 +278,18 @@ void __init select_idle_routine(const st
 
 static int __init idle_setup (char *str)
 {
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
-		pm_idle = poll_idle;
+		idle = poll_idle;
 	} else if (!strncmp(str, "halt", 4)) {
 		printk("using halt in idle threads.\n");
-		pm_idle = default_idle;
+		idle = default_idle;
+	} else if (!strncmp(str, "C1halt", 6)) {
+		printk("using C1 halt disconnect friendly idle threads.\n");
+		idle = c1halt_idle;
 	}
-
 	return 1;
 }
 
 __setup("idle=", idle_setup);
---CUTHERE--- 



--Boundary-00=_ijXLAtQb19Zmf0h
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="nforce2-2.6.3-rc1-mm1-idle-c1halt-rev1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="nforce2-2.6.3-rc1-mm1-idle-c1halt-rev1.patch"

--- linux-2.6.3-rc1-mm1/arch/i386/kernel/process.c	2004-02-11 21:29:49.000000000 +1000
+++ linux-2.6.3-rc1-mm1-nf/arch/i386/kernel/process.c	2004-02-11 23:44:04.000000000 +1000
@@ -50,10 +50,11 @@
 #include <asm/desc.h>
 #include <asm/atomic_kmap.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#include <asm/apic.h>
 
 #include <linux/irq.h>
 #include <linux/err.h>
 
 #include <asm/tlbflush.h>
@@ -92,11 +93,11 @@ EXPORT_SYMBOL(enable_hlt);
 
 /*
  * We use this if we don't have any better
  * idle routine..
  */
-void default_idle(void)
+static void default_idle(void)
 {
 	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
 		local_irq_disable();
 		if (!need_resched())
 			safe_halt();
@@ -104,10 +105,29 @@ void default_idle(void)
 			local_irq_enable();
 	}
 }
 
 /*
+ * We use this to avoid nforce2 lockups
+ * Reduces frequency of C1 disconnects
+ */
+static void c1halt_idle(void)
+{
+	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
+		local_irq_disable();
+		/* only hlt disconnect if more than 1.6% of apic interval remains */
+		if( (!need_resched()) &&
+			(apic_read(APIC_TMCCT) > (apic_read(APIC_TMICT)>>6))) {
+			ndelay(500); /* helps nforce2 but adds 0.5us hard int latency */
+			safe_halt();  /* nothing better to do until we wake up */
+		}
+		else
+			local_irq_enable();
+	}
+}
+
+/*
  * On SMP it's slightly faster (but much more power-consuming!)
  * to poll the ->work.need_resched flag instead of waiting for the
  * cross-CPU IPI to arrive. Use this option with caution.
  */
 static void poll_idle (void)
@@ -195,20 +215,18 @@ static inline void check_cpu_quiescent(v
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
  * low exit latency (ie sit in a loop waiting for
  * somebody to say that they'd like to reschedule)
  */
+static void (*idle)(void);
 void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			void (*idle)(void) = pm_idle;
-
 			if (!idle)
-				idle = default_idle;
-
+				idle = pm_idle ? pm_idle : default_idle;
 			check_cpu_quiescent();
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
 		}
 		schedule();
@@ -260,16 +278,18 @@ void __init select_idle_routine(const st
 
 static int __init idle_setup (char *str)
 {
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
-		pm_idle = poll_idle;
+		idle = poll_idle;
 	} else if (!strncmp(str, "halt", 4)) {
 		printk("using halt in idle threads.\n");
-		pm_idle = default_idle;
+		idle = default_idle;
+	} else if (!strncmp(str, "C1halt", 6)) {
+		printk("using C1 halt disconnect friendly idle threads.\n");
+		idle = c1halt_idle;
 	}
-
 	return 1;
 }
 
 __setup("idle=", idle_setup);
 

--Boundary-00=_ijXLAtQb19Zmf0h--

