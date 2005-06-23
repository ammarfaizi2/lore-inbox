Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVFWRPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVFWRPu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVFWRPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:15:49 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:8396 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262631AbVFWRGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:06:49 -0400
Date: Thu, 23 Jun 2005 19:06:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cborntra@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 2/3] s390: add vmcp interface.
Message-ID: <20050623170651.GB7262@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/3] s390: add vmcp interface.

From: Christian Borntraeger <cborntra@de.ibm.com>

Add interface to issue VM control program commands.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig          |    1 
 arch/s390/kernel/cpcmd.c     |  109 ++++++++++++---------
 arch/s390/kernel/setup.c     |    6 -
 arch/s390/kernel/smp.c       |    6 -
 arch/s390/kernel/traps.c     |    2 
 arch/s390/mm/extmem.c        |    4 
 drivers/s390/Kconfig         |    7 +
 drivers/s390/char/Makefile   |    1 
 drivers/s390/char/con3215.c  |    4 
 drivers/s390/char/con3270.c  |    4 
 drivers/s390/char/vmcp.c     |  219 +++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/char/vmcp.h     |   30 +++++
 drivers/s390/char/vmlogrdr.c |   10 -
 drivers/s390/net/smsgiucv.c  |    4 
 include/asm-s390/cpcmd.h     |   18 +++
 15 files changed, 359 insertions(+), 66 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-06-23 18:57:54.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2005-06-23 18:57:54.000000000 +0200
@@ -254,6 +254,7 @@ CONFIG_S390_TAPE_BLOCK=y
 #
 CONFIG_S390_TAPE_34XX=m
 # CONFIG_VMLOGRDR is not set
+# CONFIG_VMCP is not set
 # CONFIG_MONREADER is not set
 # CONFIG_DCSS_SHM is not set
 
diff -urpN linux-2.6/arch/s390/kernel/cpcmd.c linux-2.6-patched/arch/s390/kernel/cpcmd.c
--- linux-2.6/arch/s390/kernel/cpcmd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/cpcmd.c	2005-06-23 18:57:54.000000000 +0200
@@ -2,7 +2,7 @@
  *  arch/s390/kernel/cpcmd.c
  *
  *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) 1999,2005 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Christian Borntraeger (cborntra@de.ibm.com),
  */
@@ -18,93 +18,114 @@
 #include <asm/system.h>
 
 static DEFINE_SPINLOCK(cpcmd_lock);
-static char cpcmd_buf[240];
+static char cpcmd_buf[241];
 
 /*
  * the caller of __cpcmd has to ensure that the response buffer is below 2 GB
  */
-void __cpcmd(char *cmd, char *response, int rlen)
+int  __cpcmd(const char *cmd, char *response, int rlen, int *response_code)
 {
 	const int mask = 0x40000000L;
 	unsigned long flags;
+	int return_code;
+	int return_len;
 	int cmdlen;
 
 	spin_lock_irqsave(&cpcmd_lock, flags);
 	cmdlen = strlen(cmd);
 	BUG_ON(cmdlen > 240);
-	strcpy(cpcmd_buf, cmd);
+	memcpy(cpcmd_buf, cmd, cmdlen);
 	ASCEBC(cpcmd_buf, cmdlen);
 
 	if (response != NULL && rlen > 0) {
 		memset(response, 0, rlen);
 #ifndef CONFIG_ARCH_S390X
-		asm volatile ("LRA   2,0(%0)\n\t"
-                              "LR    4,%1\n\t"
-                              "O     4,%4\n\t"
-                              "LRA   3,0(%2)\n\t"
-                              "LR    5,%3\n\t"
-                              ".long 0x83240008 # Diagnose X'08'\n\t"
-                              : /* no output */
-                              : "a" (cpcmd_buf), "d" (cmdlen),
-                                "a" (response), "d" (rlen), "m" (mask)
-                              : "cc", "2", "3", "4", "5" );
+		asm volatile (	"lra	2,0(%2)\n"
+				"lr	4,%3\n"
+				"o	4,%6\n"
+				"lra	3,0(%4)\n"
+				"lr	5,%5\n"
+				"diag	2,4,0x8\n"
+				"brc	8, .Litfits\n"
+				"ar	5, %5\n"
+				".Litfits: \n"
+				"lr	%0,4\n"
+				"lr	%1,5\n"
+				: "=d" (return_code), "=d" (return_len)
+				: "a" (cpcmd_buf), "d" (cmdlen),
+				"a" (response), "d" (rlen), "m" (mask)
+				: "cc", "2", "3", "4", "5" );
 #else /* CONFIG_ARCH_S390X */
-                asm volatile ("   lrag  2,0(%0)\n"
-                              "   lgr   4,%1\n"
-                              "   o     4,%4\n"
-                              "   lrag  3,0(%2)\n"
-                              "   lgr   5,%3\n"
-                              "   sam31\n"
-                              "   .long 0x83240008 # Diagnose X'08'\n"
-                              "   sam64"
-                              : /* no output */
-                              : "a" (cpcmd_buf), "d" (cmdlen),
-                                "a" (response), "d" (rlen), "m" (mask)
-                              : "cc", "2", "3", "4", "5" );
+                asm volatile (	"lrag	2,0(%2)\n"
+				"lgr	4,%3\n"
+				"o	4,%6\n"
+				"lrag	3,0(%4)\n"
+				"lgr	5,%5\n"
+				"sam31\n"
+				"diag	2,4,0x8\n"
+				"sam64\n"
+				"brc	8, .Litfits\n"
+				"agr	5, %5\n"
+				".Litfits: \n"
+				"lgr	%0,4\n"
+				"lgr	%1,5\n"
+				: "=d" (return_code), "=d" (return_len)
+				: "a" (cpcmd_buf), "d" (cmdlen),
+				"a" (response), "d" (rlen), "m" (mask)
+				: "cc", "2", "3", "4", "5" );
 #endif /* CONFIG_ARCH_S390X */
                 EBCASC(response, rlen);
         } else {
+		return_len = 0;
 #ifndef CONFIG_ARCH_S390X
-                asm volatile ("LRA   2,0(%0)\n\t"
-                              "LR    3,%1\n\t"
-                              ".long 0x83230008 # Diagnose X'08'\n\t"
-                              : /* no output */
-                              : "a" (cpcmd_buf), "d" (cmdlen)
-                              : "2", "3"  );
+                asm volatile (	"lra	2,0(%1)\n"
+				"lr	3,%2\n"
+				"diag	2,3,0x8\n"
+				"lr	%0,3\n"
+				: "=d" (return_code)
+				: "a" (cpcmd_buf), "d" (cmdlen)
+				: "2", "3"  );
 #else /* CONFIG_ARCH_S390X */
-                asm volatile ("   lrag  2,0(%0)\n"
-                              "   lgr   3,%1\n"
-                              "   sam31\n"
-                              "   .long 0x83230008 # Diagnose X'08'\n"
-                              "   sam64"
-                              : /* no output */
-                              : "a" (cpcmd_buf), "d" (cmdlen)
-                              : "2", "3"  );
+                asm volatile (	"lrag	2,0(%1)\n"
+				"lgr	3,%2\n"
+				"sam31\n"
+				"diag	2,3,0x8\n"
+				"sam64\n"
+				"lgr	%0,3\n"
+				: "=d" (return_code)
+				: "a" (cpcmd_buf), "d" (cmdlen)
+				: "2", "3" );
 #endif /* CONFIG_ARCH_S390X */
         }
 	spin_unlock_irqrestore(&cpcmd_lock, flags);
+	if (response_code != NULL)
+		*response_code = return_code;
+	return return_len;
 }
 
 EXPORT_SYMBOL(__cpcmd);
 
 #ifdef CONFIG_ARCH_S390X
-void cpcmd(char *cmd, char *response, int rlen)
+int cpcmd(const char *cmd, char *response, int rlen, int *response_code)
 {
 	char *lowbuf;
+	int len;
+
 	if ((rlen == 0) || (response == NULL)
 	    || !((unsigned long)response >> 31))
-		__cpcmd(cmd, response, rlen);
+		len = __cpcmd(cmd, response, rlen, response_code);
 	else {
 		lowbuf = kmalloc(rlen, GFP_KERNEL | GFP_DMA);
 		if (!lowbuf) {
 			printk(KERN_WARNING
 				"cpcmd: could not allocate response buffer\n");
-			return;
+			return -ENOMEM;
 		}
-		__cpcmd(cmd, lowbuf, rlen);
+		len = __cpcmd(cmd, lowbuf, rlen, response_code);
 		memcpy(response, lowbuf, rlen);
 		kfree(lowbuf);
 	}
+	return len;
 }
 
 EXPORT_SYMBOL(cpcmd);
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2005-06-23 18:57:54.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2005-06-23 18:57:54.000000000 +0200
@@ -198,11 +198,11 @@ static void __init conmode_default(void)
 	char *ptr;
 
         if (MACHINE_IS_VM) {
-		__cpcmd("QUERY CONSOLE", query_buffer, 1024);
+		__cpcmd("QUERY CONSOLE", query_buffer, 1024, NULL);
 		console_devno = simple_strtoul(query_buffer + 5, NULL, 16);
 		ptr = strstr(query_buffer, "SUBCHANNEL =");
 		console_irq = simple_strtoul(ptr + 13, NULL, 16);
-		__cpcmd("QUERY TERM", query_buffer, 1024);
+		__cpcmd("QUERY TERM", query_buffer, 1024, NULL);
 		ptr = strstr(query_buffer, "CONMODE");
 		/*
 		 * Set the conmode to 3215 so that the device recognition 
@@ -211,7 +211,7 @@ static void __init conmode_default(void)
 		 * 3215 and the 3270 driver will try to access the console
 		 * device (3215 as console and 3270 as normal tty).
 		 */
-		__cpcmd("TERM CONMODE 3215", NULL, 0);
+		__cpcmd("TERM CONMODE 3215", NULL, 0, NULL);
 		if (ptr == NULL) {
 #if defined(CONFIG_SCLP_CONSOLE)
 			SET_CONSOLE_SCLP;
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2005-06-23 18:57:54.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2005-06-23 18:57:54.000000000 +0200
@@ -284,7 +284,7 @@ static void do_machine_restart(void * __
 	 * locks are always held disabled).
 	 */
 	if (MACHINE_IS_VM)
-		cpcmd ("IPL", NULL, 0);
+		cpcmd ("IPL", NULL, 0, NULL);
 	else
 		reipl (0x10000 | S390_lowcore.ipl_device);
 }
@@ -313,7 +313,7 @@ static void do_machine_halt(void * __unu
 	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid) == 0) {
 		smp_send_stop();
 		if (MACHINE_IS_VM && strlen(vmhalt_cmd) > 0)
-			cpcmd(vmhalt_cmd, NULL, 0);
+			cpcmd(vmhalt_cmd, NULL, 0, NULL);
 		signal_processor(smp_processor_id(),
 				 sigp_stop_and_store_status);
 	}
@@ -332,7 +332,7 @@ static void do_machine_power_off(void * 
 	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid) == 0) {
 		smp_send_stop();
 		if (MACHINE_IS_VM && strlen(vmpoff_cmd) > 0)
-			cpcmd(vmpoff_cmd, NULL, 0);
+			cpcmd(vmpoff_cmd, NULL, 0, NULL);
 		signal_processor(smp_processor_id(),
 				 sigp_stop_and_store_status);
 	}
diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2005-06-23 18:57:44.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2005-06-23 18:57:54.000000000 +0200
@@ -735,7 +735,7 @@ void __init trap_init(void)
 						    &ext_int_pfault);
 #endif
 #ifndef CONFIG_ARCH_S390X
-		cpcmd("SET PAGEX ON", NULL, 0);
+		cpcmd("SET PAGEX ON", NULL, 0, NULL);
 #endif
 	}
 }
diff -urpN linux-2.6/arch/s390/mm/extmem.c linux-2.6-patched/arch/s390/mm/extmem.c
--- linux-2.6/arch/s390/mm/extmem.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/extmem.c	2005-06-23 18:57:54.000000000 +0200
@@ -576,8 +576,8 @@ segment_save(char *name)
 			segtype_string[seg->range[i].start & 0xff]);
 	}
 	sprintf(cmd2, "SAVESEG %s", name);
-	cpcmd(cmd1, NULL, 0);
-	cpcmd(cmd2, NULL, 0);
+	cpcmd(cmd1, NULL, 0, NULL);
+	cpcmd(cmd2, NULL, 0, NULL);
 	spin_unlock(&dcss_lock);
 }
 
diff -urpN linux-2.6/drivers/s390/char/con3215.c linux-2.6-patched/drivers/s390/char/con3215.c
--- linux-2.6/drivers/s390/char/con3215.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/con3215.c	2005-06-23 18:57:54.000000000 +0200
@@ -860,8 +860,8 @@ con3215_init(void)
 
 	/* Set the console mode for VM */
 	if (MACHINE_IS_VM) {
-		cpcmd("TERM CONMODE 3215", NULL, 0);
-		cpcmd("TERM AUTOCR OFF", NULL, 0);
+		cpcmd("TERM CONMODE 3215", NULL, 0, NULL);
+		cpcmd("TERM AUTOCR OFF", NULL, 0, NULL);
 	}
 
 	/* allocate 3215 request structures */
diff -urpN linux-2.6/drivers/s390/char/con3270.c linux-2.6-patched/drivers/s390/char/con3270.c
--- linux-2.6/drivers/s390/char/con3270.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/con3270.c	2005-06-23 18:57:54.000000000 +0200
@@ -591,8 +591,8 @@ con3270_init(void)
 
 	/* Set the console mode for VM */
 	if (MACHINE_IS_VM) {
-		cpcmd("TERM CONMODE 3270", 0, 0);
-		cpcmd("TERM AUTOCR OFF", 0, 0);
+		cpcmd("TERM CONMODE 3270", NULL, 0, NULL);
+		cpcmd("TERM AUTOCR OFF", NULL, 0, NULL);
 	}
 
 	cdev = ccw_device_probe_console();
diff -urpN linux-2.6/drivers/s390/char/Makefile linux-2.6-patched/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/Makefile	2005-06-23 18:57:54.000000000 +0200
@@ -19,6 +19,7 @@ obj-$(CONFIG_SCLP_CPI) += sclp_cpi.o
 
 obj-$(CONFIG_ZVM_WATCHDOG) += vmwatchdog.o
 obj-$(CONFIG_VMLOGRDR) += vmlogrdr.o
+obj-$(CONFIG_VMCP) += vmcp.o
 
 tape-$(CONFIG_S390_TAPE_BLOCK) += tape_block.o
 tape-$(CONFIG_PROC_FS) += tape_proc.o
diff -urpN linux-2.6/drivers/s390/char/vmcp.c linux-2.6-patched/drivers/s390/char/vmcp.c
--- linux-2.6/drivers/s390/char/vmcp.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/vmcp.c	2005-06-23 18:57:54.000000000 +0200
@@ -0,0 +1,219 @@
+/*
+ * Copyright (C) 2004,2005 IBM Corporation
+ * Interface implementation for communication with the v/VM control program
+ * Author(s): Christian Borntraeger <cborntra@de.ibm.com>
+ *
+ *
+ * z/VMs CP offers the possibility to issue commands via the diagnose code 8
+ * this driver implements a character device that issues these commands and
+ * returns the answer of CP.
+
+ * The idea of this driver is based on cpint from Neale Ferguson and #CP in CMS
+ */
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <asm/cpcmd.h>
+#include <asm/debug.h>
+#include <asm/uaccess.h>
+#include "vmcp.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christian Borntraeger <cborntra@de.ibm.com>");
+MODULE_DESCRIPTION("z/VM CP interface");
+
+static debug_info_t *vmcp_debug;
+
+static int vmcp_open(struct inode *inode, struct file *file)
+{
+	struct vmcp_session *session;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	session = kmalloc(sizeof(*session), GFP_KERNEL);
+	if (!session)
+		return -ENOMEM;
+	session->bufsize = PAGE_SIZE;
+	session->response = NULL;
+	session->resp_size = 0;
+	init_MUTEX(&session->mutex);
+	file->private_data = session;
+	return nonseekable_open(inode, file);
+}
+
+static int vmcp_release(struct inode *inode, struct file *file)
+{
+	struct vmcp_session *session;
+
+	session = (struct vmcp_session *)file->private_data;
+	file->private_data = NULL;
+	free_pages((unsigned long)session->response, get_order(session->bufsize));
+	kfree(session);
+	return 0;
+}
+
+static ssize_t
+vmcp_read(struct file *file, char __user * buff, size_t count, loff_t * ppos)
+{
+	size_t tocopy;
+	struct vmcp_session *session;
+
+	session = (struct vmcp_session *)file->private_data;
+	if (down_interruptible(&session->mutex))
+		return -ERESTARTSYS;
+	if (!session->response) {
+		up(&session->mutex);
+		return 0;
+	}
+	if (*ppos > session->resp_size) {
+		up(&session->mutex);
+		return 0;
+	}
+	tocopy = min(session->resp_size - (size_t) (*ppos), count);
+	tocopy = min(tocopy,session->bufsize - (size_t) (*ppos));
+
+	if (copy_to_user(buff, session->response + (*ppos), tocopy)) {
+		up(&session->mutex);
+		return -EFAULT;
+	}
+	up(&session->mutex);
+	*ppos += tocopy;
+	return tocopy;
+}
+
+static ssize_t
+vmcp_write(struct file *file, const char __user * buff, size_t count,
+	   loff_t * ppos)
+{
+	char *cmd;
+	struct vmcp_session *session;
+
+	if (count > 240)
+		return -EINVAL;
+	cmd = kmalloc(count + 1, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+	if (copy_from_user(cmd, buff, count)) {
+		kfree(cmd);
+		return -EFAULT;
+	}
+	cmd[count] = '\0';
+	session = (struct vmcp_session *)file->private_data;
+	if (down_interruptible(&session->mutex))
+		return -ERESTARTSYS;
+	if (!session->response)
+		session->response = (char *)__get_free_pages(GFP_KERNEL
+						| __GFP_REPEAT 	| GFP_DMA,
+						get_order(session->bufsize));
+	if (!session->response) {
+		up(&session->mutex);
+		kfree(cmd);
+		return -ENOMEM;
+	}
+	debug_text_event(vmcp_debug, 1, cmd);
+	session->resp_size = cpcmd(cmd, session->response,
+				   session->bufsize,
+				   &session->resp_code);
+	up(&session->mutex);
+	kfree(cmd);
+	*ppos = 0;		/* reset the file pointer after a command */
+	return count;
+}
+
+
+/*
+ * These ioctls are available, as the semantics of the diagnose 8 call
+ * does not fit very well into a Linux call. Diagnose X'08' is described in
+ * CP Programming Services SC24-6084-00
+ *
+ * VMCP_GETCODE: gives the CP return code back to user space
+ * VMCP_SETBUF: sets the response buffer for the next write call. diagnose 8
+ * expects adjacent pages in real storage and to make matters worse, we
+ * dont know the size of the response. Therefore we default to PAGESIZE and
+ * let userspace to change the response size, if userspace expects a bigger
+ * response
+ */
+static long vmcp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct vmcp_session *session;
+	int temp;
+
+	session = (struct vmcp_session *)file->private_data;
+	if (down_interruptible(&session->mutex))
+		return -ERESTARTSYS;
+	switch (cmd) {
+	case VMCP_GETCODE:
+		temp = session->resp_code;
+		up(&session->mutex);
+		return put_user(temp, (int __user *)arg);
+	case VMCP_SETBUF:
+		free_pages((unsigned long)session->response,
+				get_order(session->bufsize));
+		session->response=NULL;
+		temp = get_user(session->bufsize, (int __user *)arg);
+		if (get_order(session->bufsize) > 8) {
+			session->bufsize = PAGE_SIZE;
+			temp = -EINVAL;
+		}
+		up(&session->mutex);
+		return temp;
+	case VMCP_GETSIZE:
+		temp = session->resp_size;
+		up(&session->mutex);
+		return put_user(temp, (int __user *)arg);
+	default:
+		up(&session->mutex);
+		return -ENOIOCTLCMD;
+	}
+}
+
+static struct file_operations vmcp_fops = {
+	.owner		= THIS_MODULE,
+	.open		= &vmcp_open,
+	.release	= &vmcp_release,
+	.read		= &vmcp_read,
+	.llseek		= &no_llseek,
+	.write		= &vmcp_write,
+	.unlocked_ioctl	= &vmcp_ioctl,
+	.compat_ioctl	= &vmcp_ioctl
+};
+
+static struct miscdevice vmcp_dev = {
+	.name	= "vmcp",
+	.minor	= MISC_DYNAMIC_MINOR,
+	.fops	= &vmcp_fops,
+};
+
+static int __init vmcp_init(void)
+{
+	int ret;
+
+	if (!MACHINE_IS_VM) {
+		printk(KERN_WARNING
+		       "z/VM CP interface is only available under z/VM\n");
+		return -ENODEV;
+	}
+	ret = misc_register(&vmcp_dev);
+	if (!ret)
+		printk(KERN_INFO "z/VM CP interface loaded\n");
+	else
+		printk(KERN_WARNING
+		       "z/VM CP interface not loaded. Could not register misc device.\n");
+	vmcp_debug = debug_register("vmcp", 0, 1, 240);
+	debug_register_view(vmcp_debug, &debug_hex_ascii_view);
+	return ret;
+}
+
+static void __exit vmcp_exit(void)
+{
+	WARN_ON(misc_deregister(&vmcp_dev) != 0);
+	debug_unregister(vmcp_debug);
+	printk(KERN_INFO "z/VM CP interface unloaded.\n");
+}
+
+module_init(vmcp_init);
+module_exit(vmcp_exit);
diff -urpN linux-2.6/drivers/s390/char/vmcp.h linux-2.6-patched/drivers/s390/char/vmcp.h
--- linux-2.6/drivers/s390/char/vmcp.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/vmcp.h	2005-06-23 18:57:54.000000000 +0200
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2004, 2005 IBM Corporation
+ * Interface implementation for communication with the v/VM control program
+ * Version 1.0
+ * Author(s): Christian Borntraeger <cborntra@de.ibm.com>
+ *
+ *
+ * z/VMs CP offers the possibility to issue commands via the diagnose code 8
+ * this driver implements a character device that issues these commands and
+ * returns the answer of CP.
+ *
+ * The idea of this driver is based on cpint from Neale Ferguson
+ */
+
+#include <asm/semaphore.h>
+#include <linux/ioctl.h>
+
+#define VMCP_GETCODE _IOR(0x10, 1, int)
+#define VMCP_SETBUF _IOW(0x10, 2, int)
+#define VMCP_GETSIZE _IOR(0x10, 3, int)
+
+struct vmcp_session {
+	unsigned int bufsize;
+	char *response;
+	int resp_size;
+	int resp_code;
+	/* As we use copy_from/to_user, which might     *
+	 * sleep and cannot use a spinlock              */
+	struct semaphore mutex;
+};
diff -urpN linux-2.6/drivers/s390/char/vmlogrdr.c linux-2.6-patched/drivers/s390/char/vmlogrdr.c
--- linux-2.6/drivers/s390/char/vmlogrdr.c	2005-06-23 18:57:45.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/vmlogrdr.c	2005-06-23 18:57:54.000000000 +0200
@@ -236,7 +236,7 @@ vmlogrdr_get_recording_class_AB(void) {
 	int len,i;
 
 	printk (KERN_DEBUG "vmlogrdr: query command: %s\n", cp_command);
-	cpcmd(cp_command, cp_response, sizeof(cp_response));
+	cpcmd(cp_command, cp_response, sizeof(cp_response), NULL);
 	printk (KERN_DEBUG "vmlogrdr: response: %s", cp_response);
 	len = strnlen(cp_response,sizeof(cp_response));
 	// now the parsing
@@ -288,7 +288,7 @@ vmlogrdr_recording(struct vmlogrdr_priv_
 
 		printk (KERN_DEBUG "vmlogrdr: recording command: %s\n",
 			cp_command);
-		cpcmd(cp_command, cp_response, sizeof(cp_response));
+		cpcmd(cp_command, cp_response, sizeof(cp_response), NULL);
 		printk (KERN_DEBUG "vmlogrdr: recording response: %s",
 			cp_response);
 	}
@@ -301,7 +301,7 @@ vmlogrdr_recording(struct vmlogrdr_priv_
 		qid_string);
 
 	printk (KERN_DEBUG "vmlogrdr: recording command: %s\n", cp_command);
-	cpcmd(cp_command, cp_response, sizeof(cp_response));
+	cpcmd(cp_command, cp_response, sizeof(cp_response), NULL);
 	printk (KERN_DEBUG "vmlogrdr: recording response: %s",
 		cp_response);
 	/* The recording command will usually answer with 'Command complete'
@@ -607,7 +607,7 @@ vmlogrdr_purge_store(struct device * dev
 			 priv->recording_name);
 
 	printk (KERN_DEBUG "vmlogrdr: recording command: %s\n", cp_command);
-	cpcmd(cp_command, cp_response, sizeof(cp_response));
+	cpcmd(cp_command, cp_response, sizeof(cp_response), NULL);
 	printk (KERN_DEBUG "vmlogrdr: recording response: %s",
 		cp_response);
 
@@ -682,7 +682,7 @@ vmlogrdr_recording_status_show(struct de
 	char cp_command[] = "QUERY RECORDING ";
 	int len;
 
-	cpcmd(cp_command, buf, 4096);
+	cpcmd(cp_command, buf, 4096, NULL);
 	len = strlen(buf);
 	return len;
 }
diff -urpN linux-2.6/drivers/s390/Kconfig linux-2.6-patched/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/Kconfig	2005-06-23 18:57:54.000000000 +0200
@@ -187,6 +187,13 @@ config VMLOGRDR
 	  *SYMPTOM.
 	  This driver depends on the IUCV support driver.
 
+config VMCP
+	tristate "Support for the z/VM CP interface (VM only)"
+	help
+	  Select this option if you want to be able to interact with the control
+	  program on z/VM
+
+
 config MONREADER
 	tristate "API for reading z/VM monitor service records"
 	depends on IUCV
diff -urpN linux-2.6/drivers/s390/net/smsgiucv.c linux-2.6-patched/drivers/s390/net/smsgiucv.c
--- linux-2.6/drivers/s390/net/smsgiucv.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/smsgiucv.c	2005-06-23 18:57:54.000000000 +0200
@@ -138,7 +138,7 @@ static void __exit
 smsg_exit(void)
 {
 	if (smsg_handle > 0) {
-		cpcmd("SET SMSG OFF", 0, 0);
+		cpcmd("SET SMSG OFF", NULL, 0, NULL);
 		iucv_sever(smsg_pathid, 0);
 		iucv_unregister_program(smsg_handle);
 		driver_unregister(&smsg_driver);
@@ -177,7 +177,7 @@ smsg_init(void)
 		smsg_handle = 0;
 		return -EIO;
 	}
-	cpcmd("SET SMSG IUCV", 0, 0);
+	cpcmd("SET SMSG IUCV", NULL, 0, NULL);
 	return 0;
 }
 
diff -urpN linux-2.6/include/asm-s390/cpcmd.h linux-2.6-patched/include/asm-s390/cpcmd.h
--- linux-2.6/include/asm-s390/cpcmd.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/cpcmd.h	2005-06-23 18:57:54.000000000 +0200
@@ -11,14 +11,28 @@
 #define __CPCMD__
 
 /*
+ * the lowlevel function for cpcmd
  * the caller of __cpcmd has to ensure that the response buffer is below 2 GB
  */
-extern void __cpcmd(char *cmd, char *response, int rlen);
+extern int __cpcmd(const char *cmd, char *response, int rlen, int *response_code);
 
 #ifndef __s390x__
 #define cpcmd __cpcmd
 #else
-extern void cpcmd(char *cmd, char *response, int rlen);
+/*
+ * cpcmd is the in-kernel interface for issuing CP commands
+ *
+ * cmd:		null-terminated command string, max 240 characters
+ * response:	response buffer for VM's textual response
+ * rlen:	size of the response buffer, cpcmd will not exceed this size
+ *		but will cap the output, if its too large. Everything that
+ *		did not fit into the buffer will be silently dropped
+ * response_code: return pointer for VM's error code
+ * return value: the size of the response. The caller can check if the buffer
+ *		was large enough by comparing the return value and rlen
+ * NOTE: If the response buffer is not below 2 GB, cpcmd can sleep
+ */
+extern int cpcmd(const char *cmd, char *response, int rlen, int *response_code);
 #endif /*__s390x__*/
 
 #endif
