Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVKADNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVKADNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVKADNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:13:31 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:23216 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964953AbVKADN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:13:28 -0500
Date: Mon, 31 Oct 2005 19:12:49 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051101031249.12488.83391.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/5] Swap Migration V5: PF_SWAPWRITE to allow writing to swap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add PF_SWAPWRITE to control a processes permission to write to swap.

- Use PF_SWAPWRITE in may_write_to_queue() instead of checking for kswapd
  and pdflush

- Set PF_SWAPWRITE flag for kswapd and pdflush

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc5-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/sched.h	2005-10-24 10:27:29.000000000 -0700
+++ linux-2.6.14-rc5-mm1/include/linux/sched.h	2005-10-31 13:30:48.000000000 -0800
@@ -914,6 +914,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
+#define PF_SWAPWRITE	0x01000000	/* the process is allowed to write to swap */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux-2.6.14-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c	2005-10-31 13:21:57.000000000 -0800
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c	2005-10-31 13:30:48.000000000 -0800
@@ -263,9 +263,7 @@ static inline int is_page_cache_freeable
 
 static int may_write_to_queue(struct backing_dev_info *bdi)
 {
-	if (current_is_kswapd())
-		return 1;
-	if (current_is_pdflush())	/* This is unlikely, but why not... */
+	if (current->flags & PF_SWAPWRITE)
 		return 1;
 	if (!bdi_write_congested(bdi))
 		return 1;
@@ -1289,7 +1287,7 @@ static int kswapd(void *p)
 	 * us from recursively trying to free more memory as we're
 	 * trying to free the first piece of memory in the first place).
 	 */
-	tsk->flags |= PF_MEMALLOC|PF_KSWAPD;
+	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
 
 	order = 0;
 	for ( ; ; ) {
Index: linux-2.6.14-rc5-mm1/mm/pdflush.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/pdflush.c	2005-10-24 10:27:21.000000000 -0700
+++ linux-2.6.14-rc5-mm1/mm/pdflush.c	2005-10-31 13:30:48.000000000 -0800
@@ -90,7 +90,7 @@ struct pdflush_work {
 
 static int __pdflush(struct pdflush_work *my_work)
 {
-	current->flags |= PF_FLUSHER;
+	current->flags |= PF_FLUSHER | PF_SWAPWRITE;
 	my_work->fn = NULL;
 	my_work->who = current;
 	INIT_LIST_HEAD(&my_work->list);
