Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTLJC5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTLJC5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:57:33 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:25823 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S263452AbTLJC51
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:57:27 -0500
Date: Tue, 9 Dec 2003 20:39:06 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Ross Dickson <ross@datscreative.com.au>
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031210033906.GA176@tesore.local>
References: <200312072312.01013.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <200312072312.01013.ross@datscreative.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ross,

I have rediffed your two patches for vanilla 2.6.0-test11.  Briefly, I tried the apic patch first, and found that there are no lockups so far; well it passed my grep tests and even a kernel compile =).  Then I tried your io_apic patch + apic patch.  With nmi_watchdog=1 "NMI:" in /proc/interrupts increments alot compared to nmi_watchdog=2 before (as much as the timer).  So I believe your two patches are more correct than the other two.  Especially the fact I can run with CPU Disconnect and not lock up just like windows ... for people that have windows (I dont have windows =) plus a probably working nmi_watchdog.

And for comparison, my setup:
Shuttle AN35N Ultra v 1.1  (Nforce2 400 ultra), bios updated
Athlon Barton 2600+ (1.9 Ghz)
256 MB PC3200, single stick.

The patches are included in this mail.  I suppose the next thing to do is get out of nvidia the corresponding information.  And then clean up the patch for inclusion.

Jesse



--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nforce2-apic-delay-2.6t11.patch"

--- linux/arch/i386/kernel/apic.c	2003-10-25 11:44:59.000000000 -0700
+++ linux-jla/arch/i386/kernel/apic.c	2003-12-09 19:07:19.000000000 -0700
@@ -1089,6 +1089,16 @@
 	 */
 	irq_stat[cpu].apic_timer_irqs++;
 
+#ifdef CONFIG_MK7 && CONFIG_BLK_DEV_AMD74XX
+
+	/*
+	 * on 2200XP & nforce2 chipset we need at least 500ns delay here
+	 * to stop lockups with udma100 drive. try to scale delay time
+	 * with cpu speed. Ross Dickson.
+	 */
+	ndelay((cpu_khz >> 12)+200 ); /* don't ack too soon or hard lockup */
+#endif
+
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
 	 * because timer handling can be slow.

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nforce2-ioapic-timer-2.6t11.patch"

--- linux/arch/i386/kernel/io_apic.c	2003-10-25 11:43:20.000000000 -0700
+++ linux-jla/arch/i386/kernel/io_apic.c	2003-12-09 19:56:07.000000000 -0700
@@ -2128,6 +2128,41 @@
 		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}
 
+#ifdef CONFIG_ACPI_BOOT && CONFIG_X86_UP_IOAPIC
+	/* for nforce2 try vector 0 on pin0
+	 * Note the io_apic_set_pci_routing call disables the 8259 irq 0
+	 * so we must be connected directly to the 8254 timer if this works
+	 * Note2: this violates the above comment re Subtle but works!
+	 */
+	printk(KERN_INFO "..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...\n");
+	if ( pin1 != -1 && nr_ioapics ) {
+		int saved_timer_ack = timer_ack;
+		/* next call also disables 8259 irq0 */
+		int result = io_apic_set_pci_routing ( 0, 0, 0, 0, 0);
+		/*
+		 * Ok, does IRQ0 through the IOAPIC work?
+		 */
+		unmask_IO_APIC_irq(0);
+		timer_ack = 0 ;
+		if (timer_irq_works()) {
+			if (nmi_watchdog == NMI_IO_APIC) {
+				disable_8259A_irq(0);
+				setup_nmi();
+				enable_8259A_irq(0);
+				check_nmi_watchdog();
+			}
+			printk(KERN_INFO "..TIMER: works OK on apic pin0 irq0\n" );
+			return;
+		}
+		/* failed */
+		timer_ack = saved_timer_ack;
+		clear_IO_APIC_pin(0, 0);
+		result = io_apic_set_pci_routing ( 0, pin1, 0, 0, 0);
+		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC Pin 0\n");
+	}
+#endif
+/* end new stuff for nforce2 */
+
 	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
 	if (pin2 != -1) {
 		printk("\n..... (found pin %d) ...", pin2);

--C7zPtVaVf+AK4Oqc--
