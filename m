Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWHFOdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWHFOdA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 10:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWHFOc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 10:32:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9604 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932542AbWHFOc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 10:32:59 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Paul Jackson <pj@sgi.com>, Andi Kleen <ak@suse.de>
Date: Sun, 06 Aug 2006 07:32:41 -0700
Message-Id: <20060806143241.19463.63953.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] apply type enum zone_type fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

The variable 'k' was changed from 'int' to 'enum zone_type'
(unsigned), and it was being tested for being '>= 0' in a loop.
Result was that the set_mempolicy(MPOL_BIND) system call crashed
the kernel in a near infinite loop off into the weeds.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 mm/mempolicy.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- 2.6.18-rc3-mm1.orig/mm/mempolicy.c	2006-08-06 06:41:41.622684572 -0700
+++ 2.6.18-rc3-mm1/mm/mempolicy.c	2006-08-06 06:42:53.419522620 -0700
@@ -149,12 +149,16 @@ static struct zonelist *bind_zonelist(no
 	   lower zones etc. Avoid empty zones because the memory allocator
 	   doesn't like them. If you implement node hot removal you
 	   have to fix that. */
-	for (k = policy_zone; k >= 0; k--) { 
+	k = policy_zone;
+	while (1) {
 		for_each_node_mask(nd, *nodes) { 
 			struct zone *z = &NODE_DATA(nd)->node_zones[k];
 			if (z->present_pages > 0) 
 				zl->zones[num++] = z;
 		}
+		if (k == 0)
+			break;
+		k--;
 	}
 	zl->zones[num] = NULL;
 	return zl;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
