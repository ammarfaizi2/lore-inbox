Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVCZIO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVCZIO6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 03:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVCZIO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 03:14:58 -0500
Received: from fep16.inet.fi ([194.251.242.241]:17109 "EHLO fep16.inet.fi")
	by vger.kernel.org with ESMTP id S261936AbVCZIOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 03:14:55 -0500
Subject: [PATCH] mm: thrashing control cleanups
From: Pekka Enberg <pekka.enberg@ri.fi>
To: riel@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 26 Mar 2005 10:14:16 +0200
Message-Id: <1111824856.9431.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes one redundant variable from mm/thrash.c and
moves the declaration of one variable closer to the block where
it is actually used.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 thrash.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

Index: kernel/2.6/mm/thrash.c
===================================================================
--- kernel.orig/2.6/mm/thrash.c	2005-03-26 09:52:50.000000000 +0200
+++ kernel/2.6/mm/thrash.c	2005-03-26 10:00:58.000000000 +0200
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


