Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262647AbTCIWUO>; Sun, 9 Mar 2003 17:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbTCIWUO>; Sun, 9 Mar 2003 17:20:14 -0500
Received: from air-2.osdl.org ([65.172.181.6]:35480 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262647AbTCIWUI>;
	Sun, 9 Mar 2003 17:20:08 -0500
Date: Sun, 9 Mar 2003 16:06:24 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Tomasz Torcz, BG" <zdzichu@irc.pl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: Kernel bug in dcache.h:266; 2.5.64, EIP at sysfs_remove_dir
In-Reply-To: <1047245678.8985.188.camel@ixodes.goop.org>
Message-ID: <Pine.LNX.4.33.0303091604530.994-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Mar 2003, Jeremy Fitzhardinge wrote:

> On Sun, 2003-03-09 at 12:31, Patrick Mochel wrote:
> > I was able to reproduce the Oops with a USB device on multiple insert/
> > removals. The patch below fixes the Oops for me. Could people who have 
> > seen the Oops try it out and let me know if it helps them? 
> > 
> > [ Unfortunately, I can't test some of the exact failure scenarios, as I 
> > don't use ppp, and my one system with PCMCIA has decided that it doesn't 
> > want to let me (physically) insert cards anymore.. ]
> 
> I'm still getting a crash with this patch+mm4.  I got this on ethernet
> card removal:

Bah, we're accidentally dropping the refcount on the directory one too 
many times, which is a different, though slightly related, problem to the 
one the previous patch fixed. 

Please try this patch (after removing the previous one). Thanks,

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

