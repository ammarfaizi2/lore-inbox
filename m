Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288487AbSADE4X>; Thu, 3 Jan 2002 23:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288488AbSADE4O>; Thu, 3 Jan 2002 23:56:14 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:3594 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S288487AbSADE4E>; Thu, 3 Jan 2002 23:56:04 -0500
Date: Thu, 3 Jan 2002 22:56:00 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020103225600.A12884@asooo.flowerfire.com>
In-Reply-To: <3C2CD326.100@athlon.maya.org>, <3C2CD326.100@athlon.maya.org>; <20020103142301.C4759@asooo.flowerfire.com> <3C34D306.F0893D1B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C34D306.F0893D1B@zip.com.au>; from akpm@zip.com.au on Thu, Jan 03, 2002 at 01:54:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I posted about C) many moons ago, and had some chats with
Manfred Spraul and Alan.  It's a tough one to crack, and I have my own
workaround patch (below) that I've been using for a while now.  My posts
are in the archives, but I can send a summary by request.

I haven't succeeded my bag check in putting -aa in production, which is
where I'm able to reproduce these problems.  Part of the problem is me,
in that I can't easily test with -aa.  And part of the problem is
chicken vs egg -- can't test unless it's in mainline, don't want to put
questionable stuff in a release kernel, even a -pre...  But I do think
the -aa stuff is worth breaking out into Marcelo-digestable chunks as
soon as Andrea can.

The machines that are OOPSing are in production and right now don't have
serial consoles available... that will change in a month or so, but
right now I can't decode OOPSes without hand-copying.  I might get that
desparate unless the problem goes away with 2.4.18 (with -aa merged,
hopefully.  :)

Thanks much,
-- 
Ken.
brownfld@irridia.com


Applies to any recent 2.4.  Changing indent sucks.

--- linux/arch/i386/kernel/io_apic.c.orig	Tue Nov 13 17:28:41 2001
+++ linux/arch/i386/kernel/io_apic.c	Tue Dec 18 15:10:45 2001
@@ -172,6 +172,7 @@
 int pirq_entries [MAX_PIRQS];
 int pirqs_enabled;
 int skip_ioapic_setup;
+int pintimer_setup;
 
 static int __init ioapic_setup(char *str)
 {
@@ -179,7 +180,14 @@
 	return 1;
 }
 
+static int __init do_pintimer_setup(char *str)
+{
+	pintimer_setup = 1;
+	return 1;
+}
+
 __setup("noapic", ioapic_setup);
+__setup("pintimer", do_pintimer_setup);
 
 static int __init ioapic_pirq_setup(char *str)
 {
@@ -1524,27 +1532,31 @@
 		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}
 
-	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
-	if (pin2 != -1) {
-		printk("\n..... (found pin %d) ...", pin2);
-		/*
-		 * legacy devices should be connected to IO APIC #0
-		 */
-		setup_ExtINT_IRQ0_pin(pin2, vector);
-		if (timer_irq_works()) {
-			printk("works.\n");
-			if (nmi_watchdog == NMI_IO_APIC) {
-				setup_nmi();
-				check_nmi_watchdog();
+	if ( pintimer_setup )
+		printk(KERN_INFO "...skipping 8259A init for IRQ0\n");
+	else {
+		printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
+		if (pin2 != -1) {
+			printk("\n..... (found pin %d) ...", pin2);
+			/*
+			 * legacy devices should be connected to IO APIC #0
+			 */
+			setup_ExtINT_IRQ0_pin(pin2, vector);
+			if (timer_irq_works()) {
+				printk("works.\n");
+				if (nmi_watchdog == NMI_IO_APIC) {
+					setup_nmi();
+					check_nmi_watchdog();
+				}
+				return;
 			}
-			return;
+			/*
+			 * Cleanup, just in case ...
+			 */
+			clear_IO_APIC_pin(0, pin2);
 		}
-		/*
-		 * Cleanup, just in case ...
-		 */
-		clear_IO_APIC_pin(0, pin2);
+		printk(" failed.\n");
 	}
-	printk(" failed.\n");
 
 	if (nmi_watchdog) {
 		printk(KERN_WARNING "timer doesnt work through the IO-APIC - disabling NMI Watchdog!\n");
On Thu, Jan 03, 2002 at 01:54:14PM -0800, Andrew Morton wrote:
| Ken Brownfield wrote:
| > 
| > Unfortunately, I lost the response that basically said "2.4 looks stable
| > to me", but let me count the ways in which I agree with Andreas'
| > sentiment:
| > 
| >         A) VM has major issues
| >                 1) about a dozen recent OOPS reports in VM code
| 
| Ben LaHaise's fix for page_cache_release() is absolutely required.
| 
| >                 2) VM falls down on large-memory machines with a
| >                    high inode count (slocate/updatedb, i/dcache)
| >                 3) Memory allocation failures and OOM triggers
| >                    even though caches remain full.
| >                 4) Other bugs fixed in -aa and others
| >         B) Live- and dead-locks that I'm seeing on all 2.4 production
| >            machines > 2.4.9, possibly related to A.  But how will I
| >            ever find out?
| 
| Does this happen with the latest -aa patch?  If so, please send
| a full system description and report.
| 
| >         C) IO-APIC code that requires noapic on any and all SMP
| >            machines that I've ever run on.
| 
| Dunno about this one.  Have you prepared a description?
|  
| 
| -
