Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTFXWeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTFXWeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:34:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:58023 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262543AbTFXWeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:34:08 -0400
Date: Tue, 24 Jun 2003 15:45:05 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: marcelo@conectiva.com.br, macro@ds2.pg.gda.pl
Subject: PATCH] unexpected IO-APIC update
Message-Id: <20030624154505.5681941a.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Recently there has been a rash of Unexpected IO APIC reports on
the linux-smp mailing list.  Most of the most recent ones are due
to some newer Intel chipsets (865, 875).

I have an patch that addresses these chipsets.  It has been
tested by a few people with good results and has been blessed
by Maciej Rozycki.

Other than conditionally decoding IO APIC registers 2 and 3,
we could alternately ignore them since Linux doesn't use the values
for anything other than printing them.

This patch ignores IO APIC register 2 if it's the same value as IO APIC
register 1.  It also reads IO APIC register 3 if the IO APIC
version is >= 0x20, but some chipsets don't support this
register, so it is also ignored if it's value if the same as IO APIC
register 1 or 2.

The IO APIC Version register doesn't indicate the differences in
these IO APICs.


Patch for 2.4.22-pre1 is below.  Please apply.

--
~Randy
~ http://developer.osdl.org/rddunlap/ ~ http://www.xenotime.net/linux/ ~


patch_name:	ioapic_update_2422.patch
patch_version:	2003-06-24.15:25:38
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	support newer Intel chipset IO APICs;
product:	Linux
product_versions: linux-2422-pre1
maintainer:	Maciej W. Rozycki <macro@ds2.pg.gda.pl>
diffstat:	=
 arch/i386/kernel/io_apic.c |   23 ++++++++++++++++++++++-
 include/asm-i386/io_apic.h |    5 +++++
 2 files changed, 27 insertions(+), 1 deletion(-)


diff -Naur ./include/asm-i386/io_apic.h~ioap ./include/asm-i386/io_apic.h
--- ./include/asm-i386/io_apic.h~ioap	2003-06-13 09:11:32.000000000 -0700
+++ ./include/asm-i386/io_apic.h	2003-06-13 14:45:37.000000000 -0700
@@ -44,6 +44,11 @@
 		__reserved_1	:  4;
 } __attribute__ ((packed));
 
+struct IO_APIC_reg_03 {
+	__u32	boot_DT		:  1,
+		__reserved_1	: 31;
+} __attribute__ ((packed));
+
 /*
  * # of IO-APICs and # of IRQ routing registers
  */
diff -Naur ./arch/i386/kernel/io_apic.c~ioap ./arch/i386/kernel/io_apic.c
--- ./arch/i386/kernel/io_apic.c~ioap	2003-06-13 07:51:29.000000000 -0700
+++ ./arch/i386/kernel/io_apic.c	2003-06-13 15:34:33.000000000 -0700
@@ -752,6 +752,7 @@
 	struct IO_APIC_reg_00 reg_00;
 	struct IO_APIC_reg_01 reg_01;
 	struct IO_APIC_reg_02 reg_02;
+	struct IO_APIC_reg_03 reg_03;
 	unsigned long flags;
 
  	printk(KERN_DEBUG "number of MP IRQ sources: %d.\n", mp_irq_entries);
@@ -772,6 +773,8 @@
 	*(int *)&reg_01 = io_apic_read(apic, 1);
 	if (reg_01.version >= 0x10)
 		*(int *)&reg_02 = io_apic_read(apic, 2);
+	if (reg_01.version >= 0x20)
+		*(int *)&reg_03 = io_apic_read(apic, 3);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	printk("\n");
@@ -809,13 +812,31 @@
 	if (reg_01.__reserved_1 || reg_01.__reserved_2)
 		UNEXPECTED_IO_APIC();
 
-	if (reg_01.version >= 0x10) {
+	/*
+	 * Some Intel chipsets with IO APIC VERSION of 0x1? don't have reg_02,
+	 * but the value of reg_02 is read as the previous read register
+	 * value, so ignore it if reg_02 == reg_01.
+	 */
+	if (reg_01.version >= 0x10 && *(int *)&reg_02 != *(int *)&reg_01) {
 		printk(KERN_DEBUG ".... register #02: %08X\n", *(int *)&reg_02);
 		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.arbitration);
 		if (reg_02.__reserved_1 || reg_02.__reserved_2)
 			UNEXPECTED_IO_APIC();
 	}
 
+	/*
+	 * Some Intel chipsets with IO APIC VERSION of 0x2? don't have reg_02
+	 * or reg_03, but the value of reg_0[23] is read as the previous read
+	 * register value, so ignore it if reg_03 == reg_0[12].
+	 */
+	if (reg_01.version >= 0x20 && *(int *)&reg_03 != *(int *)&reg_02 &&
+	    *(int *)&reg_03 != *(int *)&reg_01) {
+		printk(KERN_DEBUG ".... register #03: %08X\n", *(int *)&reg_03);
+		printk(KERN_DEBUG ".......     : Boot DT    : %X\n", reg_03.boot_DT);
+		if (reg_03.__reserved_1)
+			UNEXPECTED_IO_APIC();
+	}
+
 	printk(KERN_DEBUG ".... IRQ redirection table:\n");
 
 	printk(KERN_DEBUG " NR Log Phy Mask Trig IRR Pol"
