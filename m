Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWADT21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWADT21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWADT21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:28:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751263AbWADT20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:28:26 -0500
Date: Wed, 4 Jan 2006 11:28:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Ulrich Drepper <drepper@redhat.com>, Andi Kleen <ak@suse.de>,
       "Viro, Al" <viro@ftp.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Limit sendfile() to 2^31-PAGE_CACHE_SIZE bytes without
 error
In-Reply-To: <43BC1AB8.3050801@zytor.com>
Message-ID: <Pine.LNX.4.64.0601041115410.3668@g5.osdl.org>
References: <43BB348F.3070108@zytor.com> <200601040451.20411.ak@suse.de>
 <Pine.LNX.4.64.0601032051300.3668@g5.osdl.org> <43BB5646.2040504@zytor.com>
 <43BB5E22.2010306@zytor.com> <Pine.LNX.4.64.0601040900311.3668@g5.osdl.org>
 <Pine.LNX.4.64.0601041033040.3668@g5.osdl.org> <43BC1AB8.3050801@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Jan 2006, H. Peter Anvin wrote:
> 
> So, what system calls are affected?  sendfile, [p]read[v], [p]write[v], send*,
> recv*, any others?

Just {read|write}[v] and sendfile. With compat32 functions (although 
those, for obvious reasons, have just 32-bit counts anyway, so they have a 
natural limit from that).

The send*/recv* functions don't end up calling to lots of strange drivers 
(it will go through the network layer), so they don't have the same "limit 
damage from untrusted code" issues.

So here's a suggested patch.

It changes "rw_verify_area()" in a simple way:

 - it continues to return -EINVAL for truly invalid sizes (ie if the 
   "size_t" is negative in "ssize_t")
 - it returns the _truncated_ size for other cases (ie it will now return 
   a non-negative "suggested count" for success)

this means that the "hard limit" of INT_MAX is gone, and it's up to the 
caller to decide how it reacts to a positive value. A caller can choose to 
just ignore it ("I'll use my untruncated count, thank you") or can choose 
to take the truncated value.

In the first case, the only change is that instead of checking the return 
value against zero (any non-zero being error), the caller has to realize 
that positive values aren't error cases. So

	ret = rw_verify_area(...)
	if (ret)
		goto out;

turns into

	ret = rw_verify_area(...)
	if (ret < 0)
		goto out;

and in the second case, the caller just ends up adding a "count = ret" 
afterwards.

The rw_verify_area() function isn't exported to modules, and is used in 
only a few places, so this all seems pretty straightforward.

Untested, but mostly sane-looking patch appended. I do want to do 
something about the "readv|writev()" case, though, so it's not complete (I 
don't want to have readv/writev pass insane huge values down the stack to 
untrustworthy drivers..)

Comments? Can somebody test this with the apache thing that caused this 
to surface?

(And I'd like to stress that this really is untested. I've not even 
compile-tested it, so while it all looks very straightforward, typos and 
thinkos can abound)

		Linus

---
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 330cf84..60353f5 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -420,7 +420,7 @@ asmlinkage ssize_t sys32_pread(unsigned 
 		goto out;
 	pos = merge_64(a4, a5);
 	ret = rw_verify_area(READ, file, &pos, count);
-	if (ret)
+	if (ret < 0)
 		goto out;
 	ret = -EINVAL;
 	if (!file->f_op || !(read = file->f_op->read))
@@ -455,7 +455,7 @@ asmlinkage ssize_t sys32_pwrite(unsigned
 		goto out;
 	pos = merge_64(a4, a5);
 	ret = rw_verify_area(WRITE, file, &pos, count);
-	if (ret)
+	if (ret < 0)
 		goto out;
 	ret = -EINVAL;
 	if (!file->f_op || !(write = file->f_op->write))
diff --git a/fs/compat.c b/fs/compat.c
index 8186341..55ac032 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -1170,7 +1170,7 @@ static ssize_t compat_do_readv_writev(in
 	}
 
 	ret = rw_verify_area(type, file, pos, tot_len);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	fnv = NULL;
diff --git a/fs/read_write.c b/fs/read_write.c
index a091ee4..df3468a 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -14,6 +14,7 @@
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/pagemap.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -182,22 +183,33 @@ bad:
 }
 #endif
 
+/*
+ * rw_verify_area doesn't like huge counts. We limit
+ * them to something that fits in "int" so that others
+ * won't have to do range checks all the time.
+ */
+#define MAX_RW_COUNT (INT_MAX & PAGE_CACHE_MASK)
 
 int rw_verify_area(int read_write, struct file *file, loff_t *ppos, size_t count)
 {
 	struct inode *inode;
 	loff_t pos;
 
-	if (unlikely(count > INT_MAX))
+	if (unlikely((ssize_t) count < 0))
 		goto Einval;
 	pos = *ppos;
 	if (unlikely((pos < 0) || (loff_t) (pos + count) < 0))
 		goto Einval;
 
 	inode = file->f_dentry->d_inode;
-	if (inode->i_flock && MANDATORY_LOCK(inode))
-		return locks_mandatory_area(read_write == READ ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE, inode, file, pos, count);
-	return 0;
+	if (inode->i_flock && MANDATORY_LOCK(inode)) {
+		int retval = locks_mandatory_area(
+			read_write == READ ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE,
+			inode, file, pos, count);
+		if (retval < 0)
+			return retval;
+	}
+	return count > MAX_RW_COUNT ? MAX_RW_COUNT : count;
 
 Einval:
 	return -EINVAL;
@@ -244,7 +256,8 @@ ssize_t vfs_read(struct file *file, char
 		return -EFAULT;
 
 	ret = rw_verify_area(READ, file, pos, count);
-	if (!ret) {
+	if (ret >= 0) {
+		count = ret;
 		ret = security_file_permission (file, MAY_READ);
 		if (!ret) {
 			if (file->f_op->read)
@@ -295,7 +308,8 @@ ssize_t vfs_write(struct file *file, con
 		return -EFAULT;
 
 	ret = rw_verify_area(WRITE, file, pos, count);
-	if (!ret) {
+	if (ret >= 0) {
+		count = ret;
 		ret = security_file_permission (file, MAY_WRITE);
 		if (!ret) {
 			if (file->f_op->write)
@@ -497,7 +511,7 @@ static ssize_t do_readv_writev(int type,
 	}
 
 	ret = rw_verify_area(type, file, pos, tot_len);
-	if (ret)
+	if (ret < 0)
 		goto out;
 	ret = security_file_permission(file, type == READ ? MAY_READ : MAY_WRITE);
 	if (ret)
@@ -653,8 +667,9 @@ static ssize_t do_sendfile(int out_fd, i
 		if (!(in_file->f_mode & FMODE_PREAD))
 			goto fput_in;
 	retval = rw_verify_area(READ, in_file, ppos, count);
-	if (retval)
+	if (retval < 0)
 		goto fput_in;
+	count = retval;
 
 	retval = security_file_permission (in_file, MAY_READ);
 	if (retval)
@@ -674,8 +689,9 @@ static ssize_t do_sendfile(int out_fd, i
 		goto fput_out;
 	out_inode = out_file->f_dentry->d_inode;
 	retval = rw_verify_area(WRITE, out_file, &out_file->f_pos, count);
-	if (retval)
+	if (retval < 0)
 		goto fput_out;
+	count = retval;
 
 	retval = security_file_permission (out_file, MAY_WRITE);
 	if (retval)
