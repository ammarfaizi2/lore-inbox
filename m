Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270663AbTHFEzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 00:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272476AbTHFEzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 00:55:09 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33431 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S270663AbTHFEzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 00:55:03 -0400
Date: Wed, 6 Aug 2003 10:30:03 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Dick Streefland <dick.streefland@xs4all.nl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] autofs4 doesn't expire
Message-ID: <20030806050003.GB1298@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <4b0c.3f302ca5.93873@altium.nl> <20030805164904.36b5d2cc.akpm@osdl.org> <20030806042853.GA1298@in.ibm.com> <1060144454.18625.5.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060144454.18625.5.camel@ixodes.goop.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 09:34:14PM -0700, Jeremy Fitzhardinge wrote:
> On Tue, 2003-08-05 at 21:28, Maneesh Soni wrote:
> > Sorry, I don't think it is correct. This code is called under dcache_lock,
> > taken in is_tree_busy(). mntput() calls dput() and which can lead to deadlock.
> 
> Urk.  On the other hand, it only calls dput if the refcount drops to
> zero, which it can't because there's already a reference (hence the -2
> in is_vfsmnt_tree_busy).
> 
> I'm not too keen on releasing dcache lock, since the whole point is to
> keep the dcache tree stable while we traverse it.

yeah.. that is the problem in release dcache_lock there. How about just
doing atomic_dec(&vfs->mnt_count) in place of mntput()? This is also ugly,
but otherwise we have to re-write the entire is_tree_busy() thing.

> 
> > @@ -71,7 +74,8 @@ static int check_vfsmnt(struct vfsmount 
> >         struct vfsmount *vfs = lookup_mnt(mnt, dentry);
> >  
> >         if (vfs && is_vfsmnt_tree_busy(vfs))
> > -               ret--;
> > +               ret = 0;
> 
> Erm, why?
> 

oh.. it should be ret--. I just copied Andrew's code. Following is the 
corrected patch


 fs/autofs4/expire.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff -puN fs/autofs4/expire.c~autofs4-vfsmount-fix fs/autofs4/expire.c
--- linux-2.6.0-test2/fs/autofs4/expire.c~autofs4-vfsmount-fix	2003-08-06 09:10:49.000000000 +0530
+++ linux-2.6.0-test2-maneesh/fs/autofs4/expire.c	2003-08-06 10:25:58.000000000 +0530
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
@@ -70,8 +73,14 @@ static int check_vfsmnt(struct vfsmount 
 	int ret = dentry->d_mounted;
 	struct vfsmount *vfs = lookup_mnt(mnt, dentry);
 
-	if (vfs && is_vfsmnt_tree_busy(vfs))
-		ret--;
+	if (vfs) {
+		if (is_vfsmnt_tree_busy(vfs))
+			ret--;
+		/* just to reduce ref count taken in lookup_mnt
+	 	 * cannot call mntput() here
+	 	 */
+		atomic_dec(&vfs->mnt_count);
+	}
 	DPRINTK(("check_vfsmnt: ret=%d\n", ret));
 	return ret;
 }

_

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
