Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVB1S4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVB1S4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 13:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVB1SzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 13:55:07 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:63213 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261712AbVB1Syj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:54:39 -0500
Subject: [PATCH 2/5] do not unnecessarily memset the pgdats
To: linux-mm@kvack.org
Cc: akpm@osdl.org, kmannth@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, ygoto@us.fujitsu.com
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 28 Feb 2005 10:54:34 -0800
Message-Id: <E1D5q2M-0007aZ-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Both the pgdats and the struct zonelist are zeroed unnecessarily.
The zonelist is a member of the pgdat, so any time the pgdat is
cleared, so is the zonelist.  All of the architectures present a
zeroed pgdat to the generic code, so it's not necessary to set it
again.

Not clearing it like this allows the functions to be reused by
the memory hotplug code.  The only architecture which has a
dependence on these clears is i386.  The previous patch in this
series fixed that up.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 arch/i386/mm/init.c         |    0 
 sparse-dave/mm/page_alloc.c |    2 --
 2 files changed, 2 deletions(-)

diff -puN arch/i386/kernel/setup.c~A2.2-dont-memset-pgdats arch/i386/kernel/setup.c
diff -puN arch/i386/mm/discontig.c~A2.2-dont-memset-pgdats arch/i386/mm/discontig.c
diff -puN include/asm-i386/mmzone.h~A2.2-dont-memset-pgdats include/asm-i386/mmzone.h
diff -puN mm/page_alloc.c~A2.2-dont-memset-pgdats mm/page_alloc.c
--- sparse/mm/page_alloc.c~A2.2-dont-memset-pgdats	2005-02-24 08:56:39.000000000 -0800
+++ sparse-dave/mm/page_alloc.c	2005-02-24 08:56:39.000000000 -0800
@@ -1397,7 +1397,6 @@ static void __init build_zonelists(pg_da
 	/* initialize zonelists */
 	for (i = 0; i < GFP_ZONETYPES; i++) {
 		zonelist = pgdat->node_zonelists + i;
-		memset(zonelist, 0, sizeof(*zonelist));
 		zonelist->zones[0] = NULL;
 	}
 
@@ -1444,7 +1443,6 @@ static void __init build_zonelists(pg_da
 		struct zonelist *zonelist;
 
 		zonelist = pgdat->node_zonelists + i;
-		memset(zonelist, 0, sizeof(*zonelist));
 
 		j = 0;
 		k = ZONE_NORMAL;
diff -puN arch/i386/mm/init.c~A2.2-dont-memset-pgdats arch/i386/mm/init.c
_
