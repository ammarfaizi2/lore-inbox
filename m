Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbVGIAP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbVGIAP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbVGIAPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:15:12 -0400
Received: from gold.veritas.com ([143.127.12.110]:48574 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S263015AbVGIANm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:13:42 -0400
Date: Sat, 9 Jul 2005 01:15:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] update swsusp use of swap_info
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090111440.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:13:41.0995 (UTC) FILETIME=[1027BBB0:01C5841B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aha, swsusp dips into swap_info[], better update it to swap_lock.  It's
bitflipping flags with 0xFF, so get_swap_page will allocate from only
the one chosen device: let's change that to flip SWP_WRITEOK.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/power/swsusp.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

--- swap12/kernel/power/swsusp.c	2005-07-07 12:33:21.000000000 +0100
+++ swap13/kernel/power/swsusp.c	2005-07-08 19:15:59.000000000 +0100
@@ -178,9 +178,9 @@ static int swsusp_swap_check(void) /* Th
 	len=strlen(resume_file);
 	root_swap = 0xFFFF;
 
-	swap_list_lock();
+	spin_lock(&swap_lock);
 	for (i=0; i<MAX_SWAPFILES; i++) {
-		if (swap_info[i].flags == 0) {
+		if (!swap_info[i].flags & SWP_WRITEOK) {
 			swapfile_used[i]=SWAPFILE_UNUSED;
 		} else {
 			if (!len) {
@@ -201,7 +201,7 @@ static int swsusp_swap_check(void) /* Th
 			}
 		}
 	}
-	swap_list_unlock();
+	spin_unlock(&swap_lock);
 	return (root_swap != 0xffff) ? 0 : -ENODEV;
 }
 
@@ -215,12 +215,12 @@ static void lock_swapdevices(void)
 {
 	int i;
 
-	swap_list_lock();
+	spin_lock(&swap_lock);
 	for (i = 0; i< MAX_SWAPFILES; i++)
 		if (swapfile_used[i] == SWAPFILE_IGNORED) {
-			swap_info[i].flags ^= 0xFF;
+			swap_info[i].flags ^= SWP_WRITEOK;
 		}
-	swap_list_unlock();
+	spin_unlock(&swap_lock);
 }
 
 /**
