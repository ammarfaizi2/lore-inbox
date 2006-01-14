Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945919AbWANAtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945919AbWANAtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945952AbWANAtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:49:24 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:27566 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1945949AbWANAtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:49:23 -0500
Date: Fri, 13 Jan 2006 16:49:17 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-git9 build failure when CONFIG_SWAP is not set
In-Reply-To: <20060113223108.GA3709@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0601131648320.7664@schroedinger.engr.sgi.com>
References: <20060113223108.GA3709@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Ravikiran G Thirumalai wrote:

> Compile fails when CONFIG_SWAP is not set.  Attaching the .config for
> reference.

-- Patch that was sent to Andrew.

Some people apparently run CONFIG_NUMA without CONFIG_SWAP. The migration
code currently depends on swap. This patch provides a set of inline fallback
functions so that the kernel properly compiles. Howeverver, calls to migration
functions will fail.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15/include/linux/swap.h
===================================================================
--- linux-2.6.15.orig/include/linux/swap.h	2006-01-11 12:49:03.000000000 -0800
+++ linux-2.6.15/include/linux/swap.h	2006-01-13 16:41:19.000000000 -0800
@@ -180,6 +180,11 @@ extern int isolate_lru_page(struct page 
 extern int putback_lru_pages(struct list_head *l);
 extern int migrate_pages(struct list_head *l, struct list_head *t,
 		struct list_head *moved, struct list_head *failed);
+#else
+static inline int isolate_lru_page(struct page *p) { return -ENOSYS; }
+static inline int putback_lru_pages(struct list_head *l) { return 0; }
+static inline int migrate_pages(struct list_head *l, struct list_head *t,
+	struct list_head *moved, struct list_head *failed) { return -ENOSYS; }
 #endif
 
 #ifdef CONFIG_MMU
