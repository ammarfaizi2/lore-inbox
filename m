Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbTAPQOX>; Thu, 16 Jan 2003 11:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267163AbTAPQOX>; Thu, 16 Jan 2003 11:14:23 -0500
Received: from 216-42-72-144.ppp.netsville.net ([216.42.72.144]:52712 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S267162AbTAPQOO>;
	Thu, 16 Jan 2003 11:14:14 -0500
Subject: Re: [2.4] VFS locking problem during concurrent link/unlink
From: Chris Mason <mason@suse.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
       eazgwmir@umail.furryterror.org, viro@math.psu.edu
In-Reply-To: <15910.55436.680525.450310@laputa.namesys.com>
References: <20030116140015.A17612@namesys.com>
	 <1042731580.31099.2195.camel@tiny.suse.com>
	 <20030116184352.A32192@namesys.com>
	 <1042732927.31100.2205.camel@tiny.suse.com>
	 <15910.55436.680525.450310@laputa.namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042734151.31095.2211.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 16 Jan 2003 11:22:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-16 at 11:06, Nikita Danilov wrote:
> Chris Mason writes:
>  > On Thu, 2003-01-16 at 10:43, Oleg Drokin wrote:
> 
> [...]
> 
>  > 
>  > link count at 1
>  > reiserfs_link: make new directory entry for link, schedule()
>  > reiserfs_unlink: dec link count to zero, remove file stat data
>  > reiserfs_link: inc link count, return thinking the stat data is still
>  > there
> 
> What protects ext2 from doing the same on the SMP?
> 

They inc the link count in ext2_link before scheduling.  The patch below
is what I had in mind, but is untested.

-chris

--- 1.24/fs/reiserfs/namei.c	Fri Aug  9 11:22:33 2002
+++ edited/fs/reiserfs/namei.c	Thu Jan 16 11:20:11 2003
@@ -748,6 +748,7 @@
     int windex ;
     struct reiserfs_transaction_handle th ;
     int jbegin_count;
+    unsigned long savelink;
 
     inode = dentry->d_inode;
 
@@ -783,11 +784,20 @@
 	inode->i_nlink = 1;
     }
 
+    inode->i_nlink--;
+
+    /* 
+     * we schedule before doing the add_save_link call, save the link
+     * count so we don't race
+     */
+    savelink = inode->i_nlink;
+
+
     retval = reiserfs_cut_from_item (&th, &path, &(de.de_entry_key), dir, NULL, 0);
-    if (retval < 0)
+    if (retval < 0) {
+	inode->i_nlink++;
 	goto end_unlink;
-
-    inode->i_nlink--;
+    }
     inode->i_ctime = CURRENT_TIME;
     reiserfs_update_sd (&th, inode);
 
@@ -796,7 +806,7 @@
     dir->i_ctime = dir->i_mtime = CURRENT_TIME;
     reiserfs_update_sd (&th, dir);
 
-    if (!inode->i_nlink)
+    if (!savelink)
        /* prevent file from getting lost */
        add_save_link (&th, inode, 0/* not truncate */);
 
@@ -900,6 +910,12 @@
 	//FIXME: sd_nlink is 32 bit for new files
 	return -EMLINK;
     }
+    if (inode->i_nlink == 0) {
+        return -ENOENT;
+    }
+
+    /* inc before scheduling so reiserfs_unlink knows we are here */
+    inode->i_nlink++;
 
     journal_begin(&th, dir->i_sb, jbegin_count) ;
     windex = push_journal_writer("reiserfs_link") ;
@@ -912,12 +928,12 @@
     reiserfs_update_inode_transaction(dir) ;
 
     if (retval) {
+        inode->i_nlink--;
 	pop_journal_writer(windex) ;
 	journal_end(&th, dir->i_sb, jbegin_count) ;
 	return retval;
     }
 
-    inode->i_nlink++;
     ctime = CURRENT_TIME;
     inode->i_ctime = ctime;
     reiserfs_update_sd (&th, inode);
@@ -992,6 +1008,7 @@
     int jbegin_count ; 
     umode_t old_inode_mode;
     time_t ctime;
+    unsigned long savelink = 1;
 
 
     /* two balancings: old name removal, new name insertion or "save" link,
@@ -1161,6 +1178,7 @@
 	} else {
 	    new_dentry_inode->i_nlink--;
 	}
+	savelink = new_dentry_inode->i_nlink;
 	ctime = CURRENT_TIME;
 	new_dentry_inode->i_ctime = ctime;
     }
@@ -1196,7 +1214,7 @@
     reiserfs_update_sd (&th, new_dir);
 
     if (new_dentry_inode) {
-	if (new_dentry_inode->i_nlink == 0)
+	if (savelink == 0)
 	    add_save_link (&th, new_dentry_inode, 0/* not truncate */);
 	reiserfs_update_sd (&th, new_dentry_inode);
     }



