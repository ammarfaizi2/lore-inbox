Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268615AbUHLQvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268615AbUHLQvo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268620AbUHLQvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:51:11 -0400
Received: from mout0.freenet.de ([194.97.50.131]:47833 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S268613AbUHLQuE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:50:04 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC, PATCH] sys_revoke(), just a try. (was: Re: dynamic /dev security hole?)
Date: Thu, 12 Aug 2004 18:49:17 +0200
User-Agent: KMail/1.6.2
References: <20040808162115.GA7597@kroah.com> <1092057570.5761.215.camel@cube> <200408111912.21469.mbuesch@freenet.de>
In-Reply-To: <200408111912.21469.mbuesch@freenet.de>
Cc: Albert Cahalan <albert@users.sf.net>, Eric Lammerts <eric@lammerts.org>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, Greg KH <greg@kroah.com>,
       albert@users.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408121849.20227.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Nobody interrested in this syscall?

I can't code this on my own, because I don't have the experience.
Need help for this IMHO needed syscall.

And yes, I forgot to attach the patch inline, so you
can comment on it. So here it is. :)


===== arch/i386/kernel/entry.S 1.77 vs edited =====
- --- 1.77/arch/i386/kernel/entry.S	2004-05-22 23:56:24 +02:00
+++ edited/arch/i386/kernel/entry.S	2004-08-10 20:11:29 +02:00
@@ -886,5 +886,6 @@
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
+	.long sys_revoke
 
 syscall_table_size=(.-sys_call_table)
===== fs/open.c 1.68 vs edited =====
- --- 1.68/fs/open.c	2004-08-08 03:54:13 +02:00
+++ edited/fs/open.c	2004-08-11 18:58:26 +02:00
@@ -1043,6 +1043,134 @@
 
 EXPORT_SYMBOL(sys_close);
 
+static int revoke_ret_ebadf(void)
+{
+	return -EBADF;
+}
+
+static ssize_t revoke_read(struct file *filp,
+			   char *buf,
+			   size_t count,
+			   loff_t *ppos)
+{
+	return 0;
+}
+
+static int revoke_release(struct inode *inode, struct file *filp)
+{
+	fops_put(filp->f_op);
+	filp->f_op = NULL;
+	return 0;
+}
+
+static ssize_t revoke_readv(struct file *filp,
+			    const struct iovec *iov,
+			    unsigned long count,
+			    loff_t *ppos)
+{
+	return 0;
+}
+
+static struct file_operations revoke_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= (void *)revoke_ret_ebadf,
+	.read		= revoke_read,
+	.write		= (void *)revoke_ret_ebadf,
+	.readdir	= (void *)revoke_ret_ebadf,
+	.poll		= (void *)revoke_ret_ebadf,
+	.ioctl		= (void *)revoke_ret_ebadf,
+	.mmap		= (void *)revoke_ret_ebadf,
+	.open		= (void *)revoke_ret_ebadf,
+	.flush		= (void *)revoke_ret_ebadf,
+	.release	= revoke_release,
+	.fsync		= (void *)revoke_ret_ebadf,
+	.fasync		= (void *)revoke_ret_ebadf,
+	.lock		= (void *)revoke_ret_ebadf,
+	.readv		= revoke_readv,
+	.writev		= (void *)revoke_ret_ebadf,
+};
+
+static int filp_revoke(struct file *filp, struct inode *inode)
+{
+	struct file_operations *fops = filp->f_op;
+	int ret = 0;
+
+	down(&inode->i_sem);
+	if (!fops || !file_count(filp))
+		goto out_truncate;
+
+	filp->f_op = &revoke_fops;
+
+	if (fops->flush)
+		fops->flush(filp);
+	if (fops->release)
+		ret = fops->release(inode, filp);
+	fops_put(fops);
+
+out_truncate:
+	vmtruncate(inode, (loff_t)0);
+	up(&inode->i_sem);
+	return ret;
+}
+
+asmlinkage int sys_revoke(const char *path)
+{
+	struct nameidata nd;
+	struct super_block *sb;
+	struct list_head *p;
+	struct file *filp;
+	int ret = 0;
+printk("called sys_revoke()\n");
+
+	if (user_path_walk(path, &nd)) {
+printk("user_path_walk() failed\n");
+		ret = -ENOENT;
+		goto out;
+	}
+	if (!nd.dentry->d_inode) {
+printk("no inode\n");
+		ret = -ENOENT;
+		goto out_release;
+	}
+	/* Allow only on Character or Block Devices. */
+	if (!S_ISCHR(nd.dentry->d_inode->i_mode) &&
+	    !S_ISBLK(nd.dentry->d_inode->i_mode)) {
+printk("no CHK/BLK\n");
+		ret = -EINVAL;
+		goto out_release;
+	}
+	if ((current->fsuid != nd.dentry->d_inode->i_uid) ||
+	    !capable(CAP_FOWNER)) {
+printk("perm\n");
+		ret = -EPERM;
+		goto out_release;
+	}
+
+	sb = nd.dentry->d_inode->i_sb;
+	file_list_lock();
+	for (p = sb->s_files.next; p != &sb->s_files; p = p->next) {
+		filp = list_entry(p, struct file, f_list);
+
+		if (!filp || !filp->f_dentry)
+			continue;
+		if (nd.dentry != filp->f_dentry)
+			continue;
+		if (filp->f_op == &revoke_fops)
+			continue;
+		if (!filp->f_dentry->d_inode)
+			continue;
+
+		ret = filp_revoke(filp, filp->f_dentry->d_inode);
+	}
+	file_list_unlock();
+printk("done");
+
+out_release:
+	path_release(&nd);
+out:
+	return ret;
+}
+
 /*
  * This routine simulates a hangup on the tty, to arrange that users
  * are given clean terminals at login time.
===== include/asm-i386/unistd.h 1.39 vs edited =====
- --- 1.39/include/asm-i386/unistd.h	2004-08-02 10:00:44 +02:00
+++ edited/include/asm-i386/unistd.h	2004-08-10 20:14:44 +02:00
@@ -289,8 +289,9 @@
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
+#define __NR_revoke		284
 
- -#define NR_syscalls 284
+#define NR_syscalls 285
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 



Quoting Michael Buesch <mbuesch@freenet.de>:
> Quoting Albert Cahalan <albert@users.sf.net>:
> > Now all we need is revoke() and we're all set.
> > Ordering: chown, chmod, revoke, unlink
> 
> So, I searched the archives and found two previous attempts to create
> a revoke syscall. They were long long ago.
> I picked up some of its code and did a patch for latest 2.6 bk.
> I'm currently running a kernel with the patch applied and did some
> basic tests on it. Testing source is attached, too.
> 
> I am a beginner in Kernel programming. I read some books and online
> tutorials, but did not write much code.
> So I'm sure, the code is full of bugs. I think there are nasty
> race conditions.
> Would be cool if someone could review it for races and report
> them, please. I've not yet the experience to find them.
> 
> Thank you. Have fun.
> 

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBG5+NFGK1OIvVOP4RAoTgAKClBCUcLqJYk8o7aukgpkCzGEjVswCfZJVm
6ZsZw85Cps9LihNCX/3RnTI=
=LjLk
-----END PGP SIGNATURE-----
