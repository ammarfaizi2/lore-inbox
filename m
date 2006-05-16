Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWEPTjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWEPTjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWEPTjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:39:43 -0400
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:51083 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S1750710AbWEPTjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:39:42 -0400
Date: Tue, 16 May 2006 15:39:41 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: John McCutchan <john@johnmccutchan.com>, Robert Love <rlove@rlove.org>
Subject: [PATCH] fix race in inotify_release
Message-ID: <20060516193941.GA27045@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While doing some inotify stress testing, I hit the following race.  In
inotify_release(), it's possible for a watch to be removed from the
lists in between dropping dev->mutex and taking inode->inotify_mutex.
The reference we hold prevents the watch from being freed, but not
from being removed.

Checking the dev's idr mapping will prevent a double list_del of the
same watch.

Signed-off-by: Amy Griffis <amy.griffis@hp.com>

diff --git a/fs/inotify.c b/fs/inotify.c
index 1f50302..7d57253 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -848,7 +848,11 @@ static int inotify_release(struct inode 
 		inode = watch->inode;
 		mutex_lock(&inode->inotify_mutex);
 		mutex_lock(&dev->mutex);
-		remove_watch_no_event(watch, dev);
+
+		/* make sure we didn't race with another list removal */
+		if (likely(idr_find(&dev->idr, watch->wd)))
+			remove_watch_no_event(watch, dev);
+
 		mutex_unlock(&dev->mutex);
 		mutex_unlock(&inode->inotify_mutex);
 		put_inotify_watch(watch);


