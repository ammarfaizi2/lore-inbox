Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbQLHQp7>; Fri, 8 Dec 2000 11:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbQLHQpt>; Fri, 8 Dec 2000 11:45:49 -0500
Received: from gw.atria.com ([192.88.237.2]:42000 "EHLO gw.atria.com")
	by vger.kernel.org with ESMTP id <S130768AbQLHQpm>;
	Fri, 8 Dec 2000 11:45:42 -0500
Message-Id: <200012081615.LAA22468@cryolite.atria.com>
Date: Fri, 8 Dec 2000 11:15:42 -0500 (EST)
From: William Taber <wtaber@rational.com>
Reply-To: William Taber <wtaber@rational.com>
Subject: [PATCH] 2.2.x Fixes for stackable filesystems
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: sct@redhat.com, tytso@mit.edu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: 1CxMl6rcQwJ+ok0rVvSvIA==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.3.4p_5 SunOS 5.7 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, Alan,

I am resubmitting this patch for inclusion in the 2.2.x tree because I
received no response to my initial submission.  This patch has been
tested this on 2.2.14-2.2.17.  At Usenix last summer, Stephen Tweedie
and Ted T'so looked at it and saw no problems with it (which is why I
have included them on the cc: line).  

Our kernel patches help stacking file systems work properly in two
areas:

* dentry reference count fixes when files are opened by init_private_file()
* file reference count fixes for stacking filesystems mmap().

1. In some cases, stacking file systems which do no data translation may
want to substitute another dentry/inode at the time of a file open.  If
they do that, the dentry reference counts will get mishandled by some
callers of init_private_file().  Our changes make init_private_file()
take a dentry reference itself, and free it only if an error occurs on
the file open.  This leaves the file open routine free to swap the
dentry with another one.  All callers of the file system open routine
must dget() the dentry before putting it into the file structure prior
to calling the open routine.  Callers of init_private_file() must dput()
the file's dentry when they are done with the file.

2. In the mmap case, stacking file systems which do no data translation
probably want to substitute the underlying file system's file pointer,
so that paging operations are handled directly by the underlying file
system.  The call into the file system's mmap() must be allowed to set
the VM area's file pointer, so that it can effect this swap.  Our change
to the VM system is to set the VMA's file pointer only if the specific
mmap() routine did not set it.

Thanks,

Will Taber

+---------------------------------------------------------------------+
| Will Taber                                                          |
| Software Engineer, CMBU                 E-mail  wtaber@rational.com |
| Rational Software Corporation           Phone:  781-676-2436        |
| 20 Maguire Road, Lexington, Mass. 02421                             |
+---------------------------------------------------------------------+


diff -Naur linux.clean.2.2.14/fs/exec.c linux/fs/exec.c
--- linux.clean.2.2.14/fs/exec.c	Tue Oct 26 20:53:42 1999
+++ linux/fs/exec.c	Wed Sep 13 09:51:09 2000
@@ -136,7 +136,7 @@
 			goto out_fd;
 		f->f_flags = mode;
 		f->f_mode = (mode+1) & O_ACCMODE;
-		f->f_dentry = dentry;
+		f->f_dentry = dget(dentry);
 		f->f_pos = 0;
 		f->f_reada = 0;
 		f->f_op = inode->i_op->default_file_ops;
@@ -146,11 +146,11 @@
 				goto out_filp;
 		}
 		fd_install(fd, f);
-		dget(dentry);
 	}
 	return fd;
 
 out_filp:
+        dput(dentry);
 	if (error > 0)
 		error = -EIO;
 	put_filp(f);
@@ -371,6 +371,7 @@
 close_readexec:
 	if (file.f_op->release)
 		file.f_op->release(inode,&file);
+        dput(file.f_dentry);
 end_readexec:
 	return result;
 }
diff -Naur linux.clean.2.2.14/fs/file_table.c linux/fs/file_table.c
--- linux.clean.2.2.14/fs/file_table.c	Tue Jan  4 13:12:23 2000
+++ linux/fs/file_table.c	Wed Sep 13 09:51:09 2000
@@ -117,16 +117,20 @@
  */
 int init_private_file(struct file *filp, struct dentry *dentry, int mode)
 {
+	int err;
 	memset(filp, 0, sizeof(*filp));
 	filp->f_mode   = mode;
 	filp->f_count  = 1;
-	filp->f_dentry = dentry;
+	filp->f_dentry = dget(dentry);
 	filp->f_uid    = current->fsuid;
 	filp->f_gid    = current->fsgid;
 	filp->f_op     = dentry->d_inode->i_op->default_file_ops;
-	if (filp->f_op->open)
-		return filp->f_op->open(dentry->d_inode, filp);
-	else
+	if (filp->f_op->open) {
+		err = filp->f_op->open(dentry->d_inode, filp);
+                if (err)
+                    dput(dentry);
+		return err;
+        } else
 		return 0;
 }
 
diff -Naur linux.clean.2.2.14/fs/nfsd/nfsfh.c linux/fs/nfsd/nfsfh.c
--- linux.clean.2.2.14/fs/nfsd/nfsfh.c	Tue Sep 12 17:08:27 2000
+++ linux/fs/nfsd/nfsfh.c	Wed Sep 13 09:51:09 2000
@@ -396,6 +396,7 @@
 out_close:
 	if (file.f_op->release)
 		file.f_op->release(dir, &file);
+        dput(file.f_dentry);
 out:
 	return error;
 }
diff -Naur linux.clean.2.2.14/mm/mmap.c linux/mm/mmap.c
--- linux.clean.2.2.14/mm/mmap.c	Tue Jan  4 13:12:26 2000
+++ linux/mm/mmap.c	Wed Sep 13 09:51:09 2000
@@ -321,8 +321,14 @@
 			file->f_dentry->d_inode->i_writecount++;
 		if (error)
 			goto unmap_and_free_vma;
-		vma->vm_file = file;
-		file->f_count++;
+                if (vma->vm_file == NULL) {
+                    /*
+                     * underlying FS may have attached it differently--only
+                     * attach it if they didn't.
+                     */
+                    vma->vm_file = file;
+                    file->f_count++;
+                }
 	}
 
 	/*



------ End of patch -----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
