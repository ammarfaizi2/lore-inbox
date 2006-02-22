Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWBVXlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWBVXlA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWBVXlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:41:00 -0500
Received: from d36-15-41.home1.cgocable.net ([24.36.15.41]:23964 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750972AbWBVXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:41:00 -0500
Subject: Re: udevd is killing file write performance.
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Andrew Morton <akpm@osdl.org>
Cc: holt@sgi.com, linux-kernel@vger.kernel.org, rml@novell.com, arnd@arndb.de,
       hch@lst.de
In-Reply-To: <20060222151223.5c9061fd.akpm@osdl.org>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
	 <1140626903.13461.5.camel@localhost.localdomain>
	 <20060222175030.GB30556@lnx-holt.americas.sgi.com>
	 <1140648776.1729.5.camel@localhost.localdomain>
	 <20060222151223.5c9061fd.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Feb 2006 18:41:02 -0500
Message-Id: <1140651662.2985.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-22-02 at 15:12 -0800, Andrew Morton wrote:
> John McCutchan <john@johnmccutchan.com> wrote:
> >
> > On Wed, 2006-22-02 at 11:50 -0600, Robin Holt wrote:
> > > On Wed, Feb 22, 2006 at 11:48:23AM -0500, John McCutchan wrote:
> > > > On Wed, 2006-22-02 at 07:42 -0600, Robin Holt wrote:
> > > > > 
> > > > > I know _VERY_ little about filesystems.  udevd appears to be looking
> > > > > at /etc/udev/rules.d.  This bumps inotify_watches to 1.  The file
> > > > > being written is on an xfs filesystem mounted at a different mountpoint.
> > > > > Could the inotify flag be moved from a global to a sb (or something
> > > > > finer) point and therefore avoid taking the dentry->d_lock when there
> > > > > is no possibility of a watch event being queued.
> > > > 
> > > > We could do this, and avoid the problem, but only in this specific
> > > > scenario. The file being written is on a different mountpoint but whats
> > > > to stop a different app from running inotify on that mount point?
> > > > Perhaps the program could be altered instead? 
> > > 
> > > Looking at fsnotify_access() I think we could hit the same scenario.
> > > Are you proposing we alter any appliction where multiple threads read
> > > a single data file to first make a hard link to that data file and each
> > > read from their private copy?  I don't think that is a very reasonable
> > > suggestion.
> > 
> > Listen, what I'm saying is that your suggested change will only help in
> > one specific scenario, and simply having inotify used on the 'wrong'
> > mountpoint will get you back to square one. So, your suggestion isn't
> > really a solution, but a way of avoiding the real problem. What I *am*
> > suggesting is that a real fix be found,
> 
> I have a bad feeling about this one.  It'd be nice to have an exact
> understanding of the problen source, but if it's just lots of traffic on
> ->d_lock we're kinda stuck.  I don't expect we'll run off and RCUify
> d_parent or turn d_lock into a seq_lock or anything liek that.
> 
> Then again, maybe making d_lock an rwlock _will_ help - if this workload is
> also hitting tree_lock (Robin?) and we're not seeing suckiness due to that
> then perhaps the rwlock is magically helping.
> 
> 
> > instead of your hack.
> 
> It's not a terribly bad hack - it's just poor-man's hashing, and it's
> reasonably well-suited to the sorts of machines and workloads which we
> expect will hit this problem.
> 

If this is as good as it gets, here is a patch (totally untested).

Signed-off-by: John McCutchan <john@johnmccutchan.com>

Index: linux-2.6.16-rc4/fs/inotify.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/inotify.c	2006-02-17 17:23:45.000000000 -0500
+++ linux-2.6.16-rc4/fs/inotify.c	2006-02-22 18:36:29.000000000 -0500
@@ -38,7 +38,6 @@
 #include <asm/ioctls.h>
 
 static atomic_t inotify_cookie;
-static atomic_t inotify_watches;
 
 static kmem_cache_t *watch_cachep;
 static kmem_cache_t *event_cachep;
@@ -426,7 +425,7 @@
 	get_inotify_watch(watch);
 
 	atomic_inc(&dev->user->inotify_watches);
-	atomic_inc(&inotify_watches);
+	atomic_inc(&inode->i_sb->s_inotify_watches);
 
 	return watch;
 }
@@ -459,7 +458,7 @@
 	list_del(&watch->d_list);
 
 	atomic_dec(&dev->user->inotify_watches);
-	atomic_dec(&inotify_watches);
+	atomic_dec(&watch->inode->i_sb->s_inotify_watches);
 	idr_remove(&dev->idr, watch->wd);
 	put_inotify_watch(watch);
 }
@@ -538,7 +537,7 @@
 	struct dentry *parent;
 	struct inode *inode;
 
-	if (!atomic_read (&inotify_watches))
+	if (!atomic_read (&dentry->d_sb->s_inotify_watches))
 		return;
 
 	spin_lock(&dentry->d_lock);
@@ -1065,7 +1064,6 @@
 	inotify_max_user_watches = 8192;
 
 	atomic_set(&inotify_cookie, 0);
-	atomic_set(&inotify_watches, 0);
 
 	watch_cachep = kmem_cache_create("inotify_watch_cache",
 					 sizeof(struct inotify_watch),
Index: linux-2.6.16-rc4/fs/super.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/super.c	2006-02-17 17:23:45.000000000 -0500
+++ linux-2.6.16-rc4/fs/super.c	2006-02-22 18:34:27.000000000 -0500
@@ -86,6 +86,9 @@
 		s->s_qcop = sb_quotactl_ops;
 		s->s_op = &default_op;
 		s->s_time_gran = 1000000000;
+#ifdef CONFIG_INOTIFY
+		atomic_set(&s->s_inotify_watches, 0);
+#endif
 	}
 out:
 	return s;
Index: linux-2.6.16-rc4/include/linux/fs.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/fs.h	2006-02-22 18:30:14.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/fs.h	2006-02-22 18:32:37.000000000 -0500
@@ -843,7 +843,7 @@
 	void 			*s_fs_info;	/* Filesystem private info */
 
+#ifdef CONFIG_INOTIFY
+	atomic_t		s_inotify_watches; /* Number of inotify watches */
+#endif
 
 	/*

-- 
John McCutchan <john@johnmccutchan.com>
