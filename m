Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVAZA1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVAZA1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVAZAZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:25:17 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:21710 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262268AbVAZAXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:23:54 -0500
Subject: [RFC][PATCH 5/5] do not unnecessarily memset the pgdats
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 25 Jan 2005 16:23:48 -0800
Message-Id: <E1CtayL-00077d-00@kernel.beaverton.ibm.com>
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

 arch/i386/mm/init.c             |    0 
 memhotplug-dave/mm/page_alloc.c |    2 --
 2 files changed, 2 deletions(-)

diff -puN arch/i386/kernel/setup.c~A2.2-dont-memset-pgdats arch/i386/kernel/setup.c
diff -puN arch/i386/mm/discontig.c~A2.2-dont-memset-pgdats arch/i386/mm/discontig.c
diff -puN include/asm-i386/mmzone.h~A2.2-dont-memset-pgdats include/asm-i386/mmzone.h
diff -puN mm/page_alloc.c~A2.2-dont-memset-pgdats mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~A2.2-dont-memset-pgdats	2005-01-25 14:23:52.000000000 -0800
+++ memhotplug-dave/mm/page_alloc.c	2005-01-25 14:23:52.000000000 -0800
@@ -1488,7 +1488,6 @@ static void __init build_zonelists(pg_da
 	/* initialize zonelists */
 	for (i = 0; i < GFP_ZONETYPES; i++) {
 		zonelist = pgdat->node_zonelists + i;
-		memset(zonelist, 0, sizeof(*zonelist));
 		zonelist->zones[0] = NULL;
 	}
 
@@ -1535,7 +1534,6 @@ static void __init build_zonelists(pg_da
 		struct zonelist *zonelist;
 
 		zonelist = pgdat->node_zonelists + i;
-		memset(zonelist, 0, sizeof(*zonelist));
 
 		j = 0;
 		k = ZONE_NORMAL;
diff -puN arch/i386/mm/init.c~A2.2-dont-memset-pgdats arch/i386/mm/init.c
_
