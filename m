Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUHII3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUHII3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266256AbUHII3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:29:46 -0400
Received: from holomorphy.com ([207.189.100.168]:56285 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266257AbUHII3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:29:38 -0400
Date: Mon, 9 Aug 2004 01:29:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040809082926.GJ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040808152936.1ce2eab8.akpm@osdl.org> <200408090820.i798Kbj07417@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408090820.i798Kbj07417@owlet.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 01:20:37AM -0700, Rick Lindsley wrote:
> Got complaints from arch/i386/mm/discontig.c:
[...]
> arch/i386/mm/discontig.c:430: warning: passing arg 3 of `free_area_init_node' from incompatible pointer type
> arch/i386/mm/discontig.c:430: warning: passing arg 4 of `free_area_init_node' makes integer from pointer without a cast
> arch/i386/mm/discontig.c:430: warning: passing arg 5 of `free_area_init_node' makes pointer from integer without a cast
> arch/i386/mm/discontig.c:430: too many arguments to function `free_area_init_node'
> Looks like I can't get by with just deleting the third argument in the
> second case.

Initializing NODE_DATA(nid)->node_mem_map prior to calling it should do.

Index: mm2-2.6.8-rc3/arch/i386/mm/discontig.c
===================================================================
--- mm2-2.6.8-rc3.orig/arch/i386/mm/discontig.c	2004-08-08 15:39:24.000000000 -0700
+++ mm2-2.6.8-rc3/arch/i386/mm/discontig.c	2004-08-09 01:17:17.815702160 -0700
@@ -425,8 +425,8 @@
 			lmem_map = (unsigned long)node_remap_start_vaddr[nid];
 			lmem_map += sizeof(pg_data_t) + PAGE_SIZE - 1;
 			lmem_map &= PAGE_MASK;
-			free_area_init_node(nid, NODE_DATA(nid), 
-				(struct page *)lmem_map, zones_size, 
+			NODE_DATA(nid)->node_mem_map = (struct page *)lmem_map;
+			free_area_init_node(nid, NODE_DATA(nid), zones_size, 
 				start, zholes_size);
 		}
 	}
