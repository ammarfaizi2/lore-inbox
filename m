Return-Path: <linux-kernel-owner+w=401wt.eu-S932136AbXADRsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbXADRsv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbXADRsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:48:51 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:2535 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136AbXADRsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:48:50 -0500
X-AuditID: d80ac287-a06c3bb000002548-f8-459d3ed90143 
Date: Thu, 4 Jan 2007 17:49:00 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@sgi.com>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix BUG_ON(!PageSlab) from fallback_alloc
Message-ID: <Pine.LNX.4.64.0701041741490.16466@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Jan 2007 17:48:43.0716 (UTC) FILETIME=[93A3D040:01C73028]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pdflush hit the BUG_ON(!PageSlab(page)) in kmem_freepages called from
fallback_alloc: cache_grow already freed those pages when alloc_slabmgmt
failed.  But it wouldn't have freed them if __GFP_NO_GROW, so make sure
fallback_alloc doesn't waste its time on that case.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
___
Fixes a CONFIG_NUMA regression introduced in 2.6.20-rc1.  Or you may
feel it's cleaner for cache_grow to skip its kmem_freepages when objp
is input: patch below is slightly simpler, but I've no strong feeling.

 mm/slab.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 2.6.20-rc3/mm/slab.c	2007-01-01 10:30:46.000000000 +0000
+++ linux/mm/slab.c	2007-01-04 17:30:11.000000000 +0000
@@ -3281,7 +3281,7 @@ retry:
 					flags | GFP_THISNODE, nid);
 	}
 
-	if (!obj) {
+	if (!obj && !(flags & __GFP_NO_GROW)) {
 		/*
 		 * This allocation will be performed within the constraints
 		 * of the current cpuset / memory policy requirements.
@@ -3310,7 +3310,7 @@ retry:
 					 */
 					goto retry;
 			} else {
-				kmem_freepages(cache, obj);
+				/* cache_grow already freed obj */
 				obj = NULL;
 			}
 		}
