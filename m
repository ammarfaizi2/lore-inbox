Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVI1VrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVI1VrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVI1VrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:47:19 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:17929 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750992AbVI1VrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:47:18 -0400
Date: Wed, 28 Sep 2005 14:43:07 -0700
Message-Id: <200509282143.j8SLh7dY032231@zach-dev.vmware.com>
Subject: [PATCH 2/3] Pnp bios gdt fix
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
X-OriginalArrivalTime: 28 Sep 2005 21:43:08.0073 (UTC) FILETIME=[9D642190:01C5C475]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PnP BIOS for x86 is part of drivers, so I missed it in the initial
GDT page alignment patch.  Kudos to Andrew for fixing that.
Unfortunately, fixing the build introduced a kernel panic when
trying to setup the as of yet unallocated GDTs for the APs.
This fixes the problem by setting only the BSP's GDT, then copying
the PnP segments back to the cpu_gdt_table template.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-rc2/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/pnp/pnpbios/bioscalls.c	2005-09-28 14:16:34.000000000 -0700
+++ linux-2.6.14-rc2/drivers/pnp/pnpbios/bioscalls.c	2005-09-28 14:23:57.000000000 -0700
@@ -528,17 +528,24 @@ static int pnp_bios_write_escd(char *dat
 
 void pnpbios_calls_init(union pnp_bios_install_struct *header)
 {
-	int i;
 	spin_lock_init(&pnp_bios_lock);
 	pnp_bios_callpoint.offset = header->fields.pm16offset;
 	pnp_bios_callpoint.segment = PNP_CS16;
 
 	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
 	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
-	for(i=0; i < NR_CPUS; i++)
-	{
-		Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
-		Q_SET_SEL(i, PNP_CS16, header->fields.pm16cseg, 64 * 1024);
-		Q_SET_SEL(i, PNP_DS, header->fields.pm16dseg, 64 * 1024);
-	}
+
+	/*
+	 * This is awkward; GDT entries needed for this driver must
+	 * be set during init on the BSP, but also copied into the
+	 * cpu_gdt_table template for the APs to acquire.  This is
+	 * because APs will not have allocated GDTs until later in
+	 * the boot process.
+	 */
+	Q2_SET_SEL(0, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
+	Q_SET_SEL(0, PNP_CS16, header->fields.pm16cseg, 64 * 1024);
+	Q_SET_SEL(0, PNP_DS, header->fields.pm16dseg, 64 * 1024);
+	memcpy(&cpu_gdt_table[GDT_ENTRY_PNPBIOS_BASE],
+		&get_cpu_gdt_table(0)[GDT_ENTRY_PNPBIOS_BASE],
+		3 * sizeof(struct desc_struct));
 }
