Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbVHZRw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbVHZRw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVHZRwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:52:55 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:30813 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965147AbVHZRwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:52:55 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: John McCutchan <ttb@tentacle.dhs.org>
To: jim.houston@comcast.net
Cc: linux-kernel@vger.kernel.org, george@mvista.com, rml@novell.com,
       akpm@osdl.org, johannes@sipsolutions.net
In-Reply-To: <1125075832.2783.99.camel@new.localdomain>
References: <1125075832.2783.99.camel@new.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Aug 2005 13:52:44 -0400
Message-Id: <1125078764.13243.6.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 13:03 -0400, Jim Houston wrote:
> Hi Everyone,
> 
> I'm answering this from my home email. I have not heard from my
> co-workers in Florida yet, and I imagine that they are busy cleaning up
> after hurricane Katrina and waiting for the power to come back on.
> 
> It looks like we have an "off by one" problem with idr_get_new_above()
> which may be part of the inotify problem.  I'm not sure if the problem
> is the behavior or the name & comments.  The start_id parameter is the
> starting point for the idr allocation search, and if it is available, it
> will be allocated.  If you pass in the last id allocated as the start_id
> and it has already been freed (by an idr_remove call), it will be
> allocated again.  The obvious fix would be to increment start_id
> in idr_get_new_above().

Thanks for your suggestion, it has fixed the inotify problem. But where
to put the fix is turning into a bit of a mess. Some callers like
drivers/md/dm.c:682 call idr_get_new_above as if it will return >=
starting_id. The comment says that it will return > starting_id, and the
function name leads people to believe the same thing. In the patch below
I change inotify do add one to the value was pass into idr. I also
change the comment to more accurately reflect what the function does.
The function name doesn't fit, but it never did.

Signed-off-by: John McCutchan <ttb@tentacle.dhs.org>

Index: linux/fs/inotify.c
===================================================================
--- linux.orig/fs/inotify.c	2005-08-26 13:38:29.000000000 -0400
+++ linux/fs/inotify.c	2005-08-26 13:38:55.000000000 -0400
@@ -353,7 +353,7 @@
 	do {
 		if (unlikely(!idr_pre_get(&dev->idr, GFP_KERNEL)))
 			return -ENOSPC;
-		ret = idr_get_new_above(&dev->idr, watch, dev->last_wd, &watch->wd);
+		ret = idr_get_new_above(&dev->idr, watch, dev->last_wd+1, &watch->wd);
 	} while (ret == -EAGAIN);
 
 	return ret;
Index: linux/lib/idr.c
===================================================================
--- linux.orig/lib/idr.c	2005-08-26 13:38:22.000000000 -0400
+++ linux/lib/idr.c	2005-08-26 13:39:08.000000000 -0400
@@ -207,7 +207,7 @@
 }
 
 /**
- * idr_get_new_above - allocate new idr entry above a start id
+ * idr_get_new_above - allocate new idr entry above or equal to a start id
  * @idp: idr handle
  * @ptr: pointer you want associated with the ide
  * @start_id: id to start search at

