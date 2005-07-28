Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVG1Nr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVG1Nr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVG1Npf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:45:35 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:49617 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261441AbVG1Nnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:43:50 -0400
Date: Thu, 28 Jul 2005 23:43:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] compat_sys_read/write
Message-Id: <20050728234341.3303d5fe.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Someone mentioned the mess in evdev.c that is caused by the fact that the
structures that are passed to/from user mode via read/write require
conversion when this API is used from 32 bit tasks on 64 bit kernels. 
Some "discussion" followed during which I suggested an idea originally
from Matthew Wilcox of an arch-specific is_compat_task() function so that
these places could be identified.  However it was considered better to
instead implement compat_sys_read/write.

This patch implements those and uses them to clean up evdev.c somewhat.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---
 arch/ia64/ia32/ia32_entry.S        |    4 -
 arch/mips/kernel/scall64-n32.S     |    4 -
 arch/mips/kernel/scall64-o32.S     |    4 -
 arch/parisc/kernel/syscall_table.S |    4 -
 arch/ppc64/kernel/misc.S           |    4 -
 arch/s390/kernel/compat_linux.c    |   16 -------
 arch/s390/kernel/compat_wrapper.S  |   12 ++---
 arch/s390/kernel/syscalls.S        |    4 -
 arch/sparc64/kernel/systbls.S      |    2
 arch/x86_64/ia32/ia32entry.S       |    4 -
 drivers/input/evdev.c              |   54 +++++--------------------
 fs/compat.c                        |   12 +++++
 fs/read_write.c                    |   77 +++++++++++++++++++++++++++++-------- include/linux/fs.h                 |    6 ++
 14 files changed, 112 insertions(+), 95 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus/arch/ia64/ia32/ia32_entry.S linus-compat_write.5/arch/ia64/ia32/ia32_entry.S
--- linus/arch/ia64/ia32/ia32_entry.S	2005-06-27 16:07:59.000000000 +1000
+++ linus-compat_write.5/arch/ia64/ia32/ia32_entry.S	2005-07-01 13:58:03.000000000 +1000
@@ -213,8 +213,8 @@
 	data8 sys_ni_syscall	  /* 0	-  old "setup(" system call*/
 	data8 sys_exit
 	data8 sys32_fork
-	data8 sys_read
-	data8 sys_write
+	data8 compat_sys_read
+	data8 compat_sys_write
 	data8 sys32_open	  /* 5 */
 	data8 sys_close
 	data8 sys32_waitpid
diff -ruN linus/arch/mips/kernel/scall64-n32.S linus-compat_write.5/arch/mips/kernel/scall64-n32.S
--- linus/arch/mips/kernel/scall64-n32.S	2005-06-27 16:08:00.000000000 +1000
+++ linus-compat_write.5/arch/mips/kernel/scall64-n32.S	2005-07-01 13:59:26.000000000 +1000
@@ -117,8 +117,8 @@
 	END(handle_sysn32)
 
 EXPORT(sysn32_call_table)
-	PTR	sys_read			/* 6000 */
-	PTR	sys_write
+	PTR	compat_sys_read			/* 6000 */
+	PTR	compat_sys_write
 	PTR	sys_open
 	PTR	sys_close
 	PTR	sys_newstat
diff -ruN linus/arch/mips/kernel/scall64-o32.S linus-compat_write.5/arch/mips/kernel/scall64-o32.S
--- linus/arch/mips/kernel/scall64-o32.S	2005-06-27 16:08:00.000000000 +1000
+++ linus-compat_write.5/arch/mips/kernel/scall64-o32.S	2005-07-01 13:59:40.000000000 +1000
@@ -205,8 +205,8 @@
 	PTR	sys32_syscall			/* 4000 */
 	PTR	sys_exit
 	PTR	sys_fork
-	PTR	sys_read
-	PTR	sys_write
+	PTR	compat_sys_read
+	PTR	compat_sys_write
 	PTR	sys_open			/* 4005 */
 	PTR	sys_close
 	PTR	sys_waitpid
diff -ruN linus/arch/parisc/kernel/syscall_table.S linus-compat_write.5/arch/parisc/kernel/syscall_table.S
--- linus/arch/parisc/kernel/syscall_table.S	2005-06-27 16:08:00.000000000 +1000
+++ linus-compat_write.5/arch/parisc/kernel/syscall_table.S	2005-07-01 14:01:50.000000000 +1000
@@ -63,8 +63,8 @@
 	ENTRY_SAME(restart_syscall)	/* 0 */
 	ENTRY_SAME(exit)
 	ENTRY_SAME(fork_wrapper)
-	ENTRY_SAME(read)
-	ENTRY_SAME(write)
+	ENTRY_COMP(read)
+	ENTRY_COMP(write)
 	ENTRY_SAME(open)		/* 5 */
 	ENTRY_SAME(close)
 	ENTRY_SAME(waitpid)
diff -ruN linus/arch/ppc64/kernel/misc.S linus-compat_write.5/arch/ppc64/kernel/misc.S
--- linus/arch/ppc64/kernel/misc.S	2005-07-08 15:18:27.000000000 +1000
+++ linus-compat_write.5/arch/ppc64/kernel/misc.S	2005-07-08 15:25:17.000000000 +1000
@@ -857,8 +857,8 @@
 	.llong .sys_restart_syscall	/* 0 */
 	.llong .sys_exit
 	.llong .ppc_fork
-	.llong .sys_read
-	.llong .sys_write
+	.llong .compat_sys_read
+	.llong .compat_sys_write
 	.llong .sys32_open		/* 5 */
 	.llong .sys_close
 	.llong .sys32_waitpid
diff -ruN linus/arch/s390/kernel/compat_linux.c linus-compat_write.5/arch/s390/kernel/compat_linux.c
--- linus/arch/s390/kernel/compat_linux.c	2005-07-15 14:37:43.000000000 +1000
+++ linus-compat_write.5/arch/s390/kernel/compat_linux.c	2005-07-18 14:41:35.000000000 +1000
@@ -981,22 +981,6 @@
 	return error;
 }
 
-asmlinkage long sys32_read(unsigned int fd, char * buf, size_t count)
-{
-	if ((compat_ssize_t) count < 0)
-		return -EINVAL; 
-
-	return sys_read(fd, buf, count);
-}
-
-asmlinkage long sys32_write(unsigned int fd, char * buf, size_t count)
-{
-	if ((compat_ssize_t) count < 0)
-		return -EINVAL; 
-
-	return sys_write(fd, buf, count);
-}
-
 asmlinkage long sys32_clone(struct pt_regs regs)
 {
         unsigned long clone_flags;
diff -ruN linus/arch/s390/kernel/compat_wrapper.S linus-compat_write.5/arch/s390/kernel/compat_wrapper.S
--- linus/arch/s390/kernel/compat_wrapper.S	2005-07-15 14:37:43.000000000 +1000
+++ linus-compat_write.5/arch/s390/kernel/compat_wrapper.S	2005-07-18 14:41:54.000000000 +1000
@@ -13,19 +13,19 @@
 	lgfr	%r2,%r2			# int
 	jg	sys_exit		# branch to sys_exit
     
-	.globl  sys32_read_wrapper 
-sys32_read_wrapper:
+	.globl  compat_read_wrapper
+compat_sys_read_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# char *
 	llgfr	%r4,%r4			# size_t
-	jg	sys32_read		# branch to sys_read
+	jg	compat_sys_read		# branch to sys_read
 
-	.globl  sys32_write_wrapper 
-sys32_write_wrapper:
+	.globl  compat_write_wrapper
+compat_sys_write_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# const char *
 	llgfr	%r4,%r4			# size_t
-	jg	sys32_write		# branch to system call
+	jg	compat_sys_write	# branch to system call
 
 	.globl  sys32_open_wrapper 
 sys32_open_wrapper:
diff -ruN linus/arch/s390/kernel/syscalls.S linus-compat_write.5/arch/s390/kernel/syscalls.S
--- linus/arch/s390/kernel/syscalls.S	2005-06-27 16:08:00.000000000 +1000
+++ linus-compat_write.5/arch/s390/kernel/syscalls.S	2005-07-01 14:10:05.000000000 +1000
@@ -11,8 +11,8 @@
 NI_SYSCALL							/* 0 */
 SYSCALL(sys_exit,sys_exit,sys32_exit_wrapper)
 SYSCALL(sys_fork_glue,sys_fork_glue,sys_fork_glue)
-SYSCALL(sys_read,sys_read,sys32_read_wrapper)
-SYSCALL(sys_write,sys_write,sys32_write_wrapper)
+SYSCALL(sys_read,sys_read,compat_sys_read_wrapper)
+SYSCALL(sys_write,sys_write,compat_sys_write_wrapper)
 SYSCALL(sys_open,sys_open,sys32_open_wrapper)			/* 5 */
 SYSCALL(sys_close,sys_close,sys32_close_wrapper)
 SYSCALL(sys_restart_syscall,sys_restart_syscall,sys_restart_syscall)
diff -ruN linus/arch/sparc64/kernel/systbls.S linus-compat_write.5/arch/sparc64/kernel/systbls.S
--- linus/arch/sparc64/kernel/systbls.S	2005-07-12 10:39:02.000000000 +1000
+++ linus-compat_write.5/arch/sparc64/kernel/systbls.S	2005-07-12 11:28:11.000000000 +1000
@@ -20,7 +20,7 @@
 
 	.globl sys_call_table32
 sys_call_table32:
-/*0*/	.word sys_restart_syscall, sys32_exit, sys_fork, sys_read, sys_write
+/*0*/	.word sys_restart_syscall, sys32_exit, sys_fork, compat_sys_read, compat_sys_write
 /*5*/	.word sys32_open, sys_close, sys32_wait4, sys32_creat, sys_link
 /*10*/  .word sys_unlink, sunos_execv, sys_chdir, sys32_chown16, sys32_mknod
 /*15*/	.word sys_chmod, sys32_lchown16, sparc_brk, sys32_perfctr, sys32_lseek
diff -ruN linus/arch/x86_64/ia32/ia32entry.S linus-compat_write.5/arch/x86_64/ia32/ia32entry.S
--- linus/arch/x86_64/ia32/ia32entry.S	2005-06-27 16:08:00.000000000 +1000
+++ linus-compat_write.5/arch/x86_64/ia32/ia32entry.S	2005-07-01 14:12:50.000000000 +1000
@@ -305,8 +305,8 @@
 	.quad sys_restart_syscall
 	.quad sys_exit
 	.quad stub32_fork
-	.quad sys_read
-	.quad sys_write
+	.quad compat_sys_read
+	.quad compat_sys_write
 	.quad sys32_open		/* 5 */
 	.quad sys_close
 	.quad sys32_waitpid
diff -ruN linus/drivers/input/evdev.c linus-compat_write.5/drivers/input/evdev.c
--- linus/drivers/input/evdev.c	2005-06-28 10:05:26.000000000 +1000
+++ linus-compat_write.5/drivers/input/evdev.c	2005-07-01 00:51:37.000000000 +1000
@@ -154,16 +154,6 @@
 	__s32 value;
 };
 
-#ifdef CONFIG_X86_64
-#  define COMPAT_TEST test_thread_flag(TIF_IA32)
-#elif defined(CONFIG_IA64)
-#  define COMPAT_TEST IS_IA32_PROCESS(ia64_task_regs(current))
-#elif defined(CONFIG_ARCH_S390)
-#  define COMPAT_TEST test_thread_flag(TIF_31BIT)
-#else
-#  define COMPAT_TEST test_thread_flag(TIF_32BIT)
-#endif
-
 static ssize_t evdev_write_compat(struct file * file, const char __user * buffer, size_t count, loff_t *ppos)
 {
 	struct evdev_list *list = file->private_data;
@@ -179,6 +169,8 @@
 
 	return retval;
 }
+#else
+#define evdev_write_compat	NULL
 #endif
 
 static ssize_t evdev_write(struct file * file, const char __user * buffer, size_t count, loff_t *ppos)
@@ -189,11 +181,6 @@
 
 	if (!list->evdev->exist) return -ENODEV;
 
-#ifdef CONFIG_COMPAT
-	if (COMPAT_TEST)
-		return evdev_write_compat(file, buffer, count, ppos);
-#endif
-
 	while (retval < count) {
 
 		if (copy_from_user(&event, buffer + retval, sizeof(struct input_event)))
@@ -243,6 +230,8 @@
 
 	return retval;
 }
+#else
+#define evdev_read_compat	NULL
 #endif
 
 static ssize_t evdev_read(struct file * file, char __user * buffer, size_t count, loff_t *ppos)
@@ -250,11 +239,6 @@
 	struct evdev_list *list = file->private_data;
 	int retval;
 
-#ifdef CONFIG_COMPAT
-	if (COMPAT_TEST)
-		return evdev_read_compat(file, buffer, count, ppos);
-#endif
-
 	if (count < sizeof(struct input_event))
 		return -EINVAL;
 
@@ -484,34 +468,18 @@
 
 #ifdef CONFIG_COMPAT
 
-#define BITS_PER_LONG_COMPAT (sizeof(compat_long_t) * 8)
-#define NBITS_COMPAT(x) ((((x)-1)/BITS_PER_LONG_COMPAT)+1)
-#define OFF_COMPAT(x)  ((x)%BITS_PER_LONG_COMPAT)
+#define NBITS_COMPAT(x) ((((x)-1)/BITS_PER_COMPAT_LONG)+1)
+#define OFF_COMPAT(x)  ((x)%BITS_PER_COMPAT_LONG)
 #define BIT_COMPAT(x)  (1UL<<OFF_COMPAT(x))
-#define LONG_COMPAT(x) ((x)/BITS_PER_LONG_COMPAT)
+#define LONG_COMPAT(x) ((x)/BITS_PER_COMPAT_LONG)
 #define test_bit_compat(bit, array) ((array[LONG_COMPAT(bit)] >> OFF_COMPAT(bit)) & 1)
 
-#ifdef __BIG_ENDIAN
 #define bit_to_user(bit, max) \
 do { \
-	int i; \
 	int len = NBITS_COMPAT((max)) * sizeof(compat_long_t); \
 	if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd); \
-	for (i = 0; i < len / sizeof(compat_long_t); i++) \
-		if (copy_to_user((compat_long_t*) p + i, \
-				 (compat_long_t*) (bit) + i + 1 - ((i % 2) << 1), \
-				 sizeof(compat_long_t))) \
-			return -EFAULT; \
-	return len; \
+	return compat_put_bitmap(p, (bit), len * 8) ? -EFAULT : len; \
 } while (0)
-#else
-#define bit_to_user(bit, max) \
-do { \
-	int len = NBITS_COMPAT((max)) * sizeof(compat_long_t); \
-	if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd); \
-	return copy_to_user(p, (bit), len) ? -EFAULT : len; \
-} while (0)
-#endif
 
 static long evdev_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -631,19 +599,21 @@
 	}
 	return -EINVAL;
 }
+#else
+#define evdev_ioctl_compat	NULL
 #endif
 
 static struct file_operations evdev_fops = {
 	.owner =	THIS_MODULE,
 	.read =		evdev_read,
+	.compat_read =	evdev_read_compat,
 	.write =	evdev_write,
+	.compat_write =	evdev_write_compat,
 	.poll =		evdev_poll,
 	.open =		evdev_open,
 	.release =	evdev_release,
 	.unlocked_ioctl = evdev_ioctl,
-#ifdef CONFIG_COMPAT
 	.compat_ioctl =	evdev_ioctl_compat,
-#endif
 	.fasync =	evdev_fasync,
 	.flush =	evdev_flush
 };
diff -ruN linus/fs/compat.c linus-compat_write.5/fs/compat.c
--- linus/fs/compat.c	2005-07-13 15:13:18.000000000 +1000
+++ linus-compat_write.5/fs/compat.c	2005-07-13 16:35:28.000000000 +1000
@@ -51,6 +51,18 @@
 #include <asm/mmu_context.h>
 #include <asm/ioctls.h>
 
+asmlinkage ssize_t compat_sys_read(unsigned int fd, char __user * buf,
+		compat_size_t count)
+{
+	return do_sys_read(fd, buf, count, 1);
+}
+
+asmlinkage ssize_t compat_sys_write(unsigned int fd, const char __user * buf,
+		compat_size_t count)
+{
+	return do_sys_write(fd, buf, count, 1);
+}
+
 /*
  * Not all architectures have sys_utime, so implement this in terms
  * of sys_utimes.
diff -ruN linus/fs/read_write.c linus-compat_write.5/fs/read_write.c
--- linus/fs/read_write.c	2005-07-13 15:13:18.000000000 +1000
+++ linus-compat_write.5/fs/read_write.c	2005-07-13 16:36:03.000000000 +1000
@@ -18,6 +18,26 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
+#ifdef CONFIG_COMPAT
+#define vfs_select_rw(file, func, compat)				\
+		(((file)->f_op == NULL) ? NULL				\
+		 : (((compat) && ((file)->f_op->compat_ ## func != NULL)) \
+			? (file)->f_op->compat_ ## func			\
+			: (((file)->f_op->func != NULL)			\
+				? (file)->f_op->func			\
+				: (((file)->f_op->aio_ ## func != NULL)	\
+					? do_sync_ ## func		\
+					: NULL))))
+#else
+#define vfs_select_rw(file, func, compat)				\
+		(((file)->f_op == NULL) ? NULL				\
+			: (((file)->f_op->func != NULL)			\
+				? (file)->f_op->func			\
+				: (((file)->f_op->aio_ ## func != NULL)	\
+					? do_sync_ ## func		\
+					: NULL)))
+#endif	/* CONFIG_COMPAT */
+
 struct file_operations generic_ro_fops = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_file_read,
@@ -232,13 +252,15 @@
 
 EXPORT_SYMBOL(do_sync_read);
 
-ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
+static ssize_t do_vfs_read(struct file *file, char __user *buf, size_t count,
+		loff_t *pos, ssize_t (*read_func)(struct file *, char __user *,
+			size_t, loff_t *))
 {
 	ssize_t ret;
 
 	if (!(file->f_mode & FMODE_READ))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->read && !file->f_op->aio_read))
+	if (!read_func)
 		return -EINVAL;
 	if (unlikely(!access_ok(VERIFY_WRITE, buf, count)))
 		return -EFAULT;
@@ -247,10 +269,7 @@
 	if (!ret) {
 		ret = security_file_permission (file, MAY_READ);
 		if (!ret) {
-			if (file->f_op->read)
-				ret = file->f_op->read(file, buf, count, pos);
-			else
-				ret = do_sync_read(file, buf, count, pos);
+			ret = read_func(file, buf, count, pos);
 			if (ret > 0) {
 				fsnotify_access(file->f_dentry);
 				current->rchar += ret;
@@ -262,6 +281,10 @@
 	return ret;
 }
 
+ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
+{
+	return do_vfs_read(file, buf, count, pos, vfs_select_rw(file, read, 0));
+}
 EXPORT_SYMBOL(vfs_read);
 
 ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos)
@@ -283,13 +306,16 @@
 
 EXPORT_SYMBOL(do_sync_write);
 
-ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
+static ssize_t do_vfs_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *pos,
+		ssize_t (*write_func)(struct file *, const char __user *,
+			size_t, loff_t *))
 {
 	ssize_t ret;
 
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->write && !file->f_op->aio_write))
+	if (!write_func)
 		return -EINVAL;
 	if (unlikely(!access_ok(VERIFY_READ, buf, count)))
 		return -EFAULT;
@@ -298,10 +324,7 @@
 	if (!ret) {
 		ret = security_file_permission (file, MAY_WRITE);
 		if (!ret) {
-			if (file->f_op->write)
-				ret = file->f_op->write(file, buf, count, pos);
-			else
-				ret = do_sync_write(file, buf, count, pos);
+			ret = write_func(file, buf, count, pos);
 			if (ret > 0) {
 				fsnotify_modify(file->f_dentry);
 				current->wchar += ret;
@@ -313,6 +336,13 @@
 	return ret;
 }
 
+ssize_t vfs_write(struct file *file, const char __user *buf, size_t count,
+		loff_t *pos)
+{
+	return do_vfs_write(file, buf, count, pos,
+			vfs_select_rw(file, write, 0));
+}
+
 EXPORT_SYMBOL(vfs_write);
 
 static inline loff_t file_pos_read(struct file *file)
@@ -325,7 +355,8 @@
 	file->f_pos = pos;
 }
 
-asmlinkage ssize_t sys_read(unsigned int fd, char __user * buf, size_t count)
+ssize_t do_sys_read(unsigned int fd, char __user * buf,
+		size_t count, int compat)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
@@ -334,16 +365,23 @@
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
-		ret = vfs_read(file, buf, count, &pos);
+		ret = do_vfs_read(file, buf, count, &pos,
+				vfs_select_rw(file, read, compat));
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
 	}
 
 	return ret;
 }
+
+asmlinkage ssize_t sys_read(unsigned int fd, char __user * buf, size_t count)
+{
+	return do_sys_read(fd, buf, count, 0);
+}
 EXPORT_SYMBOL_GPL(sys_read);
 
-asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf, size_t count)
+ssize_t do_sys_write(unsigned int fd, const char __user * buf, size_t count,
+		int compat)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
@@ -352,7 +390,8 @@
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
-		ret = vfs_write(file, buf, count, &pos);
+		ret = do_vfs_write(file, buf, count, &pos,
+				vfs_select_rw(file, write, compat));
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
 	}
@@ -360,6 +399,12 @@
 	return ret;
 }
 
+asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf,
+		size_t count)
+{
+	return do_sys_write(fd, buf, count, 0);
+}
+
 asmlinkage ssize_t sys_pread64(unsigned int fd, char __user *buf,
 			     size_t count, loff_t pos)
 {
diff -ruN linus/include/linux/fs.h linus-compat_write.5/include/linux/fs.h
--- linus/include/linux/fs.h	2005-07-15 14:37:43.000000000 +1000
+++ linus-compat_write.5/include/linux/fs.h	2005-07-18 14:40:56.000000000 +1000
@@ -954,8 +954,10 @@
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);
+	ssize_t (*compat_read) (struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*aio_write) (struct kiocb *, const char __user *, size_t, loff_t);
+	ssize_t (*compat_write) (struct file *, const char __user *, size_t, loff_t *);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
@@ -1506,6 +1508,10 @@
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
+extern ssize_t do_sys_read(unsigned int fd, char __user * buf,
+		size_t count, int compat);
+extern ssize_t do_sys_write(unsigned int fd, const char __user * buf,
+		size_t count, int compat);
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
