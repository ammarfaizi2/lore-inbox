Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbUBPPEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265631AbUBPPEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:04:52 -0500
Received: from ns.suse.de ([195.135.220.2]:45274 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265572AbUBPPEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:04:50 -0500
Date: Mon, 16 Feb 2004 18:00:28 +0100
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: [PATCH] Disable useless bootmem warning
Message-Id: <20040216180028.06402e70.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This bootmem warning has been annoying me forever:

hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.

It happens because the i386/x86-64 boot code prereserves the mptable and then later bootmem
tries to reserve it again because it's marked reserved in the e820 map.

I've never seen a bug uncovered by this warning too. I considered to disable it 
by passing a special array of "ok to reserve twice" regions, but on second thought 
it is just best to remove it completely. Reserving things twice is not usually
an error.

This patch does this.

-Andi

--- linux-2.6.3rc2-amd64/mm/bootmem.c-o	2004-02-11 22:06:58.000000000 +0100
+++ linux-2.6.3rc2-amd64/mm/bootmem.c	2004-02-16 17:52:05.000000000 +0100
@@ -91,8 +91,7 @@
 	if (end > bdata->node_low_pfn)
 		BUG();
 	for (i = sidx; i < eidx; i++)
-		if (test_and_set_bit(i, bdata->node_bootmem_map))
-			printk("hm, page %08lx reserved twice.\n", i*PAGE_SIZE);
+		set_bit(i, bdata->node_bootmem_map);
 }
 
 static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
