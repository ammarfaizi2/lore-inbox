Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290370AbSBOR6Q>; Fri, 15 Feb 2002 12:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290344AbSBOR6H>; Fri, 15 Feb 2002 12:58:07 -0500
Received: from air-2.osdl.org ([65.201.151.6]:58499 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S290417AbSBOR5w>;
	Fri, 15 Feb 2002 12:57:52 -0500
Date: Fri, 15 Feb 2002 09:57:42 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
        <linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
In-Reply-To: <3C6D4A58.6070401@wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0202150956400.829-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> no, it doesn't solve the problem. i would like to test it whith 
> preemtible kernel not set but it doesn't boot.

While Greg's patch did fix part of the problem, the rest of it was on my 
end. Could you try this patch, and see if helps?

Thanks,

	-pat

===== fs/driverfs/inode.c 1.14 vs edited =====
--- 1.14/fs/driverfs/inode.c	Wed Feb 13 15:27:02 2002
+++ edited/fs/driverfs/inode.c	Fri Feb 15 09:53:44 2002
@@ -585,29 +585,6 @@
 }
 
 /**
- * __remove_file - remove a regular file in the filesystem
- * @dentry:	dentry of file to remove
- *
- * Call unlink to remove the file, and dput on the dentry to drop
- * the refcount.
- */
-static void __remove_file(struct dentry * dentry)
-{
-	dget(dentry);
-	down(&dentry->d_inode->i_sem);
-
-	vfs_unlink(dentry->d_parent->d_inode,dentry);
-
-	up(&dentry->d_inode->i_sem);
-	dput(dentry);
-
-	/* remove reference count from when file was created */
-	dput(dentry);
-
-	put_mount();
-}
-
-/**
  * driverfs_remove_file - exported file removal
  * @dir:	directory the file supposedly resides in
  * @name:	name of the file
@@ -617,14 +594,12 @@
  */
 void driverfs_remove_file(struct driver_dir_entry * dir, const char * name)
 {
-	struct dentry * dentry;
 	struct list_head * node;
 
 	if (!dir->dentry)
 		return;
 
-	dentry = dget(dir->dentry);
-	down(&dentry->d_inode->i_sem);
+	down(&dir->dentry->d_inode->i_sem);
 
 	node = dir->files.next;
 	while (node != &dir->files) {
@@ -633,14 +608,13 @@
 		entry = list_entry(node,struct driver_file_entry,node);
 		if (!strcmp(entry->name,name)) {
 			list_del_init(node);
-
-			__remove_file(entry->dentry);
+			vfs_unlink(entry->dentry->d_parent->d_inode,entry->dentry);
+			put_mount();
 			break;
 		}
 		node = node->next;
 	}
-	up(&dentry->d_inode->i_sem);
-	dput(dentry);
+	up(&dir->dentry->d_inode->i_sem);
 }
 
 /**
@@ -669,15 +643,14 @@
 		entry = list_entry(node,struct driver_file_entry,node);
 
 		list_del_init(node);
-
-		__remove_file(entry->dentry);
-
+		vfs_unlink(dentry->d_inode,entry->dentry);
+		put_mount();
 		node = dir->files.next;
 	}
+	up(&dentry->d_inode->i_sem);
 
 	vfs_rmdir(dentry->d_parent->d_inode,dentry);
 	up(&dentry->d_parent->d_inode->i_sem);
-	up(&dentry->d_inode->i_sem);
 	dput(dentry);
  done:
 	put_mount();

