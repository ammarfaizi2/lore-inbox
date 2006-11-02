Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752822AbWKBNVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbWKBNVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbWKBNVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:21:11 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:48573 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1752848AbWKBNVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:21:10 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Mel Gorman <mel@csn.ul.ie>, Vivek Goyal <vgoyal@in.ibm.com>,
       Andi Kleen <ak@muc.de>, magnus.damm@gmail.com, fastboot@lists.osdl.org,
       Magnus Damm <magnus@valinux.co.jp>
Date: Thu, 02 Nov 2006 22:19:34 +0900
Message-Id: <20061102131934.24684.93195.sendpatchset@localhost>
Subject: [PATCH] x86_64: setup saved_max_pfn correctly (kdump)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64: setup saved_max_pfn correctly

2.6.19-rc4 has broken CONFIG_CRASH_DUMP support on x86_64. It is impossible 
to read out the kernel contents from /proc/vmcore because saved_max_pfn is set
to zero instead of the max_pfn value before the user map is setup.

This happens because saved_max_pfn is initialized at parse_early_param() time,
and at this time no active regions have been registered. save_max_pfn is setup
from e820_end_of_ram(), more exact find_max_pfn_with_active_regions() which
returns 0 because no regions exist.

This patch fixes this by registering before and removing after the call
to e820_end_of_ram().

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 Applies to 2.6.19-rc4.

 arch/x86_64/kernel/e820.c |    2 ++
 1 file changed, 2 insertions(+)

--- 0002/arch/x86_64/kernel/e820.c
+++ work/arch/x86_64/kernel/e820.c	2006-11-02 21:37:19.000000000 +0900
@@ -594,7 +594,9 @@ static int __init parse_memmap_opt(char 
 		 * size before original memory map is
 		 * reset.
 		 */
+		e820_register_active_regions(0, 0, -1UL);
 		saved_max_pfn = e820_end_of_ram();
+		remove_all_active_ranges();
 #endif
 		end_pfn_map = 0;
 		e820.nr_map = 0;
