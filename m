Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUGRWbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUGRWbD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 18:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUGRWbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 18:31:03 -0400
Received: from mail.euroweb.hu ([193.226.220.4]:59353 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S264562AbUGRWa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 18:30:59 -0400
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fix readahead breakage for sequential after random reads
Message-Id: <E1BmKAd-0001hz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 19 Jul 2004 00:30:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Current readahead logic is broken when a random read pattern is
followed by a long sequential read.  The cause is that on a window
miss ra->next_size is set to ra->average, but ra->average is only
updated at the end of a sequence, so window size will remain 1 until
the end of the sequential read.

This patch fixes this by taking the current sequence length into
account (code taken from towards end of page_cache_readahead()), and
also setting ra->average to a decent value in handle_ra_miss() when
sequential access is detected.

Please apply!

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

==============================================================================
--- linux-2.6.8-rc2/mm/readahead.c.orig	2004-06-16 07:18:57.000000000 +0200
+++ linux-2.6.8-rc2/mm/readahead.c	2004-07-18 23:52:31.000000000 +0200
@@ -470,7 +470,11 @@ do_io:
 			  * pages shall be accessed in the next
 			  * current window.
 			  */
-			ra->next_size = min(ra->average , (unsigned long)max);
+			average = ra->average;
+			if (ra->serial_cnt > average)
+				average = (ra->serial_cnt + ra->average + 1) / 2;
+
+			ra->next_size = min(average , (unsigned long)max);
 		}
 		ra->start = offset;
 		ra->size = ra->next_size;
@@ -552,6 +556,7 @@ void handle_ra_miss(struct address_space
 				ra->size = max;
 				ra->ahead_start = 0;
 				ra->ahead_size = 0;
+				ra->average = max / 2;
 			}
 		}
 		ra->prev_page = offset;



