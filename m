Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUKSAod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUKSAod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbUKSAoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:44:16 -0500
Received: from peabody.ximian.com ([130.57.169.10]:62885 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262896AbUKRTIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:08:15 -0500
Subject: [patch] inotify: grab right lock
From: Robert Love <rml@novell.com>
To: ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1100710677.6280.2.camel@betsy.boston.ximian.com>
References: <1100710677.6280.2.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 14:05:21 -0500
Message-Id: <1100804721.28785.34.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

Ah, another part of my locking rewrite I remember and should pull out
and send now.

We need to grab inode_lock before calling __iget().

	Robert Love


need to hold inode_lock around __iget()

 drivers/char/inotify.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -u linux/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux/drivers/char/inotify.c	2004-11-18 12:31:14.294242616 -0500
+++ linux/drivers/char/inotify.c	2004-11-18 13:59:33.400655992 -0500
@@ -171,7 +171,9 @@
 		goto release_and_out;
 	}
 
+	spin_lock(&inode_lock);
 	__iget(inode);
+	spin_unlock(&inode_lock);
 release_and_out:
 	path_release(&nd);
 out:
@@ -790,7 +792,7 @@
  */
 static void inotify_release_all_watches(struct inotify_device *dev)
 {
-	struct inotify_watch *watch,*next;
+	struct inotify_watch *watch, *next;
 
 	list_for_each_entry_safe(watch, next, &dev->watches, d_list)
 		ignore_helper(watch, 0);


