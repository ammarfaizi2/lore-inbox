Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266260AbTGJCvB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 22:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268794AbTGJCvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 22:51:01 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57302 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266260AbTGJCu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 22:50:58 -0400
Date: Thu, 10 Jul 2003 00:02:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>,
       Jeff Muizelaar <kernel@infidigm.net>
Subject: [PATCH] add seq file helpers from 2.5 (fwd)
Message-ID: <Pine.LNX.4.55L.0307100000100.6316@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=------------040204030809000209070309
Content-ID: <Pine.LNX.4.55L.0307100000101.6316@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------040204030809000209070309
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.55L.0307100000102.6316@freak.distro.conectiva>


Viro,

I think you are the right person to review that.

Would you do me the favour?

---------- Forwarded message ----------
Date: Wed, 09 Jul 2003 20:16:54 -0400
From: Jeff Muizelaar <kernel@infidigm.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] add seq file helpers from 2.5

Marcelo,

The attached patch adds the single_* helpers that have been in 2.5 since
May 2002, it also adds some missing includes that are in 2.5.

-Jeff
--------------040204030809000209070309
Content-Type: TEXT/PLAIN; NAME="seq_file-single.diff"
Content-ID: <Pine.LNX.4.55L.0307100000103.6316@freak.distro.conectiva>
Content-Description: 
Content-Disposition: INLINE; FILENAME="seq_file-single.diff"

diff -urN linux-2.4.21-bk1/fs/seq_file.c linux-2.4.21-bk1-seq-file-single/fs/seq_file.c
--- linux-2.4.21-bk1/fs/seq_file.c	2003-06-13 10:51:37.000000000 -0400
+++ linux-2.4.21-bk1-seq-file-single/fs/seq_file.c	2003-07-09 20:06:25.000000000 -0400
@@ -295,3 +295,45 @@
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
diff -urN linux-2.4.21-bk1/include/linux/seq_file.h linux-2.4.21-bk1-seq-file-single/include/linux/seq_file.h
--- linux-2.4.21-bk1/include/linux/seq_file.h	2002-08-02 20:39:45.000000000 -0400
+++ linux-2.4.21-bk1-seq-file-single/include/linux/seq_file.h	2003-07-06 08:57:25.000000000 -0400
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
@@ -52,5 +58,8 @@
 int seq_printf(struct seq_file *, const char *, ...)
 	__attribute__ ((format (printf,2,3)));
 
+
+int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
+int single_release(struct inode *, struct file *);
 #endif
 #endif

--------------040204030809000209070309--
