Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbTDQWHO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 18:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbTDQWHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 18:07:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5293 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262637AbTDQWHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 18:07:11 -0400
Date: Thu, 17 Apr 2003 15:18:27 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: marcelo@conectiva.com.br
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] update seq_file to support single_open()
Message-Id: <20030417151827.159bd9bc.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo,

This patch updates the seq_file interface in 2.4.21-pre to be the same
as what's included in 2.5.67-bk7.  That is, it addes single_open() and
single_release() methods for simpler seq file output.

It also corrects a few typos (straight from 2.5.67-bk7).

Please apply.

Thanks,
--
~Randy


--- linux-2420/include/linux/seq_file.h	2002-08-03 00:39:45.000000000 +0000
+++ linux-2421-pre7/include/linux/seq_file.h	2003-04-07 17:33:02.000000000 +0000
@@ -2,7 +2,13 @@
 #define _LINUX_SEQ_FILE_H
 #ifdef __KERNEL__
 
+#include <linux/types.h>
+#include <linux/string.h>
+#include <asm/semaphore.h>
+
 struct seq_operations;
+struct file;
+struct inode;
 
 struct seq_file {
 	char *buf;
@@ -52,5 +58,7 @@ static inline int seq_puts(struct seq_fi
 int seq_printf(struct seq_file *, const char *, ...)
 	__attribute__ ((format (printf,2,3)));
 
+int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
+int single_release(struct inode *, struct file *);
 #endif
 #endif
--- linux-2420/fs/seq_file.c	2003-04-16 21:34:08.000000000 +0000
+++ linux-2421-pre7/fs/seq_file.c	2003-04-16 21:32:47.000000000 +0000
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
@@ -42,7 +43,7 @@ int seq_open(struct file *file, struct s
  *
  *	Ready-made ->f_op->read()
  */
-ssize_t seq_read(struct file *file, char *buf, size_t size, loff_t *ppos)
+ssize_t seq_read(struct file *file, char *buf, size_t size, loff_t *ppos)
 {
 	struct seq_file *m = (struct seq_file *)file->private_data;
 	size_t copied = 0;
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
@@ -295,3 +296,45 @@ int seq_printf(struct seq_file *m, const
 	m->count = m->size;
 	return -1;
 }
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
--- linux-2420/kernel/ksyms.c%SEQ	Thu Apr 17 10:42:17 2003
+++ linux-2421-pre7/kernel/ksyms.c	Thu Apr 17 14:49:54 2003
@@ -506,6 +506,8 @@ EXPORT_SYMBOL(seq_open);
 EXPORT_SYMBOL(seq_release);
 EXPORT_SYMBOL(seq_read);
 EXPORT_SYMBOL(seq_lseek);
+EXPORT_SYMBOL(single_open);
+EXPORT_SYMBOL(single_release);
 
 /* Program loader interfaces */
 EXPORT_SYMBOL(setup_arg_pages);
