Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSCCVSf>; Sun, 3 Mar 2002 16:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSCCVS0>; Sun, 3 Mar 2002 16:18:26 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50040 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288800AbSCCVSU>; Sun, 3 Mar 2002 16:18:20 -0500
Date: Sun, 3 Mar 2002 16:18:18 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [bkpatch] add sys_sendfile64
Message-ID: <20020303161818.A18187@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below bitkeeper patch can be pulled from
	bk://bcrlbits.bkbits.net/linux-2.5
and adds a sys_sendfile64 call.  Arch maintainers should 
probably add the entry to their syscall tables if it is 
appropriate.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.466   -> 1.467  
#	arch/i386/kernel/entry.S	1.19    -> 1.20   
#	        mm/filemap.c	1.63    -> 1.64   
#	include/asm-i386/unistd.h	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/03	bcrl@toomuch.toronto.redhat.com	1.467
# Add sendfile64 syscall to generic code and i386.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Sun Mar  3 16:15:55 2002
+++ b/arch/i386/kernel/entry.S	Sun Mar  3 16:15:55 2002
@@ -716,6 +716,7 @@
 	.long SYMBOL_NAME(sys_lremovexattr)
 	.long SYMBOL_NAME(sys_fremovexattr)
 	.long SYMBOL_NAME(sys_tkill)
+	.long SYMBOL_NAME(sys_sendfile64)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -Nru a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
--- a/include/asm-i386/unistd.h	Sun Mar  3 16:15:55 2002
+++ b/include/asm-i386/unistd.h	Sun Mar  3 16:15:55 2002
@@ -243,6 +243,7 @@
 #define __NR_lremovexattr	236
 #define __NR_fremovexattr	237
 #define __NR_tkill		238
+#define __NR_sendfile64		239
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Sun Mar  3 16:15:55 2002
+++ b/mm/filemap.c	Sun Mar  3 16:15:55 2002
@@ -1715,7 +1715,7 @@
 	return written;
 }
 
-asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count)
+static ssize_t common_sendfile(int out_fd, int in_fd, loff_t *offset, size_t count)
 {
 	ssize_t retval;
 	struct file * in_file, * out_file;
@@ -1760,27 +1760,19 @@
 	retval = 0;
 	if (count) {
 		read_descriptor_t desc;
-		loff_t pos = 0, *ppos;
 
-		retval = -EFAULT;
-		ppos = &in_file->f_pos;
-		if (offset) {
-			if (get_user(pos, offset))
-				goto fput_out;
-			ppos = &pos;
-		}
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
@@ -1789,6 +1781,38 @@
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
