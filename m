Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbVL2I1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbVL2I1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVL2I1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:27:20 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51625 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965055AbVL2I1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:27:20 -0500
Date: Thu, 29 Dec 2005 13:57:09 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Andi Kleen <ak@muc.de>, Morton Andrew Morton <akpm@osdl.org>
Subject: [PATCH] x86_64 write apic id fix
Message-ID: <20051229082709.GB1626@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o Apic id is in most significant 8 bits of APIC_ID register. Current code
  is trying to write apic id to least significant 8 bits. This patch fixes
  it.

o This fix enables booting uni kdump capture kernel on a cpu with non-zero
  apic id.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---


diff -puN arch/x86_64/kernel/apic.c~kdump-up-kernel-non-boot-cpu-fix arch/x86_64/kernel/apic.c
--- linux-2.6.15-rc5-mm3-16M/arch/x86_64/kernel/apic.c~kdump-up-kernel-non-boot-cpu-fix	2005-12-27 10:38:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3-16M-root/arch/x86_64/kernel/apic.c	2005-12-27 10:39:31.000000000 -0800
@@ -1060,7 +1060,7 @@ int __init APIC_init_uniprocessor (void)
 	connect_bsp_APIC();
 
 	phys_cpu_present_map = physid_mask_of_physid(boot_cpu_id);
-	apic_write_around(APIC_ID, boot_cpu_id);
+	apic_write_around(APIC_ID, SET_APIC_ID(boot_cpu_id));
 
 	setup_local_APIC();
 
diff -puN include/asm-x86_64/apicdef.h~kdump-up-kernel-non-boot-cpu-fix include/asm-x86_64/apicdef.h
--- linux-2.6.15-rc5-mm3-16M/include/asm-x86_64/apicdef.h~kdump-up-kernel-non-boot-cpu-fix	2005-12-27 10:38:25.000000000 -0800
+++ linux-2.6.15-rc5-mm3-16M-root/include/asm-x86_64/apicdef.h	2005-12-27 10:39:02.000000000 -0800
@@ -13,6 +13,7 @@
 #define		APIC_ID		0x20
 #define			APIC_ID_MASK		(0xFFu<<24)
 #define			GET_APIC_ID(x)		(((x)>>24)&0xFFu)
+#define			SET_APIC_ID(x)		(((x)<<24))
 #define		APIC_LVR	0x30
 #define			APIC_LVR_MASK		0xFF00FF
 #define			GET_APIC_VERSION(x)	((x)&0xFFu)
_
