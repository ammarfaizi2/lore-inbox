Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265895AbUBPRJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUBPRJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:09:43 -0500
Received: from ns.suse.de ([195.135.220.2]:15278 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265895AbUBPRJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:09:41 -0500
Date: Mon, 16 Feb 2004 20:13:34 +0100
From: Andi Kleen <ak@suse.de>
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [PATCH] Disable useless bootmem warning
Message-Id: <20040216201334.07ab2aa8.ak@suse.de>
In-Reply-To: <20040216165211.GC2389@phunnypharm.org>
References: <20040216180028.06402e70.ak@suse.de>
	<20040216165211.GC2389@phunnypharm.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004 11:52:11 -0500
Ben Collins <bcollins@debian.org> wrote:

> > I've never seen a bug uncovered by this warning too. I considered to disable it 
> > by passing a special array of "ok to reserve twice" regions, but on second thought 
> > it is just best to remove it completely. Reserving things twice is not usually
> > an error.
> 
> I have. When I was working to get sparc64 booting from alternate memory
> (other than 0x0 physical), those messages helped me a lot.
> 
> Maybe make it ifdef'd by CONFIG_DEBUG_BOOTMEM (which is an option that I
> know sparc and sparc64 already have).

That would be fine by me too.  Anything, as long as I don't have to see them ;-)

Here's a new patch.

-Andi

diff -u linux-2.6.2-work32/mm/bootmem.c-o linux-2.6.2-work32/mm/bootmem.c
--- linux-2.6.2-work32/mm/bootmem.c-o	2004-02-11 22:06:58.000000000 +0100
+++ linux-2.6.2-work32/mm/bootmem.c	2004-02-16 20:11:10.000000000 +0100
@@ -91,8 +91,11 @@
 	if (end > bdata->node_low_pfn)
 		BUG();
 	for (i = sidx; i < eidx; i++)
-		if (test_and_set_bit(i, bdata->node_bootmem_map))
+		if (test_and_set_bit(i, bdata->node_bootmem_map)) { 
+#ifdef CONFIG_DEBUG_BOOTMEM
 			printk("hm, page %08lx reserved twice.\n", i*PAGE_SIZE);
+#endif
+		}
 }
 
 static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
