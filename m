Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVAEVgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVAEVgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVAEVgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:36:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:54687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262600AbVAEVe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:34:27 -0500
Date: Wed, 5 Jan 2005 13:33:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: hch@infradead.org, ak@suse.de, mingo@elte.hu, rlrevell@joe-job.com,
       tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Message-Id: <20050105133358.16ce6891.akpm@osdl.org>
In-Reply-To: <20050105150310.GA19758@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de>
	<20041217014345.GA11926@mellanox.co.il>
	<20050105144043.GB19434@mellanox.co.il>
	<20050105144603.GA1419@infradead.org>
	<20050105150310.GA19758@mellanox.co.il>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@mellanox.co.il> wrote:
>
> Quoting r. Christoph Hellwig (hch@infradead.org) "Re: [PATCH] deprecate (un)register_ioctl32_conversion":
>  > On Wed, Jan 05, 2005 at 04:40:43PM +0200, Michael S. Tsirkin wrote:
>  > > Hello, Andrew, all!
>  > > 
>  > > Since in -mm1 we now have a race-free replacement (that being ioctl_compat),
>  > > here is a patch to deprecate (un)register_ioctl32_conversion.
>  > 
>  > Sorry, but this is a lot too early.  Once there's a handfull users left
>  > in _mainline_ you can start deprecating it (or better remove it completely).
> 
>  I dont know. So how will people know they are supposed to convert then?
> 
>  > So far we have a non-final version of the replacement in -mm and no single
>  > user converted.
> 
>  Christoph, I know you want to remove the inode parameter :)
> 
>  Otherwise I think -mm1 has the final version of the replacement.

I merged Christoph's verion of the patch into -mm.



--- 25/Documentation/filesystems/Locking~ioctl-rework-2	Tue Jan  4 15:08:56 2005
+++ 25-akpm/Documentation/filesystems/Locking	Tue Jan  4 15:08:56 2005
@@ -350,6 +350,8 @@ prototypes:
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int,
 			unsigned long);
+	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
+	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
@@ -383,6 +385,8 @@ aio_write:		no
 readdir: 		no
 poll:			no
 ioctl:			yes	(see below)
+unlocked_ioctl:		no	(see below)
+compat_ioctl:		no
 mmap:			no
 open:			maybe	(see below)
 flush:			no
@@ -428,6 +432,9 @@ move ->readdir() to inode_operations and
 anything that resembles union-mount we won't have a struct file for all
 components. And there are other reasons why the current interface is a mess...
 
+->ioctl() on regular files is superceded by the ->unlocked_ioctl() that
+doesn't take the BKL.
+
 ->read on directories probably must go away - we should just enforce -EISDIR
 in sys_read() and friends.
 
diff -puN fs/compat.c~ioctl-rework-2 fs/compat.c
--- 25/fs/compat.c~ioctl-rework-2	Tue Jan  4 15:08:56 2005
+++ 25-akpm/fs/compat.c	Tue Jan  4 15:08:56 2005
@@ -397,77 +397,87 @@ out:
 }
 EXPORT_SYMBOL(unregister_ioctl32_conversion); 
 
+static void compat_ioctl_error(struct file *filp, unsigned int fd,
+		unsigned int cmd, unsigned long arg)
+{
+	char buf[10];
+	char *fn = "?";
+	char *path;
+
+	/* find the name of the device. */
+	path = (char *)__get_free_page(GFP_KERNEL);
+	if (path) {
+		fn = d_path(filp->f_dentry, filp->f_vfsmnt, path, PAGE_SIZE);
+		if (IS_ERR(fn))
+			fn = "?";
+	}
+
+	sprintf(buf,"'%c'", (cmd>>24) & 0x3f);
+	if (!isprint(buf[1]))
+		sprintf(buf, "%02x", buf[1]);
+	printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
+			"cmd(%08x){%s} arg(%08x) on %s\n",
+			current->comm, current->pid,
+			(int)fd, (unsigned int)cmd, buf,
+			(unsigned int)arg, fn);
+
+	if (path)
+		free_page((unsigned long)path);
+}
+
 asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
 				unsigned long arg)
 {
-	struct file * filp;
+	struct file *filp;
 	int error = -EBADF;
 	struct ioctl_trans *t;
 
 	filp = fget(fd);
-	if(!filp)
-		goto out2;
-
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
+	if (!filp)
 		goto out;
+
+	if (!filp->f_op) {
+		if (!filp->f_op->ioctl)
+			goto do_ioctl;
+	} else if (filp->f_op->compat_ioctl) {
+		error = filp->f_op->compat_ioctl(filp, cmd, arg);
+		goto out_fput;
 	}
 
 	down_read(&ioctl32_sem);
+	for (t = ioctl32_hash_table[ioctl32_hash(cmd)]; t; t = t->next) {
+		if (t->cmd == cmd)
+			goto found_handler;
+	}
+	up_read(&ioctl32_sem);
 
-	t = ioctl32_hash_table[ioctl32_hash (cmd)];
-
-	while (t && t->cmd != cmd)
-		t = t->next;
-	if (t) {
-		if (t->handler) { 
-			lock_kernel();
-			error = t->handler(fd, cmd, arg, filp);
-			unlock_kernel();
-			up_read(&ioctl32_sem);
-		} else {
-			up_read(&ioctl32_sem);
-			error = sys_ioctl(fd, cmd, arg);
-		}
+	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
+		error = siocdevprivate_ioctl(fd, cmd, arg);
 	} else {
+		static int count;
+
+		if (++count <= 50)
+			compat_ioctl_error(filp, fd, cmd, arg);
+		error = -EINVAL;
+	}
+
+	goto out_fput;
+
+ found_handler:
+	if (t->handler) {
+		lock_kernel();
+		error = t->handler(fd, cmd, arg, filp);
+		unlock_kernel();
 		up_read(&ioctl32_sem);
-		if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
-			error = siocdevprivate_ioctl(fd, cmd, arg);
-		} else {
-			static int count;
-			if (++count <= 50) {
-				char buf[10];
-				char *fn = "?";
-				char *path;
-
-				path = (char *)__get_free_page(GFP_KERNEL);
-
-				/* find the name of the device. */
-				if (path) {
-			       		fn = d_path(filp->f_dentry,
-						filp->f_vfsmnt, path,
-						PAGE_SIZE);
-					if (IS_ERR(fn))
-						fn = "?";
-				}
-
-				sprintf(buf,"'%c'", (cmd>>24) & 0x3f);
-				if (!isprint(buf[1]))
-				    sprintf(buf, "%02x", buf[1]);
-				printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
-					"cmd(%08x){%s} arg(%08x) on %s\n",
-					current->comm, current->pid,
-					(int)fd, (unsigned int)cmd, buf,
-					(unsigned int)arg, fn);
-				if (path)
-					free_page((unsigned long)path);
-			}
-			error = -EINVAL;
-		}
+		goto out_fput;
 	}
-out:
+
+	up_read(&ioctl32_sem);
+ do_ioctl:
+	error = sys_ioctl(fd, cmd, arg);
+ out_fput:
 	fput(filp);
-out2:
+ out:
 	return error;
 }
 
diff -puN fs/ioctl.c~ioctl-rework-2 fs/ioctl.c
--- 25/fs/ioctl.c~ioctl-rework-2	Tue Jan  4 15:08:56 2005
+++ 25-akpm/fs/ioctl.c	Tue Jan  4 15:08:56 2005
@@ -16,7 +16,29 @@
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
-static int file_ioctl(struct file *filp,unsigned int cmd,unsigned long arg)
+static long do_ioctl(struct file *filp, unsigned int cmd,
+		unsigned long arg)
+{
+	int error = -ENOTTY;
+
+	if (!filp->f_op)
+		goto out;
+
+	if (filp->f_op->unlocked_ioctl) {
+		error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
+	} else if (filp->f_op->ioctl) {
+		lock_kernel();
+		error = filp->f_op->ioctl(filp->f_dentry->d_inode,
+					  filp, cmd, arg);
+		unlock_kernel();
+	}
+
+ out:
+	return error;
+}
+
+static int file_ioctl(struct file *filp, unsigned int cmd,
+		unsigned long arg)
 {
 	int error;
 	int block;
@@ -36,7 +58,9 @@ static int file_ioctl(struct file *filp,
 			if ((error = get_user(block, p)) != 0)
 				return error;
 
+			lock_kernel();
 			res = mapping->a_ops->bmap(mapping, block);
+			unlock_kernel();
 			return put_user(res, p);
 		}
 		case FIGETBSZ:
@@ -46,14 +70,13 @@ static int file_ioctl(struct file *filp,
 		case FIONREAD:
 			return put_user(i_size_read(inode) - filp->f_pos, p);
 	}
-	if (filp->f_op && filp->f_op->ioctl)
-		return filp->f_op->ioctl(inode, filp, cmd, arg);
-	return -ENOTTY;
+
+	return do_ioctl(filp, cmd, arg);
 }
 
 
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{	
+{
 	struct file * filp;
 	unsigned int flag;
 	int on, error = -EBADF;
@@ -63,12 +86,9 @@ asmlinkage long sys_ioctl(unsigned int f
 		goto out;
 
 	error = security_file_ioctl(filp, cmd, arg);
-	if (error) {
-                fput(filp);
-                goto out;
-        }
+	if (error)
+		goto out_fput;
 
-	lock_kernel();
 	switch (cmd) {
 		case FIOCLEX:
 			set_close_on_exec(fd, 1);
@@ -100,8 +120,11 @@ asmlinkage long sys_ioctl(unsigned int f
 
 			/* Did FASYNC state change ? */
 			if ((flag ^ filp->f_flags) & FASYNC) {
-				if (filp->f_op && filp->f_op->fasync)
+				if (filp->f_op && filp->f_op->fasync) {
+					lock_kernel();
 					error = filp->f_op->fasync(fd, filp, on);
+					unlock_kernel();
+				}
 				else error = -ENOTTY;
 			}
 			if (error != 0)
@@ -124,16 +147,15 @@ asmlinkage long sys_ioctl(unsigned int f
 				error = -ENOTTY;
 			break;
 		default:
-			error = -ENOTTY;
 			if (S_ISREG(filp->f_dentry->d_inode->i_mode))
 				error = file_ioctl(filp, cmd, arg);
-			else if (filp->f_op && filp->f_op->ioctl)
-				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
+			else
+				error = do_ioctl(filp, cmd, arg);
+			break;
 	}
-	unlock_kernel();
+ out_fput:
 	fput(filp);
-
-out:
+ out:
 	return error;
 }
 
diff -puN include/linux/fs.h~ioctl-rework-2 include/linux/fs.h
--- 25/include/linux/fs.h~ioctl-rework-2	Tue Jan  4 15:08:56 2005
+++ 25-akpm/include/linux/fs.h	Tue Jan  4 15:08:56 2005
@@ -907,8 +907,8 @@ typedef int (*read_actor_t)(read_descrip
 
 /*
  * NOTE:
- * read, write, poll, fsync, readv, writev can be called
- *   without the big kernel lock held in all filesystems.
+ * read, write, poll, fsync, readv, writev, unlocked_ioctl and compat_ioctl
+ * can be called without the big kernel lock held in all filesystems.
  */
 struct file_operations {
 	struct module *owner;
@@ -920,6 +920,8 @@ struct file_operations {
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
+	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
+	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
_

