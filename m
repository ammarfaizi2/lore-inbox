Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVI1VmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVI1VmR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVI1VmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:42:16 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:21514 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750909AbVI1VmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:42:16 -0400
Date: Wed, 28 Sep 2005 14:42:09 -0700
Message-Id: <200509282142.j8SLg9Z8032224@zach-dev.vmware.com>
Subject: [PATCH 1/3] Gdt page isolation fix
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 28 Sep 2005 21:42:09.0951 (UTC) FILETIME=[7ABF6AF0:01C5C475]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton's fix for PnP BIOS.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.14-rc1/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-rc1.orig/drivers/pnp/pnpbios/bioscalls.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.14-rc1/drivers/pnp/pnpbios/bioscalls.c	2005-09-28 13:13:42.000000000 -0700
@@ -69,14 +69,14 @@ __asm__(
 
 #define Q_SET_SEL(cpu, selname, address, size) \
 do { \
-set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], __va((u32)(address))); \
-set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \
+set_base(get_cpu_gdt_table(cpu)[(selname) >> 3], __va((u32)(address))); \
+set_limit(get_cpu_gdt_table(cpu)[(selname) >> 3], size); \
 } while(0)
 
 #define Q2_SET_SEL(cpu, selname, address, size) \
 do { \
-set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], (u32)(address)); \
-set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \
+set_base(get_cpu_gdt_table(cpu)[(selname) >> 3], (u32)(address)); \
+set_limit(get_cpu_gdt_table(cpu)[(selname) >> 3], size); \
 } while(0)
 
 static struct desc_struct bad_bios_desc = { 0, 0x00409200 };
@@ -115,8 +115,8 @@ static inline u16 call_pnp_bios(u16 func
 		return PNP_FUNCTION_NOT_SUPPORTED;
 
 	cpu = get_cpu();
-	save_desc_40 = per_cpu(cpu_gdt_table,cpu)[0x40 / 8];
-	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] = bad_bios_desc;
+	save_desc_40 = get_cpu_gdt_table(cpu)[0x40 / 8];
+	get_cpu_gdt_table(cpu)[0x40 / 8] = bad_bios_desc;
 
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
@@ -158,7 +158,7 @@ static inline u16 call_pnp_bios(u16 func
 	);
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 
-	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] = save_desc_40;
+	get_cpu_gdt_table(cpu)[0x40 / 8] = save_desc_40;
 	put_cpu();
 
 	/* If we get here and this is set then the PnP BIOS faulted on us. */
