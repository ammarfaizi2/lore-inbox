Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268210AbUHQMUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268210AbUHQMUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268200AbUHQMT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:19:27 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:15538 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265348AbUHQMNr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:13:47 -0400
Date: Tue, 17 Aug 2004 17:43:32 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: akpm@osdl.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       mbligh@aracnet.com, litke@us.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH][6/6]Device abstraction for linear/raw view of the dump
Message-ID: <20040817121332.GG3916@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040817120239.GA3916@in.ibm.com> <20040817120531.GB3916@in.ibm.com> <20040817120717.GC3916@in.ibm.com> <20040817120809.GD3916@in.ibm.com> <20040817120911.GE3916@in.ibm.com> <20040817121017.GF3916@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <20040817121017.GF3916@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-hmem-268.patch"



This patch contains the code that enables us to access the previous kernel's
memory as /dev/hmem.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>
Signed off by Adam Litke <litke@us.ibm.com>


---

 linux-2.6.8.1-hari/Documentation/devices.txt |    1 
 linux-2.6.8.1-hari/drivers/char/mem.c        |   72 +++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff -puN Documentation/devices.txt~kd-hmem-268 Documentation/devices.txt
--- linux-2.6.8.1/Documentation/devices.txt~kd-hmem-268	2004-08-17 17:11:26.000000000 +0530
+++ linux-2.6.8.1-hari/Documentation/devices.txt	2004-08-17 17:11:32.000000000 +0530
@@ -100,6 +100,7 @@ Your cooperation is appreciated.
 		  9 = /dev/urandom	Faster, less secure random number gen.
 		 10 = /dev/aio		Asyncronous I/O notification interface
 		 11 = /dev/kmsg		Writes to this come out as printk's
+		 12 = /dev/hmem		Access to kexec-ed crash dump
   1 block	RAM disk
 		  0 = /dev/ram0		First RAM disk
 		  1 = /dev/ram1		Second RAM disk
diff -puN drivers/char/mem.c~kd-hmem-268 drivers/char/mem.c
--- linux-2.6.8.1/drivers/char/mem.c~kd-hmem-268	2004-08-17 17:11:26.000000000 +0530
+++ linux-2.6.8.1-hari/drivers/char/mem.c	2004-08-17 17:11:32.000000000 +0530
@@ -263,6 +263,68 @@ ssize_t copy_hmem_page(unsigned long pfn
 	return 0;
 }
 
+/*
+ * After a crash-induced kexec, our physical memory layout
+ * looks like the following:
+ *
+ *        max_pfn                           End of memory\
+ * /---------|--------------------------------------------\
+ * | Section | Section | Section | Section                |
+ * |    K    |    B    |    A    |    C                   |
+ * \------------------------------------------------------/
+ *
+ * Section K: System memory.  The system is fooled to think it
+ *            can only use memory in this area.
+ * Section A: Backup of 0 - CRASH_BACKUP_SIZE kB from
+ *            the crashed kernel.
+ * Section B: Untouched memory from last kernel.
+ * Section C: Untouched memory from last kernel.
+ *
+ * In order to present a properly-ordered dump via this device,
+ * we must reorder the sections per the following:
+ *
+ * /---------|--------------------------------------------\
+ * | Section | Section |  Empty  | Section                |
+ * |    A    |    B    | Section |    C                   |
+ * \------------------------------------------------------/
+ *
+ */
+static ssize_t read_hmem(struct file * file, char * buf,
+                        size_t count, loff_t *ppos)
+{
+	unsigned long pfn;
+	unsigned curmem_end, backup_start, backup_end;
+	size_t read=0, csize;
+
+	backup_start = CRASH_BACKUP_BASE / PAGE_SIZE;
+	backup_end = backup_start + (CRASH_BACKUP_SIZE / PAGE_SIZE);
+	curmem_end = max_pfn;
+
+	while(count) {
+		pfn = *ppos / PAGE_SIZE;
+
+		/* Perform translation (see comment above) */
+		if (pfn < curmem_end)
+			pfn += backup_start;
+		else if ((pfn >= backup_start) && (pfn < backup_end))
+			pfn = -1; /* Placeholder so we know to zero page later */
+
+		if ((pfn != -1) && (pfn > saved_max_pfn))
+			return 0; /* EOF */
+
+		csize = (count > PAGE_SIZE) ? PAGE_SIZE : count;
+
+		if (copy_hmem_page(pfn, buf, csize, 1))
+			return -EFAULT;
+
+		buf += csize;
+		*ppos += csize;
+		read += csize;
+		count -= csize;
+	}
+	return read;
+}
+
 extern long vread(char *buf, char *addr, unsigned long count);
 extern long vwrite(char *buf, char *addr, unsigned long count);
 
@@ -626,6 +688,7 @@ static int open_port(struct inode * inod
 #define read_full       read_zero
 #define open_mem	open_port
 #define open_kmem	open_mem
+#define open_hmem	open_mem
 
 static struct file_operations mem_fops = {
 	.llseek		= memory_lseek,
@@ -671,6 +734,11 @@ static struct file_operations full_fops 
 	.write		= write_full,
 };
 
+static struct file_operations hmem_fops = {
+        .read           = read_hmem,
+        .open           = open_hmem,
+};
+
 static ssize_t kmsg_write(struct file * file, const char __user * buf,
 			  size_t count, loff_t *ppos)
 {
@@ -725,6 +793,9 @@ static int memory_open(struct inode * in
 		case 11:
 			filp->f_op = &kmsg_fops;
 			break;
+		case 12:
+			filp->f_op = &hmem_fops;
+			break;
 		default:
 			return -ENXIO;
 	}
@@ -754,6 +825,7 @@ static const struct {
 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},
 	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
 	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
+	{12,"hmem",    S_IRUSR | S_IWUSR | S_IRGRP, &hmem_fops},
 };
 
 static struct class_simple *mem_class;

_

--/aVve/J9H4Wl5yVO--
