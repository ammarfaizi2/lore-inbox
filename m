Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWCORhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWCORhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 12:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWCORhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 12:37:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38553 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750762AbWCORhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 12:37:01 -0500
From: hawkes@sgi.com
To: Kenneth Chen <kenneth.w.chen@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Cc: Jack Steiner <steiner@sgi.com>, hawkes@sgi.com, Jes Sorensen <jes@sgi.com>
Date: Wed, 15 Mar 2006 09:36:39 -0800
Message-Id: <20060315173639.11102.71657.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] fix alloc_large_system_hash roundup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "rounded up to nearest power of 2 in size" algorithm in
alloc_large_system_hash is not correct.  As coded, it takes an otherwise
acceptable power-of-2 value and doubles it.  For example, we see the
error if we boot with   thash_entries=2097152   which produces a hash
table with 4194304 entries.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c	2006-03-14 15:25:40.000000000 -0800
+++ linux/mm/page_alloc.c	2006-03-14 16:06:48.000000000 -0800
@@ -2686,7 +2686,7 @@ void *__init alloc_large_system_hash(con
 			numentries <<= (PAGE_SHIFT - scale);
 	}
 	/* rounded up to nearest power of 2 in size */
-	numentries = 1UL << (long_log2(numentries) + 1);
+	numentries = 1UL << (long_log2(2*numentries - 1));
 
 	/* limit allocation size to 1/16 total memory by default */
 	if (max == 0) {
