Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWDZG2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWDZG2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 02:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWDZG2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 02:28:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14829 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750810AbWDZG2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 02:28:11 -0400
Date: Wed, 26 Apr 2006 07:28:09 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: ralf@linux-mips.org
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix mips sys32_p{read,write}
Message-ID: <20060426062809.GI27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switched to use of sys_pread64()/sys_pwrite64() rather than keep duplicating
their guts; among the little things that had been missing there were such as
	ret = security_file_permission (file, MAY_READ);
Gotta love the LSM robustness, right?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/mips/kernel/linux32.c |   64 +-------------------------------------------
 1 files changed, 2 insertions(+), 62 deletions(-)

ed1914b47f964ab580f7e837df011c4a0f197ab6
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 7c953bc..a7d2bb3 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -356,73 +356,13 @@ asmlinkage int sys32_llseek(unsigned int
 asmlinkage ssize_t sys32_pread(unsigned int fd, char __user * buf,
 			       size_t count, u32 unused, u64 a4, u64 a5)
 {
-	ssize_t ret;
-	struct file * file;
-	ssize_t (*read)(struct file *, char __user *, size_t, loff_t *);
-	loff_t pos;
-
-	ret = -EBADF;
-	file = fget(fd);
-	if (!file)
-		goto bad_file;
-	if (!(file->f_mode & FMODE_READ))
-		goto out;
-	pos = merge_64(a4, a5);
-	ret = rw_verify_area(READ, file, &pos, count);
-	if (ret < 0)
-		goto out;
-	ret = -EINVAL;
-	if (!file->f_op || !(read = file->f_op->read))
-		goto out;
-	if (pos < 0)
-		goto out;
-	ret = -ESPIPE;
-	if (!(file->f_mode & FMODE_PREAD))
-		goto out;
-	ret = read(file, buf, count, &pos);
-	if (ret > 0)
-		dnotify_parent(file->f_dentry, DN_ACCESS);
-out:
-	fput(file);
-bad_file:
-	return ret;
+	return sys_pread64(fd, buf, count, merge_64(a4, a5));
 }
 
 asmlinkage ssize_t sys32_pwrite(unsigned int fd, const char __user * buf,
 			        size_t count, u32 unused, u64 a4, u64 a5)
 {
-	ssize_t ret;
-	struct file * file;
-	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *);
-	loff_t pos;
-
-	ret = -EBADF;
-	file = fget(fd);
-	if (!file)
-		goto bad_file;
-	if (!(file->f_mode & FMODE_WRITE))
-		goto out;
-	pos = merge_64(a4, a5);
-	ret = rw_verify_area(WRITE, file, &pos, count);
-	if (ret < 0)
-		goto out;
-	ret = -EINVAL;
-	if (!file->f_op || !(write = file->f_op->write))
-		goto out;
-	if (pos < 0)
-		goto out;
-
-	ret = -ESPIPE;
-	if (!(file->f_mode & FMODE_PWRITE))
-		goto out;
-
-	ret = write(file, buf, count, &pos);
-	if (ret > 0)
-		dnotify_parent(file->f_dentry, DN_MODIFY);
-out:
-	fput(file);
-bad_file:
-	return ret;
+	return sys_pwrite64(fd, buf, count, merge_64(a4, a5));
 }
 
 asmlinkage int sys32_sched_rr_get_interval(compat_pid_t pid,
-- 
1.3.0.g0080f

