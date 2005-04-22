Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVDVX0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVDVX0a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 19:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVDVX0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 19:26:30 -0400
Received: from peabody.ximian.com ([130.57.169.10]:19075 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261309AbVDVX01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 19:26:27 -0400
Subject: Re: [patch] updated inotify for 2.6.12-rc3.
From: Robert Love <rml@novell.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       Mr Morton <akpm@osdl.org>
In-Reply-To: <20050422211324.GF13052@parcelfarce.linux.theplanet.co.uk>
References: <1114060434.6913.26.camel@jenny.boston.ximian.com>
	 <1114146110.6973.101.camel@jenny.boston.ximian.com>
	 <20050422085614.GE13052@parcelfarce.linux.theplanet.co.uk>
	 <1114182273.13886.17.camel@vertex>
	 <20050422211324.GF13052@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 19:27:18 -0400
Message-Id: <1114212438.6975.3.camel@jenny.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-22 at 22:13 +0100, Al Viro wrote:

> Or it would, if remove_watch() had been called only once.  In the scenario
> above that will not be true.

Thanks.

	Robert Love


Double check that we don't race.

Signed-off-by: Robert Love <rml@novell.com>

 fs/inotify.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -urN linux-2.6.12-rc3-inotify/fs/inotify.c linux/fs/inotify.c
--- linux-2.6.12-rc3-inotify/fs/inotify.c	2005-04-22 19:20:14.000000000 -0400
+++ linux/fs/inotify.c	2005-04-22 19:25:44.000000000 -0400
@@ -861,12 +861,17 @@
 		return -EINVAL;
 	}
 	get_inotify_watch(watch);
+	inode = watch->inode;	
 	up(&dev->sem);
 
-	inode = watch->inode;
 	down(&inode->inotify_sem);
 	down(&dev->sem);
-	remove_watch(watch, dev);
+
+	/* make sure we did not race */
+	watch = idr_find(&dev->idr, wd);
+	if (likely(watch))
+		remove_watch(watch, dev);
+
 	up(&dev->sem);
 	up(&inode->inotify_sem);
 	put_inotify_watch(watch);


