Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVACNWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVACNWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVACNWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:22:03 -0500
Received: from [213.146.154.40] ([213.146.154.40]:27111 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261437AbVACNV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:21:28 -0500
Date: Mon, 3 Jan 2005 13:21:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050103132125.GA19379@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103102535.GB17856@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103102535.GB17856@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 10:25:35AM +0000, Christoph Hellwig wrote:
> > -ioctl-cleanup.patch
> > -unlocked_ioctl.patch
> > +ioctl-rework.patch
> > 
> >  New version of the dont-hold-BKL-across-ioctl patch.
> 
> For the native case the new naming is stupid.  The old ioctl_unlocked
> made perfect sense while ioctl_native doesn't - after all ->ioctl is
> native aswell.  Also this still has the useless inode * paramater in
> the method signature.

Here's a better and much simpler patch:

 - add ->unlocked_ioctl method and a do_ioctl wrapper in ioctl.c so all
   places calling ->ioctl get it.
 - add ->compat_ioctl method and call it in compat_sys_ioctl before doing
   the hash lookup for registered handlers.
 - streamline compat_sys_ioctl and move the complex error reporting into
   a function of it's own


--- 1.52/Documentation/filesystems/Locking	2004-10-25 11:41:20 +02:00
+++ edited/Documentation/filesystems/Locking	2005-01-03 12:23:34 +01:00
@@ -350,6 +350,8 @@
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int,
 			unsigned long);
+	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
+	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
@@ -383,6 +385,8 @@
 readdir: 		no
 poll:			no
 ioctl:			yes	(see below)
+unlocked_ioctl:		no	(see below)
+compat_ioctl:		no
 mmap:			no
 open:			maybe	(see below)
 flush:			no
@@ -427,6 +431,9 @@
 ->ioctl() or kill the latter completely. One of the problems is that for
 anything that resembles union-mount we won't have a struct file for all
 components. And there are other reasons why the current interface is a mess...
+
+->ioctl() on regular files is superceded by the ->unlocked_ioctl() that
+doesn't take the BKL.
 
 ->read on directories probably must go away - we should just enforce -EISDIR
 in sys_read() and friends.
--- 1.47/fs/compat.c	2004-12-10 18:57:46 +01:00
+++ edited/fs/compat.c	2005-01-03 13:58:00 +01:00
@@ -397,77 +397,87 @@
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
 
--- 1.14/fs/ioctl.c	2004-10-19 07:26:38 +02:00
+++ edited/fs/ioctl.c	2005-01-03 14:01:24 +01:00
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
@@ -36,7 +58,9 @@
 			if ((error = get_user(block, p)) != 0)
 				return error;
 
+			lock_kernel();
 			res = mapping->a_ops->bmap(mapping, block);
+			unlock_kernel();
 			return put_user(res, p);
 		}
 		case FIGETBSZ:
@@ -46,14 +70,13 @@
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
@@ -63,12 +86,9 @@
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
@@ -100,8 +120,11 @@
 
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
@@ -124,16 +147,15 @@
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
 
--- 1.362/include/linux/fs.h	2004-10-29 10:14:03 +02:00
+++ edited/include/linux/fs.h	2005-01-03 11:38:01 +01:00
@@ -902,8 +902,8 @@
 
 /*
  * NOTE:
- * read, write, poll, fsync, readv, writev can be called
- *   without the big kernel lock held in all filesystems.
+ * read, write, poll, fsync, readv, writev, unlocked_ioctl and compat_ioctl
+ * can be called without the big kernel lock held in all filesystems.
  */
 struct file_operations {
 	struct module *owner;
@@ -915,6 +915,8 @@
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
+	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
+	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
