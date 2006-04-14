Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWDNAhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWDNAhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWDNAhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:37:13 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:906 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965020AbWDNAhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:37:12 -0400
Date: Thu, 13 Apr 2006 17:36:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Swapless V2: Add migration swap entries
In-Reply-To: <20060413171331.1752e21f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604131735550.15910@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add explanation for the yield

2. Move unlikely to is_migration_entry (Does that really work??)

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc1-mm2/mm/memory.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/memory.c	2006-04-13 16:43:10.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/memory.c	2006-04-13 17:32:36.000000000 -0700
@@ -1880,7 +1880,11 @@ static int do_swap_page(struct mm_struct
 
 	entry = pte_to_swp_entry(orig_pte);
 
-	if (unlikely(is_migration_entry(entry))) {
+	if (is_migration_entry(entry)) {
+		/*
+		 * We cannot access the page because of ongoing page
+		 * migration. See if we can do something else.
+		 */
 		yield();
 		goto out;
 	}
Index: linux-2.6.17-rc1-mm2/include/linux/swapops.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/swapops.h	2006-04-13 16:43:10.000000000 -0700
+++ linux-2.6.17-rc1-mm2/include/linux/swapops.h	2006-04-13 17:32:58.000000000 -0700
@@ -77,7 +77,7 @@ static inline swp_entry_t make_migration
 
 static inline int is_migration_entry(swp_entry_t entry)
 {
-	return swp_type(entry) == SWP_TYPE_MIGRATION;
+	return unlikely(swp_type(entry) == SWP_TYPE_MIGRATION);
 }
 
 static inline struct page *migration_entry_to_page(swp_entry_t entry)
