Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbRGJHPM>; Tue, 10 Jul 2001 03:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265902AbRGJHOx>; Tue, 10 Jul 2001 03:14:53 -0400
Received: from patan.Sun.COM ([192.18.98.43]:31225 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S265895AbRGJHOo>;
	Tue, 10 Jul 2001 03:14:44 -0400
Message-ID: <3B4AAD25.8E4FB9D0@sun.com>
Date: Tue, 10 Jul 2001 00:22:13 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: groudier@club-internet.fr, alan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  sym53c8xx reboot notifier and minor nits
Content-Type: multipart/mixed;
 boundary="------------130E4BD2D45E49B190F46774"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------130E4BD2D45E49B190F46774
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Gerard and all,

This patch adds areboot notifier to the sym53c8xx driver, and fixes a
couple minor issues.  The host list is now spinlocked, and the unmap
pci_mem (which icalled by a non-init function) is now non-init.

Please let me know if there are any problems with this patch for general
inclusion. (reboot notifier by asun)

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------130E4BD2D45E49B190F46774
Content-Type: text/plain; charset=us-ascii;
 name="sym_reboot_and_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym_reboot_and_cleanup.diff"

diff -ruN dist-2.4.6/drivers/scsi/sym53c8xx.c cobalt-2.4.6/drivers/scsi/sym53c8xx.c
--- dist-2.4.6/drivers/scsi/sym53c8xx.c	Tue Jun 12 11:06:54 2001
+++ cobalt-2.4.6/drivers/scsi/sym53c8xx.c	Mon Jul  9 11:04:14 2001
@@ -113,6 +113,8 @@
 #elif LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
 #include <asm/spinlock.h>
 #endif
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -634,8 +636,11 @@
 #if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
 
 spinlock_t sym53c8xx_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t sym53c8xx_host_lock = SPIN_LOCK_UNLOCKED;
 #define	NCR_LOCK_DRIVER(flags)     spin_lock_irqsave(&sym53c8xx_lock, flags)
 #define	NCR_UNLOCK_DRIVER(flags)   spin_unlock_irqrestore(&sym53c8xx_lock,flags)
+#define	NCR_LOCK_HOSTS(flags)     spin_lock_irqsave(&sym53c8xx_host_lock, flags)
+#define	NCR_UNLOCK_HOSTS(flags)   spin_unlock_irqrestore(&sym53c8xx_host_lock,flags)
 
 #define NCR_INIT_LOCK_NCB(np)      spin_lock_init(&np->smp_lock);
 #define	NCR_LOCK_NCB(np, flags)    spin_lock_irqsave(&np->smp_lock, flags)
@@ -650,6 +655,8 @@
 
 #define	NCR_LOCK_DRIVER(flags)     do { save_flags(flags); cli(); } while (0)
 #define	NCR_UNLOCK_DRIVER(flags)   do { restore_flags(flags); } while (0)
+#define	NCR_LOCK_HOSTS(flags)     do { save_flags(flags); cli(); } while (0)
+#define	NCR_UNLOCK_HOSTS(flags)   do { restore_flags(flags); } while (0)
 
 #define	NCR_INIT_LOCK_NCB(np)      do { } while (0)
 #define	NCR_LOCK_NCB(np, flags)    do { save_flags(flags); cli(); } while (0)
@@ -695,7 +702,7 @@
 	return page_remapped? (page_remapped + page_offs) : 0UL;
 }
 
-static void __init unmap_pci_mem(u_long vaddr, u_long size)
+static void unmap_pci_mem(u_long vaddr, u_long size)
 {
 	if (vaddr)
 		iounmap((void *) (vaddr & PAGE_MASK));
@@ -1301,6 +1308,15 @@
 			int length, int hostno, int func);
 #endif
 
+/* 
+** reset the scsi controller on a "reboot." it should be way at the
+** end.
+*/
+static int sym53c8xx_halt(struct notifier_block *, ulong, void *);
+static struct notifier_block sym53c8xx_notifier = {
+  sym53c8xx_halt, NULL, 0
+};
+
 /*
 **	Driver setup.
 **
@@ -13043,7 +13046,8 @@
 	}
 
 	m_free(devtbl, PAGE_SIZE, "devtbl");
-
+	if (attach_count)
+ 	          register_reboot_notifier(&sym53c8xx_notifier);
 	return attach_count;
 }
 
@@ -13775,19 +13779,49 @@
 }
 
 
+static int sym53c8xx_halt(struct notifier_block *block, ulong event, void *buf)
+{
+	unsigned long flags;
+	struct Scsi_Host *host, *next;
+
+	switch (event) {
+	case SYS_RESTART:
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	printk(KERN_INFO "resetting sym53c8xx scsi bus(es)\n");
+	NCR_LOCK_HOSTS(flags);
+	next = first_host;
+	while ((host = next)) {
+		struct host_data *data = (struct host_data *)host->hostdata;
+
+		next = host->next;	
+		if (data && data->ncb)
+			ncr_detach(data->ncb);
+	}
+	NCR_UNLOCK_HOSTS(flags);
+
+	return NOTIFY_OK;
+}
+
 #ifdef MODULE
 int sym53c8xx_release(struct Scsi_Host *host)
 {
 #ifdef DEBUG_SYM53C8XX
 printk("sym53c8xx : release\n");
 #endif
+     if (first_host)
+	unregister_reboot_notifier(&sym53c8xx_notifier);
      ncr_detach(((struct host_data *) host->hostdata)->ncb);
 
      return 1;
 }
 #endif
 
-
 /*
 **	Scsi command waiting list management.
 **
@@ -14182,13 +14216,15 @@
 {
 	struct Scsi_Host *host;
 	struct host_data *host_data;
+	unsigned long flags;
 	ncb_p ncb = 0;
-	int retv;
+	int retv = -EINVAL;
 
 #ifdef DEBUG_PROC_INFO
 printk("sym53c8xx_proc_info: hostno=%d, func=%d\n", hostno, func);
 #endif
 
+	NCR_LOCK_HOSTS(flags);
 	for (host = first_host; host; host = host->next) {
 		if (host->hostt != first_host->hostt)
 			continue;
@@ -14200,25 +14236,22 @@
 	}
 
 	if (!ncb)
-		return -EINVAL;
+		goto proc_done;
 
 	if (func) {
 #ifdef	SCSI_NCR_USER_COMMAND_SUPPORT
 		retv = ncr_user_command(ncb, buffer, length);
-#else
-		retv = -EINVAL;
 #endif
-	}
-	else {
+	} else {
 		if (start)
 			*start = buffer;
 #ifdef SCSI_NCR_USER_INFO_SUPPORT
 		retv = ncr_host_info(ncb, buffer, offset, length);
-#else
-		retv = -EINVAL;
 #endif
 	}
+	NCR_UNLOCK_HOSTS(flags);
 
+proc_done:
 	return retv;
 }
 

--------------130E4BD2D45E49B190F46774--

