Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWFNBEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWFNBEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWFNBEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:04:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15048 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964841AbWFNBEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:04:05 -0400
Date: Tue, 13 Jun 2006 18:03:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010356.859.70524.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 15/21] reiser4: Conversiion of nr_dirty to ZVC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: reiser4: conversion of nr_dirty to per zone counter
From: Christoph Lameter <clameter@sgi.com>

Conversion of nr_dirty to a per zone counter

Requested by Andrew.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/fs/reiser4/as_ops.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/reiser4/as_ops.c	2006-06-10 11:44:14.557965359 -0700
+++ linux-2.6.17-rc6-cl/fs/reiser4/as_ops.c	2006-06-10 15:05:55.473509770 -0700
@@ -83,7 +83,7 @@ int reiser4_set_page_dirty(struct page *
 			if (page->mapping) {
 				assert("vs-1652", page->mapping == mapping);
 				if (mapping_cap_account_dirty(mapping))
-					inc_page_state(nr_dirty);
+					__inc_zone_page_state(page, NR_DIRTY);
 				radix_tree_tag_set(&mapping->page_tree,
 						   page->index,
 						   PAGECACHE_TAG_REISER4_MOVED);
Index: linux-2.6.17-rc6-cl/fs/reiser4/page_cache.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/reiser4/page_cache.c	2006-06-10 11:44:14.641944528 -0700
+++ linux-2.6.17-rc6-cl/fs/reiser4/page_cache.c	2006-06-10 15:05:17.209277244 -0700
@@ -464,7 +464,7 @@ int set_page_dirty_internal(struct page 
 
 	if (!TestSetPageDirty(page)) {
 		if (mapping_cap_account_dirty(mapping))
-			inc_page_state(nr_dirty);
+			inc_zone_page_state(page, NR_DIRTY);
 
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
