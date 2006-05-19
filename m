Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWESNmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWESNmr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 09:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWESNmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 09:42:47 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:56295 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932312AbWESNmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 09:42:46 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: Mel Gorman <mel@csn.ul.ie>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, haveblue@us.ibm.com, ak@suse.de,
       bob.picco@hp.com, mbligh@mbligh.org, linux-mm@kvack.org,
       apw@shadowen.org, mingo@elte.hu
Message-Id: <20060519134241.29021.84756.sendpatchset@skynet>
Subject: [PATCH 0/2] Fixes for node alignment and flatmem assumptions
Date: Fri, 19 May 2006 14:42:41 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After almost 3 days of banging the head on the keyboard, it was discovered
why arch-independent zone-sizing failed on IA64 for the configuration
posted on http://www.zip.com.au/~akpm/linux/patches/stuff/config-ia64 .

The two patches in this set address the following;

1. The buddy allocator requires that the node_mem_map be aligned on
   a MAX_ORDER boundary. Patch 1 from Bob Picco's patch aligns the
   node_map_map correctly.

2. This is the one that was giving me keyboard face. The FLATMEM memory
   model assumes that

   mem_map[0] == NODE_DATA(0)->node_mem_map == PFN 0

   This is not the case on IA64 with arch-independent zone sizing because
   NODE_DATA(0)->node_mem_map starts where the first valid page frame is. On
   my test machine, that is PFN 1025 but it probably varies.  Patch 2 from Andy
   Whitcroft relaxes the assumption that NODE_DATA(0)->node_mem_map == PFN 0 .

These patches apply to 2.6.17-rc4-mm1 and are independent of
architecture-independent zone sizing. Patch 1 in particular fixes a
real problem that is just difficult to trigger. However, once applied,
have-ia64-use-add_active_range-and-free_area_init_nodes.patch will work again.

2.6.17-rc4-mm1 with this patchset have been boot-tested by me
and verified that /proc/zoneinfo is ok on x86, ppc64, x86_64 and
ia64 in a variety of configurations. Bob Picco also says that both
patches passed a test with mem=750M and 4Gb on a rx2600 (ia64) with
large memory holes. They have also been successfully tested with
have-ia64-use-add_active_range-and-free_area_init_nodes.patch added back in.
-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
