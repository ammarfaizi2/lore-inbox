Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267835AbTAMFCH>; Mon, 13 Jan 2003 00:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267838AbTAMFCH>; Mon, 13 Jan 2003 00:02:07 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:221 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267835AbTAMFCF>;
	Mon, 13 Jan 2003 00:02:05 -0500
Date: Mon, 13 Jan 2003 16:09:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: [PATCH][COMPAT] compat_sys_[f]statfs - generic part
Message-Id: <20030113160923.603d4f72.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch creates compat_sys_statfs and compat_sys_fstatfs. This is just
the generic part of the patch. Following are the arch specific parts.  The
diffstat for the whole patch looks like this:

 arch/ia64/ia32/ia32_entry.S       |    4 +-
 arch/ia64/ia32/sys_ia32.c         |   55 ------------------------------
 arch/mips64/kernel/linux32.c      |   66 ------------------------------------
 arch/mips64/kernel/scall_o32.S    |    4 +-
 arch/parisc/kernel/sys_parisc32.c |   68 --------------------------------------
 arch/ppc64/kernel/misc.S          |    4 +-
 arch/ppc64/kernel/sys_ppc32.c     |   59 --------------------------------
 arch/s390x/kernel/entry.S         |    4 +-
 arch/s390x/kernel/linux32.c       |   55 ------------------------------
 arch/s390x/kernel/linux32.h       |   13 -------
 arch/s390x/kernel/wrapper32.S     |   16 ++++----
 arch/sparc64/kernel/sys_sparc32.c |   55 ------------------------------
 arch/sparc64/kernel/systbls.S     |    4 +-
 arch/x86_64/ia32/ia32entry.S      |    4 +-
 arch/x86_64/ia32/sys_ia32.c       |   52 -----------------------------
 fs/compat.c                       |   57 +++++++++++++++++++++++++++++++
 include/asm-ia64/compat.h         |   23 ++++++++++--
 include/asm-ia64/ia32.h           |   13 -------
 include/asm-mips64/compat.h       |   14 +++++++
 include/asm-parisc/compat.h       |   13 +++++++
 include/asm-ppc64/compat.h        |   13 +++++++
 include/asm-ppc64/ppc32.h         |   13 -------
 include/asm-s390x/compat.h        |   13 +++++++
 include/asm-sparc64/compat.h      |   13 +++++++
 include/asm-sparc64/statfs.h      |   14 -------
 include/asm-x86_64/compat.h       |   13 +++++++
 include/asm-x86_64/ia32.h         |   13 -------
 27 files changed, 174 insertions(+), 501 deletions(-)

I was wondering if put_compat_statfs would not be better if it declared a
struct compat_statfs and then zeroed it and then copied each of the
elements and then used copy_to_user on the whole structure. This would
have two effects: it may be faster in the copy to user mode and we would
no longer need to understand the internals of compat_fsid_t.  What do you
think?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.56-32bit.3/fs/compat.c 2.5.56-32bit.4/fs/compat.c
--- 2.5.56-32bit.3/fs/compat.c	2003-01-13 15:39:42.000000000 +1100
+++ 2.5.56-32bit.4/fs/compat.c	2003-01-13 15:58:34.000000000 +1100
@@ -17,6 +17,8 @@
 #include <linux/time.h>
 #include <linux/fs.h>
 #include <linux/fcntl.h>
+#include <linux/namei.h>
+#include <linux/file.h>
 
 #include <asm/uaccess.h>
 
@@ -101,3 +103,58 @@
 	err |= __put_user(kfl->l_pid, &ufl->l_pid);
 	return err;
 }
+
+static int put_compat_statfs(struct compat_statfs *ubuf, struct statfs *kbuf)
+{
+	if (verify_area(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
+	    __put_user(kbuf->f_type, &ubuf->f_type) ||
+	    __put_user(kbuf->f_bsize, &ubuf->f_bsize) ||
+	    __put_user(kbuf->f_blocks, &ubuf->f_blocks) ||
+	    __put_user(kbuf->f_bfree, &ubuf->f_bfree) ||
+	    __put_user(kbuf->f_bavail, &ubuf->f_bavail) ||
+	    __put_user(kbuf->f_files, &ubuf->f_files) ||
+	    __put_user(kbuf->f_ffree, &ubuf->f_ffree) ||
+	    __put_user(kbuf->f_namelen, &ubuf->f_namelen) ||
+	    __put_user(kbuf->f_fsid.val[0], &ubuf->f_fsid.val[0]) ||
+	    __put_user(kbuf->f_fsid.val[1], &ubuf->f_fsid.val[1]))
+		return -EFAULT;
+	return 0;
+}
+
+/*
+ * The following statfs calls are copies of code from fs/open.c and
+ * should be checked against those from time to time
+ */
+asmlinkage long compat_sys_statfs(const char *path, struct compat_statfs *buf)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk(path, &nd);
+	if (!error) {
+		struct statfs tmp;
+		error = vfs_statfs(nd.dentry->d_inode->i_sb, &tmp);
+		if (!error && put_compat_statfs(buf, &tmp))
+			error = -EFAULT;
+		path_release(&nd);
+	}
+	return error;
+}
+
+asmlinkage long compat_sys_fstatfs(unsigned int fd, struct compat_statfs *buf)
+{
+	struct file * file;
+	struct statfs tmp;
+	int error;
+
+	error = -EBADF;
+	file = fget(fd);
+	if (!file)
+		goto out;
+	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &tmp);
+	if (!error && put_compat_statfs(buf, &tmp))
+		error = -EFAULT;
+	fput(file);
+out:
+	return error;
+}
