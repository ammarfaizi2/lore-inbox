Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTDRPPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 11:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbTDRPPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 11:15:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20413 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262770AbTDRPPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 11:15:16 -0400
Date: Fri, 18 Apr 2003 08:26:31 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: marcelo@conectiva.com.br
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] update unexpected IO APIC detection
Message-Id: <20030418082631.3052a97c.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates 2.4.21-pre to use the same IO APIC data structures
and detection as 2.5.67.  This will help reduce the number of emails
about UNEXPECTED IO APIC detected, which are mostly noise.

Please apply.

--
~Randy



--- linux-2421-pre7/include/asm-i386/io_apic.h	2003-04-16 21:34:08.000000000 +0000
+++ linux/include/asm-i386/io_apic.h	2003-04-07 17:31:56.000000000 +0000
@@ -22,9 +23,12 @@
  * The structure of the IO-APIC:
  */
 struct IO_APIC_reg_00 {
-	__u32	__reserved_2	: 24,
+	__u32	__reserved_2	: 14,
+		LTS		:  1,
+		delivery_type	:  1,
+		__reserved_1	:  8,
 		ID		:  4,
-		__reserved_1	:  4;
+		__reserved_0	:  4;
 } __attribute__ ((packed));
 
 struct IO_APIC_reg_01 {
--- linux-2421-pre7/arch/i386/kernel/io_apic.c	2003-04-16 21:34:02.000000000 +0000
+++ linux/arch/i386/kernel/io_apic.c	2003-04-16 21:32:46.000000000 +0000
@@ -776,7 +1286,9 @@ void __init print_IO_APIC(void)
 	printk(KERN_DEBUG "IO APIC #%d......\n", mp_ioapics[apic].mpc_apicid);
 	printk(KERN_DEBUG ".... register #00: %08X\n", *(int *)&reg_00);
 	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.ID);
-	if (reg_00.__reserved_1 || reg_00.__reserved_2)
+	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.delivery_type);
+	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
+	if (reg_00.__reserved_0 || reg_00.__reserved_1 || reg_00.__reserved_2)
 		UNEXPECTED_IO_APIC();
 
 	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
