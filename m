Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWC2P5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWC2P5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWC2P5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:57:23 -0500
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:48021 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751090AbWC2P5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:57:22 -0500
Date: Wed, 29 Mar 2006 10:57:19 -0500
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH] inotify: IN_DELETE events missing in -mm
Message-ID: <20060329155719.GA22092@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In recent -mm kernels (e.g. 2.6.16-mm1), IN_DELETE events are no longer 
generated for the removal of a file from a watched directory.

This seems to be a result of clearing DCACHE_INOTIFY_PARENT_WATCHED in
d_delete() directly before calling fsnotify_nameremove().

Assuming the flag doesn't need to be cleared before dentry_iput(), this should
do the trick.

Signed-off-by: Amy Griffis <amy.griffis@hp.com>

diff --git a/fs/dcache.c b/fs/dcache.c
index 363cd4b..344ce91 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1198,11 +1198,11 @@ void d_delete(struct dentry * dentry)
 	spin_lock(&dentry->d_lock);
 	isdir = S_ISDIR(dentry->d_inode->i_mode);
 	if (atomic_read(&dentry->d_count) == 1) {
-		/* remove this and other inotify debug checks after 2.6.18 */
-		dentry->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
-
 		dentry_iput(dentry);
 		fsnotify_nameremove(dentry, isdir);
+
+		/* remove this and other inotify debug checks after 2.6.18 */
+		dentry->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
 		return;
 	}
 
