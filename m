Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWCBNSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWCBNSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWCBNSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:18:55 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:63387
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1750923AbWCBNSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:18:54 -0500
Message-ID: <4406F0C2.7090002@ed-soft.at>
Date: Thu, 02 Mar 2006 14:18:58 +0100
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EFI: Fix gdt load
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------070405080104030404090006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070405080104030404090006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch makes the kernel bootable again on ia32 EFI systems.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

--------------070405080104030404090006
Content-Type: text/x-patch;
 name="2.6.15-rc5_efi_gdt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.15-rc5_efi_gdt.patch"

diff -uNr linux-2.6.16-rc5/arch/i386/kernel/efi.c linux-2.6.16-rc5.efi/arch/i386/kernel/efi.c
--- linux-2.6.16-rc5/arch/i386/kernel/efi.c	2006-03-02 14:08:06.000000000 +0100
+++ linux-2.6.16-rc5.efi/arch/i386/kernel/efi.c	2006-03-02 14:04:44.000000000 +0100
@@ -70,7 +70,8 @@
 {
 	unsigned long cr4;
 	unsigned long temp;
-
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, 0);
+	
 	spin_lock(&efi_rt_lock);
 	local_irq_save(efi_rt_eflags);
 
@@ -103,18 +104,17 @@
 	 */
 	local_flush_tlb();
 
-	per_cpu(cpu_gdt_descr, 0).address =
-				 __pa(per_cpu(cpu_gdt_descr, 0).address);
-	load_gdt((struct Xgt_desc_struct *)__pa(&per_cpu(cpu_gdt_descr, 0)));
+	cpu_gdt_descr->address = __pa(cpu_gdt_descr->address);
+	load_gdt(cpu_gdt_descr);
 }
 
 static void efi_call_phys_epilog(void)
 {
 	unsigned long cr4;
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, 0);
 
-	per_cpu(cpu_gdt_descr, 0).address =
-			(unsigned long)__va(per_cpu(cpu_gdt_descr, 0).address);
-	load_gdt((struct Xgt_desc_struct *)__va(&per_cpu(cpu_gdt_descr, 0)));
+	cpu_gdt_descr->address = __va(cpu_gdt_descr->address);
+	load_gdt(cpu_gdt_descr);
 
 	cr4 = read_cr4();
 

--------------070405080104030404090006--
