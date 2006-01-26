Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWAZDuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWAZDuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWAZDuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:50:15 -0500
Received: from [202.53.187.9] ([202.53.187.9]:26347 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932235AbWAZDtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:46 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 23/23] [Suspend2] Don't scan LRU while freezer is on.
Date: Thu, 26 Jan 2006 13:46:12 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034612.3178.23890.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stop processes from initiating scanning of the LRU while the freezer is on.
This is primarily for the benefit of Suspend2, which could conceivably
trigger LRU scanning through this path while writing the image, and would
thus generate an inconsistent image and through it all sorts of trouble.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 mm/page_alloc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f9151b9..713d773 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
 #include <linux/slab.h>
@@ -957,8 +958,8 @@ restart:
 
 	/* This allocation should allow future memory freeing. */
 
-	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
-			&& !in_interrupt()) {
+	if ((((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE))) && 
+				!in_interrupt()) || (test_freezer_state(FREEZER_ON))) {
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 nofail_alloc:
 			/* go through the zonelist yet again, ignoring mins */

--
Nigel Cunningham		nigel at suspend2 dot net
