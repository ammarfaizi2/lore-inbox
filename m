Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbUKOUlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbUKOUlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUKOUjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:39:48 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:1000 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S261691AbUKOUfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:35:18 -0500
Date: Mon, 15 Nov 2004 15:35:14 -0500 (EST)
From: Nickolai Zeldovich <kolya@MIT.EDU>
To: linux-kernel@vger.kernel.org
cc: csapuntz@stanford.edu
Subject: [patch] Fix GDT re-load on ACPI resume
Message-ID: <Pine.GSO.4.58L.0411151525540.28749@contents-vnder-pressvre.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI resume code currently uses a real-mode 16-bit lgdt instruction to
reload the GDT.  This only restores the lower 24 bits of the GDT base
address.  In recent kernels, the GDT seems to have moved out of the lower
16 megs, thereby causing the ACPI resume to fail -- an invalid GDT was
being loaded.

This simple patch adds the 0x66 prefix to lgdt, which forces it to load
all 32 bits of the GDT base address, thereby removing any restrictions on
where the GDT can be placed in memory.  This makes ACPI resume work for me
on a Thinkpad T40 laptop.

-- kolya

--- linux-2.6.9/arch/i386/kernel/acpi/wakeup.S	2004/11/15 09:00:34	1.1
+++ linux-2.6.9/arch/i386/kernel/acpi/wakeup.S	2004/11/15 20:33:27
@@ -67,6 +67,8 @@
 	movw	$0x0e00 + 'i', %fs:(0x12)

 	# need a gdt
+	.byte	0x66			# force 32-bit operands in case
+					# the GDT is past 16 megabytes
 	lgdt	real_save_gdt - wakeup_code

 	movl	real_save_cr0 - wakeup_code, %eax
