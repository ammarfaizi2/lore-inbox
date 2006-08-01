Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbWHALG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbWHALG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWHALGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53724 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932620AbWHALFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:24 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/33] i386 setup.c: Reserve kernel memory starting from _text
Date: Tue,  1 Aug 2006 05:03:18 -0600
Message-Id: <11544302303305-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when we are reserving the memory the kernel text
resides in we start at __PHYSICAL_START which happens to be
correct but not very obvious.  In addition when we start relocating
the kernel __PHYSICAL_START is the wrong value, as it is an
absolute symbol that does not get relocated.

By starting the reservation at __pa_symbol(_text)
the code is clearer and will be correct when relocated.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index f168220..f3a451a 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -1219,8 +1219,8 @@ void __init setup_bootmem_allocator(void
 	 * the (very unlikely) case of us accidentally initializing the
 	 * bootmem allocator with an invalid RAM area.
 	 */
-	reserve_bootmem(__PHYSICAL_START, (PFN_PHYS(min_low_pfn) +
-			 bootmap_size + PAGE_SIZE-1) - (__PHYSICAL_START));
+	reserve_bootmem(__pa_symbol(_text), (PFN_PHYS(min_low_pfn) +
+			 bootmap_size + PAGE_SIZE-1) - __pa_symbol(_text));
 
 	/*
 	 * reserve physical page 0 - it's a special BIOS page on many boxes,
-- 
1.4.2.rc2.g5209e

