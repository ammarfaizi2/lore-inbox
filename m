Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWETEpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWETEpU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 00:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWETEpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 00:45:20 -0400
Received: from palrel13.hp.com ([156.153.255.238]:412 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1751113AbWETEpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 00:45:19 -0400
Date: Sat, 20 May 2006 00:45:17 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: John McCutchan <john@johnmccutchan.com>, Robert Love <rlove@rlove.org>
Subject: [PATCH] fix NULL dereference in inotify_ignore
Message-ID: <20060520044517.GA6878@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't reassign to watch.  If idr_find() returns NULL, then
put_inotify_watch will choke.

Signed-off-by: Amy Griffis <amy.griffis@hp.com>

diff --git a/fs/inotify.c b/fs/inotify.c
index 7d57253..5d4ba7c 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -889,18 +889,17 @@ static int inotify_ignore(struct inotify
 	get_inotify_watch(watch);
 	inode = watch->inode;
 	mutex_unlock(&dev->mutex);
 
 	mutex_lock(&inode->inotify_mutex);
 	mutex_lock(&dev->mutex);
 
 	/* make sure that we did not race */
-	watch = idr_find(&dev->idr, wd);
-	if (likely(watch))
+	if (likely(idr_find(&dev->idr, wd) == watch))
 		remove_watch(watch, dev);
 
 	mutex_unlock(&dev->mutex);
 	mutex_unlock(&inode->inotify_mutex);
 	put_inotify_watch(watch);
 
 	return 0;
 }
