Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWFBUlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWFBUlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWFBUlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:41:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932565AbWFBUlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:41:11 -0400
Date: Fri, 2 Jun 2006 13:43:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, drepper@redhat.com,
       mingo@elte.hu
Subject: Re: lock_kernel called under spinlock in NFS
Message-Id: <20060602134346.73019624.akpm@osdl.org>
In-Reply-To: <1149280078.5621.63.camel@lade.trondhjem.org>
References: <20060601195535.GA28188@tsunami.ccur.com>
	<1149192820.3549.43.camel@lade.trondhjem.org>
	<20060602202436.GA4783@tsunami.ccur.com>
	<1149280078.5621.63.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
>
> On Fri, 2006-06-02 at 16:24 -0400, Joe Korty wrote:
> > On Thu, Jun 01, 2006 at 04:13:39PM -0400, Trond Myklebust wrote:
> > > On Thu, 2006-06-01 at 15:55 -0400, Joe Korty wrote:
> > >> Tree 5fdccf2354269702f71beb8e0a2942e4167fd992
> > >> 
> > >>         [PATCH] vfs: *at functions: core
> > >> 
> > >> introduced a bug where lock_kernel() can be called from
> > >> under a spinlock.  To trigger the bug one must have
> > >> CONFIG_PREEMPT_BKL=y and be using NFS heavily.  It is
> > >> somewhat rare and, so far, haven't traced down the userland
> > >> sequence that causes the fatal path to be taken.
> > >> 
> > >> The bug was caused by the insertion into do_path_lookup()
> > >> of a call to file_permission().  do_path_lookup()
> > >> read-locks current->fs->lock for most of its operation.
> > >> file_permission() calls permission() which calls
> > >> nfs_permission(), which has one path through it
> > >> that uses lock_kernel().
> > 
> > > Nowhere should anyone be calling file_permission() under a spinlock.
> > > 
> > > Why would you need to read-protect current->fs in the case where you are
> > > starting from a file? The correct thing to do there would appear to be
> > > to read_protect only the cases where (*name=='/') and (dfd == AT_FDCWD).
> > > 
> > > Something like the attached patch...
> > 
> > 
> > Hi Trond,
> > I've been running with the patch for the last few hours, on an nfs-rooted
> > system, and it has been working fine.  Any plans to submit this for 2.6.17?
> 
> It probably ought to be, given the nature of the sin. Andrew?
> 

OK.

Just to confirm, this is final?


From: Trond Myklebust <Trond.Myklebust@netapp.com>

We're presently running lock_kernel() under fs_lock via nfs's ->permission
handler.  That's a ranking bug and sometimes a sleep-in-spinlock bug.  This
problem was introduced in the openat() patchset.

We should not need to hold the current->fs->lock for a codepath that doesn't
use current->fs.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Al Viro <viro@ftp.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/namei.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN fs/namei.c~fs-nameic-call-to-file_permission-under-a-spinlock-in-do_lookup_path fs/namei.c
--- 25/fs/namei.c~fs-nameic-call-to-file_permission-under-a-spinlock-in-do_lookup_path	Fri Jun  2 13:39:52 2006
+++ 25-akpm/fs/namei.c	Fri Jun  2 13:39:52 2006
@@ -1080,8 +1080,8 @@ static int fastcall do_path_lookup(int d
 	nd->flags = flags;
 	nd->depth = 0;
 
-	read_lock(&current->fs->lock);
 	if (*name=='/') {
+		read_lock(&current->fs->lock);
 		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
 			nd->mnt = mntget(current->fs->altrootmnt);
 			nd->dentry = dget(current->fs->altroot);
@@ -1092,9 +1092,12 @@ static int fastcall do_path_lookup(int d
 		}
 		nd->mnt = mntget(current->fs->rootmnt);
 		nd->dentry = dget(current->fs->root);
+		read_unlock(&current->fs->lock);
 	} else if (dfd == AT_FDCWD) {
+		read_lock(&current->fs->lock);
 		nd->mnt = mntget(current->fs->pwdmnt);
 		nd->dentry = dget(current->fs->pwd);
+		read_unlock(&current->fs->lock);
 	} else {
 		struct dentry *dentry;
 
@@ -1118,7 +1121,6 @@ static int fastcall do_path_lookup(int d
 
 		fput_light(file, fput_needed);
 	}
-	read_unlock(&current->fs->lock);
 	current->total_link_count = 0;
 	retval = link_path_walk(name, nd);
 out:
_

