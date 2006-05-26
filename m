Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWEZPZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWEZPZp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 11:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWEZPZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 11:25:45 -0400
Received: from exo3753.pck.nerim.net ([213.41.240.142]:60316 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S1750908AbWEZPZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 11:25:45 -0400
Date: Fri, 26 May 2006 17:25:42 +0200
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>
Cc: Grant Coady <grant_lkml@dodo.com.au>, willy@w.ods.org
Subject: [ANNOUNCE] Linux-2.4.32-hf32.6
Message-ID: <20060526152542.GA18609@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Last hotfix caused some regression : a recent patch caused 7 panics at
boot on Grant Coady's machines, I'm quickly releasing a new hotfix with
this patch reverted. I have restricted download permissions on previous
one (32.5) in order to avoid a large mess.

If you have already downloaded 32.5, please either apply he patch included
in this mail, or download plain 32.6 from the sites below.

Sorry for the inconvenience,
Willy

  hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
   last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
       RSS feed : http://linux.exosec.net/kernel/hf.xml
  build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)
            GIT : http://w.ods.org/kernel/2.4/patches-2.4-hf.git/
         GITWEB : http://w.ods.org/git/?p=patches-2.4-hf.git;a=summary


New kernel information :

   Version | New | Total
   --------+-----+------
    2.4.28 |   0 |  177 
    2.4.29 |   0 |  174 
    2.4.30 |   0 |  108 
    2.4.31 |   0 |   95 
    2.4.32 |   0 |   45 
   --------+-----+------

Changelog from 2.4.32-hf32.5 to 2.4.32-hf32.6
---------------------------------------
'+' = added ; '-' = removed

- 2.4.32-ext3-link-unlink-race-1                              (Vadim Egorov)

  7 panics at boot reported by Grant Coady. Looks like dentry->d_inode is
  NULL in vfs_unlink(). Reverting the patch for now.


--- linux-2.4.32-hf32.5/fs/namei.c	2006-05-26 17:17:08.000000000 +0200
+++ linux-2.4.32-hf32.6/fs/namei.c	2005-04-14 09:43:34.000000000 +0200
@@ -1479,7 +1479,7 @@
 {
 	int error;
 
-	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
+	down(&dir->i_zombie);
 	error = may_delete(dir, dentry, 0);
 	if (!error) {
 		error = -EPERM;
@@ -1491,14 +1491,14 @@
 				lock_kernel();
 				error = dir->i_op->unlink(dir, dentry);
 				unlock_kernel();
+				if (!error)
+					d_delete(dentry);
 			}
 		}
 	}
-	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
-	if (!error) {
-		d_delete(dentry);
+	up(&dir->i_zombie);
+	if (!error)
 		inode_dir_notify(dir, DN_DELETE);
-	}
 	return error;
 }
 
@@ -1607,21 +1607,20 @@
 	struct inode *inode;
 	int error;
 
+	down(&dir->i_zombie);
 	error = -ENOENT;
 	inode = old_dentry->d_inode;
 	if (!inode)
-		goto exit;
-
-	error = -EXDEV;
-	if (dir->i_dev != inode->i_dev)
-		goto exit;
-
-	double_down(&dir->i_zombie, &old_dentry->d_inode->i_zombie);
+		goto exit_lock;
 
 	error = may_create(dir, new_dentry);
 	if (error)
 		goto exit_lock;
 
+	error = -EXDEV;
+	if (dir->i_dev != inode->i_dev)
+		goto exit_lock;
+
 	/*
 	 * A link to an append-only or immutable file cannot be created.
 	 */
@@ -1637,10 +1636,9 @@
 	unlock_kernel();
 
 exit_lock:
-	double_up(&dir->i_zombie, &old_dentry->d_inode->i_zombie);
+	up(&dir->i_zombie);
 	if (!error)
 		inode_dir_notify(dir, DN_CREATE);
-exit:
 	return error;
 }
 

--

Willy Tarreau - http://w.ods.org/
PGP Fingerprint : 72C2 A394 02EA F546 BA6F  A7B1 E82C B631 848A 1004
EXOSEC - ZAC des Metz - 3 Rue du petit robinson - 78350 JOUY EN JOSAS
N°Indigo: 0 825 075 510 - Accueil: +33 1 72 89 72 30 - Fax: +33 1 72 89 80 19
Site web : http://www.exosec.fr/

