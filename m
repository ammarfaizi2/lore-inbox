Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268713AbTCCS66>; Mon, 3 Mar 2003 13:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268715AbTCCS66>; Mon, 3 Mar 2003 13:58:58 -0500
Received: from verein.lst.de ([212.34.181.86]:25608 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S268713AbTCCS64>;
	Mon, 3 Mar 2003 13:58:56 -0500
Date: Mon, 3 Mar 2003 20:09:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] backport sys_sendfile64
Message-ID: <20030303200919.A18889@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To support sendfile() in LFS applications we need the sendfile64()
syscall that is different from sendfile() only in taking a loff_t offset
parameter instead of off_t.  Obviously they share the actual
implementation so the patch is very small.  sendfile64() is supported
in 2.5 and many vendor kernel for a long time and in -ac for a while
now.


--- 1.17/arch/i386/kernel/entry.S	Sun Feb  9 21:30:42 2003
+++ edited/arch/i386/kernel/entry.S	Mon Mar  3 19:04:16 2003
@@ -643,7 +643,7 @@
 	.long SYMBOL_NAME(sys_lremovexattr)
 	.long SYMBOL_NAME(sys_fremovexattr)
  	.long SYMBOL_NAME(sys_tkill)
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sendfile64 */
+	.long SYMBOL_NAME(sys_sendfile64)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* 240 reserved for futex */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sched_setaffinity */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sched_getaffinity */
--- 1.75/mm/filemap.c	Wed Feb  5 21:53:44 2003
+++ edited/mm/filemap.c	Mon Mar  3 19:04:16 2003
@@ -1743,7 +1743,7 @@
 	return written;
 }
 
-asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count)
+static ssize_t common_sendfile(int out_fd, int in_fd, loff_t *offset, size_t count)
 {
 	ssize_t retval;
 	struct file * in_file, * out_file;
@@ -1788,27 +1788,19 @@
 	retval = 0;
 	if (count) {
 		read_descriptor_t desc;
-		loff_t pos = 0, *ppos;
-
-		retval = -EFAULT;
-		ppos = &in_file->f_pos;
-		if (offset) {
-			if (get_user(pos, offset))
-				goto fput_out;
-			ppos = &pos;
-		}
+		
+		if (!offset)
+			offset = &in_file->f_pos;
 
 		desc.written = 0;
 		desc.count = count;
 		desc.buf = (char *) out_file;
 		desc.error = 0;
-		do_generic_file_read(in_file, ppos, &desc, file_send_actor);
+		do_generic_file_read(in_file, offset, &desc, file_send_actor);
 
 		retval = desc.written;
 		if (!retval)
 			retval = desc.error;
-		if (offset)
-			put_user(pos, offset);
 	}
 
 fput_out:
@@ -1817,6 +1809,38 @@
 	fput(in_file);
 out:
 	return retval;
+}
+
+asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count)
+{
+	loff_t pos, *ppos = NULL;
+	ssize_t ret;
+	if (offset) {
+		off_t off;
+		if (unlikely(get_user(off, offset)))
+			return -EFAULT;
+		pos = off;
+		ppos = &pos;
+	}
+	ret = common_sendfile(out_fd, in_fd, ppos, count);
+	if (offset)
+		put_user((off_t)pos, offset);
+	return ret;
+}
+
+asmlinkage ssize_t sys_sendfile64(int out_fd, int in_fd, loff_t *offset, size_t count)
+{
+	loff_t pos, *ppos = NULL;
+	ssize_t ret;
+	if (offset) {
+		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
+			return -EFAULT;
+		ppos = &pos;
+	}
+	ret = common_sendfile(out_fd, in_fd, ppos, count);
+	if (offset)
+		put_user(pos, offset);
+	return ret;
 }
 
 static ssize_t do_readahead(struct file *file, unsigned long index, unsigned long nr)
