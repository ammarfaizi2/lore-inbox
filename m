Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVERJwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVERJwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbVERJwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:52:49 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:40462 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262147AbVERJwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 05:52:31 -0400
To: linuxram@us.ibm.com
CC: dhowells@redhat.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1116400118.24560.119.camel@localhost> (message from Ram on Wed,
	18 May 2005 00:08:38 -0700)
Subject: [PATCH] fix race in mark_mounts_for_expiry()
References: <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
	 <1116256279.4154.41.camel@localhost>
	 <20050516111408.GA21145@mail.shareable.org>
	 <1116301843.4154.88.camel@localhost>
	 <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
	 <20050517012854.GC32226@mail.shareable.org>
	 <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu>
	 <1116360352.24560.85.camel@localhost>
	 <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu>
	 <1116399887.24560.116.camel@localhost> <1116400118.24560.119.camel@localhost>
Message-Id: <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 May 2005 11:51:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I am seeing a locking issue with get_namespace() and put_namespace()
> > > > 
> > > > lets say put_namespace() is called and it finds that it is the last
> > > > user of the namespace is just about to  call __put_namespace().
> > > > 
> > > > Simultaneously another thread calls get_namespace() and increments
> > > > the count.  
> > > > 
> > > > At this point __put_namespace() goes ahead and cleans the namespace.
> > > 
> > > I think you are right. 
> > > 
> > > There's one place in the existing code, which could experience this
> > > race I think:
> > > 
> > > 
> > > 		/* don't do anything if the namespace is dead - all the
> > > 		 * vfsmounts from it are going away anyway */
> > > 		namespace = mnt->mnt_namespace;
> > > 		if (!namespace || atomic_read(&namespace->count) <= 0)
> > > 			continue;
> > > here ----> 
> > > 		get_namespace(namespace);
> > > 
> > > 		spin_unlock(&vfsmount_lock);
> > > 
> > > 
> > > Locking vfsmount_lock in put_namespace() would fix it.  Any better ideas?
> > > 
> > yes. it will.
> > 
> > However I don't think this issue will trigger currently because for this
> > to happen, a process should attempt a get_namespace() on a foreign
> > namespace. If all tasks are operating in the same
> > namespace, than the count will not go to zero for put namespace to
> > clean it up, unless it is the last task.
> > 
> > I think, it will trigger once we allow recursive binds from foreign
> > namespace.
> 
> No I am wrong. mark_mounts_for_expiry() is not called from a process
> context. Its in a timer context. So the race could happen.

How about this patch?  It tries to solve this race without additional
locking.  If refcount is already zero, it will increment and decrement
it.  So be careful to only call grab_namespace() with vfsmount_lock
held, otherwise it could race with itself.  (vfsmount_lock is also
needed in this case so that mnt->mnt_namespace, doesn't change, while
grabbing the namespace)

Compile tested only, please review carefully.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-17 13:46:58.000000000 +0200
+++ linux/fs/namespace.c	2005-05-18 11:09:47.000000000 +0200
@@ -825,6 +825,16 @@ unlock:
 
 EXPORT_SYMBOL_GPL(do_add_mount);
 
+/* Must be called with vfsmount_lock */
+static inline struct namespace *grab_namespace(struct namespace *n)
+{
+	if (n && atomic_add_return(1, &n->count) <= 1) {
+		atomic_dec(&n->count);
+		n = NULL;
+	}
+	return n;
+}
+
 /*
  * process a list of expirable mountpoints with the intent of discarding any
  * mountpoints that aren't in use and haven't been touched since last we came
@@ -868,10 +878,9 @@ void mark_mounts_for_expiry(struct list_
 
 		/* don't do anything if the namespace is dead - all the
 		 * vfsmounts from it are going away anyway */
-		namespace = mnt->mnt_namespace;
-		if (!namespace || atomic_read(&namespace->count) <= 0)
+		namespace = grab_namespace(mnt->mnt_namespace);
+		if (!namespace)
 			continue;
-		get_namespace(namespace);
 
 		spin_unlock(&vfsmount_lock);
 		down_write(&namespace->sem);

