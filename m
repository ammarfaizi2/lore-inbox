Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262304AbTCJWkw>; Mon, 10 Mar 2003 17:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbTCJWkw>; Mon, 10 Mar 2003 17:40:52 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57827 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262296AbTCJWks>;
	Mon, 10 Mar 2003 17:40:48 -0500
Date: Mon, 10 Mar 2003 16:27:01 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <linux-ppp@vger.kernel.org>
Subject: Re: 2.5.64 oops in ppp / pppo2 / kobject
In-Reply-To: <1047336461.10548.3.camel@simulacron>
Message-ID: <Pine.LNX.4.33.0303101625230.1002-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Mar 2003, Andreas Jellinghaus wrote:

> pppoe link failed, then ppp oopsed.
> 
> Also, shutting down the system ends in a deadlock
> (or so? nothing is happening, lots of processes in __down.)
> 
> plain 2.5.64 plus ipv6/setkey patch (unreleated i think).

Please try the latest BK snapshot from 

http://kernel.org/pub/linux/kernel/v2.5/snapshots/

Plus this patch on top it. This problem has been reported before, and this
patch should fix it..

Thanks,

	-pat

===== fs/sysfs/dir.c 1.4 vs edited =====
--- 1.4/fs/sysfs/dir.c	Sat Mar  8 23:42:32 2003
+++ edited/fs/sysfs/dir.c	Sun Mar  9 16:01:45 2003
@@ -98,7 +98,6 @@
 			 * Unlink and unhash.
 			 */
 			spin_unlock(&dcache_lock);
-			d_delete(d);
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
 			spin_lock(&dcache_lock);
@@ -108,16 +107,11 @@
 	}
 	spin_unlock(&dcache_lock);
 	up(&dentry->d_inode->i_sem);
-	d_invalidate(dentry);
-	simple_rmdir(parent->d_inode,dentry);
 	d_delete(dentry);
+	simple_rmdir(parent->d_inode,dentry);
 
 	pr_debug(" o %s removing done (%d)\n",dentry->d_name.name,
 		 atomic_read(&dentry->d_count));
-	/**
-	 * Drop reference from initial sysfs_get_dentry().
-	 */
-	dput(dentry);
 
 	/**
 	 * Drop reference from dget() on entrance.
===== fs/sysfs/inode.c 1.83 vs edited =====
--- 1.83/fs/sysfs/inode.c	Mon Mar  3 17:11:29 2003
+++ edited/fs/sysfs/inode.c	Sun Mar  9 14:25:45 2003
@@ -93,19 +93,14 @@
 		/* make sure dentry is really there */
 		if (victim->d_inode && 
 		    (victim->d_parent->d_inode == dir->d_inode)) {
-			simple_unlink(dir->d_inode,victim);
-			d_delete(victim);
-
 			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
 				 atomic_read(&victim->d_count));
-			/*
-			 * Drop reference from initial sysfs_get_dentry().
-			 */
-			dput(victim);
+
+			simple_unlink(dir->d_inode,victim);
+
 		}
-		
-		/**
-		 * Drop the reference acquired from sysfs_get_dentry() above.
+		/*
+		 * Drop reference from sysfs_get_dentry() above.
 		 */
 		dput(victim);
 	}

