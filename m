Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWFQHKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWFQHKw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 03:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWFQHKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 03:10:52 -0400
Received: from 1wt.eu ([62.212.114.60]:45576 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932443AbWFQHKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 03:10:51 -0400
Date: Sat, 17 Jun 2006 09:10:00 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060617071000.GA23498@1wt.eu>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <6bffcb0e0606161538w41036b4ajdb394ef5a36eebd2@mail.gmail.com> <q5f69219dre4fufq44jgo76msqe3btch1g@4ax.com> <20060617051356.GA23202@1wt.eu> <il57929b81lja4bb24sj77575vqibu19ev@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <il57929b81lja4bb24sj77575vqibu19ev@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 04:24:00PM +1000, Grant Coady wrote:
> On Sat, 17 Jun 2006 07:13:57 +0200, Willy Tarreau <w@1wt.eu> wrote:
> 
> >Hi Grant,
> >
> >On Sat, Jun 17, 2006 at 09:24:02AM +1000, Grant Coady wrote:
> >> On Sat, 17 Jun 2006 00:38:10 +0200, "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> >> 
> >> >Can you revert 42cce987d63d3048595b8b00d74be786707d5e5d commit?
> >> 
> >> Only if you point me at the patch, that string seems not to be 
> >> in the patch-2.4.33-rc1.gz file.
> >
> >First, revert this one :
> >
> >  http://kernel.org/git/?p=linux/kernel/git/marcelo/linux-2.4.git;a=commitdiff_plain;h=efc95599c0261dd7ab3a1d9071024ca140b4c644;hp=6601095e2de35f00325a33c8be6b548f81fe76d5
> >
> >--- a/fs/namei.c
> >+++ b/fs/namei.c
> >@@ -1479,19 +1479,20 @@ int vfs_unlink(struct inode *dir, struct
> > {
> > 	int error;
> > 
> >-	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
> > 	error = may_delete(dir, dentry, 0);
> >-	if (!error) {
> >-		error = -EPERM;
> >-		if (dir->i_op && dir->i_op->unlink) {
> >-			DQUOT_INIT(dir);
> >-			if (d_mountpoint(dentry))
> >-				error = -EBUSY;
> >-			else {
> >-				lock_kernel();
> >-				error = dir->i_op->unlink(dir, dentry);
> >-				unlock_kernel();
> >-			}
> >+	if (error)
> >+		return error;
> >+
> >+	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
> >+	error = -EPERM;
> >+	if (dir->i_op && dir->i_op->unlink) {
> >+		DQUOT_INIT(dir);
> >+		if (d_mountpoint(dentry))
> >+			error = -EBUSY;
> >+		else {
> >+			lock_kernel();
> >+			error = dir->i_op->unlink(dir, dentry);
> >+			unlock_kernel();
> > 		}
> > 	}
> > 	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
> >
> >
> >It will put you back to the state where all your machines hanged at boot
> >with -hf32.5, then revert this one :
> >
> >  http://kernel.org/git/?p=linux/kernel/git/marcelo/linux-2.4.git;a=commitdiff_plain;h=f41e0ce901260d3d1ae5bd8bae34266891b4a65d;hp=925c7ce0a2d9a676cd8e4a2baf411b23cf6762d6
> >
> >--- a/fs/namei.c
> >+++ b/fs/namei.c
> >@@ -1479,7 +1479,7 @@ int vfs_unlink(struct inode *dir, struct
> > {
> > 	int error;
> > 
> >-	down(&dir->i_zombie);
> >+	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
> > 	error = may_delete(dir, dentry, 0);
> > 	if (!error) {
> > 		error = -EPERM;
> >@@ -1491,14 +1491,14 @@ int vfs_unlink(struct inode *dir, struct
> > 				lock_kernel();
> > 				error = dir->i_op->unlink(dir, dentry);
> > 				unlock_kernel();
> >-				if (!error)
> >-					d_delete(dentry);
> > 			}
> > 		}
> > 	}
> >-	up(&dir->i_zombie);
> >-	if (!error)
> >+	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
> >+	if (!error) {
> >+		d_delete(dentry);
> > 		inode_dir_notify(dir, DN_DELETE);
> >+	}
> > 	return error;
> > }
> > 
> >@@ -1607,18 +1607,19 @@ int vfs_link(struct dentry *old_dentry, 
> > 	struct inode *inode;
> > 	int error;
> > 
> >-	down(&dir->i_zombie);
> > 	error = -ENOENT;
> > 	inode = old_dentry->d_inode;
> > 	if (!inode)
> >-		goto exit_lock;
> >-
> >-	error = may_create(dir, new_dentry);
> >-	if (error)
> >-		goto exit_lock;
> >+		goto exit;
> > 
> > 	error = -EXDEV;
> > 	if (dir->i_dev != inode->i_dev)
> >+		goto exit;
> >+
> >+	double_down(&dir->i_zombie, &old_dentry->d_inode->i_zombie);
> >+
> >+	error = may_create(dir, new_dentry);
> >+	if (error)
> > 		goto exit_lock;
> > 
> > 	/*
> >@@ -1636,9 +1637,10 @@ int vfs_link(struct dentry *old_dentry, 
> > 	unlock_kernel();
> > 
> > exit_lock:
> >-	up(&dir->i_zombie);
> >+	double_up(&dir->i_zombie, &old_dentry->d_inode->i_zombie);
> > 	if (!error)
> > 		inode_dir_notify(dir, DN_CREATE);
> >+exit:
> > 	return error;
> > }
> > 
> >
> >And you will have something equivalent to -hf32.6 (you remember, I only
> >reverted the fix in -hf32.6, and did not merge Marcelo's fix for the fix).
> >Then we will have to decide whether we can fix it again or revert it
> >completely. I would have liked to Cc: Vadim Egorov, but I cannot find his
> >email.
> >
> 
> Hi Willy, this worked.  

OK Fine. However, I don't understand. From you oops, it looks like
dentry->d_inode suddenly gets NULL before calling this line :

        double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);

I'm wondering if the unlink(dir, dentry) above can produce this. If this
is the case, the Vadim's fix is terribly broken. I also think that in
vfs_link(), we can encounter the same problem that Marcelo had to fix,
because double_down() is performed without prior checking that
old_dentry->d_inode is valid.

Marcelo, do you have Vadim's email somewhere ? I think he should help us
on this otherwise it would be better to revert his fix, as it has introduced
lots of sensible changes in the error path.

> Grant.

Thanks for the tests, Grant.
Willy

