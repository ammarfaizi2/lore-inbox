Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRAMOK6>; Sat, 13 Jan 2001 09:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130765AbRAMOKs>; Sat, 13 Jan 2001 09:10:48 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:17081 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130202AbRAMOKa>; Sat, 13 Jan 2001 09:10:30 -0500
X-Gnus-Agent-Meta-Information: mail nil
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] symlink creation broken in shmem.c
From: Christoph Rohland <cr@sap.com>
Message-ID: <m3g0ink1ss.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
Date: 13 Jan 2001 15:14:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The shmem_symlink function is completely broken in 2.4.0 and never
worked.

This patch removes the function from 2.4.0

Greetings
                Christoph

P.S.: For those which test read/write support patch: I will post patch
      for my swapfs soon which will make it working on top of that


diff -uNr 2.4.0/mm/shmem.c 2.4.0-nosymlink/mm/shmem.c
--- 2.4.0/mm/shmem.c	Sat Jan 13 14:20:51 2001
+++ 2.4.0-nosymlink/mm/shmem.c	Sat Jan 13 14:18:26 2001
@@ -374,8 +374,7 @@
 			inode->i_fop = &shmem_dir_operations;
 			break;
 		case S_IFLNK:
-			inode->i_op = &page_symlink_inode_operations;
-			break;
+			BUG();
 		}
 		spin_lock (&shmem_ilock);
 		list_add (&inode->u.shmem_i.list, &shmem_inodes);
@@ -528,19 +527,6 @@
 	return error;
 }
 
-static int shmem_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
-{
-	int error;
-
-	error = shmem_mknod(dir, dentry, S_IFLNK | S_IRWXUGO, 0);
-	if (!error) {
-		int l = strlen(symname)+1;
-		struct inode *inode = dentry->d_inode;
-		error = block_symlink(inode, symname, l);
-	}
-	return error;
-}
-
 static int shmem_mmap(struct file * file, struct vm_area_struct * vma)
 {
 	struct vm_operations_struct * ops;
@@ -677,7 +663,6 @@
 	lookup:		shmem_lookup,
 	link:		shmem_link,
 	unlink:		shmem_unlink,
-	symlink:	shmem_symlink,
 	mkdir:		shmem_mkdir,
 	rmdir:		shmem_rmdir,
 	mknod:		shmem_mknod,

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
