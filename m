Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVHOQ1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVHOQ1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVHOQ1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:27:54 -0400
Received: from peabody.ximian.com ([130.57.169.10]:10880 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S964822AbVHOQ1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:27:53 -0400
Subject: [patch] inotify: idr_get_new_above not working?
From: Robert Love <rml@novell.com>
To: Linus Torvalds <torvalds@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jim.houston@ccur.com
In-Reply-To: <1124115406.7369.6.camel@vertex>
References: <1124115406.7369.6.camel@vertex>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 12:27:54 -0400
Message-Id: <1124123274.23297.122.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 10:16 -0400, John McCutchan wrote:

> Inotify is using idr_get_new_above to make sure that the next watch
> descriptor is larger/different than any of the previous watch
> descriptors. We keep track of the largest wd that we get out of
> idr_get_new_above, and pass that to idr_get_new_above. I have noticed
> though, that idr_get_new_above always returns the first available id.
> This causes a serious problem for inotify, because user space will get a
> IGNORE event for a wd K that might refer to the last holder of the K.

Turns out that the problem was in our court and not the idr layer.
idr_get_new_above() seems to work fine.

One-line patch is attached.  Please merge before 2.6.13.

	Robert Love


We are saving the wrong thing in ->last_wd.  We want the wd, not the return
value.

Signed-off-by: Robert Love <rml@novell.com>

 fs/inotify.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-2.6.13-rc6-git2/fs/inotify.c linux/fs/inotify.c
--- linux-2.6.13-rc6-git2/fs/inotify.c	2005-08-09 16:52:16.000000000 -0400
+++ linux/fs/inotify.c	2005-08-15 12:21:18.000000000 -0400
@@ -402,7 +402,7 @@
 		return ERR_PTR(ret);
 	}
 
-	dev->last_wd = ret;
+	dev->last_wd = watch->wd;
 	watch->mask = mask;
 	atomic_set(&watch->count, 0);
 	INIT_LIST_HEAD(&watch->d_list);


