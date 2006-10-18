Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWJRGoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWJRGoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 02:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWJRGoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 02:44:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:33006 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964778AbWJRGoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 02:44:10 -0400
Message-ID: <4535CD32.2010502@impulze.org>
Date: Wed, 18 Oct 2006 08:44:02 +0200
From: Daniel Mierswa <impulze@impulze.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061018)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ASUS M2NPV-VM APIC/ACPI Bug (patched)
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:477985ecf28e42b783e12f32bfe78b70
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people have deeper problems with the Asus M2NPV-VM mainboard
(rather the chipset of the mainboard).
A google for "Asus M2NPV-VM apic" shows that. I'm one of them,
desperately searching a way to fix that, using that board with an AMD
Athlon64 X2 3800+ Dual Core Processor.
It wouldn't boot because of APIC and ACPI errors. There were "kind of"
workarounds by passing acpi=off/noirq and noapic to the kernel which
resulted in sometimes bad internal clock. I for myself had the same
problem and due to the error with my internal system clock all
applications and drivers gone mad, including
sound,video,graphics,usb,etc.. I googled around and saw the following:
http://lkml.org/lkml/2006/8/13/25
Actually that was a patch created for the 2.6.18-rc4 kernel. I tried
several kernels all with the same results. Some of them are
2.6.18-mm3, 2.6.19-rc2, 2.6.17, 2.6.18, 2.6.18.1, some gentoo patched
sources and what not. All will hang after the io scheduler gets loaded,
passing acpi=off/noirq to the kernel will workaround that one. Then it
will boot on and finally reach the ochi_hcd driver which will not load
because of shared IRQ problems, passing nousb to the kernel will
workaround that. It will boot more and come to the dhcp client, where it
fails because of an Interrupt error.
Some people passing noapic acpi=off/noirq to the kernel got later sound
problems, they fixed that by passing "snd-hda-intel model=3stack
position_fix=1" which worked around that interrupt problem. So with the
patch provided on http://lkml.org/lkml/2006/8/13/25 it all works out.
The internal system clock works just fine, the drivers load
 all fine, no need to patch the sound,graphics or anything at all. No
need for kernel parameters either. Here's the patch again, created by
diff -ur on the current 2.6.18.1 kernel:

--- io_apic.c.orig	2006-10-18 08:02:50.000000000 +0200
+++ io_apic.c	2006-10-18 07:40:48.000000000 +0200
@@ -337,12 +337,12 @@
 					nvidia_hpet_detected = 0;
 					acpi_table_parse(ACPI_HPET,
 							nvidia_hpet_check);
-					if (nvidia_hpet_detected == 0) {
+/*					if (nvidia_hpet_detected == 0) {
 						acpi_skip_timer_override = 1;
 						printk(KERN_INFO "Nvidia board "
 						    "detected. Ignoring ACPI "
 						    "timer override.\n");
-					}
+					}*/
 #endif
 					/* RED-PEN skip them on mptables too? */
 					return;

Is there a small chance by getting that fixed in next kernel versions?
Greets impulze

