Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUKIHqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUKIHqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 02:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbUKIHqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 02:46:55 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:62882 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261416AbUKIHqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 02:46:02 -0500
Date: Tue, 9 Nov 2004 18:45:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [1/6] PPC64 iSeries combine some MF code
Message-Id: <20041109184551.03b8a32c.sfr@canb.auug.org.au>
In-Reply-To: <20041109184223.16ea3414.sfr@canb.auug.org.au>
References: <20041109184223.16ea3414.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__9_Nov_2004_18_45_51_+1100_NQtJShOHYE5HkOzY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__9_Nov_2004_18_45_51_+1100_NQtJShOHYE5HkOzY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch just moves mf_proc.c into mf.c inanticipation of more cleanup
to come.  So mf_proc.c ceases to exist

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk/arch/ppc64/kernel/Makefile linus-bk-mf.0.5/arch/ppc64/kernel/Makefile
--- linus-bk/arch/ppc64/kernel/Makefile	2004-10-29 10:45:15.000000000 +1000
+++ linus-bk-mf.0.5/arch/ppc64/kernel/Makefile	2004-11-09 16:28:49.000000000 +1100
@@ -22,7 +22,7 @@
 
 obj-$(CONFIG_PPC_ISERIES) += iSeries_irq.o \
 			     iSeries_VpdInfo.o XmPciLpEvent.o \
-			     HvCall.o HvLpConfig.o LparData.o mf_proc.o \
+			     HvCall.o HvLpConfig.o LparData.o \
 			     iSeries_setup.o ItLpQueue.o hvCall.o \
 			     mf.o HvLpEvent.o iSeries_proc.o iSeries_htab.o \
 			     iSeries_iommu.o
diff -ruN linus-bk/arch/ppc64/kernel/mf.c linus-bk-mf.0.5/arch/ppc64/kernel/mf.c
--- linus-bk/arch/ppc64/kernel/mf.c	2004-05-07 06:56:27.000000000 +1000
+++ linus-bk-mf.0.5/arch/ppc64/kernel/mf.c	2004-11-09 16:30:30.000000000 +1100
@@ -1,6 +1,7 @@
 /*
   * mf.c
   * Copyright (C) 2001 Troy D. Armstrong  IBM Corporation
+  * Copyright (C) 2004 Stephen Rothwell  IBM Corporation
   *
   * This modules exists as an interface between a Linux secondary partition
   * running on an iSeries and the primary partition's Virtual Service
@@ -1079,3 +1080,232 @@
    
 	return signal_ce_msg(ceTime, NULL);
 }
+
+static int proc_mf_dump_cmdline(char *page, char **start, off_t off,
+		int count, int *eof, void *data)
+{
+	int len = count;
+	char *p;
+
+	if (off) {
+		*eof = 1;
+		return 0;
+	}
+
+	len = mf_getCmdLine(page, &len, (u64)data);
+   
+	p = page;
+	while (len < (count - 1)) {
+		if (!*p || *p == '\n')
+			break;
+		p++;
+		len++;
+	}
+	*p = '\n';
+	p++;
+	*p = 0;
+
+	return p - page;
+}
+
+#if 0
+static int proc_mf_dump_vmlinux(char *page, char **start, off_t off,
+		int count, int *eof, void *data)
+{
+	int sizeToGet = count;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (mf_getVmlinuxChunk(page, &sizeToGet, off, (u64)data) == 0) {
+		if (sizeToGet != 0) {
+			*start = page + off;
+			return sizeToGet;
+		}
+		*eof = 1;
+		return 0;
+	}
+	*eof = 1;
+	return 0;
+}
+#endif
+
+static int proc_mf_dump_side(char *page, char **start, off_t off,
+		int count, int *eof, void *data)
+{
+	int len;
+	char mf_current_side = mf_getSide();
+
+	len = sprintf(page, "%c\n", mf_current_side);
+
+	if (len <= (off + count))
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+	return len;			
+}
+
+static int proc_mf_change_side(struct file *file, const char __user *buffer,
+		unsigned long count, void *data)
+{
+	char stkbuf[10];
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (count > (sizeof(stkbuf) - 1))
+		count = sizeof(stkbuf) - 1;
+	if (copy_from_user(stkbuf, buffer, count))
+		return -EFAULT;
+	stkbuf[count] = 0;
+	if ((*stkbuf != 'A') && (*stkbuf != 'B') &&
+	    (*stkbuf != 'C') && (*stkbuf != 'D')) {
+		printk(KERN_ERR "mf_proc.c: proc_mf_change_side: invalid side\n");
+		return -EINVAL;
+	}
+
+	mf_setSide(*stkbuf);
+
+	return count;
+}
+
+static int proc_mf_dump_src(char *page, char **start, off_t off,
+		int count, int *eof, void *data)
+{
+	int len;
+
+	mf_getSrcHistory(page, count);
+	len = count;
+	len -= off;			
+	if (len < count) {		
+		*eof = 1;		
+		if (len <= 0)		
+			return 0;	
+	} else				
+		len = count;		
+	*start = page + off;		
+	return len;			
+}
+
+static int proc_mf_change_src(struct file *file, const char __user *buffer,
+		unsigned long count, void *data)
+{
+	char stkbuf[10];
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if ((count < 4) && (count != 1)) {
+		printk(KERN_ERR "mf_proc: invalid src\n");
+		return -EINVAL;
+	}
+
+	if (count > (sizeof(stkbuf) - 1))
+		count = sizeof(stkbuf) - 1;
+	if (copy_from_user(stkbuf, buffer, count))
+		return -EFAULT;
+
+	if ((count == 1) && (*stkbuf == '\0'))
+		mf_clearSrc();
+	else
+		mf_displaySrc(*(u32 *)stkbuf);
+
+	return count;			
+}
+
+static int proc_mf_change_cmdline(struct file *file, const char *buffer,
+		unsigned long count, void *data)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	mf_setCmdLine(buffer, count, (u64)data);
+
+	return count;			
+}
+
+static ssize_t proc_mf_change_vmlinux(struct file *file, 
+				      const char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	struct proc_dir_entry * dp = PDE(inode);
+	int rc;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	rc = mf_setVmlinuxChunk(buf, count, *ppos, (u64)dp->data);
+	if (rc < 0)
+		return rc;
+
+	*ppos += count;
+
+	return count;			
+}
+
+static struct file_operations proc_vmlinux_operations = {
+	.write		= proc_mf_change_vmlinux,
+};
+
+static int __init mf_proc_init(void)
+{
+	struct proc_dir_entry *mf_proc_root;
+	struct proc_dir_entry *ent;
+	struct proc_dir_entry *mf;
+	char name[2];
+	int i;
+
+	mf_proc_root = proc_mkdir("iSeries/mf", NULL);
+	if (!mf_proc_root)
+		return 1;
+
+	name[1] = '\0';
+	for (i = 0; i < 4; i++) {
+		name[0] = 'A' + i;
+		mf = proc_mkdir(name, mf_proc_root);
+		if (!mf)
+			return 1;
+
+		ent = create_proc_entry("cmdline", S_IFREG|S_IRUSR|S_IWUSR, mf);
+		if (!ent)
+			return 1;
+		ent->nlink = 1;
+		ent->data = (void *)(long)i;
+		ent->read_proc = proc_mf_dump_cmdline;
+		ent->write_proc = proc_mf_change_cmdline;
+
+		if (i == 3)	/* no vmlinux entry for 'D' */
+			continue;
+
+		ent = create_proc_entry("vmlinux", S_IFREG|S_IWUSR, mf);
+		if (!ent)
+			return 1;
+		ent->nlink = 1;
+		ent->data = (void *)(long)i;
+		ent->proc_fops = &proc_vmlinux_operations;
+	}
+
+	ent = create_proc_entry("side", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root);
+	if (!ent)
+		return 1;
+	ent->nlink = 1;
+	ent->data = (void *)0;
+	ent->read_proc = proc_mf_dump_side;
+	ent->write_proc = proc_mf_change_side;
+
+	ent = create_proc_entry("src", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root);
+	if (!ent)
+		return 1;
+	ent->nlink = 1;
+	ent->data = (void *)0;
+	ent->read_proc = proc_mf_dump_src;
+	ent->write_proc = proc_mf_change_src;
+
+	return 0;
+}
+
+__initcall(mf_proc_init);
diff -ruN linus-bk/arch/ppc64/kernel/mf_proc.c linus-bk-mf.0.5/arch/ppc64/kernel/mf_proc.c
--- linus-bk/arch/ppc64/kernel/mf_proc.c	2004-08-24 07:22:47.000000000 +1000
+++ linus-bk-mf.0.5/arch/ppc64/kernel/mf_proc.c	1970-01-01 10:00:00.000000000 +1000
@@ -1,250 +0,0 @@
-/*
- * mf_proc.c
- * Copyright (C) 2001 Kyle A. Lucke  IBM Corporation
- * 
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- * 
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#include <linux/init.h>
-#include <asm/uaccess.h>
-#include <asm/iSeries/mf.h>
-
-static int proc_mf_dump_cmdline(char *page, char **start, off_t off,
-		int count, int *eof, void *data)
-{
-	int len = count;
-	char *p;
-
-	if (off) {
-		*eof = 1;
-		return 0;
-	}
-
-	len = mf_getCmdLine(page, &len, (u64)data);
-   
-	p = page;
-	while (len < (count - 1)) {
-		if (!*p || *p == '\n')
-			break;
-		p++;
-		len++;
-	}
-	*p = '\n';
-	p++;
-	*p = 0;
-
-	return p - page;
-}
-
-#if 0
-static int proc_mf_dump_vmlinux(char *page, char **start, off_t off,
-		int count, int *eof, void *data)
-{
-	int sizeToGet = count;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (mf_getVmlinuxChunk(page, &sizeToGet, off, (u64)data) == 0) {
-		if (sizeToGet != 0) {
-			*start = page + off;
-			return sizeToGet;
-		}
-		*eof = 1;
-		return 0;
-	}
-	*eof = 1;
-	return 0;
-}
-#endif
-
-static int proc_mf_dump_side(char *page, char **start, off_t off,
-		int count, int *eof, void *data)
-{
-	int len;
-	char mf_current_side = mf_getSide();
-
-	len = sprintf(page, "%c\n", mf_current_side);
-
-	if (len <= (off + count))
-		*eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
-	return len;			
-}
-
-static int proc_mf_change_side(struct file *file, const char __user *buffer,
-		unsigned long count, void *data)
-{
-	char stkbuf[10];
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (count > (sizeof(stkbuf) - 1))
-		count = sizeof(stkbuf) - 1;
-	if (copy_from_user(stkbuf, buffer, count))
-		return -EFAULT;
-	stkbuf[count] = 0;
-	if ((*stkbuf != 'A') && (*stkbuf != 'B') &&
-	    (*stkbuf != 'C') && (*stkbuf != 'D')) {
-		printk(KERN_ERR "mf_proc.c: proc_mf_change_side: invalid side\n");
-		return -EINVAL;
-	}
-
-	mf_setSide(*stkbuf);
-
-	return count;
-}
-
-static int proc_mf_dump_src(char *page, char **start, off_t off,
-		int count, int *eof, void *data)
-{
-	int len;
-
-	mf_getSrcHistory(page, count);
-	len = count;
-	len -= off;			
-	if (len < count) {		
-		*eof = 1;		
-		if (len <= 0)		
-			return 0;	
-	} else				
-		len = count;		
-	*start = page + off;		
-	return len;			
-}
-
-static int proc_mf_change_src(struct file *file, const char __user *buffer,
-		unsigned long count, void *data)
-{
-	char stkbuf[10];
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if ((count < 4) && (count != 1)) {
-		printk(KERN_ERR "mf_proc: invalid src\n");
-		return -EINVAL;
-	}
-
-	if (count > (sizeof(stkbuf) - 1))
-		count = sizeof(stkbuf) - 1;
-	if (copy_from_user(stkbuf, buffer, count))
-		return -EFAULT;
-
-	if ((count == 1) && (*stkbuf == '\0'))
-		mf_clearSrc();
-	else
-		mf_displaySrc(*(u32 *)stkbuf);
-
-	return count;			
-}
-
-static int proc_mf_change_cmdline(struct file *file, const char *buffer,
-		unsigned long count, void *data)
-{
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	mf_setCmdLine(buffer, count, (u64)data);
-
-	return count;			
-}
-
-static ssize_t proc_mf_change_vmlinux(struct file *file, 
-				      const char __user *buf,
-				      size_t count, loff_t *ppos)
-{
-	struct inode * inode = file->f_dentry->d_inode;
-	struct proc_dir_entry * dp = PDE(inode);
-	int rc;
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	rc = mf_setVmlinuxChunk(buf, count, *ppos, (u64)dp->data);
-	if (rc < 0)
-		return rc;
-
-	*ppos += count;
-
-	return count;			
-}
-
-static struct file_operations proc_vmlinux_operations = {
-	.write		= proc_mf_change_vmlinux,
-};
-
-static int __init mf_proc_init(void)
-{
-	struct proc_dir_entry *mf_proc_root;
-	struct proc_dir_entry *ent;
-	struct proc_dir_entry *mf;
-	char name[2];
-	int i;
-
-	mf_proc_root = proc_mkdir("iSeries/mf", NULL);
-	if (!mf_proc_root)
-		return 1;
-
-	name[1] = '\0';
-	for (i = 0; i < 4; i++) {
-		name[0] = 'A' + i;
-		mf = proc_mkdir(name, mf_proc_root);
-		if (!mf)
-			return 1;
-
-		ent = create_proc_entry("cmdline", S_IFREG|S_IRUSR|S_IWUSR, mf);
-		if (!ent)
-			return 1;
-		ent->nlink = 1;
-		ent->data = (void *)(long)i;
-		ent->read_proc = proc_mf_dump_cmdline;
-		ent->write_proc = proc_mf_change_cmdline;
-
-		if (i == 3)	/* no vmlinux entry for 'D' */
-			continue;
-
-		ent = create_proc_entry("vmlinux", S_IFREG|S_IWUSR, mf);
-		if (!ent)
-			return 1;
-		ent->nlink = 1;
-		ent->data = (void *)(long)i;
-		ent->proc_fops = &proc_vmlinux_operations;
-	}
-
-	ent = create_proc_entry("side", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root);
-	if (!ent)
-		return 1;
-	ent->nlink = 1;
-	ent->data = (void *)0;
-	ent->read_proc = proc_mf_dump_side;
-	ent->write_proc = proc_mf_change_side;
-
-	ent = create_proc_entry("src", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root);
-	if (!ent)
-		return 1;
-	ent->nlink = 1;
-	ent->data = (void *)0;
-	ent->read_proc = proc_mf_dump_src;
-	ent->write_proc = proc_mf_change_src;
-
-	return 0;
-}
-
-__initcall(mf_proc_init);

--Signature=_Tue__9_Nov_2004_18_45_51_+1100_NQtJShOHYE5HkOzY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBkHWv4CJfqux9a+8RAmw0AJ9bMI6UFl6Ug2QByKaKRBKxsZpvXQCgi3Rg
bLGD0PgVh5shQ0Va6IZtcko=
=pZ0i
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Nov_2004_18_45_51_+1100_NQtJShOHYE5HkOzY--
