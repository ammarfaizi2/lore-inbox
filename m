Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263186AbUKTVWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbUKTVWn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 16:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUKTVWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 16:22:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34312 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263177AbUKTVSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 16:18:42 -0500
Date: Sat, 20 Nov 2004 22:18:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill scsi_syms.c
Message-ID: <20041120211840.GF2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes scsi_syms.c and moves the EXPORT_SYMBOL's to the 
files where the actual functions are.


diffstat output:
 Documentation/scsi/scsi_mid_low_api.txt |    4 
 drivers/scsi/Makefile                   |    2 
 drivers/scsi/constants.c                |    9 ++
 drivers/scsi/hosts.c                    |    8 +
 drivers/scsi/scsi.c                     |   11 ++
 drivers/scsi/scsi_error.c               |    6 +
 drivers/scsi/scsi_ioctl.c               |    3 
 drivers/scsi/scsi_lib.c                 |   10 ++
 drivers/scsi/scsi_scan.c                |    5 +
 drivers/scsi/scsi_syms.c                |   97 ------------------------
 drivers/scsi/scsi_sysfs.c               |    3 
 drivers/scsi/scsicam.c                  |    3 
 12 files changed, 60 insertions(+), 101 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/Documentation/scsi/scsi_mid_low_api.txt.old	2004-11-20 21:25:38.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/Documentation/scsi/scsi_mid_low_api.txt	2004-11-20 21:25:56.000000000 +0100
@@ -363,8 +363,8 @@
 Mid level supplied functions
 ============================
 These functions are supplied by the SCSI mid level for use by LLDs.
-The names (i.e. entry points) of these functions are exported (mainly in 
-scsi_syms.c) so an LLD that is a module can access them. The kernel will
+The names (i.e. entry points) of these functions are exported 
+so an LLD that is a module can access them. The kernel will
 arrange for the SCSI mid level to be loaded and initialized before any LLD
 is initialized. The functions below are listed alphabetically and their
 names all start with "scsi_".
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/Makefile.old	2004-11-20 21:26:08.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/Makefile	2004-11-20 21:26:17.000000000 +0100
@@ -143,7 +143,7 @@
 
 scsi_mod-y			+= scsi.o hosts.o scsi_ioctl.o constants.o \
 				   scsicam.o scsi_error.o scsi_lib.o \
-				   scsi_scan.o scsi_syms.o scsi_sysfs.o \
+				   scsi_scan.o scsi_sysfs.o \
 				   scsi_devinfo.o
 scsi_mod-$(CONFIG_SYSCTL)	+= scsi_sysctl.o
 scsi_mod-$(CONFIG_SCSI_PROC_FS)	+= scsi_proc.o
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_sysfs.c.old	2004-11-20 21:27:17.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_sysfs.c	2004-11-20 21:44:12.000000000 +0100
@@ -611,6 +611,7 @@
 out:
 	up(&shost->scan_mutex);
 }
+EXPORT_SYMBOL(scsi_remove_device);
 
 int scsi_register_driver(struct device_driver *drv)
 {
@@ -618,6 +619,7 @@
 
 	return driver_register(drv);
 }
+EXPORT_SYMBOL(scsi_register_driver);
 
 int scsi_register_interface(struct class_interface *intf)
 {
@@ -625,6 +627,7 @@
 
 	return class_interface_register(intf);
 }
+EXPORT_SYMBOL(scsi_register_interface);
 
 
 static struct class_device_attribute *class_attr_overridden(
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/hosts.c.old	2004-11-20 21:27:57.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/hosts.c	2004-11-20 21:30:51.000000000 +0100
@@ -88,6 +88,7 @@
 		class_device_unregister(&shost->transport_classdev);
 	device_del(&shost->shost_gendev);
 }
+EXPORT_SYMBOL(scsi_remove_host);
 
 /**
  * scsi_add_host - add a scsi host
@@ -152,6 +153,7 @@
  out:
 	return error;
 }
+EXPORT_SYMBOL(scsi_add_host);
 
 static void scsi_host_dev_release(struct device *dev)
 {
@@ -308,6 +310,7 @@
 	kfree(shost);
 	return NULL;
 }
+EXPORT_SYMBOL(scsi_host_alloc);
 
 struct Scsi_Host *scsi_register(struct scsi_host_template *sht, int privsize)
 {
@@ -323,12 +326,14 @@
 		list_add_tail(&shost->sht_legacy_list, &sht->legacy_hosts);
 	return shost;
 }
+EXPORT_SYMBOL(scsi_register);
 
 void scsi_unregister(struct Scsi_Host *shost)
 {
 	list_del(&shost->sht_legacy_list);
 	scsi_host_put(shost);
 }
+EXPORT_SYMBOL(scsi_unregister);
 
 /**
  * scsi_host_lookup - get a reference to a Scsi_Host by host no
@@ -356,6 +361,7 @@
 
 	return shost;
 }
+EXPORT_SYMBOL(scsi_host_lookup);
 
 /**
  * scsi_host_get - inc a Scsi_Host ref count
@@ -368,6 +374,7 @@
 		return NULL;
 	return shost;
 }
+EXPORT_SYMBOL(scsi_host_get);
 
 /**
  * scsi_host_put - dec a Scsi_Host ref count
@@ -377,6 +384,7 @@
 {
 	put_device(&shost->shost_gendev);
 }
+EXPORT_SYMBOL(scsi_host_put);
 
 int scsi_init_hosts(void)
 {
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_scan.c.old	2004-11-20 21:28:44.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_scan.c	2004-11-20 21:43:37.000000000 +0100
@@ -1096,6 +1096,7 @@
 
 	return sdev;
 }
+EXPORT_SYMBOL(__scsi_add_device);
 
 void scsi_rescan_device(struct device *dev)
 {
@@ -1239,6 +1240,7 @@
 	scsi_scan_host_selected(shost, SCAN_WILD_CARD, SCAN_WILD_CARD,
 				SCAN_WILD_CARD, 0);
 }
+EXPORT_SYMBOL(scsi_scan_host);
 
 void scsi_forget_host(struct Scsi_Host *shost)
 {
@@ -1293,6 +1295,7 @@
 	}
 	return sdev;
 }
+EXPORT_SYMBOL(scsi_get_host_dev);
 
 /*
  * Function:    scsi_free_host_dev()
@@ -1317,3 +1320,5 @@
 		sdev->host->transportt->device_destroy(sdev);
 	put_device(&sdev->sdev_gendev);
 }
+EXPORT_SYMBOL(scsi_free_host_dev);
+
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/scsicam.c.old	2004-11-20 21:31:09.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/scsicam.c	2004-11-20 21:31:54.000000000 +0100
@@ -41,6 +41,7 @@
 	}
 	return res;
 }
+EXPORT_SYMBOL(scsi_bios_ptable);
 
 /*
  * Function : int scsicam_bios_param (struct block_device *bdev, ector_t capacity, int *ip)
@@ -94,6 +95,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(scsicam_bios_param);
 
 /*
  * Function : static int scsi_partsize(unsigned char *buf, unsigned long 
@@ -175,6 +177,7 @@
 	}
 	return -1;
 }
+EXPORT_SYMBOL(scsi_partsize);
 
 /*
  * Function : static int setsize(unsigned long capacity,unsigned int *cyls,
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_ioctl.c.old	2004-11-20 21:32:20.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_ioctl.c	2004-11-20 21:36:32.000000000 +0100
@@ -173,6 +173,7 @@
 		sdev->locked = (state == SCSI_REMOVAL_PREVENT);
 	return ret;
 }
+EXPORT_SYMBOL(scsi_set_medium_removal);
 
 /*
  * This interface is deprecated - users should use the scsi generic (sg)
@@ -354,6 +355,7 @@
 	kfree(buf);
 	return result;
 }
+EXPORT_SYMBOL(scsi_ioctl_send_command);
 
 /*
  * The scsi_ioctl_get_pci() function places into arg the value
@@ -463,6 +465,7 @@
 	}
 	return -EINVAL;
 }
+EXPORT_SYMBOL(scsi_ioctl);
 
 /*
  * the scsi_nonblock_ioctl() function is designed for ioctls which may
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/constants.c.old	2004-11-20 21:33:13.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/constants.c	2004-11-20 21:35:16.000000000 +0100
@@ -352,6 +352,7 @@
 		printk(" %02x", command[k]);
 	printk("\n");
 }
+EXPORT_SYMBOL(__scsi_print_command);
 
 /* This function (perhaps with the addition of peripheral device type)
  * is more approriate than __scsi_print_command(). Perhaps that static
@@ -403,6 +404,7 @@
 	printk(KERN_INFO "0x%0x", scsi_status);
 #endif
 }
+EXPORT_SYMBOL(scsi_print_status);
 
 #ifdef CONFIG_SCSI_CONSTANTS
 
@@ -1106,6 +1108,7 @@
 #endif
 	return NULL;
 }
+EXPORT_SYMBOL(scsi_sense_key_string);
 
 /*
  * Get additional sense code string or NULL if not available.
@@ -1128,6 +1131,7 @@
 #endif
 	return NULL;
 }
+EXPORT_SYMBOL(scsi_extd_sense_format);
 
 /* Print extended sense information; no leadin, no linefeed */
 static void
@@ -1256,12 +1260,14 @@
 	print_sense_internal(devclass, cmd->sense_buffer,
 			     SCSI_SENSE_BUFFERSIZE, cmd->request);
 }
+EXPORT_SYMBOL(scsi_print_sense);
 
 void scsi_print_req_sense(const char *devclass, struct scsi_request *sreq)
 {
 	print_sense_internal(devclass, sreq->sr_sense_buffer,
 			     SCSI_SENSE_BUFFERSIZE, sreq->sr_request);
 }
+EXPORT_SYMBOL(scsi_print_req_sense);
 
 #ifdef CONFIG_SCSI_CONSTANTS
 static const char *one_byte_msgs[] = {
@@ -1340,6 +1346,7 @@
 		printk("reserved");
 	return len;
 }
+EXPORT_SYMBOL(scsi_print_msg);
 
 #else  /* ifndef CONFIG_SCSI_CONSTANTS */
 
@@ -1367,6 +1374,7 @@
 		printk("%02x ", msg[0]);
 	return len;
 }
+EXPORT_SYMBOL(scsi_print_msg);
 #endif /* ! CONFIG_SCSI_CONSTANTS */
 
 void scsi_print_command(struct scsi_cmnd *cmd)
@@ -1379,6 +1387,7 @@
 	printk(KERN_INFO "        command: ");
 	scsi_print_cdb(cmd->cmnd, cmd->cmd_len, 0);
 }
+EXPORT_SYMBOL(scsi_print_command);
 
 #ifdef CONFIG_SCSI_CONSTANTS
 
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_error.c.old	2004-11-20 21:35:32.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_error.c	2004-11-20 21:46:48.000000000 +0100
@@ -125,6 +125,7 @@
 
 	add_timer(&scmd->eh_timeout);
 }
+EXPORT_SYMBOL(scsi_add_timer);
 
 /**
  * scsi_delete_timer - Delete/cancel timer for a given function.
@@ -152,6 +153,7 @@
 
 	return rtn;
 }
+EXPORT_SYMBOL(scsi_delete_timer);
 
 /**
  * scsi_times_out - Timeout function for normal scsi commands.
@@ -214,6 +216,7 @@
 
 	return online;
 }
+EXPORT_SYMBOL(scsi_block_when_processing_errors);
 
 #ifdef CONFIG_SCSI_LOGGING
 /**
@@ -1752,6 +1755,7 @@
 		}
 	}
 }
+EXPORT_SYMBOL(scsi_report_bus_reset);
 
 /*
  * Function:    scsi_report_device_reset()
@@ -1787,6 +1791,7 @@
 		}
 	}
 }
+EXPORT_SYMBOL(scsi_report_device_reset);
 
 static void
 scsi_reset_provider_done_command(struct scsi_cmnd *scmd)
@@ -1866,6 +1871,7 @@
 	scsi_next_command(scmd);
 	return rtn;
 }
+EXPORT_SYMBOL(scsi_reset_provider);
 
 /**
  * scsi_normalize_sense - normalize main elements from either fixed or
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi.c.old	2004-11-20 21:36:54.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi.c	2004-11-20 21:46:12.000000000 +0100
@@ -98,6 +98,9 @@
  * After the system is up, you may enable logging via the /proc interface.
  */
 unsigned int scsi_logging_level;
+#if defined(CONFIG_SCSI_LOGGING)
+EXPORT_SYMBOL(scsi_logging_level);
+#endif
 
 const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE] = {
 	"Direct-Access    ",
@@ -115,6 +118,7 @@
 	"RAID             ",
 	"Enclosure        ",
 };
+EXPORT_SYMBOL(scsi_device_types);
 
 /*
  * Function:    scsi_allocate_request
@@ -147,6 +151,7 @@
 
 	return sreq;
 }
+EXPORT_SYMBOL(scsi_allocate_request);
 
 void __scsi_release_request(struct scsi_request *sreq)
 {
@@ -187,6 +192,7 @@
 	__scsi_release_request(sreq);
 	kfree(sreq);
 }
+EXPORT_SYMBOL(scsi_release_request);
 
 struct scsi_host_cmd_pool {
 	kmem_cache_t	*slab;
@@ -269,6 +275,7 @@
 
 	return cmd;
 }				
+EXPORT_SYMBOL(scsi_get_command);
 
 /*
  * Function:	scsi_put_command()
@@ -305,6 +312,7 @@
 
 	put_device(&sdev->sdev_gendev);
 }
+EXPORT_SYMBOL(scsi_put_command);
 
 /*
  * Function:	scsi_setup_command_freelist()
@@ -961,6 +969,7 @@
 	spin_unlock(sdev->request_queue->queue_lock);
 	spin_unlock_irqrestore(&device_request_lock, flags);
 }
+EXPORT_SYMBOL(scsi_adjust_queue_depth);
 
 /*
  * Function:	scsi_track_queue_full()
@@ -1011,6 +1020,7 @@
 		scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, depth);
 	return depth;
 }
+EXPORT_SYMBOL(scsi_track_queue_full);
 
 /**
  * scsi_device_get  -  get an addition reference to a scsi_device
@@ -1176,6 +1186,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(scsi_device_cancel);
 
 #ifdef CONFIG_HOTPLUG_CPU
 static int scsi_cpu_notify(struct notifier_block *self,
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_lib.c.old	2004-11-20 21:38:11.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_lib.c	2004-11-20 21:46:26.000000000 +0100
@@ -233,7 +233,8 @@
 	 */
 	scsi_insert_special_req(sreq, 1);
 }
- 
+EXPORT_SYMBOL(scsi_do_req);
+
 static void scsi_wait_done(struct scsi_cmnd *cmd)
 {
 	struct request *req = cmd->request;
@@ -267,6 +268,7 @@
 
 	__scsi_release_request(sreq);
 }
+EXPORT_SYMBOL(scsi_wait_req);
 
 /*
  * Function:    scsi_init_cmd_errh()
@@ -885,6 +887,7 @@
 		cmd = scsi_end_request(cmd, 0, block_bytes, 1);
 	}
 }
+EXPORT_SYMBOL(scsi_io_completion);
 
 /*
  * Function:    scsi_init_io()
@@ -1345,6 +1348,7 @@
 
 	return bounce_limit;
 }
+EXPORT_SYMBOL(scsi_calculate_bounce_limit);
 
 struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)
 {
@@ -1394,6 +1398,7 @@
 {
 	shost->host_self_blocked = 1;
 }
+EXPORT_SYMBOL(scsi_block_requests);
 
 /*
  * Function:    scsi_unblock_requests()
@@ -1420,6 +1425,7 @@
 	shost->host_self_blocked = 0;
 	scsi_run_host_queues(shost);
 }
+EXPORT_SYMBOL(scsi_unblock_requests);
 
 int __init scsi_init_queue(void)
 {
@@ -1554,6 +1560,7 @@
 
 	return sreq->sr_result;
 }
+EXPORT_SYMBOL(__scsi_mode_sense);
 
 /**
  *	scsi_mode_sense - issue a mode sense, falling back from 10 to 
@@ -1588,6 +1595,7 @@
 
 	return ret;
 }
+EXPORT_SYMBOL(scsi_mode_sense);
 
 int
 scsi_test_unit_ready(struct scsi_device *sdev, int timeout, int retries)
--- linux-2.6.10-rc2-mm2-full/drivers/scsi/scsi_syms.c	2004-10-18 23:54:08.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,97 +0,0 @@
-/*
- * We should not even be trying to compile this if we are not doing
- * a module.
- */
-#include <linux/config.h>
-#include <linux/module.h>
-
-#include <scsi/scsi.h>
-#include <scsi/scsi_dbg.h>
-#include <scsi/scsi_device.h>
-#include <scsi/scsi_driver.h>
-#include <scsi/scsi_eh.h>
-#include <scsi/scsi_host.h>
-#include <scsi/scsi_ioctl.h>
-#include <scsi/scsi_request.h>
-#include <scsi/scsicam.h>
-
-#include "scsi_logging.h"
-
-
-/*
- * This source file contains the symbol table used by scsi loadable
- * modules.
- */
-EXPORT_SYMBOL(scsi_register_driver);
-EXPORT_SYMBOL(scsi_register_interface);
-EXPORT_SYMBOL(scsi_host_alloc);
-EXPORT_SYMBOL(scsi_add_host);
-EXPORT_SYMBOL(scsi_scan_host);
-EXPORT_SYMBOL(scsi_remove_host);
-EXPORT_SYMBOL(scsi_host_get);
-EXPORT_SYMBOL(scsi_host_put);
-EXPORT_SYMBOL(scsi_host_lookup);
-EXPORT_SYMBOL(scsi_register);
-EXPORT_SYMBOL(scsi_unregister);
-EXPORT_SYMBOL(scsicam_bios_param);
-EXPORT_SYMBOL(scsi_partsize);
-EXPORT_SYMBOL(scsi_bios_ptable);
-EXPORT_SYMBOL(scsi_ioctl);
-EXPORT_SYMBOL(scsi_print_command);
-EXPORT_SYMBOL(__scsi_print_command);
-EXPORT_SYMBOL(scsi_print_sense);
-EXPORT_SYMBOL(scsi_print_req_sense);
-EXPORT_SYMBOL(scsi_print_msg);
-EXPORT_SYMBOL(scsi_print_status);
-EXPORT_SYMBOL(scsi_sense_key_string);
-EXPORT_SYMBOL(scsi_extd_sense_format);
-EXPORT_SYMBOL(scsi_block_when_processing_errors);
-EXPORT_SYMBOL(scsi_ioctl_send_command);
-EXPORT_SYMBOL(scsi_set_medium_removal);
-#if defined(CONFIG_SCSI_LOGGING)	/* { */
-EXPORT_SYMBOL(scsi_logging_level);
-#endif
-
-EXPORT_SYMBOL(scsi_allocate_request);
-EXPORT_SYMBOL(scsi_release_request);
-EXPORT_SYMBOL(scsi_wait_req);
-EXPORT_SYMBOL(scsi_do_req);
-EXPORT_SYMBOL(scsi_get_command);
-EXPORT_SYMBOL(scsi_put_command);
-
-EXPORT_SYMBOL(scsi_report_bus_reset);
-EXPORT_SYMBOL(scsi_report_device_reset);
-EXPORT_SYMBOL(scsi_block_requests);
-EXPORT_SYMBOL(scsi_unblock_requests);
-EXPORT_SYMBOL(scsi_adjust_queue_depth);
-EXPORT_SYMBOL(scsi_track_queue_full);
-
-EXPORT_SYMBOL(scsi_get_host_dev);
-EXPORT_SYMBOL(scsi_free_host_dev);
-
-EXPORT_SYMBOL(scsi_io_completion);
-
-EXPORT_SYMBOL(__scsi_add_device);
-EXPORT_SYMBOL(scsi_remove_device);
-EXPORT_SYMBOL(scsi_device_cancel);
-
-EXPORT_SYMBOL(__scsi_mode_sense);
-EXPORT_SYMBOL(scsi_mode_sense);
-
-/*
- * This symbol is for the highlevel drivers (e.g. sg) only.
- */
-EXPORT_SYMBOL(scsi_reset_provider);
-
-EXPORT_SYMBOL(scsi_device_types);
-
-/*
- * This is for st to find the bounce limit
- */
-EXPORT_SYMBOL(scsi_calculate_bounce_limit);
-
-/*
- * Externalize timers so that HBAs can safely start/restart commands.
- */
-EXPORT_SYMBOL(scsi_add_timer);
-EXPORT_SYMBOL(scsi_delete_timer);

