Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTBQLPW>; Mon, 17 Feb 2003 06:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbTBQLPW>; Mon, 17 Feb 2003 06:15:22 -0500
Received: from bi-01pt1.bluebird.ibm.com ([129.42.208.186]:8234 "EHLO
	bigbang.in.ibm.com") by vger.kernel.org with ESMTP
	id <S266987AbTBQLPU>; Mon, 17 Feb 2003 06:15:20 -0500
Date: Mon, 17 Feb 2003 17:08:56 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org,
       adam@yggdrasil.com, kernel@kolivas.org
Subject: Re: 2.5.61-mm1
Message-ID: <20030217113856.GC1112@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030214231356.59e2ef51.akpm@digeo.com> <m365rlf5ia.fsf@lugabout.jhcloos.org> <20030215162904.6ba8fdc2.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215162904.6ba8fdc2.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 12:31:31AM +0000, Andrew Morton wrote:
> "James H. Cloos Jr." <cloos@jhcloos.com> wrote:
> >
> > I just tried 2.5.61 and 2.5.61-mm1 on a dell inspiron 8100.
> > 
> > 2.5.61 is working OK, but -mm1 hung as soon as it tried to exec init.
> > init=/bin/bash showed the same failure.
> > 
> > init(8) was able to print out it's first line, announcing its version
> > but then stopped.  with init=/bin/bash bash did not output anything.
> > 
> 
> If you are using devfs then yes, there is a locking problem.
> 
> If you are not using devfs then please send me your .config.
> 
> Thanks.

Hello Andrew,

The following patch should enable smalldevfs to work with dcache_rcu. The
locking problem is because smalldevfs is written keeping fastwalk
in mind where as dcache_rcu backs out fastwalk code to 2.5.10 level.

Patch is based on 2.5.61-mm1.

Regards,
Maneesh

dcache_rcu-smalldevfs.patch

diff -urN linux-2.5.61-mm1/fs/devfs/base.c linux-2.5.61-mm1-smalldevfs-dcache_rcu/fs/devfs/base.c
--- linux-2.5.61-mm1/fs/devfs/base.c	2003-02-17 12:04:54.000000000 +0530
+++ linux-2.5.61-mm1-smalldevfs-dcache_rcu/fs/devfs/base.c	2003-02-17 12:29:46.000000000 +0530
@@ -60,8 +60,7 @@
 		memcpy(buf, *path, len);
 		buf[len] = '\0';
 
-		spin_lock(&dcache_lock);
-		err = link_path_walk(buf, nd); /* releases dcache_lock */
+		err = link_path_walk(buf, nd); 
 
 		if (err)
 			return err;
@@ -101,14 +100,13 @@
 
 	memset(&nd, 0, sizeof(nd));
 	nd.flags = LOOKUP_PARENT;
-	nd.mnt = devfs_vfsmount;
-	nd.dentry = dir;
+	nd.mnt = mntget(devfs_vfsmount);
+	nd.dentry = dget(dir);
 
 	err = walk_parents_mkdir(&name, &nd, is_dir);
 	if (err)
 		return err;
 
-	spin_lock(&dcache_lock);
 	err = link_path_walk(name, &nd);
 	if (err)
 		return err;
@@ -247,10 +245,9 @@
 	buf[sizeof(buf)-1] = '\0';
 
 	memset(&nd, 0, sizeof(nd));
-	nd.mnt = devfs_vfsmount;
-	nd.dentry = devfs_vfsmount->mnt_sb->s_root;
+	nd.mnt = mntget(devfs_vfsmount);
+	nd.dentry = dget(devfs_vfsmount->mnt_sb->s_root);
 
-	spin_lock(&dcache_lock);
 	err = link_path_walk(buf, &nd);
 	if (!err) {
 		devfs_unregister(nd.dentry);


-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
