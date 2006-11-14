Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966144AbWKNQJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966144AbWKNQJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966142AbWKNQJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:09:26 -0500
Received: from cantor2.suse.de ([195.135.220.15]:26253 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933452AbWKNQJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:09:01 -0500
From: Andi Kleen <ak@suse.de>
References: <20061114508.445749000@suse.de>
In-Reply-To: <20061114508.445749000@suse.de>
To: Magnus Damm <magnus@valinux.co.jp>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.19] [5/9] x86_64: setup saved_max_pfn correctly (kdump)
Message-Id: <20061114160855.BD53413DD4@wotan.suse.de>
Date: Tue, 14 Nov 2006 17:08:55 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Magnus Damm <magnus@valinux.co.jp>
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
Signed-off-by: Andi Kleen <ak@suse.de>

---

 Applies to 2.6.19-rc4.

 arch/x86_64/kernel/e820.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux/arch/x86_64/kernel/e820.c
===================================================================
--- linux.orig/arch/x86_64/kernel/e820.c
+++ linux/arch/x86_64/kernel/e820.c
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
