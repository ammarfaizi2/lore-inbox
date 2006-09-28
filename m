Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWI1SYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWI1SYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWI1SYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:24:41 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:47579 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S964961AbWI1SYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:24:39 -0400
Date: Thu, 28 Sep 2006 12:24:38 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] async scsi scanning, version 12
Message-ID: <20060928182438.GC5017@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully the final version ... I've addressed all the comments
I received on version 11.  Please review the implementation of
shost_for_each_device_safe.

Add ability to scan scsi busses asynchronously

Since it often takes around 20-30 seconds to scan a scsi bus, it's
highly advantageous to do this in parallel with other things.  The bulk
of this patch is ensuring that devices don't change numbering, and that
all devices are discovered prior to trying to start init.  For those
who build SCSI as modules, there's a new scsi_wait_scan module that will
ensure all bus scans are finished.

This patch only handles drivers which call scsi_scan_host.  Fibre Channel,
SAS, SATA, USB and Firewire all need additional work.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5498324..4b687ef 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1426,6 +1426,11 @@ running once the system is up.
 
 	scsi_logging=	[SCSI]
 
+	scsi_mod.scan=	[SCSI] sync (default) scans SCSI busses as they are
+			discovered.  async scans them in kernel threads,
+			allowing boot to proceed.  none ignores them, expecting
+			user space to do the scan.
+
 	selinux		[SELINUX] Disable or enable SELinux at boot time.
 			Format: { "0" | "1" }
 			See security/selinux/Kconfig help text.
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 1ef951b..38d0e25 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -140,6 +140,8 @@ obj-$(CONFIG_CHR_DEV_SCH)	+= ch.o
 # This goes last, so that "real" scsi devices probe earlier
 obj-$(CONFIG_SCSI_DEBUG)	+= scsi_debug.o
 
+obj-$(CONFIG_SCSI)		+= scsi_wait_scan.o
+
 scsi_mod-y			+= scsi.o hosts.o scsi_ioctl.o constants.o \
 				   scsicam.o scsi_error.o scsi_lib.o \
 				   scsi_scan.o scsi_sysfs.o \
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 5d023d4..f458c2f 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -39,6 +39,9 @@ static inline void scsi_log_completion(s
 	{ };
 #endif
 
+/* scsi_scan.c */
+int scsi_complete_async_scans(void);
+
 /* scsi_devinfo.c */
 extern int scsi_get_device_flags(struct scsi_device *sdev,
 				 const unsigned char *vendor,
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index fd9e281..6748b22 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -29,7 +29,9 @@ #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
-#include <asm/semaphore.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/spinlock.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -87,6 +89,11 @@ module_param_named(max_luns, max_scsi_lu
 MODULE_PARM_DESC(max_luns,
 		 "last scsi LUN (should be between 1 and 2^32-1)");
 
+static char scsi_scan_type[6] = "sync";
+
+module_param_string(scan, scsi_scan_type, sizeof(scsi_scan_type), S_IRUGO);
+MODULE_PARM_DESC(scan, "sync, async or none");
+
 /*
  * max_scsi_report_luns: the maximum number of LUNS that will be
  * returned from the REPORT LUNS command. 8 times this value must
@@ -108,6 +115,53 @@ MODULE_PARM_DESC(inq_timeout, 
 		 "Timeout (in seconds) waiting for devices to answer INQUIRY."
 		 " Default is 5. Some non-compliant devices need more.");
 
+static spinlock_t async_scan_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(scanning_hosts);
+
+struct async_scan_data {
+	struct list_head list;
+	struct Scsi_Host *shost;
+	struct completion prev_finished;
+};
+
+int scsi_complete_async_scans(void)
+{
+	struct async_scan_data *data;
+
+	do {
+		if (list_empty(&scanning_hosts))
+			return 0;
+		data = kmalloc(sizeof(*data), GFP_KERNEL);
+		if (!data)
+			msleep(1);
+	} while (!data);
+
+	data->shost = NULL;
+	init_completion(&data->prev_finished);
+
+	spin_lock(&async_scan_lock);
+	if (list_empty(&scanning_hosts))
+		goto done;
+	list_add_tail(&data->list, &scanning_hosts);
+	spin_unlock(&async_scan_lock);
+
+	printk(KERN_INFO "scsi: waiting for bus probes to complete ...\n");
+	wait_for_completion(&data->prev_finished);
+
+	spin_lock(&async_scan_lock);
+	list_del(&data->list);
+ done:
+	spin_unlock(&async_scan_lock);
+
+	kfree(data);
+	return 0;
+}
+
+#ifdef MODULE
+/* Only exported for the benefit of scsi_wait_scan */
+EXPORT_SYMBOL_GPL(scsi_complete_async_scans);
+#endif
+
 /**
  * scsi_unlock_floptical - unlock device via a special MODE SENSE command
  * @sdev:	scsi device to send command to
@@ -619,7 +673,7 @@ static int scsi_probe_lun(struct scsi_de
  *     SCSI_SCAN_LUN_PRESENT: a new scsi_device was allocated and initialized
  **/
 static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
-		int *bflags)
+		int *bflags, int async)
 {
 	/*
 	 * XXX do not save the inquiry, since it can change underneath us,
@@ -795,7 +849,7 @@ static int scsi_add_lun(struct scsi_devi
 	 * register it and tell the rest of the kernel
 	 * about it.
 	 */
-	if (scsi_sysfs_add_sdev(sdev) != 0)
+	if (!async && scsi_sysfs_add_sdev(sdev) != 0)
 		return SCSI_SCAN_NO_RESPONSE;
 
 	return SCSI_SCAN_LUN_PRESENT;
@@ -964,7 +1018,7 @@ static int scsi_probe_and_add_lun(struct
 		goto out_free_result;
 	}
 
-	res = scsi_add_lun(sdev, result, &bflags);
+	res = scsi_add_lun(sdev, result, &bflags, shost->async_scan);
 	if (res == SCSI_SCAN_LUN_PRESENT) {
 		if (bflags & BLIST_KEY) {
 			sdev->lockable = 0;
@@ -1464,6 +1518,9 @@ void scsi_scan_target(struct device *par
 {
 	struct Scsi_Host *shost = dev_to_shost(parent);
 
+	if (!shost->async_scan)
+		scsi_complete_async_scans();
+
 	mutex_lock(&shost->scan_mutex);
 	if (scsi_host_scan_allowed(shost))
 		__scsi_scan_target(parent, channel, id, lun, rescan);
@@ -1509,6 +1566,9 @@ int scsi_scan_host_selected(struct Scsi_
 		"%s: <%u:%u:%u>\n",
 		__FUNCTION__, channel, id, lun));
 
+	if (!shost->async_scan)
+		scsi_complete_async_scans();
+
 	if (((channel != SCAN_WILD_CARD) && (channel > shost->max_channel)) ||
 	    ((id != SCAN_WILD_CARD) && (id >= shost->max_id)) ||
 	    ((lun != SCAN_WILD_CARD) && (lun > shost->max_lun)))
@@ -1529,14 +1589,130 @@ int scsi_scan_host_selected(struct Scsi_
 	return 0;
 }
 
+static void scsi_sysfs_add_devices(struct Scsi_Host *shost)
+{
+	struct scsi_device *sdev, *tmp;
+	shost_for_each_device_safe(sdev, tmp, shost) {
+		if (scsi_sysfs_add_sdev(sdev) != 0)
+			scsi_destroy_sdev(sdev);
+	}
+}
+
+/**
+ * scsi_prep_async_scan - prepare for an async scan
+ * @shost: the host which will be scanned
+ * Returns: a cookie to be passed to scsi_finish_async_scan()
+ *
+ * Tells the midlayer this host is going to do an asynchronous scan.
+ * It reserves the host's position in the scanning list and ensures
+ * that other asynchronous scans started after this one won't affect the
+ * ordering of the discovered devices.
+ */
+struct async_scan_data *scsi_prep_async_scan(struct Scsi_Host *shost)
+{
+	struct async_scan_data *data;
+
+	if (strncmp(scsi_scan_type, "sync", 4) == 0)
+		return NULL;
+
+	if (shost->async_scan) {
+		printk("%s called twice for host %d", __FUNCTION__,
+				shost->host_no);
+		dump_stack();
+		return NULL;
+	}
+
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		goto err;
+	data->shost = scsi_host_get(shost);
+	if (!data->shost)
+		goto err;
+	init_completion(&data->prev_finished);
+
+	spin_lock(&async_scan_lock);
+	shost->async_scan = 1;
+	if (list_empty(&scanning_hosts))
+		complete(&data->prev_finished);
+	list_add_tail(&data->list, &scanning_hosts);
+	spin_unlock(&async_scan_lock);
+
+	return data;
+
+ err:
+	kfree(data);
+	return NULL;
+}
+
+/**
+ * scsi_finish_async_scan - asynchronous scan has finished
+ * @data: cookie returned from earlier call to scsi_prep_async_scan()
+ *
+ * All the devices currently attached to this host have been found.
+ * This function announces all the devices it has found to the rest
+ * of the system.
+ */
+void scsi_finish_async_scan(struct async_scan_data *data)
+{
+	struct Scsi_Host *shost;
+
+	if (!data)
+		return;
+
+	shost = data->shost;
+	if (!shost->async_scan) {
+		printk("%s called twice for host %d", __FUNCTION__,
+				shost->host_no);
+		dump_stack();
+		return;
+	}
+
+	wait_for_completion(&data->prev_finished);
+
+	scsi_sysfs_add_devices(shost);
+
+	spin_lock(&async_scan_lock);
+	shost->async_scan = 0;
+	list_del(&data->list);
+	if (!list_empty(&scanning_hosts)) {
+		struct async_scan_data *next = list_entry(scanning_hosts.next,
+				struct async_scan_data, list);
+		complete(&next->prev_finished);
+	}
+	spin_unlock(&async_scan_lock);
+
+	scsi_host_put(shost);
+	kfree(data);
+}
+
+static int do_scan_async(void *_data)
+{
+	struct async_scan_data *data = _data;
+	scsi_scan_host_selected(data->shost, SCAN_WILD_CARD, SCAN_WILD_CARD,
+				SCAN_WILD_CARD, 0);
+
+	scsi_finish_async_scan(data);
+	return 0;
+}
+
 /**
  * scsi_scan_host - scan the given adapter
  * @shost:	adapter to scan
  **/
 void scsi_scan_host(struct Scsi_Host *shost)
 {
-	scsi_scan_host_selected(shost, SCAN_WILD_CARD, SCAN_WILD_CARD,
-				SCAN_WILD_CARD, 0);
+	struct async_scan_data *data;
+
+	if (strncmp(scsi_scan_type, "none", 4) == 0)
+		return;
+
+	data = scsi_prep_async_scan(shost);
+	if (!data) {
+		scsi_scan_host_selected(shost, SCAN_WILD_CARD, SCAN_WILD_CARD,
+					SCAN_WILD_CARD, 0);
+		return;
+	}
+	kthread_run(do_scan_async, data, "scsi_scan_%d", shost->host_no);
 }
 EXPORT_SYMBOL(scsi_scan_host);
 
diff --git a/drivers/scsi/scsi_wait_scan.c b/drivers/scsi/scsi_wait_scan.c
new file mode 100644
index 0000000..f7aea46
--- /dev/null
+++ b/drivers/scsi/scsi_wait_scan.c
@@ -0,0 +1,31 @@
+/*
+ * scsi_wait_scan.c
+ *
+ * Copyright (C) 2006 James Bottomley <James.Bottomley@SteelEye.com>
+ *
+ * This is a simple module to wait until all the async scans are
+ * complete.  The idea is to use it in initrd/initramfs scripts.  You
+ * modprobe it after all the modprobes of the root SCSI drivers and it
+ * will wait until they have all finished scanning their busses before
+ * allowing the boot to proceed
+ */
+
+#include <linux/module.h>
+#include "scsi_priv.h"
+
+static int __init wait_scan_init(void)
+{
+	scsi_complete_async_scans();
+	return 0;
+}
+
+static void __exit wait_scan_exit(void)
+{
+}
+ 
+MODULE_DESCRIPTION("SCSI wait for scans");
+MODULE_AUTHOR("James Bottomley");
+MODULE_LICENSE("GPL");
+ 
+late_initcall(wait_scan_init);
+module_exit(wait_scan_exit);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 895d212..f6e33ab 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -227,7 +227,7 @@ extern struct scsi_device *__scsi_iterat
  * @sdev:	iterator
  * @host:	host whiches devices we want to iterate over
  *
- * This traverses over each devices of @shost.  The devices have
+ * This iterates over each device of @shost.  The devices have
  * a reference that must be released by scsi_host_put when breaking
  * out of the loop.
  */
@@ -237,6 +237,24 @@ #define shost_for_each_device(sdev, shos
 	     (sdev) = __scsi_iterate_devices((shost), (sdev)))
 
 /**
+ * shost_for_each_device_safe - iterate over all devices of a host allowing removal
+ * @sdev:	iterator
+ * @n:		another &struct scsi_device for temporary storage
+ * @host:	host whiches devices we want to iterate over
+ *
+ * This iterates over each device of @shost in a way that is safe against
+ * removals of the element being processed.  The devices have
+ * a reference that must be released by scsi_host_put when breaking
+ * out of the loop.
+ */
+#define shost_for_each_device_safe(sdev, n, shost) \
+	for ((sdev) = __scsi_iterate_devices((shost), NULL), \
+		(n) = __scsi_iterate_devices((shost), (sdev)); \
+	     (sdev); \
+	     (sdev) = (n), \
+		(n) = (n) ? __scsi_iterate_devices((shost), (n)) : NULL)
+
+/**
  * __shost_for_each_device  -  iterate over all devices of a host (UNLOCKED)
  * @sdev:	iterator
  * @host:	host whiches devices we want to iterate over
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 39c6f8c..ba5b3eb 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -552,6 +552,9 @@ struct Scsi_Host {
 	/* task mgmt function in progress */
 	unsigned tmf_in_progress:1;
 
+	/* Asynchronous scan in progress */
+	unsigned async_scan:1;
+
 	/*
 	 * Optional work queue to be utilized by the transport
 	 */
