Return-Path: <linux-kernel-owner+w=401wt.eu-S1030200AbXADTgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbXADTgB (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbXADTgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:36:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:40547 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030202AbXADTf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:35:59 -0500
Date: Thu, 4 Jan 2007 13:35:55 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 5/8] user ns: prepare copy_tree, copy_mnt, and their callers to handle errs
Message-ID: <20070104193555.GA17506@sergelap.austin.ibm.com>
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104181215.GF11377@sergelap.austin.ibm.com> <20070104190014.GA17863@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104190014.GA17863@slug>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Frederik Deweerdt (deweerdt@free.fr):
> On Thu, Jan 04, 2007 at 12:12:15PM -0600, Serge E. Hallyn wrote:
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 5da87e2..a4039a3 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -708,8 +708,9 @@ struct vfsmount *copy_tree(struct vfsmou
> >  		return NULL;
> >
> >  	res = q = clone_mnt(mnt, dentry, flag);
> > -	if (!q)
> > -		goto Enomem;
> > +	if (!q || IS_ERR(q)) {
> > +		return q;
> > +	}
> >  	q->mnt_mountpoint = mnt->mnt_mountpoint;
> >
> >  	p = mnt;
> > @@ -730,8 +731,9 @@ struct vfsmount *copy_tree(struct vfsmou
> >  			nd.mnt = q;
> >  			nd.dentry = p->mnt_mountpoint;
> >  			q = clone_mnt(p, p->mnt_root, flag);
> > -			if (!q)
> > -				goto Enomem;
> > +			if (!q || IS_ERR(q)) {
> > +				goto Error;
> > +			}
> >  			spin_lock(&vfsmount_lock);
> >  			list_add_tail(&q->mnt_list, &res->mnt_list);
> >  			attach_mnt(q, &nd);
> > @@ -739,7 +741,7 @@ struct vfsmount *copy_tree(struct vfsmou
> >  		}
> >  	}
> >  	return res;
> > -Enomem:
> > +Error:
> >  	if (res) {
>         ^^^^^^^^^^
> I think that this check can be safely skiped, as res is always non-NULL
> when Error: is now reached, isn't it?

Good point.  In addition, we can clean the code up a little by not
letting clone_mnt return NULL.  Compile-tested patch follows.  Though
really it starts to look like clone_mnt should be split into two
parts, with the original clone_mnt static inline, and the new clone_mnt
doing the permission check and return value conversion...

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 1/1] userns: cleanups with clone_mnt

As Frederik Deweerdt points out, the Error: case in copy_tree()
can no longer have res==NULL, so remove that check.

Also make clone_mnt always return -ENOMEM in place of NULL.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 fs/namespace.c |   90 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 60ca9b5..2ed89d4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -243,41 +243,43 @@ static struct vfsmount *clone_mnt(struct
 
 	mnt = alloc_vfsmnt(old->mnt_devname);
 
-	if (mnt) {
-		mnt->mnt_flags = old->mnt_flags;
-		atomic_inc(&sb->s_active);
-		mnt->mnt_sb = sb;
-		mnt->mnt_root = dget(root);
-		mnt->mnt_mountpoint = mnt->mnt_root;
-		mnt->mnt_parent = mnt;
-
-		if (flag & CL_SLAVE) {
-			list_add(&mnt->mnt_slave, &old->mnt_slave_list);
-			mnt->mnt_master = old;
-			CLEAR_MNT_SHARED(mnt);
-		} else {
-			if ((flag & CL_PROPAGATION) || IS_MNT_SHARED(old))
-				list_add(&mnt->mnt_share, &old->mnt_share);
-			if (IS_MNT_SLAVE(old))
-				list_add(&mnt->mnt_slave, &old->mnt_slave);
-			mnt->mnt_master = old->mnt_master;
-		}
-		if (flag & CL_MAKE_SHARED)
-			set_mnt_shared(mnt);
-		if (flag & CL_SHARE_NS)
-			mnt->mnt_flags |= MNT_SHARE_NS;
-		else
-			mnt->mnt_flags &= ~MNT_SHARE_NS;
-
-		/* stick the duplicate mount on the same expiry list
-		 * as the original if that was on one */
-		if (flag & CL_EXPIRE) {
-			spin_lock(&vfsmount_lock);
-			if (!list_empty(&old->mnt_expire))
-				list_add(&mnt->mnt_expire, &old->mnt_expire);
-			spin_unlock(&vfsmount_lock);
-		}
+	if (!mnt)
+		return ERR_PTR(-ENOMEM);
+
+	mnt->mnt_flags = old->mnt_flags;
+	atomic_inc(&sb->s_active);
+	mnt->mnt_sb = sb;
+	mnt->mnt_root = dget(root);
+	mnt->mnt_mountpoint = mnt->mnt_root;
+	mnt->mnt_parent = mnt;
+
+	if (flag & CL_SLAVE) {
+		list_add(&mnt->mnt_slave, &old->mnt_slave_list);
+		mnt->mnt_master = old;
+		CLEAR_MNT_SHARED(mnt);
+	} else {
+		if ((flag & CL_PROPAGATION) || IS_MNT_SHARED(old))
+			list_add(&mnt->mnt_share, &old->mnt_share);
+		if (IS_MNT_SLAVE(old))
+			list_add(&mnt->mnt_slave, &old->mnt_slave);
+		mnt->mnt_master = old->mnt_master;
 	}
+	if (flag & CL_MAKE_SHARED)
+		set_mnt_shared(mnt);
+	if (flag & CL_SHARE_NS)
+		mnt->mnt_flags |= MNT_SHARE_NS;
+	else
+		mnt->mnt_flags &= ~MNT_SHARE_NS;
+
+	/* stick the duplicate mount on the same expiry list
+	 * as the original if that was on one */
+	if (flag & CL_EXPIRE) {
+		spin_lock(&vfsmount_lock);
+		if (!list_empty(&old->mnt_expire))
+			list_add(&mnt->mnt_expire, &old->mnt_expire);
+		spin_unlock(&vfsmount_lock);
+	}
+	
 	return mnt;
 }
 
@@ -715,14 +717,15 @@ struct vfsmount *copy_tree(struct vfsmou
 {
 	struct vfsmount *res, *p, *q, *r, *s;
 	struct nameidata nd;
+	LIST_HEAD(umount_list);
 
 	if (!(flag & CL_COPY_ALL) && IS_MNT_UNBINDABLE(mnt))
 		return NULL;
 
 	res = q = clone_mnt(mnt, dentry, flag);
-	if (!q || IS_ERR(q)) {
+	if (IS_ERR(q))
 		return q;
-	}
+
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
 
 	p = mnt;
@@ -743,9 +746,8 @@ struct vfsmount *copy_tree(struct vfsmou
 			nd.mnt = q;
 			nd.dentry = p->mnt_mountpoint;
 			q = clone_mnt(p, p->mnt_root, flag);
-			if (!q || IS_ERR(q)) {
+			if (IS_ERR(q))
 				goto Error;
-			}
 			spin_lock(&vfsmount_lock);
 			list_add_tail(&q->mnt_list, &res->mnt_list);
 			attach_mnt(q, &nd);
@@ -754,13 +756,11 @@ struct vfsmount *copy_tree(struct vfsmou
 	}
 	return res;
 Error:
-	if (res) {
-		LIST_HEAD(umount_list);
-		spin_lock(&vfsmount_lock);
-		umount_tree(res, 0, &umount_list);
-		spin_unlock(&vfsmount_lock);
-		release_mounts(&umount_list);
-	}
+	spin_lock(&vfsmount_lock);
+	umount_tree(res, 0, &umount_list);
+	spin_unlock(&vfsmount_lock);
+	release_mounts(&umount_list);
+
 	return q;
 }
 
-- 
1.4.1

