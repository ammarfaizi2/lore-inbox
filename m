Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287205AbRL2WUY>; Sat, 29 Dec 2001 17:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287200AbRL2WUI>; Sat, 29 Dec 2001 17:20:08 -0500
Received: from gherkin.frus.com ([192.158.254.49]:41856 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S286794AbRL2WTx>;
	Sat, 29 Dec 2001 17:19:53 -0500
Message-Id: <m16KRpY-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: a few patches against 2.5.2-pre3
To: linux-kernel@vger.kernel.org
Date: Sat, 29 Dec 2001 16:19:52 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM716040821-22781-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM716040821-22781-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

Appended are a few patches against 2.5.2-pre3 to fix problems with
undefined symbols in the lvm, nfs, and intermezzo modules.  Specifically,
the lvm patch changes a lvm_get_blksize() reference to block_size(), the
nfs patch is a repost of prior art (I don't claim it, and I don't
remember who the original contributor is), and the intermezzo patch
takes care of an undefined ioctl command (missing include file).

Associated functionality NOT verified.  If these patches appear to be
correct, please include them in 2.5.2.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

--ELM716040821-22781-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch02_lvm

--- linux/drivers/md/lvm.c.orig	Sat Dec 29 13:53:49 2001
+++ linux/drivers/md/lvm.c	Sat Dec 29 15:11:49 2001
@@ -1046,7 +1046,7 @@
 
 	memset(&bio,0,sizeof(bio));
 	bio.bi_dev = inode->i_rdev;
-	bio.bi_size = lvm_get_blksize(bio.bi_dev); /* NEEDED by bio_sectors */
+	bio.bi_size = block_size(bio.bi_dev); /* NEEDED by bio_sectors */
  	bio.bi_sector = block * bio_sectors(&bio);
 	bio.bi_rw = READ;
 	if ((err=lvm_map(&bio)) < 0)  {

--ELM716040821-22781-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch02_nfs

diff -urN linux/fs/Makefile linux.mt/fs/Makefile
--- linux/fs/Makefile	Sun Dec  9 23:57:24 2001
+++ linux.mt/fs/Makefile	Mon Dec 10 22:18:31 2001
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o
+export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o seq_file.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
diff -urN linux/fs/seq_file.c linux.mt/fs/seq_file.c
--- linux/fs/seq_file.c	Sat Nov 17 21:16:22 2001
+++ linux.mt/fs/seq_file.c	Tue Dec 11 00:39:09 2001
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 
@@ -293,3 +294,9 @@
 	m->count = m->size;
 	return -1;
 }
+EXPORT_SYMBOL(seq_printf);
+EXPORT_SYMBOL(seq_escape);
+EXPORT_SYMBOL(seq_release);
+EXPORT_SYMBOL(seq_lseek);
+EXPORT_SYMBOL(seq_open);
+EXPORT_SYMBOL(seq_read);
diff -urN linux/include/linux/seq_file.h linux.mt/include/linux/seq_file.h
--- linux/include/linux/seq_file.h	Sun Dec  9 23:57:24 2001
+++ linux.mt/include/linux/seq_file.h	Mon Dec 10 23:47:15 2001
@@ -26,11 +26,11 @@
 	int (*show) (struct seq_file *m, void *v);
 };
 
-int seq_open(struct file *, struct seq_operations *);
-ssize_t seq_read(struct file *, char *, size_t, loff_t *);
-loff_t seq_lseek(struct file *, loff_t, int);
-int seq_release(struct inode *, struct file *);
-int seq_escape(struct seq_file *, const char *, const char *);
+extern int seq_open(struct file *, struct seq_operations *);
+extern ssize_t seq_read(struct file *, char *, size_t, loff_t *);
+extern loff_t seq_lseek(struct file *, loff_t, int);
+extern int seq_release(struct inode *, struct file *);
+extern int seq_escape(struct seq_file *, const char *, const char *);
 
 static inline int seq_putc(struct seq_file *m, char c)
 {
@@ -53,7 +53,7 @@
 	return -1;
 }
 
-int seq_printf(struct seq_file *, const char *, ...)
+extern int seq_printf(struct seq_file *, const char *, ...)
 	__attribute__ ((format (printf,2,3)));
 
 #endif

--ELM716040821-22781-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch02_psdev

--- linux/fs/intermezzo/psdev.c.orig	Fri Nov 23 18:51:03 2001
+++ linux/fs/intermezzo/psdev.c	Tue Dec 18 21:37:29 2001
@@ -50,6 +50,7 @@
 #include <asm/system.h>
 #include <asm/poll.h>
 #include <asm/uaccess.h>
+#include <asm/ioctls.h>
 
 #include <linux/intermezzo_fs.h>
 #include <linux/intermezzo_upcall.h>

--ELM716040821-22781-0_--
