Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310241AbSCLAic>; Mon, 11 Mar 2002 19:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310243AbSCLAiN>; Mon, 11 Mar 2002 19:38:13 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:20889 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S310252AbSCLAiE>; Mon, 11 Mar 2002 19:38:04 -0500
Date: Mon, 11 Mar 2002 18:37:46 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
Message-ID: <20020311183746.A10303@asooo.flowerfire.com>
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Mar 11, 2002 at 06:08:19PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can the authors of this patch post separately on what is fixed here?  I
apply the following patch to work around an eventual hang of the machine
due to IRQ0 being "attached" to the IO APIC, and I'm hoping that this
2.4.19-pre3 patch fixes my problem the correct way.  V.s. my workaround
hack.

Thanks much,
-- 
Ken.
brownfld@irridia.com

On Mon, Mar 11, 2002 at 06:08:19PM -0300, Marcelo Tosatti wrote:
| - Fix through-8259A mode for IRQ0 routing on APIC 	(Maciej W. Rozycki/Joe Korty)


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
