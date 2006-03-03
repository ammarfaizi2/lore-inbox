Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752235AbWCCJst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbWCCJst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752236AbWCCJst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:48:49 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:30994
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1752234AbWCCJst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:48:49 -0500
Message-Id: <44081F19.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 03 Mar 2006 10:48:57 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: cleanup after cpu_gdt_descr conversion to
	per-cpu data
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With cpu_gdt_descr having been converted to per-CPU data, the old object (in
head.S) no longer needs to reserve space for each CPU's instance.
With cpu_gdt_table not being used for CPU 0 anymore, it doesn't seem to need
page alignment (or if in fact there is a need for it to retain that alignment,
the whole object should go into .data.page_align).

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

--- /home/jbeulich/tmp/linux-2.6.16-rc5/arch/i386/kernel/head.S	2006-02-28 08:38:38.000000000 +0100
+++ 2.6.16-rc5-i386-cpu_gdt_descr-cleanup/arch/i386/kernel/head.S	2006-01-25 11:15:51.000000000 +0100
@@ -450,7 +450,6 @@ int_msg:
 
 .globl boot_gdt_descr
 .globl idt_descr
-.globl cpu_gdt_descr
 
 	ALIGN
 # early boot GDT descriptor (must use 1:1 address mapping)
@@ -470,8 +469,6 @@ cpu_gdt_descr:
 	.word GDT_ENTRIES*8-1
 	.long cpu_gdt_table
 
-	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
-
 /*
  * The boot_gdt_table must mirror the equivalent in setup.S and is
  * used only for booting.
@@ -485,7 +482,7 @@ ENTRY(boot_gdt_table)
 /*
  * The Global Descriptor Table contains 28 quadwords, per-CPU.
  */
-	.align PAGE_SIZE_asm
+	.align L1_CACHE_BYTES
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
 	.quad 0x0000000000000000	/* 0x0b reserved */

