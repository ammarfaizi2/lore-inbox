Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVANGOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVANGOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 01:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVANGNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 01:13:48 -0500
Received: from opersys.com ([64.40.108.71]:61712 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261922AbVANGDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 01:03:50 -0500
Message-ID: <41E76288.2080004@opersys.com>
Date: Fri, 14 Jan 2005 01:11:20 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH 4/8 ] ltt for 2.6.10 : fs/ events
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


signed-off-by: Karim Yaghmour (karim@opersys.com)

--- linux-2.6.10-relayfs/fs/buffer.c	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/fs/buffer.c	2005-01-13 22:21:51.000000000 -0500
@@ -39,6 +39,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/bitops.h>
+#include <linux/ltt-events.h>

 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void invalidate_bh_lrus(void);
@@ -87,7 +88,9 @@ void fastcall unlock_buffer(struct buffe
  */
 void __wait_on_buffer(struct buffer_head * bh)
 {
+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_BUF_WAIT_START, 0, 0, NULL);
 	wait_on_bit(&bh->b_state, BH_Lock, sync_buffer, TASK_UNINTERRUPTIBLE);
+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_BUF_WAIT_END, 0, 0, NULL);
 }

 static void
--- linux-2.6.10-relayfs/fs/exec.c	2004-12-24 16:34:31.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/fs/exec.c	2005-01-13 23:37:48.000000000 -0500
@@ -47,6 +47,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
+#include <linux/ltt-events.h>

 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1105,6 +1106,9 @@ int do_execve(char * filename,
 	if (IS_ERR(file))
 		goto out_kfree;

+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_EXEC, 0,
+			file->f_dentry->d_name.len, file->f_dentry->d_name.name);
+
 	sched_exec();

 	bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
--- linux-2.6.10-relayfs/fs/ioctl.c	2004-12-24 16:34:26.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/fs/ioctl.c	2005-01-13 22:35:41.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
+#include <linux/ltt-events.h>
 #include <linux/module.h>

 #include <asm/uaccess.h>
@@ -68,6 +69,8 @@ asmlinkage long sys_ioctl(unsigned int f
                 goto out;
         }

+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_IOCTL, fd, cmd, NULL);
+
 	lock_kernel();
 	switch (cmd) {
 		case FIOCLEX:
--- linux-2.6.10-relayfs/fs/open.c	2004-12-24 16:33:50.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/fs/open.c	2005-01-13 23:38:31.000000000 -0500
@@ -19,6 +19,8 @@
 #include <linux/security.h>
 #include <linux/mount.h>
 #include <linux/vfs.h>
+#include <linux/ltt-events.h>
+
 #include <asm/uaccess.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
@@ -956,6 +958,8 @@ asmlinkage long sys_open(const char __us
 			error = PTR_ERR(f);
 			if (IS_ERR(f))
 				goto out_error;
+			ltt_ev_file_system(LTT_EV_FILE_SYSTEM_OPEN, fd,
+					f->f_dentry->d_name.len, f->f_dentry->d_name.name);
 			fd_install(fd, f);
 		}
 out:
@@ -1031,6 +1035,7 @@ asmlinkage long sys_close(unsigned int f
 	filp = files->fd[fd];
 	if (!filp)
 		goto out_unlock;
+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_CLOSE, fd, 0, NULL);
 	files->fd[fd] = NULL;
 	FD_CLR(fd, files->close_on_exec);
 	__put_unused_fd(files, fd);
--- linux-2.6.10-relayfs/fs/read_write.c	2004-12-24 16:35:00.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/fs/read_write.c	2005-01-13 23:39:41.000000000 -0500
@@ -14,6 +14,7 @@
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/ltt-events.h>

 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -142,6 +143,9 @@ asmlinkage off_t sys_lseek(unsigned int
 		if (res != (loff_t)retval)
 			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
 	}
+
+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_SEEK, fd, offset, NULL);
+
 	fput_light(file, fput_needed);
 bad:
 	return retval;
@@ -169,6 +173,8 @@ asmlinkage long sys_llseek(unsigned int
 	offset = vfs_llseek(file, ((loff_t) offset_high << 32) | offset_low,
 			origin);

+	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_SEEK, fd, offset, NULL);
+
 	retval = (int)offset;
 	if (offset >= 0) {
 		retval = -EFAULT;
@@ -289,6 +295,7 @@ asmlinkage ssize_t sys_read(unsigned int
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
+ 	 	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_READ, fd, count, NULL);
 		ret = vfs_read(file, buf, count, &pos);
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
@@ -307,6 +314,7 @@ asmlinkage ssize_t sys_write(unsigned in
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
+		ltt_ev_file_system(LTT_EV_FILE_SYSTEM_WRITE, fd, count, NULL);
 		ret = vfs_write(file, buf, count, &pos);
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
@@ -328,8 +336,11 @@ asmlinkage ssize_t sys_pread64(unsigned
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		ret = -ESPIPE;
-		if (file->f_mode & FMODE_PREAD)
+		if (file->f_mode & FMODE_PREAD) {
+ 	 		ltt_ev_file_system(LTT_EV_FILE_SYSTEM_READ, fd, count, NULL);
 			ret = vfs_read(file, buf, count, &pos);
+		}
+
 		fput_light(file, fput_needed);
 	}

@@ -349,8 +360,10 @@ asmlinkage ssize_t sys_pwrite64(unsigned
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		ret = -ESPIPE;
-		if (file->f_mode & FMODE_PWRITE)
+ 		if (file->f_mode & FMODE_PWRITE) {
+  			ltt_ev_file_system(LTT_EV_FILE_SYSTEM_WRITE, fd, count, NULL);
 			ret = vfs_write(file, buf, count, &pos);
+		}
 		fput_light(file, fput_needed);
 	}

@@ -535,6 +548,7 @@ sys_readv(unsigned long fd, const struct
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
+ 		ltt_ev_file_system(LTT_EV_FILE_SYSTEM_READ, fd, vlen, NULL);
 		ret = vfs_readv(file, vec, vlen, &pos);
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
@@ -553,6 +567,7 @@ sys_writev(unsigned long fd, const struc
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		loff_t pos = file_pos_read(file);
+	 	ltt_ev_file_system(LTT_EV_FILE_SYSTEM_WRITE, fd, vlen, NULL);
 		ret = vfs_writev(file, vec, vlen, &pos);
 		file_pos_write(file, pos);
 		fput_light(file, fput_needed);
--- linux-2.6.10-relayfs/fs/relayfs/relay.c	2005-01-13 22:16:35.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/fs/relayfs/relay.c	2005-01-14 00:12:06.000000000 -0500
@@ -406,8 +406,7 @@ relay_mmap_region(struct vm_area_struct

 	while (size > 0) {
 		page = kvirt_to_pa(pos);
-		if (remap_pfn_range(vma, start, page >> PAGE_SHIFT,
-					PAGE_SIZE, PAGE_SHARED))
+		if (remap_pfn_range(vma, start, page >> PAGE_SHIFT, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 		start += PAGE_SIZE;
 		pos += PAGE_SIZE;
--- linux-2.6.10-relayfs/fs/select.c	2004-12-24 16:33:49.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/fs/select.c	2005-01-13 23:39:55.000000000 -0500
@@ -22,6 +22,7 @@
 #include <linux/personality.h> /* for STICKY_TIMEOUTS */
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/ltt-events.h>

 #include <asm/uaccess.h>

@@ -223,6 +224,8 @@ int do_select(int n, fd_set_bits *fds, l
 				file = fget(i);
 				if (file) {
 					f_op = file->f_op;
+					ltt_ev_file_system(LTT_EV_FILE_SYSTEM_SELECT, i /*  The fd*/,
+							__timeout, NULL);
 					mask = DEFAULT_POLLMASK;
 					if (f_op && f_op->poll)
 						mask = (*f_op->poll)(file, retval ? NULL : wait);
@@ -408,6 +411,7 @@ static void do_pollfd(unsigned int num,
 			struct file * file = fget(fd);
 			mask = POLLNVAL;
 			if (file != NULL) {
+			        ltt_ev_file_system(LTT_EV_FILE_SYSTEM_POLL, fd, 0, NULL);
 				mask = DEFAULT_POLLMASK;
 				if (file->f_op && file->f_op->poll)
 					mask = file->f_op->poll(file, *pwait);


