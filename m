Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUIONDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUIONDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUIOM7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:59:49 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:46055 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266096AbUIOM5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:57:21 -0400
Date: Wed, 15 Sep 2004 18:27:28 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][6/6]Linear/raw format dump file access
Message-ID: <20040915125728.GG15450@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040915125041.GA15450@in.ibm.com> <20040915125145.GB15450@in.ibm.com> <20040915125322.GC15450@in.ibm.com> <20040915125422.GD15450@in.ibm.com> <20040915125525.GE15450@in.ibm.com> <20040915125631.GF15450@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
In-Reply-To: <20040915125631.GF15450@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-oldmem-269rc1-mm5.patch"



This patch contains the code that enables us to access the previous kernel's
memory as /dev/oldmem.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>
Signed off by Adam Litke <litke@us.ibm.com>


---

 linux-2.6.9-rc1-hari/Documentation/devices.txt |    1 
 linux-2.6.9-rc1-hari/drivers/char/mem.c        |   66 +++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff -puN Documentation/devices.txt~kd-oldmem-269rc1-mm5 Documentation/devices.txt
--- linux-2.6.9-rc1/Documentation/devices.txt~kd-oldmem-269rc1-mm5	2004-09-15 17:36:57.000000000 +0530
+++ linux-2.6.9-rc1-hari/Documentation/devices.txt	2004-09-15 17:36:57.000000000 +0530
@@ -100,6 +100,7 @@ Your cooperation is appreciated.
 		  9 = /dev/urandom	Faster, less secure random number gen.
 		 10 = /dev/aio		Asyncronous I/O notification interface
 		 11 = /dev/kmsg		Writes to this come out as printk's
+		 12 = /dev/oldmem		Access to kexec-ed crash dump
   1 block	RAM disk
 		  0 = /dev/ram0		First RAM disk
 		  1 = /dev/ram1		Second RAM disk
diff -puN drivers/char/mem.c~kd-oldmem-269rc1-mm5 drivers/char/mem.c
--- linux-2.6.9-rc1/drivers/char/mem.c~kd-oldmem-269rc1-mm5	2004-09-15 17:36:57.000000000 +0530
+++ linux-2.6.9-rc1-hari/drivers/char/mem.c	2004-09-15 17:36:57.000000000 +0530
@@ -23,6 +23,8 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
 #include <linux/device.h>
+#include <linux/highmem.h>
+#include <linux/crash_dump.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -231,6 +233,60 @@ static int mmap_mem(struct file *file, s
 	return 0;
 }
 
+/*
+ * Read memory corresponding to the old kernel.
+ * If we are reading from the reserved section, which is
+ * actually used by the current kernel, we just return zeroes.
+ * Or if we are reading from the first 640k, we return from the
+ * backed up area.
+ */
+static ssize_t read_oldmem(struct file * file, char * buf,
+                        size_t count, loff_t *ppos)
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
+
 extern long vread(char *buf, char *addr, unsigned long count);
 extern long vwrite(char *buf, char *addr, unsigned long count);
 
@@ -535,6 +591,7 @@ static int open_port(struct inode * inod
 #define read_full       read_zero
 #define open_mem	open_port
 #define open_kmem	open_mem
+#define open_oldmem	open_mem
 
 static struct file_operations mem_fops = {
 	.llseek		= memory_lseek,
@@ -579,6 +636,11 @@ static struct file_operations full_fops 
 	.write		= write_full,
 };
 
+static struct file_operations oldmem_fops = {
+        .read           = read_oldmem,
+        .open           = open_oldmem,
+};
+
 static ssize_t kmsg_write(struct file * file, const char __user * buf,
 			  size_t count, loff_t *ppos)
 {
@@ -633,6 +695,9 @@ static int memory_open(struct inode * in
 		case 11:
 			filp->f_op = &kmsg_fops;
 			break;
+		case 12:
+			filp->f_op = &oldmem_fops;
+			break;
 		default:
 			return -ENXIO;
 	}
@@ -662,6 +727,7 @@ static const struct {
 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},
 	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
 	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
+	{12,"oldmem",    S_IRUSR | S_IWUSR | S_IRGRP, &oldmem_fops},
 };
 
 static struct class_simple *mem_class;

_

--b8GWCKCLzrXbuNet--
