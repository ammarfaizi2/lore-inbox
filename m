Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVC1Nc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVC1Nc0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVC1Nao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:30:44 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:2274 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261801AbVC1N1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:27:45 -0500
Subject: [RFC/PATCH 16/17][Kdump] Accessing dump file in linear raw format
	(/dev/oldmem)
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-P/dqQIiJvQ52DvDDlWar"
Date: Mon, 28 Mar 2005 18:57:35 +0530
Message-Id: <1112016455.4001.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-P/dqQIiJvQ52DvDDlWar
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-P/dqQIiJvQ52DvDDlWar
Content-Disposition: attachment; filename=crashdump-linear-raw-format-dump-file-access.patch
Content-Type: text/x-patch; name=crashdump-linear-raw-format-dump-file-access.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit



From: Hariprasad Nellitheertha <hari@in.ibm.com>

This patch contains the code that enables us to access the previous kernel's
memory as /dev/oldmem.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 linux-2.6.12-rc1-mm3-1M-root/Documentation/devices.txt |    1 
 linux-2.6.12-rc1-mm3-1M-root/drivers/char/mem.c        |   74 +++++++++++++++++
 2 files changed, 75 insertions(+)

diff -puN Documentation/devices.txt~crashdump-linear-raw-format-dump-file-access Documentation/devices.txt
--- linux-2.6.12-rc1-mm3-1M/Documentation/devices.txt~crashdump-linear-raw-format-dump-file-access	2005-03-27 18:36:32.000000000 +0530
+++ linux-2.6.12-rc1-mm3-1M-root/Documentation/devices.txt	2005-03-27 18:36:32.000000000 +0530
@@ -94,6 +94,7 @@ Your cooperation is appreciated.
 		  9 = /dev/urandom	Faster, less secure random number gen.
 		 10 = /dev/aio		Asyncronous I/O notification interface
 		 11 = /dev/kmsg		Writes to this come out as printk's
+		 12 = /dev/oldmem	Access to crash dump from kexec kernel
   1 block	RAM disk
 		  0 = /dev/ram0		First RAM disk
 		  1 = /dev/ram1		Second RAM disk
diff -puN drivers/char/mem.c~crashdump-linear-raw-format-dump-file-access drivers/char/mem.c
--- linux-2.6.12-rc1-mm3-1M/drivers/char/mem.c~crashdump-linear-raw-format-dump-file-access	2005-03-27 18:36:32.000000000 +0530
+++ linux-2.6.12-rc1-mm3-1M-root/drivers/char/mem.c	2005-03-27 18:36:32.000000000 +0530
@@ -23,6 +23,8 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
 #include <linux/device.h>
+#include <linux/highmem.h>
+#include <linux/crash_dump.h>
 #include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
@@ -273,6 +275,62 @@ static int mmap_kmem(struct file * file,
 	return mmap_mem(file, vma);
 }
 
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * Read memory corresponding to the old kernel.
+ * If we are reading from the reserved section, which is
+ * actually used by the current kernel, we just return zeroes.
+ * Or if we are reading from the first 640k, we return from the
+ * backed up area.
+ */
+static ssize_t read_oldmem(struct file * file, char * buf,
+				size_t count, loff_t *ppos)
+{
+	unsigned long pfn;
+	unsigned backup_start, backup_end, relocate_start;
+	size_t read=0, csize;
+
+	backup_start = CRASH_BACKUP_BASE / PAGE_SIZE;
+	backup_end = backup_start + (CRASH_BACKUP_SIZE / PAGE_SIZE);
+	relocate_start = (CRASH_BACKUP_BASE + CRASH_BACKUP_SIZE) / PAGE_SIZE;
+
+	while(count) {
+		pfn = *ppos / PAGE_SIZE;
+
+		csize = (count > PAGE_SIZE) ? PAGE_SIZE : count;
+
+		/* Perform translation (see comment above) */
+		if ((pfn >= backup_start) && (pfn < backup_end)) {
+			if (clear_user(buf, csize)) {
+				read = -EFAULT;
+				goto done;
+			}
+
+			goto copy_done;
+		} else if (pfn < (CRASH_RELOCATE_SIZE / PAGE_SIZE))
+			pfn += relocate_start;
+
+		if (pfn > saved_max_pfn) {
+			read = 0;
+			goto done;
+		}
+
+		if (copy_oldmem_page(pfn, buf, csize, 1)) {
+			read = -EFAULT;
+			goto done;
+		}
+
+copy_done:
+		buf += csize;
+		*ppos += csize;
+		read += csize;
+		count -= csize;
+	}
+done:
+	return read;
+}
+#endif
+
 extern long vread(char *buf, char *addr, unsigned long count);
 extern long vwrite(char *buf, char *addr, unsigned long count);
 
@@ -720,6 +778,7 @@ static int open_port(struct inode * inod
 #define read_full       read_zero
 #define open_mem	open_port
 #define open_kmem	open_mem
+#define open_oldmem	open_mem
 
 static struct file_operations mem_fops = {
 	.llseek		= memory_lseek,
@@ -769,6 +828,13 @@ static struct file_operations full_fops 
 	.write		= write_full,
 };
 
+#ifdef CONFIG_CRASH_DUMP
+static struct file_operations oldmem_fops = {
+	.read	= read_oldmem,
+	.open	= open_oldmem,
+};
+#endif
+
 static ssize_t kmsg_write(struct file * file, const char __user * buf,
 			  size_t count, loff_t *ppos)
 {
@@ -824,6 +890,11 @@ static int memory_open(struct inode * in
 		case 11:
 			filp->f_op = &kmsg_fops;
 			break;
+#ifdef CONFIG_CRASH_DUMP
+		case 12:
+			filp->f_op = &oldmem_fops;
+			break;
+#endif
 		default:
 			return -ENXIO;
 	}
@@ -853,6 +924,9 @@ static const struct {
 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},
 	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
 	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
+#ifdef CONFIG_CRASH_DUMP
+	{12,"oldmem",    S_IRUSR | S_IWUSR | S_IRGRP, &oldmem_fops},
+#endif
 };
 
 static struct class *mem_class;
_

--=-P/dqQIiJvQ52DvDDlWar--

