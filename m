Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274969AbTHFEX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 00:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274989AbTHFEX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 00:23:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:10961 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S274969AbTHFEXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 00:23:48 -0400
Date: Wed, 6 Aug 2003 09:58:54 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dick Streefland <dick.streefland@xs4all.nl>, linux-kernel@vger.kernel.org,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] autofs4 doesn't expire
Message-ID: <20030806042853.GA1298@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <4b0c.3f302ca5.93873@altium.nl> <20030805164904.36b5d2cc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805164904.36b5d2cc.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 04:49:04PM -0700, Andrew Morton wrote:
> spam@streefland.xs4all.nl (Dick Streefland) wrote:
> >
> > In linux-2.6.0-test1, lookup_mnt() was changed to increment the ref
> > count of the returned vfsmount struct. This breaks expiration of
> > autofs4 mounts, because lookup_mnt() is called in check_vfsmnt()
> > without decrementing the ref count afterwards. The following patch
> > fixes this:
> > 
> 
> Neat, thanks.
> 
> Probably we should hold onto that ref because we play with the vfsmount
> later on.  So something like this?
> 
> 
> diff -puN fs/autofs4/expire.c~autofs4-expiry-fix fs/autofs4/expire.c
> --- 25/fs/autofs4/expire.c~autofs4-expiry-fix	2003-08-05 16:44:41.000000000 -0700
> +++ 25-akpm/fs/autofs4/expire.c	2003-08-05 16:48:20.000000000 -0700
> @@ -25,7 +25,7 @@ static inline int is_vfsmnt_tree_busy(st
>  	struct list_head *next;
>  	int count;
>  
> -	count = atomic_read(&mnt->mnt_count) - 1;
> +	count = atomic_read(&mnt->mnt_count) - 1 - 1;
>  
>  repeat:
>  	next = this_parent->mnt_mounts.next;
> @@ -70,8 +70,11 @@ static int check_vfsmnt(struct vfsmount 
>  	int ret = dentry->d_mounted;
>  	struct vfsmount *vfs = lookup_mnt(mnt, dentry);
>  
> -	if (vfs && is_vfsmnt_tree_busy(vfs))
> -		ret--;
> +	if (vfs) {
> +		if (is_vfsmnt_tree_busy(vfs))
> +			ret = 0;
> +		mntput(vfs);
> +	}
>  	DPRINTK(("check_vfsmnt: ret=%d\n", ret));
>  	return ret;
>  }
> 
> _

Sorry, I don't think it is correct. This code is called under dcache_lock,
taken in is_tree_busy(). mntput() calls dput() and which can lead to deadlock.

I was thinking of some clean solution and trying to understand autofs4 but
some what lost in user mode utility, version 3 and 4, etc etc. 

Dick, can you test the appended patch whether it works for you or not.

Thanks
Maneesh

diff -puN fs/autofs4/expire.c~autofs4-vfsmount-fix fs/autofs4/expire.c
--- linux-2.6.0-test2/fs/autofs4/expire.c~autofs4-vfsmount-fix	2003-08-06 09:10:49.000000000 +0530
+++ linux-2.6.0-test2-maneesh/fs/autofs4/expire.c	2003-08-06 09:24:07.000000000 +0530
@@ -25,7 +25,10 @@ static inline int is_vfsmnt_tree_busy(st
 	struct list_head *next;
 	int count;
 
-	count = atomic_read(&mnt->mnt_count) - 1;
+	/* -1 for vfsmount's normal count,
+	 * -1 for ref taken in lookup_mnt()
+	 */
+	count = atomic_read(&mnt->mnt_count) - 1 - 1;
 
 repeat:
 	next = this_parent->mnt_mounts.next;
@@ -71,7 +74,8 @@ static int check_vfsmnt(struct vfsmount 
 	struct vfsmount *vfs = lookup_mnt(mnt, dentry);
 
 	if (vfs && is_vfsmnt_tree_busy(vfs))
-		ret--;
+		ret = 0;
+	mntput(vfs);
 	DPRINTK(("check_vfsmnt: ret=%d\n", ret));
 	return ret;
 }
@@ -96,8 +100,11 @@ static int is_tree_busy(struct vfsmount 
 		DPRINTK(("is_tree_busy: autofs; count=%d\n", count));
 	}
 
-	if (d_mountpoint(top))
+	if (d_mountpoint(top)) {
+		spin_unlock(&dcache_lock);
 		count -= check_vfsmnt(topmnt, top);
+		spin_lock(&dcache_lock);
+	}
 
  repeat:
 	next = this_parent->d_subdirs.next;
@@ -110,8 +117,11 @@ static int is_tree_busy(struct vfsmount 
 
 		count += atomic_read(&dentry->d_count) - 1;
 
-		if (d_mountpoint(dentry))
+		if (d_mountpoint(dentry)) {
+			spin_unlock(&dcache_lock);
 			adj += check_vfsmnt(topmnt, dentry);
+			spin_lock(&dcache_lock);
+		}
 
 		if (is_autofs4_dentry(dentry)) {
 			adj++;

_
_

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
