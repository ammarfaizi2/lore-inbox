Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVB1Vd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVB1Vd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVB1Vd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:33:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38152 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261765AbVB1VcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:32:01 -0500
Date: Mon, 28 Feb 2005 22:31:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI: possible cleanups
Message-ID: <20050228213159.GO4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I'm getting flamed to death:
This patch contains possible cleanups. If parts of this patch conflict 
with pending changes these parts of my patch have to be dropped.

This patch contains the following possible cleanups:
- make needlessly global code static
- remove or #if 0 the following unused functions:
  - scsi.h: print_driverbyte
  - scsi.h: print_hostbyte
  - constants.c: scsi_print_hostbyte
  - constants.c: scsi_print_driverbyte
  - scsi_scan.c: scsi_scan_single_target
- remove the following unneeded EXPORT_SYMBOL's:
  - constants.c: __scsi_print_sense
  - hosts.c: scsi_host_lookup
  - scsi.c: scsi_device_cancel
  - scsi_error.c: scsi_normalize_sense
  - scsi_error.c: scsi_sense_desc_find
  - scsi_lib.c: scsi_device_resume
  - scsi_scan.c: scsi_rescan_device
  - scsi_scan.c: scsi_scan_single_target

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/constants.c   |   56 -------------------------------------
 drivers/scsi/hosts.c       |    3 -
 drivers/scsi/scsi.c        |    9 +++--
 drivers/scsi/scsi.h        |    8 -----
 drivers/scsi/scsi_debug.c  |    2 -
 drivers/scsi/scsi_error.c  |    6 +--
 drivers/scsi/scsi_lib.c    |    5 +--
 drivers/scsi/scsi_priv.h   |    4 --
 drivers/scsi/scsi_scan.c   |    3 +
 drivers/scsi/scsi_sysfs.c  |    4 +-
 include/scsi/scsi_dbg.h    |    5 ---
 include/scsi/scsi_device.h |    1 
 include/scsi/scsi_eh.h     |    3 -
 include/scsi/scsi_host.h   |    2 -
 14 files changed, 16 insertions(+), 95 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi.h.old	2005-02-28 18:18:22.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi.h	2005-02-28 18:19:02.000000000 +0100
@@ -80,14 +80,6 @@
 {
 	return scsi_print_req_sense(devclass, req);
 }
-static inline void print_driverbyte(int scsiresult)
-{
-	return scsi_print_driverbyte(scsiresult);
-}
-static inline void print_hostbyte(int scsiresult)
-{
-	return scsi_print_hostbyte(scsiresult);
-}
 static inline void print_status(unsigned char status)
 {
 	return scsi_print_status(status);
--- linux-2.6.11-rc4-mm1-full/include/scsi/scsi_dbg.h.old	2005-02-28 18:17:32.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/scsi/scsi_dbg.h	2005-02-28 18:18:57.000000000 +0100
@@ -8,11 +8,6 @@
 extern void __scsi_print_command(unsigned char *);
 extern void scsi_print_sense(const char *, struct scsi_cmnd *);
 extern void scsi_print_req_sense(const char *, struct scsi_request *);
-extern void __scsi_print_sense(const char *name,
-			       const unsigned char *sense_buffer,
-			       int sense_len);
-extern void scsi_print_driverbyte(int);
-extern void scsi_print_hostbyte(int);
 extern void scsi_print_status(unsigned char);
 extern int scsi_print_msg(const unsigned char *);
 extern const char *scsi_sense_key_string(unsigned char);
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/constants.c.old	2005-02-28 18:17:46.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/constants.c	2005-02-28 18:19:47.000000000 +0100
@@ -1156,7 +1156,7 @@
 }
 
 /* Print sense information */
-void
+static void
 __scsi_print_sense(const char *name, const unsigned char *sense_buffer,
 		   int sense_len)
 {
@@ -1251,7 +1251,6 @@
 		printk("\n");
 	}
 }
-EXPORT_SYMBOL(__scsi_print_sense);
 
 void scsi_print_sense(const char *devclass, struct scsi_cmnd *cmd)
 {
@@ -1393,56 +1392,3 @@
 }
 EXPORT_SYMBOL(scsi_print_command);
 
-#ifdef CONFIG_SCSI_CONSTANTS
-
-static const char * hostbyte_table[]={
-"DID_OK", "DID_NO_CONNECT", "DID_BUS_BUSY", "DID_TIME_OUT", "DID_BAD_TARGET", 
-"DID_ABORT", "DID_PARITY", "DID_ERROR", "DID_RESET", "DID_BAD_INTR",
-"DID_PASSTHROUGH", "DID_SOFT_ERROR", "DID_IMM_RETRY"};
-#define NUM_HOSTBYTE_STRS (sizeof(hostbyte_table) / sizeof(const char *))
-
-void scsi_print_hostbyte(int scsiresult)
-{
-	int hb = host_byte(scsiresult);
-
-	printk("Hostbyte=0x%02x", hb);
-	if (hb < NUM_HOSTBYTE_STRS)
-		printk("(%s) ", hostbyte_table[hb]);
-	else
-		printk("is invalid "); 
-}
-#else
-void scsi_print_hostbyte(int scsiresult)
-{
-	printk("Hostbyte=0x%02x ", host_byte(scsiresult));
-}
-#endif
-
-#ifdef CONFIG_SCSI_CONSTANTS
-
-static const char * driverbyte_table[]={
-"DRIVER_OK", "DRIVER_BUSY", "DRIVER_SOFT",  "DRIVER_MEDIA", "DRIVER_ERROR", 
-"DRIVER_INVALID", "DRIVER_TIMEOUT", "DRIVER_HARD", "DRIVER_SENSE"};
-#define NUM_DRIVERBYTE_STRS (sizeof(driverbyte_table) / sizeof(const char *))
-
-static const char * driversuggest_table[]={"SUGGEST_OK",
-"SUGGEST_RETRY", "SUGGEST_ABORT", "SUGGEST_REMAP", "SUGGEST_DIE",
-"SUGGEST_5", "SUGGEST_6", "SUGGEST_7", "SUGGEST_SENSE"};
-#define NUM_SUGGEST_STRS (sizeof(driversuggest_table) / sizeof(const char *))
-
-void scsi_print_driverbyte(int scsiresult)
-{
-	int dr = (driver_byte(scsiresult) & DRIVER_MASK);
-	int su = ((driver_byte(scsiresult) & SUGGEST_MASK) >> 4);
-
-	printk("Driverbyte=0x%02x ", driver_byte(scsiresult));
-	printk("(%s,%s) ",
-	       (dr < NUM_DRIVERBYTE_STRS ? driverbyte_table[dr] : "invalid"),
-	       (su < NUM_SUGGEST_STRS ? driversuggest_table[su] : "invalid"));
-}
-#else
-void scsi_print_driverbyte(int scsiresult)
-{
-	printk("Driverbyte=0x%02x ", driver_byte(scsiresult));
-}
-#endif
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/hosts.c.old	2005-02-28 18:33:14.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/hosts.c	2005-02-28 18:35:23.000000000 +0100
@@ -56,7 +56,7 @@
  * @shost:	pointer to struct Scsi_Host
  * recovery:	recovery requested to run.
  **/
-void scsi_host_cancel(struct Scsi_Host *shost, int recovery)
+static void scsi_host_cancel(struct Scsi_Host *shost, int recovery)
 {
 	struct scsi_device *sdev;
 
@@ -362,7 +362,6 @@
 
 	return shost;
 }
-EXPORT_SYMBOL(scsi_host_lookup);
 
 /**
  * scsi_host_get - inc a Scsi_Host ref count
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_priv.h.old	2005-02-28 19:59:30.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_priv.h	2005-02-28 20:20:31.000000000 +0100
@@ -66,8 +66,6 @@
 extern int scsi_dispatch_cmd(struct scsi_cmnd *cmd);
 extern int scsi_setup_command_freelist(struct Scsi_Host *shost);
 extern void scsi_destroy_command_freelist(struct Scsi_Host *shost);
-extern void scsi_done(struct scsi_cmnd *cmd);
-extern int scsi_retry_command(struct scsi_cmnd *cmd);
 extern int scsi_insert_special_req(struct scsi_request *sreq, int);
 extern void scsi_init_cmd_from_req(struct scsi_cmnd *cmd,
 		struct scsi_request *sreq);
@@ -141,7 +139,6 @@
 #endif /* CONFIG_SYSCTL */
 
 /* scsi_sysfs.c */
-extern void scsi_device_dev_release(struct device *);
 extern int scsi_sysfs_add_sdev(struct scsi_device *);
 extern int scsi_sysfs_add_host(struct Scsi_Host *);
 extern int scsi_sysfs_register(void);
@@ -150,7 +147,6 @@
 extern int scsi_sysfs_target_initialize(struct scsi_device *);
 extern struct scsi_transport_template blank_transport_template;
 
-extern struct class sdev_class;
 extern struct bus_type scsi_bus_type;
 
 /* 
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi.c.old	2005-02-28 19:59:56.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi.c	2005-02-28 20:07:39.000000000 +0100
@@ -68,6 +68,8 @@
 #include "scsi_priv.h"
 #include "scsi_logging.h"
 
+static void scsi_done(struct scsi_cmnd *cmd);
+static int scsi_retry_command(struct scsi_cmnd *cmd);
 
 /*
  * Definitions and constants.
@@ -90,7 +92,7 @@
 /*
  * Data declarations.
  */
-unsigned long scsi_pid;
+static unsigned long scsi_pid;
 static unsigned long serial_number;
 
 /*
@@ -733,7 +735,7 @@
  *
  * This function is interrupt context safe.
  */
-void scsi_done(struct scsi_cmnd *cmd)
+static void scsi_done(struct scsi_cmnd *cmd)
 {
 	/*
 	 * We don't have to worry about this one timing out any more.
@@ -829,7 +831,7 @@
  *              level drivers should not become re-entrant as a result of
  *              this.
  */
-int scsi_retry_command(struct scsi_cmnd *cmd)
+static int scsi_retry_command(struct scsi_cmnd *cmd)
 {
 	/*
 	 * Restore the SCSI command state.
@@ -1215,7 +1217,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(scsi_device_cancel);
 
 #ifdef CONFIG_HOTPLUG_CPU
 static int scsi_cpu_notify(struct notifier_block *self,
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_debug.c.old	2005-02-28 20:22:08.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_debug.c	2005-02-28 20:09:36.000000000 +0100
@@ -1783,7 +1783,7 @@
 device_initcall(scsi_debug_init);
 module_exit(scsi_debug_exit);
 
-void pseudo_0_release(struct device * dev)
+static void pseudo_0_release(struct device * dev)
 {
 	if (SCSI_DEBUG_OPT_NOISE & scsi_debug_opts)
 		printk(KERN_INFO "scsi_debug: pseudo_0_release() called\n");
--- linux-2.6.11-rc4-mm1-full/include/scsi/scsi_eh.h.old	2005-02-28 20:09:59.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/scsi/scsi_eh.h	2005-02-28 20:10:08.000000000 +0100
@@ -45,9 +45,6 @@
 	return ((sshdr->response_code >= 0x70) && (sshdr->response_code & 1));
 }
 
-extern const u8 * scsi_sense_desc_find(const u8 * sense_buffer, int sb_len,
-				       int desc_type);
-
 extern int scsi_get_sense_info_fld(const u8 * sense_buffer, int sb_len,
 				   u64 * info_out);
  
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_error.c.old	2005-02-28 20:10:16.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_error.c	2005-02-28 20:12:08.000000000 +0100
@@ -1931,7 +1931,6 @@
 
 	return 1;
 }
-EXPORT_SYMBOL(scsi_normalize_sense);
 
 int scsi_request_normalize_sense(struct scsi_request *sreq,
 				 struct scsi_sense_hdr *sshdr)
@@ -1964,8 +1963,8 @@
  * Return value:
  *	pointer to start of (first) descriptor if found else NULL
  **/
-const u8 * scsi_sense_desc_find(const u8 * sense_buffer, int sb_len,
-				int desc_type)
+static const u8 * scsi_sense_desc_find(const u8 * sense_buffer, int sb_len,
+				       int desc_type)
 {
 	int add_sen_len, add_len, desc_len, k;
 	const u8 * descp;
@@ -1988,7 +1987,6 @@
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(scsi_sense_desc_find);
 
 /**
  * scsi_get_sense_info_fld - attempts to get information field from
--- linux-2.6.11-rc4-mm1-full/include/scsi/scsi_device.h.old	2005-02-28 20:14:08.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/scsi/scsi_device.h	2005-02-28 20:14:16.000000000 +0100
@@ -223,7 +223,6 @@
 extern int scsi_device_set_state(struct scsi_device *sdev,
 				 enum scsi_device_state state);
 extern int scsi_device_quiesce(struct scsi_device *sdev);
-extern void scsi_device_resume(struct scsi_device *sdev);
 extern void scsi_target_quiesce(struct scsi_target *);
 extern void scsi_target_resume(struct scsi_target *);
 extern const char *scsi_device_state_name(enum scsi_device_state);
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_lib.c.old	2005-02-28 20:14:23.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_lib.c	2005-02-28 20:15:11.000000000 +0100
@@ -44,7 +44,7 @@
 #endif
 
 #define SP(x) { x, "sgpool-" #x } 
-struct scsi_host_sg_pool scsi_sg_pools[] = { 
+static struct scsi_host_sg_pool scsi_sg_pools[] = { 
 	SP(8),
 	SP(16),
 	SP(32),
@@ -1817,14 +1817,13 @@
  *
  *	Must be called with user context, may sleep.
  **/
-void
+static void
 scsi_device_resume(struct scsi_device *sdev)
 {
 	if(scsi_device_set_state(sdev, SDEV_RUNNING))
 		return;
 	scsi_run_queue(sdev->request_queue);
 }
-EXPORT_SYMBOL(scsi_device_resume);
 
 static void
 device_quiesce_fn(struct scsi_device *sdev, void *data)
--- linux-2.6.11-rc4-mm1-full/include/scsi/scsi_host.h.old	2005-02-28 20:17:15.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/scsi/scsi_host.h	2005-02-28 20:17:23.000000000 +0100
@@ -569,8 +569,6 @@
 extern struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *, int);
 extern int __must_check scsi_add_host(struct Scsi_Host *, struct device *);
 extern void scsi_scan_host(struct Scsi_Host *);
-extern void scsi_scan_single_target(struct Scsi_Host *, unsigned int,
-	unsigned int);
 extern void scsi_rescan_device(struct device *);
 extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_scan.c.old	2005-02-28 20:17:30.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_scan.c	2005-02-28 20:19:00.000000000 +0100
@@ -1101,7 +1101,6 @@
 		module_put(drv->owner);
 	}
 }
-EXPORT_SYMBOL(scsi_rescan_device);
 
 /**
  * scsi_scan_target - scan a target id, possibly including all LUNs on the
@@ -1238,12 +1237,14 @@
  * @chan:          channel to scan
  * @id:            target id to scan
  **/
+#if 0
 void scsi_scan_single_target(struct Scsi_Host *shost, 
 	unsigned int chan, unsigned int id)
 {
 	scsi_scan_host_selected(shost, chan, id, SCAN_WILD_CARD, 1);
 }
 EXPORT_SYMBOL(scsi_scan_single_target);
+#endif  /*  0  */
 
 void scsi_forget_host(struct Scsi_Host *shost)
 {
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_sysfs.c.old	2005-02-28 20:19:41.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_sysfs.c	2005-02-28 20:20:36.000000000 +0100
@@ -150,7 +150,7 @@
 	put_device(&sdev->sdev_gendev);
 }
 
-void scsi_device_dev_release(struct device *dev)
+static void scsi_device_dev_release(struct device *dev)
 {
 	struct scsi_device *sdev;
 	struct device *parent;
@@ -188,7 +188,7 @@
 		put_device(parent);
 }
 
-struct class sdev_class = {
+static struct class sdev_class = {
 	.name		= "scsi_device",
 	.release	= scsi_device_cls_release,
 };

