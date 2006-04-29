Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWD2Xoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWD2Xoc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 19:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWD2Xnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 19:43:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:58109 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750833AbWD2XnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 19:43:17 -0400
Message-Id: <20060429233920.825603000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:18 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 06/13] powerpc: fix 64k pages on non-hypervisor
Content-Disposition: inline; filename=fix-tlbie-64k-page.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The page size encoding passed to tlbie is incorrect for
new-style large pages. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/mm/hash_native_64.c
===================================================================
--- linus-2.6.orig/arch/powerpc/mm/hash_native_64.c	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/arch/powerpc/mm/hash_native_64.c	2006-04-29 22:53:42.000000000 +0200
@@ -52,7 +52,7 @@
 	default:
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
-		va |= (0x7f >> (8 - penc)) << 12;
+		va |= penc << 12;
 		asm volatile("tlbie %0,1" : : "r" (va) : "memory");
 		break;
 	}
@@ -74,7 +74,7 @@
 	default:
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
-		va |= (0x7f >> (8 - penc)) << 12;
+		va |= penc << 12;
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
 			     : : "r"(va) : "memory");
 		break;

--

