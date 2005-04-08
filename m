Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVDHQO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVDHQO6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVDHQO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:14:58 -0400
Received: from [213.202.245.43] ([213.202.245.43]:29087 "EHLO
	buildd1.paldo.org") by vger.kernel.org with ESMTP id S262851AbVDHQOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:14:37 -0400
Subject: [PATCH] Fix reloading GDT on ACPI S3 wakeup
From: Juerg Billeter <juerg@paldo.org>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: paldo
Date: Fri, 08 Apr 2005 18:14:13 +0200
Message-Id: <1112976854.8880.15.camel@juerg-p4.bitron.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patch - based on
http://marc.theaimsgroup.com/?l=linux-kernel&m=110055503031009&w=2 -
makes ACPI S3 wakeup work for me on a ThinkPad T40p laptop with a SMP
kernel. Without it only UP kernels work. I've been using the patch for
three months now without any issues.

The ACPI resume code currently uses a real-mode 16-bit lgdt instruction
to reload the GDT.  This only restores the lower 24 bits of the GDT base
address.  In recent SMP kernels, the GDT seems to have moved out of the
lower 16 megs, thereby causing the ACPI resume to fail -- an invalid GDT
was being loaded.

Regards,

Juerg

--
Signed-off-by: Juerg Billeter <juerg@paldo.org>

diff -uNr linux-2.6.10.orig/arch/i386/kernel/acpi/wakeup.S linux-2.6.10/arch/i386/kernel/acpi/wakeup.S
--- linux-2.6.10.orig/arch/i386/kernel/acpi/wakeup.S	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.10/arch/i386/kernel/acpi/wakeup.S	2005-01-08 23:34:38.551471486 +0100
@@ -74,8 +74,9 @@
 	movw	%ax,%fs
 	movw	$0x0e00 + 'i', %fs:(0x12)
 	
-	# need a gdt
-	lgdt	real_save_gdt - wakeup_code
+	# need a gdt -- use lgdtl to force 32-bit operands, in case
+	# the GDT is located past 16 megabytes
+	lgdtl	real_save_gdt - wakeup_code
 
 	movl	real_save_cr0 - wakeup_code, %eax
 	movl	%eax, %cr0


