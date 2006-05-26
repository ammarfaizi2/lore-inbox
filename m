Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWEZTlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWEZTlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWEZTl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:41:26 -0400
Received: from silver.veritas.com ([143.127.12.111]:46456 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751327AbWEZTk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:40:59 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,177,1146466800"; 
   d="scan'208"; a="38565037:sNHT20655720"
Date: Fri, 26 May 2006 19:29:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swapoff atomic_inc_not_zero on mm_users
Message-ID: <Pine.LNX.4.64.0605261928180.24818@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 May 2006 19:40:59.0165 (UTC) FILETIME=[502984D0:01C680FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have atomic_inc_not_zero, it's more elegant for try_to_unuse
to use that on mm_users: doesn't actually matter at present, but safer to
be sure that once mm_users has gone to 0, nothing raises it for an instant.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 mm/swapfile.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- 2.6.17-rc5/mm/swapfile.c	2006-05-25 03:43:37.000000000 +0100
+++ linux/mm/swapfile.c	2006-05-26 17:55:29.000000000 +0100
@@ -785,10 +785,8 @@ again:
 			while (*swap_map > 1 && !retval &&
 					(p = p->next) != &start_mm->mmlist) {
 				mm = list_entry(p, struct mm_struct, mmlist);
-				if (atomic_inc_return(&mm->mm_users) == 1) {
-					atomic_dec(&mm->mm_users);
+				if (!atomic_inc_not_zero(&mm->mm_users))
 					continue;
-				}
 				spin_unlock(&mmlist_lock);
 				mmput(prev_mm);
 				prev_mm = mm;
