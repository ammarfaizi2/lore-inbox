Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVANC3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVANC3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVANC3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:29:32 -0500
Received: from peabody.ximian.com ([130.57.169.10]:60603 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261837AbVANC1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:27:10 -0500
Subject: Re: 2.6.10-mm3 scaling problem with inotify
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1105666283.15782.2.camel@vertex>
References: <200501132356.j0DNujUY016224@tomahawk.engr.sgi.com>
	 <1105663758.6027.215.camel@localhost>  <1105666283.15782.2.camel@vertex>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 21:29:02 -0500
Message-Id: <1105669742.6027.243.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 20:31 -0500, John McCutchan wrote:

> No, you covered things well. This code was really just a straight copy
> of the dnotify code. Rob cleaned it up at some point, giving us what we
> have today. The only fix I can think of is the one suggested by Rob --
> copying the dnotify code again.

Oh, did I undo the dnotify optimization? :-)

Eh, no, looks like not exactly: The old code always did a dget().

John Hawkes: Attached patch implements the dget() optimization in the
same manner as dnotify.  Compile-tested but not booted.

Let me know!

	Robert Love


inotify: don't do dget() unless we have to

 drivers/char/inotify.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff -urN linux-2.6.10-mm3/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-2.6.10-mm3/drivers/char/inotify.c	2005-01-13 21:04:53.108971856 -0500
+++ linux/drivers/char/inotify.c	2005-01-13 21:25:20.052448096 -0500
@@ -607,10 +607,18 @@
 				       u32 cookie, const char *filename)
 {
 	struct dentry *parent;
+	struct inode *inode;
 
-	parent = dget_parent(dentry);
-	inotify_inode_queue_event(parent->d_inode, mask, cookie, filename);
-	dput(parent);
+	spin_lock(&dentry->d_lock);
+	parent = dentry->d_parent;
+	inode = parent->d_inode;
+	if (inode->inotify_data) {
+		dget(parent);
+		spin_unlock(&dentry->d_lock);
+		inotify_inode_queue_event(inode, mask, cookie, filename);
+		dput(parent);
+	} else
+		spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL_GPL(inotify_dentry_parent_queue_event);
 


