Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTEUJaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTEUJaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:30:11 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43245 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261965AbTEUJaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:30:08 -0400
Date: Wed, 21 May 2003 15:15:31 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       dipankar@in.ibm.com, Paul.McKenney@us.ibm.com
Subject: Re: [patch 2/2] lockfree lookup_mnt
Message-ID: <20030521094531.GH1198@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030521092502.GD1198@in.ibm.com> <20030521023523.655bc8f2.akpm@digeo.com> <20030521094340.GG1198@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521094340.GG1198@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 03:13:40PM +0530, Maneesh Soni wrote:
> On Wed, May 21, 2003 at 02:35:23AM -0700, Andrew Morton wrote:
> > >   	}
> > >  -	return p;
> > >  +	spin_lock(&vfsmount_lock);
> > >  +	return found;
> > >   }
> > 
> > err, how many times do you want to spin that lock?
> 
> sorry I didnot test the patches separately. Corrected patches follow


 - Following patch uses synchronize_kernel in detach_mnt() and facilitates
   lockless lookup_mnt.
 - diff'ed over vfsmount_lock.patch



 fs/namespace.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff -puN fs/namespace.c~lookup_mnt-rcu fs/namespace.c
--- linux-2.5.69/fs/namespace.c~lookup_mnt-rcu	2003-05-21 10:53:27.000000000 +0530
+++ linux-2.5.69-maneesh/fs/namespace.c	2003-05-21 10:56:57.000000000 +0530
@@ -74,6 +74,11 @@ void free_vfsmnt(struct vfsmount *mnt)
 /*
  * Now, lookup_mnt increments the ref count before returning
  * the vfsmount struct.
+ *
+ * lookup_mnt can be done without taking any lock, as now we 
+ * do synchronize_kernel() while removing vfsmount struct
+ * from mnt_hash list. rcu_read_(un)lock is required for 
+ * pre-emptive kernels.
  */
 struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
 {
@@ -81,7 +86,7 @@ struct vfsmount *lookup_mnt(struct vfsmo
 	struct list_head * tmp = head;
 	struct vfsmount *p, *found = NULL;
 
-	spin_lock(&vfsmount_lock);
+	rcu_read_lock();
 	for (;;) {
 		tmp = tmp->next;
 		p = NULL;
@@ -93,7 +98,7 @@ struct vfsmount *lookup_mnt(struct vfsmo
 			break;
 		}
 	}
-	spin_unlock(&vfsmount_lock);
+	rcu_read_unlock();
 	return found;
 }
 
@@ -110,10 +115,19 @@ static void detach_mnt(struct vfsmount *
 {
 	old_nd->dentry = mnt->mnt_mountpoint;
 	old_nd->mnt = mnt->mnt_parent;
+
+	/* remove from the hash_list, before other things */
+	list_del_rcu(&mnt->mnt_hash);
+	spin_unlock(&vfsmount_lock);
+
+	/* There could be existing users doing lookup_mnt, let
+	 * them finish their work.
+	 */
+	synchronize_kernel();
+	spin_lock(&vfsmount_lock);
 	mnt->mnt_parent = mnt;
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	list_del_init(&mnt->mnt_child);
-	list_del_init(&mnt->mnt_hash);
 	old_nd->dentry->d_mounted--;
 }
 
@@ -121,7 +135,7 @@ static void attach_mnt(struct vfsmount *
 {
 	mnt->mnt_parent = mntget(nd->mnt);
 	mnt->mnt_mountpoint = dget(nd->dentry);
-	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
+	list_add_rcu(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
 	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
 	nd->dentry->d_mounted++;
 }

_
-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
