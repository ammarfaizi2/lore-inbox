Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVCZIbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVCZIbk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 03:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVCZIbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 03:31:40 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38587 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261921AbVCZIbd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 03:31:33 -0500
Subject: [PATCH] mm: thrashing control cleanups
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: riel@redhat.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1111824856.9431.2.camel@localhost>
References: <1111824856.9431.2.camel@localhost>
Date: Sat, 26 Mar 2005 10:30:19 +0200
Message-Id: <1111825819.9431.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a version that applies with -p1. Quilt did some silly things to
the previous one...

This patch removes one redundant variable from mm/thrash.c and moves
declaration of one variable closer to the block where it is actually used.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 thrash.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

Index: 2.6/mm/thrash.c
===================================================================
--- 2.6.orig/mm/thrash.c	2005-03-26 09:52:50.000000000 +0200
+++ 2.6/mm/thrash.c	2005-03-26 10:00:58.000000000 +0200
@@ -51,9 +51,6 @@
  */
 void grab_swap_token(void)
 {
-	struct mm_struct *mm;
-	int reason;
-
 	/* We have the token. Let others know we still need it. */
 	if (has_swap_token(current->mm)) {
 		current->mm->recent_pagein = 1;
@@ -61,6 +58,7 @@
 	}
 
 	if (time_after(jiffies, swap_token_check)) {
+		int reason;
 
 		/* Can't get swapout protection if we exceed our RSS limit. */
 		// if (current->mm->rss > current->mm->rlimit_rss)
@@ -75,13 +73,12 @@
 
 		swap_token_check = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
 
-		mm = swap_token_mm;
-		if ((reason = should_release_swap_token(mm))) {
+		if ((reason = should_release_swap_token(swap_token_mm))) {
 			unsigned long eligible = jiffies;
 			if (reason == SWAP_TOKEN_TIMED_OUT) {
 				eligible += swap_token_default_timeout;
 			}
-			mm->swap_token_time = eligible;
+			swap_token_mm->swap_token_time = eligible;
 			swap_token_timeout = jiffies + swap_token_default_timeout;
 			swap_token_mm = current->mm;
 		}


