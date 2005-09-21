Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVIUBkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVIUBkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVIUBkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:40:42 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:44731 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750700AbVIUBkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:40:41 -0400
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event
	under load
From: John McCutchan <ttb@tentacle.dhs.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
In-Reply-To: <20050921010154.GR7992@ftp.linux.org.uk>
References: <20050920045835.GE7992@ftp.linux.org.uk>
	 <1127192784.19093.7.camel@vertex> <20050920051729.GF7992@ftp.linux.org.uk>
	 <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org>
	 <20050920163848.GO7992@ftp.linux.org.uk>
	 <1127238257.9940.14.camel@localhost>
	 <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org>
	 <20050920182249.GP7992@ftp.linux.org.uk>
	 <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org>
	 <1127256814.749.5.camel@vertex>  <20050921010154.GR7992@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 21:41:47 -0400
Message-Id: <1127266907.3950.5.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-21 at 02:01 +0100, Al Viro wrote:
> On Tue, Sep 20, 2005 at 06:53:34PM -0400, John McCutchan wrote:
> > Is there some reason we can't just do this from vfs_unlink
> > 
> > inode = dentry->inode;
> > iget (inode);
> > d_delete (dentry);
> > fsnotify_inoderemove (inode);
> > iput (inode);
> > 
> > This would allow us to have immediate event notification, and avoid a
> > race with the inode going away, right?
> 
> Playing with references to struct inode means playing dirty tricks
> behind the filesystem's back.  Doing that in a way that really changes
> inode lifetime means asking for trouble.  Combined with a dirty trick
> *already* pulled by sys_unlink() to postpone the final iput until after
> we unlock the parent, it means breakage (and aforementioned dirty trick
> took some rather interesting logics to compensate for in the first place).
> 
> Moreover, your suggestion would do that to _everyone_, whether they use
> inotify or not.  NAK.

Got it.

> 
> >  static inline void fsnotify_inoderemove(struct inode *inode)
> >  {
> > -	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
> > -	inotify_inode_is_dead(inode);
> > +	inotify_inode_queue_event(inode, IN_DELETE_SELF, inode->i_nlink, NULL);
> > +	if (inode->i_nlink == 0)
> > +		inotify_inode_is_dead(inode);
> >  }
> 
> Assumes that filesystem treats ->i_nlink on final iput() in usual way.
> It doesn't have to.
> 

I grepped all the filesystems, and they all seem to use
generic_drop_inode, except for hugetlbfs, which seems to have the same
logic of (!inode->i_nlink).

> BTW, what happens if one uses inotify on procfs?  Or sysfs, for that matter?
> Fundamental problem with that sucker is that you are playing games with
> lifetime rules of inodes in a way that might be OK for some filesystems,
> but violates a lot of assumptions made by other...
> 

Honestly, I don't know. And I don't think I know enough to say with any
certainty how either of them would work. Would a black list of
filesystems that don't want inotify on them be acceptable?

> BTW^2, what guarantees that inotify_unmount_inodes() will not happen while we
> are in inotify_release()?  That would happily keep watch refcount bumped,
> so it would outlive inotify_unmount_inodes().  Sure, it would be dropped.
> And call iput() on a pinned inode that had outlived the umount().  Oops...

Good catch,

Index: linux/fs/inotify.c
===================================================================
--- linux.orig/fs/inotify.c	2005-08-31 15:41:11.000000000 -0400
+++ linux/fs/inotify.c	2005-09-20 21:18:35.000000000 -0400
@@ -756,6 +756,7 @@
 	 * do not know the inode until we iterate to the watch.  But we need to
 	 * hold inode->inotify_sem before dev->sem.  The following works.
 	 */
+	down(&iprune_sem);
 	while (1) {
 		struct inotify_watch *watch;
 		struct list_head *watches;
@@ -779,6 +780,7 @@
 		up(&inode->inotify_sem);
 		put_inotify_watch(watch);
 	}
+	up(&iprune_sem);
 
 	/* destroy all of the events on this device */
 	down(&dev->sem);


