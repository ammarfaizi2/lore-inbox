Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTHYRIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTHYRIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:08:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:9602 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262072AbTHYRIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:08:05 -0400
Date: Mon, 25 Aug 2003 10:03:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: marcelo@conectiva.com.br
Cc: lkml <linux-kernel@vger.kernel.org>, johnstul@us.ibm.com,
       jamesclv@us.ibm.com
Subject: [PATCH] add seq_file "single" interfaces
Message-Id: <20030825100310.3c96fd68.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds the seq_file "single" interfaces from 2.6.0-test4
to 2.4.22++.  This will enable larger /proc/interrupts and
/proc/mdstat, which currently have some oopsing problems
with large outputs.

Please apply.

--
~Randy


patch_name:	seq_single_2423p1.patch
patch_version:	2003-08-25.09:34:59
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	add seq_file "single" interfaces from 2.6.0-test4
product:	Linux
product_versions: 2422
diffstat:	=
 fs/seq_file.c            |   90 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/seq_file.h |   13 ++++++
 2 files changed, 100 insertions(+), 3 deletions(-)

diff -Naurp ./include/linux/seq_file.h~seqsingle ./include/linux/seq_file.h
--- ./include/linux/seq_file.h~seqsingle	2002-08-02 17:39:45.000000000 -0700
+++ ./include/linux/seq_file.h	2003-08-25 09:34:39.000000000 -0700
@@ -2,7 +2,15 @@
 #define _LINUX_SEQ_FILE_H
 #ifdef __KERNEL__
 
+#include <linux/types.h>
+#include <linux/string.h>
+#include <asm/semaphore.h>
+
 struct seq_operations;
+struct file;
+struct vfsmount;
+struct dentry;
+struct inode;
 
 struct seq_file {
 	char *buf;
@@ -52,5 +60,10 @@ static inline int seq_puts(struct seq_fi
 int seq_printf(struct seq_file *, const char *, ...)
 	__attribute__ ((format (printf,2,3)));
 
+int seq_path(struct seq_file *, struct vfsmount *, struct dentry *, char *);
+
+int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
+int single_release(struct inode *, struct file *);
+int seq_release_private(struct inode *, struct file *);
 #endif
 #endif
diff -Naurp ./fs/seq_file.c~seqsingle ./fs/seq_file.c
--- ./fs/seq_file.c~seqsingle	2003-06-13 07:51:37.000000000 -0700
+++ ./fs/seq_file.c	2003-08-25 09:34:39.000000000 -0700
@@ -1,7 +1,7 @@
 /*
  * linux/fs/seq_file.c
  *
- * helper functions for making syntetic files from sequences of records.
+ * helper functions for making synthetic files from sequences of records.
  * initial implementation -- AV, Oct 2001.
  */
 
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 
 #include <asm/uaccess.h>
+#include <asm/page.h>
 
 /**
  *	seq_open -	initialize sequential file
@@ -214,7 +215,7 @@ loff_t seq_lseek(struct file *file, loff
 				while ((retval=traverse(m, offset)) == -EAGAIN)
 					;
 				if (retval) {
-					/* with extreme perjudice... */
+					/* with extreme prejudice... */
 					file->f_pos = 0;
 					m->index = 0;
 					m->count = 0;
@@ -249,7 +250,7 @@ int seq_release(struct inode *inode, str
  *	@s:	string
  *	@esc:	set of characters that need escaping
  *
- *	Puts string into buffer, replacing each occurence of character from
+ *	Puts string into buffer, replacing each occurrence of character from
  *	@esc with usual octal escape.  Returns 0 in case of success, -1 - in
  *	case of overflow.
  */
@@ -295,3 +296,86 @@ int seq_printf(struct seq_file *m, const
 	m->count = m->size;
 	return -1;
 }
+
+int seq_path(struct seq_file *m,
+		struct vfsmount *mnt, struct dentry *dentry,
+		char *esc)
+{
+	if (m->count < m->size) {
+		char *s = m->buf + m->count;
+		char *p = d_path(dentry, mnt, s, m->size - m->count);
+		if (!IS_ERR(p)) {
+			while (s <= p) {
+				char c = *p++;
+				if (!c) {
+					p = m->buf + m->count;
+					m->count = s - m->buf;
+					return s - p;
+				} else if (!strchr(esc, c)) {
+					*s++ = c;
+				} else if (s + 4 > p) {
+					break;
+				} else {
+					*s++ = '\\';
+					*s++ = '0' + ((c & 0300) >> 6);
+					*s++ = '0' + ((c & 070) >> 3);
+					*s++ = '0' + (c & 07);
+				}
+			}
+		}
+	}
+	m->count = m->size;
+	return -1;
+}
+
+static void *single_start(struct seq_file *p, loff_t *pos)
+{
+	return NULL + (*pos == 0);
+}
+
+static void *single_next(struct seq_file *p, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+
+static void single_stop(struct seq_file *p, void *v)
+{
+}
+
+int single_open(struct file *file, int (*show)(struct seq_file *, void*), void *data)
+{
+	struct seq_operations *op = kmalloc(sizeof(*op), GFP_KERNEL);
+	int res = -ENOMEM;
+
+	if (op) {
+		op->start = single_start;
+		op->next = single_next;
+		op->stop = single_stop;
+		op->show = show;
+		res = seq_open(file, op);
+		if (!res)
+			((struct seq_file *)file->private_data)->private = data;
+		else
+			kfree(op);
+	}
+	return res;
+}
+
+int single_release(struct inode *inode, struct file *file)
+{
+	struct seq_operations *op = ((struct seq_file *)file->private_data)->op;
+	int res = seq_release(inode, file);
+	kfree(op);
+	return res;
+}
+
+int seq_release_private(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+
+	kfree(seq->private);
+	seq->private = NULL;
+	return seq_release(inode, file);
+}
+

