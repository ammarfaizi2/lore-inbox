Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVITWxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVITWxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVITWxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:53:07 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:15550 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750713AbVITWxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:53:05 -0400
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event
	under load
From: John McCutchan <ttb@tentacle.dhs.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Ray Lee <ray@madrabbit.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
In-Reply-To: <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org>
References: <1127190971.18595.5.camel@vertex>
	 <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex>
	 <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex>
	 <20050920051729.GF7992@ftp.linux.org.uk>
	 <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org>
	 <20050920163848.GO7992@ftp.linux.org.uk>
	 <1127238257.9940.14.camel@localhost>
	 <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org>
	 <20050920182249.GP7992@ftp.linux.org.uk>
	 <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 18:53:34 -0400
Message-Id: <1127256814.749.5.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 12:37 -0700, Linus Torvalds wrote:
> 
> On Tue, 20 Sep 2005, Al Viro wrote:
> > > 
> > > I really think that the patch I sent out yesterday is as good as it gets.  
> > > If you want immediate notification, you should ask for notification about
> > > name changes in a particular directory. IN_DELETE_SELF notification on a
> > > file simple is _not_ going to be immediate.
> > 
> > But then it's too early.  Note that with your patch we still get removal
> > of _any_ link to our inode (even though it's alive and well and we'd never
> > heard about the sodding link in the first place) terminating all events
> > on it.
> 
> Yes. What is in the current 2.6.14-rc2 tree doesn't do that. It considers 
> inodes "global". But it won't work reliably on networked filesystems, I 
> think.
> 
> Anyway, I do believe that IN_DELETE_SELF is stupid, but that you migth 
> re-arm it if you get it. 

Is there some reason we can't just do this from vfs_unlink

inode = dentry->inode;
iget (inode);
d_delete (dentry);
fsnotify_inoderemove (inode);
iput (inode);

This would allow us to have immediate event notification, and avoid a
race with the inode going away, right?

I think the path below will make link handling as good as it can get, by
sending IN_DELETE_SELF every time inode->i_nlink goes down, and when
inode->i_nlink == 0, send the IN_IGNORE event. Also, it stuffs
inode->i_nlink into the cookie giving user space a clue about the status
of the inode.

Index: linux/include/linux/fsnotify.h
===================================================================
--- linux.orig/include/linux/fsnotify.h	2005-08-28 19:41:01.000000000 -0400
+++ linux/include/linux/fsnotify.h	2005-09-20 18:46:15.000000000 -0400
@@ -63,8 +63,9 @@
  */
 static inline void fsnotify_inoderemove(struct inode *inode)
 {
-	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
-	inotify_inode_is_dead(inode);
+	inotify_inode_queue_event(inode, IN_DELETE_SELF, inode->i_nlink, NULL);
+	if (inode->i_nlink == 0)
+		inotify_inode_is_dead(inode);
 }
 
 /*

