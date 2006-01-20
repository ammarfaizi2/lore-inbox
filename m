Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWATBqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWATBqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422727AbWATBqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:46:40 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34785 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422726AbWATBqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:46:39 -0500
Date: Thu, 19 Jan 2006 17:46:29 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink_list: Use of && instead || leads to unintended
 writing of pages
In-Reply-To: <20060119172032.04bad017.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601191744390.13937@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0601191602260.13428@schroedinger.engr.sgi.com>
 <20060119164341.0fb9c7e3.akpm@osdl.org> <Pine.LNX.4.62.0601191648440.13602@schroedinger.engr.sgi.com>
 <20060119172032.04bad017.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is all crap. may_writepage needs to do as it says and control 
write behavior .... We can set the  proper writemode in try_to_free_pages 
based on the laptop mode. Then everything falls into the proper place.



[PATCH] Implement sane function of sc->may_writepage

Make sc->may_writepage control the writeout behavior of shrink_list.

Remove the laptop_mode trick from shrink_list and instead set may_writepage in
try_to_free_pages properly.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc1-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.16-rc1-mm1.orig/mm/vmscan.c	2006-01-19 15:50:19.000000000 -0800
+++ linux-2.6.16-rc1-mm1/mm/vmscan.c	2006-01-19 17:42:07.000000000 -0800
@@ -491,7 +491,7 @@ static int shrink_list(struct list_head 
 				goto keep_locked;
 			if (!may_enter_fs)
 				goto keep_locked;
-			if (laptop_mode && !sc->may_writepage)
+			if (!sc->may_writepage)
 				goto keep_locked;
 
 			/* Page is dirty, try to write it out here */
@@ -1409,7 +1409,7 @@ int try_to_free_pages(struct zone **zone
 	int i;
 
 	sc.gfp_mask = gfp_mask;
-	sc.may_writepage = 0;
+	sc.may_writepage = !laptop_mode;
 	sc.may_swap = 1;
 
 	inc_page_state(allocstall);
@@ -1512,7 +1512,7 @@ loop_again:
 	total_scanned = 0;
 	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
-	sc.may_writepage = 0;
+	sc.may_writepage = 1;
 	sc.may_swap = 1;
 	sc.nr_mapped = read_page_state(nr_mapped);
 
