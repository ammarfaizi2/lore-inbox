Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbSKQSYL>; Sun, 17 Nov 2002 13:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267549AbSKQSYL>; Sun, 17 Nov 2002 13:24:11 -0500
Received: from verein.lst.de ([212.34.181.86]:6928 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267548AbSKQSYE>;
	Sun, 17 Nov 2002 13:24:04 -0500
Date: Sun, 17 Nov 2002 19:31:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH] change allow_write_access/deny_write_access prototype
Message-ID: <20021117193100.A6763@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make them take an inode instead of a file, this way we don't need
to derefence struct dentry in fs.h and with a few more steps we can
get rid of dcache.h in fs.h


--- 1.4/arch/mips/kernel/irixelf.c	Sat Aug  3 21:35:55 2002
+++ edited/arch/mips/kernel/irixelf.c	Sun Nov 17 12:25:58 2002
@@ -775,8 +775,10 @@
 	return retval;
 
 out_free_dentry:
-	allow_write_access(interpreter);
-	fput(interpreter);
+	if (interpreter) {
+		allow_write_access(interpreter->f_dentry->d_inode);
+		fput(interpreter);
+	}
 out_free_interp:
 	if (elf_interpreter)
 		kfree(elf_interpreter);
===== arch/parisc/kernel/sys_parisc32.c 1.2 vs edited =====
--- 1.2/arch/parisc/kernel/sys_parisc32.c	Fri Nov  1 04:48:35 2002
+++ edited/arch/parisc/kernel/sys_parisc32.c	Sun Nov 17 12:22:21 2002
@@ -275,7 +275,7 @@
 
 out_file:
 	if (bprm.file) {
-		allow_write_access(bprm.file);
+		allow_write_access(bprm.file->f_dentry->d_inode);
 		fput(bprm.file);
 	}
 
===== arch/ppc64/kernel/sys_ppc32.c 1.30 vs edited =====
--- 1.30/arch/ppc64/kernel/sys_ppc32.c	Fri Oct 18 13:03:47 2002
+++ edited/arch/ppc64/kernel/sys_ppc32.c	Sun Nov 17 12:22:31 2002
@@ -3564,7 +3564,7 @@
 
 out_file:
 	if (bprm.file) {
-		allow_write_access(bprm.file);
+		allow_write_access(bprm.file->f_dentry->d_inode);
 		fput(bprm.file);
 	}
 	return retval;
===== arch/s390x/kernel/linux32.c 1.24 vs edited =====
--- 1.24/arch/s390x/kernel/linux32.c	Fri Oct 18 13:03:47 2002
+++ edited/arch/s390x/kernel/linux32.c	Sun Nov 17 12:23:14 2002
@@ -3059,12 +3059,12 @@
 	bprm.loader = 0;
 	bprm.exec = 0;
 	if ((bprm.argc = count32(argv)) < 0) {
-		allow_write_access(file);
+		allow_write_access(file->f_dentry->d_inode);
 		fput(file);
 		return bprm.argc;
 	}
 	if ((bprm.envc = count32(envp)) < 0) {
-		allow_write_access(file);
+		allow_write_access(file->f_dentry->d_inode);
 		fput(file);
 		return bprm.envc;
 	}
@@ -3093,9 +3093,10 @@
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
-	allow_write_access(bprm.file);
-	if (bprm.file)
+	if (bprm.file) {
+		allow_write_access(bprm.file->f_dentry->d_inode);
 		fput(bprm.file);
+	}
 
 	for (i=0 ; i<MAX_ARG_PAGES ; i++)
 		if (bprm.page[i])
===== arch/sparc64/kernel/sys_sparc32.c 1.45 vs edited =====
--- 1.45/arch/sparc64/kernel/sys_sparc32.c	Tue Nov 12 22:43:12 2002
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Sun Nov 17 12:23:22 2002
@@ -3070,7 +3070,7 @@
 
 out_file:
 	if (bprm.file) {
-		allow_write_access(bprm.file);
+		allow_write_access(bprm.file->f_dentry->d_inode);
 		fput(bprm.file);
 	}
 	return retval;
===== fs/binfmt_elf.c 1.33 vs edited =====
--- 1.33/fs/binfmt_elf.c	Thu Nov  7 05:48:31 2002
+++ edited/fs/binfmt_elf.c	Sun Nov 17 13:43:19 2002
@@ -717,9 +717,11 @@
 						    interpreter,
 						    &interp_load_addr);
 
-		allow_write_access(interpreter);
-		fput(interpreter);
-		kfree(elf_interpreter);
+		if (interpreter) {
+			allow_write_access(interpreter->f_dentry->d_inode);
+			fput(interpreter);
+			kfree(elf_interpreter);
+		}
 
 		if (BAD_ADDR(elf_entry)) {
 			printk(KERN_ERR "Unable to load interpreter\n");
@@ -793,8 +795,10 @@
 
 	/* error cleanup */
 out_free_dentry:
-	allow_write_access(interpreter);
-	fput(interpreter);
+	if (interpreter) {
+		allow_write_access(interpreter->f_dentry->d_inode);
+		fput(interpreter);
+	}
 out_free_interp:
 	if (elf_interpreter)
 		kfree(elf_interpreter);
===== fs/binfmt_em86.c 1.7 vs edited =====
--- 1.7/fs/binfmt_em86.c	Tue Sep 17 15:52:27 2002
+++ edited/fs/binfmt_em86.c	Sun Nov 17 12:23:55 2002
@@ -45,9 +45,11 @@
 	}
 
 	bprm->sh_bang++;	/* Well, the bang-shell is implicit... */
-	allow_write_access(bprm->file);
-	fput(bprm->file);
-	bprm->file = NULL;
+	if (bprm->file) {
+		allow_write_access(bprm->file->f_dentry->d_inode);
+		fput(bprm->file);
+		bprm->file = NULL;
+	}
 
 	/* Unlike in the script case, we don't have to do any hairy
 	 * parsing to find our interpreter... it's hardcoded!
===== fs/binfmt_misc.c 1.17 vs edited =====
--- 1.17/fs/binfmt_misc.c	Sat Nov 16 16:13:10 2002
+++ edited/fs/binfmt_misc.c	Sun Nov 17 12:24:31 2002
@@ -121,9 +121,11 @@
 	if (!fmt)
 		goto _ret;
 
-	allow_write_access(bprm->file);
-	fput(bprm->file);
-	bprm->file = NULL;
+	if (bprm->file) {
+		allow_write_access(bprm->file->f_dentry->d_inode);
+		fput(bprm->file);
+		bprm->file = NULL;
+	}
 
 	/* Build args for interpreter */
 	if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
===== fs/binfmt_script.c 1.6 vs edited =====
--- 1.6/fs/binfmt_script.c	Tue Sep 17 15:52:27 2002
+++ edited/fs/binfmt_script.c	Sun Nov 17 12:24:49 2002
@@ -31,9 +31,11 @@
 	 */
 
 	bprm->sh_bang++;
-	allow_write_access(bprm->file);
-	fput(bprm->file);
-	bprm->file = NULL;
+	if (bprm->file) {
+		allow_write_access(bprm->file->f_dentry->d_inode);
+		fput(bprm->file);
+		bprm->file = NULL;
+	}
 
 	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
 	if ((cp = strchr(bprm->buf, '\n')) == NULL)
--- 1.56/fs/exec.c	Sat Nov 16 15:42:05 2002
+++ edited/fs/exec.c	Sun Nov 17 13:12:49 2002
@@ -462,7 +462,7 @@
 			if (!err) {
 				file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
 				if (!IS_ERR(file)) {
-					err = deny_write_access(file);
+					err = deny_write_access(inode);
 					if (err) {
 						fput(file);
 						file = ERR_PTR(err);
@@ -934,9 +934,11 @@
 		struct file * file;
 		unsigned long loader;
 
-		allow_write_access(bprm->file);
-		fput(bprm->file);
-		bprm->file = NULL;
+		if (bprm->file) {
+			allow_write_access(bprm->file->f_dentry->d_inode);
+			fput(bprm->file);
+			bprm->file = NULL;
+		}
 
 	        loader = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
 
@@ -977,10 +979,11 @@
 			retval = fn(bprm, regs);
 			if (retval >= 0) {
 				put_binfmt(fmt);
-				allow_write_access(bprm->file);
-				if (bprm->file)
+				if (bprm->file) {
+					allow_write_access(bprm->file->f_dentry->d_inode);
 					fput(bprm->file);
-				bprm->file = NULL;
+					bprm->file = NULL;
+				}
 				current->did_exec = 1;
 				return retval;
 			}
@@ -1101,7 +1104,7 @@
 
 out_file:
 	if (bprm.file) {
-		allow_write_access(bprm.file);
+		allow_write_access(bprm.file->f_dentry->d_inode);
 		fput(bprm.file);
 	}
 	return retval;
--- 1.58/fs/namei.c	Sat Nov 16 15:43:09 2002
+++ edited/fs/namei.c	Sun Nov 17 12:46:40 2002
@@ -251,14 +251,15 @@
 	spin_unlock(&arbitration_lock);
 	return 0;
 }
-int deny_write_access(struct file * file)
+
+int deny_write_access(struct inode * inode)
 {
 	spin_lock(&arbitration_lock);
-	if (atomic_read(&file->f_dentry->d_inode->i_writecount) > 0) {
+	if (atomic_read(&inode->i_writecount) > 0) {
 		spin_unlock(&arbitration_lock);
 		return -ETXTBSY;
 	}
-	atomic_dec(&file->f_dentry->d_inode->i_writecount);
+	atomic_dec(&inode->i_writecount);
 	spin_unlock(&arbitration_lock);
 	return 0;
 }
--- 1.191/include/linux/fs.h	Sat Nov 16 15:18:12 2002
+++ edited/include/linux/fs.h	Sun Nov 17 17:40:42 2002
@@ -1173,15 +1155,14 @@
 extern int permission(struct inode *, int);
 extern int vfs_permission(struct inode *, int);
 extern int get_write_access(struct inode *);
-extern int deny_write_access(struct file *);
+extern int deny_write_access(struct inode *);
 static inline void put_write_access(struct inode * inode)
 {
 	atomic_dec(&inode->i_writecount);
 }
-static inline void allow_write_access(struct file *file)
+static inline void allow_write_access(struct inode *inode)
 {
-	if (file)
-		atomic_inc(&file->f_dentry->d_inode->i_writecount);
+	atomic_inc(&inode->i_writecount);
 }
 extern int do_pipe(int *);
 
--- 1.62/mm/mmap.c	Thu Nov  7 05:48:58 2002
+++ edited/mm/mmap.c	Sun Nov 17 12:47:29 2002
@@ -567,7 +567,7 @@
 		if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
 			goto free_vma;
 		if (vm_flags & VM_DENYWRITE) {
-			error = deny_write_access(file);
+			error = deny_write_access(file->f_dentry->d_inode);
 			if (error)
 				goto free_vma;
 			correct_wcount = 1;

