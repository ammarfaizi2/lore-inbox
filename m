Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbTCIUpE>; Sun, 9 Mar 2003 15:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262619AbTCIUpD>; Sun, 9 Mar 2003 15:45:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56279 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262609AbTCIUo4>;
	Sun, 9 Mar 2003 15:44:56 -0500
Date: Sun, 9 Mar 2003 14:31:12 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: "Tomasz Torcz, BG" <zdzichu@irc.pl>, <linux-kernel@vger.kernel.org>,
       <akpm@digeo.com>
Subject: Re: Kernel bug in dcache.h:266; 2.5.64, EIP at sysfs_remove_dir
In-Reply-To: <Pine.LNX.4.33.0303091205280.994-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0303091427100.994-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Mar 2003, Patrick Mochel wrote:

> 
> On Sun, 9 Mar 2003, Martin J. Bligh wrote:
> 
> > Look for akpm's latest -mm tree release notes - the patch is embedded
> > in there.
> 
> Actually, sysfs is officially fscked in 2.5.64. I'm looking into it, so 
> more reports of it crashing are not necessary. :) I apologize for the 
> inconveniences this has caused.

I was able to reproduce the Oops with a USB device on multiple insert/
removals. The patch below fixes the Oops for me. Could people who have 
seen the Oops try it out and let me know if it helps them? 

[ Unfortunately, I can't test some of the exact failure scenarios, as I 
don't use ppp, and my one system with PCMCIA has decided that it doesn't 
want to let me (physically) insert cards anymore.. ]

Thanks,

	-pat


===== fs/sysfs/dir.c 1.4 vs edited =====
--- 1.4/fs/sysfs/dir.c	Sat Mar  8 23:42:32 2003
+++ edited/fs/sysfs/dir.c	Sun Mar  9 14:25:26 2003
@@ -98,7 +98,6 @@
 			 * Unlink and unhash.
 			 */
 			spin_unlock(&dcache_lock);
-			d_delete(d);
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
 			spin_lock(&dcache_lock);
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


