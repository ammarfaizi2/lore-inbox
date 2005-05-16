Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVEPUXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVEPUXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEPUVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:21:17 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:27401 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261854AbVEPUQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:16:58 -0400
To: linuxram@us.ibm.com
CC: jamie@shareable.org, miklos@szeredi.hu,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1116301843.4154.88.camel@localhost> (message from Ram on Mon, 16
	May 2005 20:50:44 -0700)
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
	 <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
	 <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
	 <1116256279.4154.41.camel@localhost>
	 <20050516111408.GA21145@mail.shareable.org> <1116301843.4154.88.camel@localhost>
Message-Id: <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 May 2005 22:15:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. less restriction without compromising security is a good idea.
> 
> Under the premise that bind mounts across namespace should be allowed;
> any insight why the "founding fathers" :) allowed only bind
> and not recursive bind?  What issue would that create? One can
> easily workaround that restriction by manually binding recursively.
> So does the recursive bind restriction serve any purpose?
> 
> I remember Miklos saying its not a security issue but a
> implementation/locking issue. That can be fixed aswell.

Yes, as pointed out by Jamie, both namespaces need to be locked for
this to work.  Something like the attached should do it.

Miklos


Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-16 22:02:36.000000000 +0200
+++ linux/fs/namespace.c	2005-05-16 22:13:30.000000000 +0200
@@ -622,6 +622,8 @@ out_unlock:
 static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
 {
 	struct nameidata old_nd;
+	struct namespace *ns1 = current->namespace;
+	struct namespace *ns2 = NULL;
 	struct vfsmount *mnt = NULL;
 	int err = mount_is_safe(nd);
 	if (err)
@@ -632,15 +634,30 @@ static int do_loopback(struct nameidata 
 	if (err)
 		return err;
 
-	down_write(&current->namespace->sem);
 	err = -EINVAL;
-	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
-		err = -ENOMEM;
-		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
-		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
-	}
+	if (!check_mnt(nd->mnt))
+		goto out_path_release;
+
+	if (recurse && old_nd.mnt->mnt_namespace != ns1) {
+		ns2 = old_nd.mnt->mnt_namespace;
+		if (ns1 < ns2) {
+			down_write(&ns1->sem);
+			down_write(&ns2->sem);
+		} else {
+			down_write(&ns2->sem);
+			down_write(&ns1->sem);
+		}
+	} else
+		down_write(&ns1->sem);
+
+	err = -ENOMEM;
+	if (recurse)
+		mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+	else
+		mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+	
+	if (ns2)
+		up_write(&ns2->sem);
 
 	if (mnt) {
 		/* stop bind mounts from expiring */
@@ -657,7 +674,8 @@ static int do_loopback(struct nameidata 
 			mntput(mnt);
 	}
 
-	up_write(&current->namespace->sem);
+	up_write(&ns1->sem);
+out_path_release:
 	path_release(&old_nd);
 	return err;
 }
