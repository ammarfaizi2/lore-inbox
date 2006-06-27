Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161235AbWF0RqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161235AbWF0RqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161262AbWF0RqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:46:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45231 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161252AbWF0RqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:46:02 -0400
Date: Tue, 27 Jun 2006 10:45:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20060627174556.11172.47432.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060627174551.11172.49700.sendpatchset@schroedinger.engr.sgi.com>
References: <20060627174551.11172.49700.sendpatchset@schroedinger.engr.sgi.com>
Subject: [ZVC 2/4] highmem.c: Use page after it may have been freed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ZVC: highmem.c: Use page after it may have been freed

This is not really a problem since the zone of a page does not
change after it has been freed but its cleaner to use the
page as a reference before it has been freed.

Move the dec_zone_page_state before the free.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm3/mm/highmem.c
===================================================================
--- linux-2.6.17-mm3.orig/mm/highmem.c	2006-06-27 09:40:25.586421810 -0700
+++ linux-2.6.17-mm3/mm/highmem.c	2006-06-27 09:42:19.342074956 -0700
@@ -315,8 +315,8 @@ static void bounce_end_io(struct bio *bi
 		if (bvec->bv_page == org_vec->bv_page)
 			continue;
 
-		mempool_free(bvec->bv_page, pool);	
 		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
+		mempool_free(bvec->bv_page, pool);
 	}
 
 	bio_endio(bio_orig, bio_orig->bi_size, err);
