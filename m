Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSIQWxW>; Tue, 17 Sep 2002 18:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSIQWw7>; Tue, 17 Sep 2002 18:52:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6539 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264724AbSIQWtW>;
	Tue, 17 Sep 2002 18:49:22 -0400
Date: Tue, 17 Sep 2002 15:54:18 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC] [PATCH] 7/7 2.5.35 SCSI multi-path
Message-ID: <20020917155418.G18424@eng2.beaverton.ibm.com>
References: <20020917154940.A18401@eng2.beaverton.ibm.com> <20020917155018.A18424@eng2.beaverton.ibm.com> <20020917155041.B18424@eng2.beaverton.ibm.com> <20020917155120.C18424@eng2.beaverton.ibm.com> <20020917155201.D18424@eng2.beaverton.ibm.com> <20020917155232.E18424@eng2.beaverton.ibm.com> <20020917155336.F18424@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020917155336.F18424@eng2.beaverton.ibm.com>; from patman on Tue, Sep 17, 2002 at 03:53:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to add scsi midlayer multi-path support.

Ideally, the code not compiled when CONFIG_SCSI_MULTI_PATH_IO is undefined
would be removed.

 Config.help  |   20 
 Config.in    |    8 
 Makefile     |    7 
 hosts.c      |    2 
 hosts.h      |    8 
 ips.c        |    5 
 scsi.c       |   40 +
 scsi.h       |   32 +
 scsi_error.c |   33 -
 scsi_lib.c   |  106 ++++
 scsi_paths.c | 1486 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 scsi_paths.h |  152 ++++++
 scsi_scan.c  |   29 +
 sg.c         |   13 
 14 files changed, 1925 insertions(+), 16 deletions(-)

diff -Nru a/drivers/scsi/Config.help b/drivers/scsi/Config.help
--- a/drivers/scsi/Config.help	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/Config.help	Mon Sep 16 16:11:26 2002
@@ -152,6 +152,26 @@
   REPORT LUNS scanning is done only for SCSI-3 devices. Most users can safely
   answer N here.
 
+CONFIG_SCSI_MULTI_PATH_IO
+  If your system contains SCSI host adapters connecting into a shared
+  transport or you have storage devices that have multiple ports say Y
+  here to enable the multiple paths/ports to be merged into one mid layer
+  SCSI device.
+
+  If you are unsure if your system is configured to support this
+  capability or that your device has this capability say N.
+
+CONFIG_SCSI_PATH_POLICY_LPU 
+  When CONFIG_SCSI_MULTI_PATH_IO is selected this option sets the path
+  selection policy. 
+
+  The last path used policy only uses another path after a path failure.
+
+  The round robin policy round robins across all active paths.
+
+  The last path used policy is the safest path policy to select if you
+  cannot determine the best path policy for your storage device.
+
 CONFIG_SCSI_CONSTANTS
   The error messages regarding your SCSI hardware will be easier to
   understand if you say Y here; it will enlarge your kernel by about
diff -Nru a/drivers/scsi/Config.in b/drivers/scsi/Config.in
--- a/drivers/scsi/Config.in	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/Config.in	Mon Sep 16 16:11:26 2002
@@ -22,6 +22,14 @@
 
 bool '  Probe all LUNs on each SCSI device' CONFIG_SCSI_MULTI_LUN
 bool '  Build with SCSI REPORT LUNS support' CONFIG_SCSI_REPORT_LUNS
+
+bool '  Enable Mid Layer Multi-Path IO support' CONFIG_SCSI_MULTI_PATH_IO
+if [ "$CONFIG_SCSI_MULTI_PATH_IO" != "n" ] ; then
+     choice ' Multipath Routing algorithim'			\
+	 "LastPathUsed		CONFIG_SCSI_PATH_POLICY_LPU	\
+	  RoundRobin		CONFIG_SCSI_PATH_POLICY_RR"	\
+	LastPathUsed
+fi
   
 bool '  Verbose SCSI error reporting (kernel size +=12K)' CONFIG_SCSI_CONSTANTS
 bool '  SCSI logging facility' CONFIG_SCSI_LOGGING
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/Makefile	Mon Sep 16 16:11:26 2002
@@ -122,6 +122,11 @@
 scsi_mod-objs	:= scsi.o hosts.o scsi_ioctl.o constants.o scsicam.o \
 			scsi_proc.o scsi_error.o scsi_queue.o scsi_lib.o \
 			scsi_merge.o scsi_scan.o scsi_syms.o
+
+ifeq ($(CONFIG_SCSI_MULTI_PATH_IO),y)
+scsi_mod-objs += scsi_paths.o
+endif
+
 sd_mod-objs	:= sd.o
 sr_mod-objs	:= sr.o sr_ioctl.o sr_vendor.o
 initio-objs	:= ini9100u.o i91uscsi.o
@@ -159,4 +164,4 @@
 $(obj)/53c700_d.h: $(src)/53c700.scr $(src)/script_asm.pl
 	$(PERL) -s $(src)/script_asm.pl -ncr7x0_family $@ $(@:_d.h=_u.h) < $<
 
-endif
\ No newline at end of file
+endif
diff -Nru a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
--- a/drivers/scsi/hosts.c	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/hosts.c	Mon Sep 16 16:11:26 2002
@@ -181,7 +181,9 @@
 	retval->host_no = shn->host_no;
     }
     next_scsi_host++;
+#ifndef CONFIG_SCSI_MULTI_PATH_IO
     retval->host_queue = NULL;
+#endif
     init_waitqueue_head(&retval->host_wait);
     retval->resetting = 0;
     retval->last_reset = 0;
diff -Nru a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
--- a/drivers/scsi/hosts.h	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/hosts.h	Mon Sep 16 16:11:26 2002
@@ -316,7 +316,9 @@
      * struct private is a way of marking it in a sort of C++ type of way.
      */
     struct Scsi_Host      * next;
+#ifndef CONFIG_SCSI_MULTI_PATH_IO
     Scsi_Device           * host_queue;
+#endif
 
     spinlock_t		  default_lock;
     spinlock_t		  *host_lock;
@@ -576,6 +578,11 @@
 #define SD_EXTRA_DEVS CONFIG_SD_EXTRA_DEVS
 #define SR_EXTRA_DEVS CONFIG_SR_EXTRA_DEVS
 
+#ifndef CONFIG_SCSI_MULTI_PATH_IO
+/*
+ * Use scsi_locate_sdev if CONFIG_SCSI_MULTI_PATH_IO
+ */
+
 /**
  * scsi_find_device - find a device given the host
  * @channel:	SCSI channel (zero if only one channel)
@@ -594,6 +601,7 @@
                         break;
         return SDpnt;
 }
+#endif
     
 /*
  * XXX For now, check for the existence of the NUMA topology patch via the
diff -Nru a/drivers/scsi/ips.c b/drivers/scsi/ips.c
--- a/drivers/scsi/ips.c	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/ips.c	Mon Sep 16 16:11:26 2002
@@ -1911,6 +1911,10 @@
 /****************************************************************************/
 static void
 ips_select_queue_depth(struct Scsi_Host *host, Scsi_Device *scsi_devs) {
+#ifndef CONFIG_SCSI_MULTI_PATH_IO
+   /*
+    * This function is not called for multi-path IO.
+    */
    Scsi_Device *device;
    ips_ha_t    *ha;
    int          count = 0;
@@ -1941,6 +1945,7 @@
             device->queue_depth = 2;
       }
    }
+#endif
 }
 
 /****************************************************************************/
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/scsi.c	Mon Sep 16 16:11:26 2002
@@ -413,6 +413,10 @@
 				 * allow us to more easily figure out whether we should
 				 * do anything here or not.
 				 */
+				/*
+				 * single_lun devices are not allowed to
+				 * have multiple paths, see scsi_paths.c.
+				 */
 				scsi_for_each_sdev_lun(&STrav_hndl, SDpnt,
 						host->host_no,
 						path_p->spi_channel, 
@@ -1422,10 +1426,12 @@
 		if (NULL == SCpnt)
 			break;	/* If not, the next line will oops ... */
 		memset(SCpnt, 0, sizeof(Scsi_Cmnd));
+#ifndef CONFIG_SCSI_MULTI_PATH_IO
 		SCpnt->host = host;
 		SCpnt->target = SDpnt->id;
 		SCpnt->lun = SDpnt->lun;
 		SCpnt->channel = SDpnt->channel;
+#endif
 		SCpnt->device = SDpnt;
 		SCpnt->request = NULL;
 		SCpnt->use_sg = 0;
@@ -1871,9 +1877,16 @@
 				/* first register parent with driverfs */
 				device_register(&shpnt->host_driverfs_dev);
 				scan_scsis(shpnt, 0, 0, 0, 0);
+#ifndef CONFIG_SCSI_MULTI_PATH_IO
+				/*
+				 * XXX for multi-path IO, rely on
+				 * slave_attach (code not yet present
+				 * in scsi_scan.c).
+				 */
 				if (shpnt->select_queue_depths != NULL) {
 					(shpnt->select_queue_depths) (shpnt, shpnt->host_queue);
 				}
+#endif
 			}
 		}
 
@@ -1886,6 +1899,12 @@
 		 * Next we create the Scsi_Cmnd structures for this host 
 		 */
 		scsi_for_all_sdevs(&STrav_hndl, SDpnt) {
+			/*
+			 * As long as we only support multiple paths that
+			 * all use the same adapter and driver, the attach
+			 * function will only be called once for each
+			 * SDpnt.
+			 */
 			shpnt = scsi_get_host(SDpnt);
 			if (shpnt && shpnt->hostt == tpnt) {
 				for (sdtpnt = scsi_devicelist; sdtpnt; sdtpnt = sdtpnt->next)
@@ -2063,9 +2082,14 @@
 					 SCSI_FIND_ALL_CHANNEL,
 					 SCSI_FIND_ALL_ID,
 					 SCSI_FIND_ALL_LUN);
-			scsi_release_commandblocks(SDpnt);
-			blk_cleanup_queue(&SDpnt->request_queue);
-			scsi_remove_scsi_device(SDpnt);
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+			if (SDpnt->sdev_paths == NULL )
+#endif
+			{
+				scsi_release_commandblocks(SDpnt);
+				blk_cleanup_queue(&SDpnt->request_queue);
+				scsi_remove_scsi_device(SDpnt);
+			}
 		}
 	}
 
@@ -2497,6 +2521,9 @@
 		return -ENOMEM;
 	}
 	generic->write_proc = proc_scsi_gen_write;
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+	scsi_paths_proc_init();
+#endif
 #endif
 
         scsi_devfs_handle = devfs_mk_dir (NULL, "scsi", NULL);
@@ -2529,6 +2556,9 @@
 		kfree (shn2);
 
 #ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+	scsi_paths_proc_cleanup();
+#endif
 	/* No, we're not here anymore. Don't show the /proc/scsi files. */
 	remove_proc_entry ("scsi/scsi", 0);
 	remove_proc_entry ("scsi", 0);
@@ -2684,6 +2714,10 @@
         SCpnt->request = &req;
 	memset(&SCpnt->eh_timeout, 0, sizeof(SCpnt->eh_timeout));
 	scsi_get_path(dev, &scsi_path);
+	/*
+	 * XXX this is broken if we have multiple paths and we want to
+	 * reset the bus or the adapter on all paths to dev.
+	 */
 	SCpnt->host                    	= scsi_path.spi_shpnt;
 	SCpnt->device                  	= dev;
 	SCpnt->target                  	= scsi_path.spi_id;
diff -Nru a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/scsi.h	Mon Sep 16 16:11:26 2002
@@ -515,6 +515,10 @@
 			int timeout, int retries);
 extern int scsi_dev_init(void);
 
+/*
+ * The following is in scsi_paths.c or scsi_lib.c depending
+ * CONFIG_SCSI_MULTI_PATH_IO.
+ */
 extern int scsi_paths_proc_print_paths(Scsi_Device *SDpnt, char *buffer,
 				       char *format);
 
@@ -604,10 +608,14 @@
 	volatile unsigned short device_busy;	/* commands actually active on low-level */
 	Scsi_Cmnd *device_queue;	/* queue of SCSI Command structures */
         Scsi_Cmnd *current_cmnd;	/* currently active command */
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+ 	void	*sdev_paths;
+#else
 	struct Scsi_Host *host;
 	unsigned int channel;
 	unsigned int id;
 	unsigned int lun;
+#endif
 	unsigned int manufacturer;	/* Manufacturer of device, for using 
 					 * vendor-specific cmd's */
 	unsigned sector_size;	/* size in bytes */
@@ -1071,6 +1079,29 @@
         return (Scsi_Cmnd *)req->special;
 }
 
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+
+extern struct scsi_device *scsi_sdev_list;
+
+extern int scsi_paths_proc_init( void );
+extern void scsi_paths_proc_cleanup( void );
+extern struct Scsi_Host *scsi_get_host(Scsi_Device *SDpnt);
+extern int scsi_get_path(Scsi_Device *SDpnt, struct scsi_path_id *pathp);
+extern int scsi_get_best_path(Scsi_Device *SDpnt, struct scsi_path_id *pathp,
+			      struct request *);
+extern int scsi_path_decide_disposition(struct scsi_cmnd *);
+extern int scsi_add_path(Scsi_Device *SDpnt, struct Scsi_Host *shpnt,
+			 unsigned int channel, unsigned int dev,
+			 unsigned int lun);
+extern void  scsi_remove_path(Scsi_Device *SDpnt, unsigned int host_no,
+			      unsigned int channel, unsigned int dev,
+			      unsigned int lun);
+extern Scsi_Device *scsi_lookup_id(char *id, Scsi_Device *sdev);
+extern void scsi_replace_path(Scsi_Device *sdev, struct Scsi_Host *shost,
+	unsigned int channel, unsigned int id, unsigned int lun);
+
+#else
+
 static inline Scsi_Device *scsi_lookup_id(char *id, Scsi_Device *sdev)
 {
 	return(NULL);
@@ -1120,6 +1151,7 @@
 {
 	return UNKNOWN_ERROR;
 }
+#endif
 
 extern void scsi_paths_printk(Scsi_Device *SDpnt, char *prefix, char *format);
 #define scsi_path_set_scmnd_ids(scp, pathp) do {		 	\
diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/scsi_error.c	Mon Sep 16 16:11:26 2002
@@ -140,7 +140,17 @@
 int scsi_block_when_processing_errors(Scsi_Device *sdev)
 {
 
+#ifndef CONFIG_SCSI_MULTI_PATH_IO
+	/* 
+	 * If multi-path IO, to match this code, check in_recover of all
+	 * hosts on all paths on sdev; more easily delete this code, and
+	 * handle it like any other IO sent after in_recovery is set: skip
+	 * the request in scsi_request_fn(), and after error recovery
+	 * completes, the IO will be sent.
+	 */
 	SCSI_SLEEP(&sdev->host->host_wait, sdev->host->in_recovery);
+#endif
+
 	SCSI_LOG_ERROR_RECOVERY(5, printk("Open returning %d\n",
 					  sdev->online));
 
@@ -832,18 +842,18 @@
 		(DRIVER_TIMEOUT << 24);
 	if (scsi_path_decide_disposition(scmd) == REQUEUE) {
 		/*
-		 * Abort the command, and then requeue it.
-		 *
-		 * XXX If the abort is not possible, what do we do?
-		 * Probably should not retry. But, for example, qlogicfc.c
-		 * times out commands after a loop down, and the command
-		 * is no longer live; so the abort command always fails
-		 * after a loop down causes the command to timeout. This
-		 * is also a problem for the current error handling, since
-		 * it does not know if the command was not able to be
-		 * aborted, or if the command failed to abort because the
-		 * adapter no longer has it.
+		 * XXX Ideally, abort the command, and then requeue it.
+		 * The current adapter abort command (eh_abort_handler) is
+		 * optional, and is allowed to block, so it will not work
+		 * here. Since we need to effectively reuse scmd, and we
+		 * can't tell if it is still used by the adapter, the only
+		 * solution for now is to allow the standard error handler
+		 * to kick in and retry the command - with the current
+		 * error handling code, this means the command will likely
+		 * not be retried or even failed for quite a bit of time,
+		 * maybe minutes.
 		 */
+#ifdef WILL_NOT_WORK
 		(void)scsi_try_to_abort_cmd(scmd);
 		SCSI_LOG_TIMEOUT(3, 
 			printk("Requeuing timed out IO host %d channel %d id % d lun %d; result 0x%x\n",
@@ -851,6 +861,7 @@
 			       scmd->target, scmd->lun, scmd->result));
 		scsi_mlqueue_insert(scmd, SCSI_MLQUEUE_RETRY);
 		return;
+#endif
 	}
 
 	/* Set the serial_number_at_timeout to the current serial_number */
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/scsi_lib.c	Mon Sep 16 16:11:26 2002
@@ -47,6 +47,10 @@
 #include "hosts.h"
 #include <scsi/scsi_ioctl.h>
 
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+struct scsi_device *scsi_sdev_list;
+#endif
+
 /*
  * This entire source file deals with the new queueing code.
  */
@@ -708,6 +712,7 @@
 		spin_unlock_irqrestore(SHpnt->host_lock, flags);
 }
 
+#ifndef CONFIG_SCSI_MULTI_PATH_IO
 /*
  * Function:    scsi_get_best_path, not-multi-path IO version.
  *
@@ -745,6 +750,7 @@
 	pathpnt->spi_shpnt->host_busy++;
 	return 0;
 }
+#endif
 
 /*
  * Function:    scsi_request_fn()
@@ -1156,6 +1162,104 @@
 {
 }
 
+
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+/**
+ * scsi_lookup_id - Lookup a scsi device matching an id
+ * @id:	id terminated with '\0'
+ * @sdev_skip:	possibly NULL Scsi_Device to skip if matched
+ *
+ * Description:
+ * Look for a Scsi_Device matching *@id. Uses a linear search. If a
+ * matching Scsi_Device not equal to sdev_skip is found return a pointer
+ * to it, else return NULL.
+ *
+ * Notes:
+ * Change to use driverfs tree.
+ **/
+Scsi_Device *scsi_lookup_id(char *id, Scsi_Device *sdev_skip)
+{
+	Scsi_Device *sdev;
+	scsi_traverse_hndl_t strav_hndl;
+
+	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi: id '%s'", id));
+	if (id[0] != SCSI_UID_UNKNOWN)
+		scsi_for_all_sdevs(&strav_hndl, sdev) {
+			/*
+			 * Both id and name should be '\0' terminated.
+			 */
+			if ((sdev != sdev_skip) && 
+			    strcmp(sdev->sdev_driverfs_dev.name,
+				   (char *) id) == 0) {
+				SCSI_LOG_SCAN_BUS(3, printk("; found\n"));
+				return sdev;
+			}
+		}
+	SCSI_LOG_SCAN_BUS(3, printk("; no match\n"));
+	return NULL;
+}
+
+/*
+ * Function:    scsi_add_scsi_device()
+ *
+ * Purpose:     Add a SDpnt to the list of Scsi_Devices, add it to the
+ *		"tail" of the list. If needed, add it to the list for
+ *		shostpnt.
+ *
+ * Arguments:   Scsi_Device pointer SDpnt.
+ *
+ * Notes:       Doesn't do anything other than link in SDpnt, we should add
+ *		other code that is common to the addition of all Scsi_Devices.
+ */
+void scsi_add_scsi_device(Scsi_Device *SDpnt, struct Scsi_Host *shostpnt)
+{
+	Scsi_Device *sdtailpnt;
+
+	SDpnt->sdev_prev = NULL;
+	SDpnt->sdev_next = NULL;
+	if (scsi_sdev_list != NULL) {
+		sdtailpnt = scsi_sdev_list;
+		while (sdtailpnt->sdev_next != NULL)
+			sdtailpnt = sdtailpnt->sdev_next;
+		sdtailpnt->sdev_next = SDpnt;
+		SDpnt->sdev_prev = sdtailpnt;
+	} else
+		scsi_sdev_list = SDpnt;
+}
+
+/*
+ * Function:    scsi_remove_scsi_device
+ *
+ * Purpose:     Remove SDpnt from the list of Scsi_Devices.
+ *
+ * Arguments:   Scsi_Device pointer SDpnt.
+ *
+ * Notes:       unlink and kfree SDpnt, we should add other code that is common
+ * 		to removal of all Scsi_Devices.
+ */
+void scsi_remove_scsi_device(Scsi_Device *SDpnt)
+{
+	if (SDpnt == NULL)
+		return;
+	if (SDpnt->sdev_next != NULL)
+		SDpnt->sdev_next->sdev_prev = SDpnt->sdev_prev;
+	if (SDpnt->sdev_prev != NULL)
+		SDpnt->sdev_prev->sdev_next = SDpnt->sdev_next;
+	if (scsi_sdev_list == SDpnt)
+		scsi_sdev_list = SDpnt->sdev_next;
+	if (SDpnt->inquiry != NULL)
+		kfree(SDpnt->inquiry);
+	kfree((char *) SDpnt);
+}
+
+#else
+
+/*
+ * Non-multi-path-io versions, replacements for the above multi-path-io
+ * versions, plus replacements for non-inlined extern functions found in
+ * scsi_paths.c.
+ */
+
 /*
  * Function:    scsi_add_scsi_device
  *
@@ -1313,3 +1417,5 @@
 		      SDpnt->channel, SDpnt->id, SDpnt->lun));
 }
 #endif
+
+#endif /* CONFIG_SCSI_MULTI_PATH_IO */
diff -Nru a/drivers/scsi/scsi_paths.c b/drivers/scsi/scsi_paths.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/scsi/scsi_paths.c	Mon Sep 16 16:11:26 2002
@@ -0,0 +1,1486 @@
+/*
+ * Scsi Multi-path Support Library
+ *
+ * Copyright (c) 2002 IBM
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to patmans@us.ibm.com and/or andmike@us.ibm.com
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/blk.h>
+#include <linux/bio.h>
+#include <asm/uaccess.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "scsi_paths.h"
+
+#define	SCSI_PATHS_VERSION "Version: 0.04.00"
+
+#if defined (CONFIG_SCSI_PATH_POLICY_LPU)
+static enum scsi_path_policy scsi_path_dflt_path_policy = SCSI_PATH_POLICY_LPU;
+#elif defined (CONFIG_SCSI_PATH_POLICY_RR)
+static enum scsi_path_policy scsi_path_dflt_path_policy =
+    SCSI_PATH_POLICY_ROUND_ROBIN;
+#else
+#error "Unknown path selection policy"
+#endif
+
+#ifdef MODULE
+MODULE_PARM(scsi_path_dflt_path_policy, "i");
+MODULE_PARM_DESC(scsi_path_dflt_path_policy,
+	"path selection policy, Last Path Used = 1, Round Robin = 2");
+#else
+
+static int __init scsi_path_policy_setup(char *str)
+{
+	unsigned int tmp;
+
+	if (get_option(&str, &tmp) == 1) {
+		scsi_path_dflt_path_policy = tmp;
+		return 1;
+	} else {
+		printk(KERN_INFO "scsi_path_policy_setup: usage "
+		       "scsi_path_dflt_path_policy=n "
+		       "Last Path Used = 1, Round Robin = 2");
+		return 0;
+	}
+}
+
+__setup("scsi_path_dflt_path_policy=", scsi_path_policy_setup);
+
+#endif
+
+/*
+ * XXX audit and ensure that we have a lock whenver accessing any paths. 
+ */
+
+/**
+ * scsi_paths_printk - printk for each path using the specified format.
+ * @sdev: printk all paths of this Scsi_Device
+ * @prefix: prefix string
+ * @format: a printf format string
+ *
+ * Description: For each path on @sdev, printk the host/channel/id/lun
+ * using the specified @format. For all but the first printk, output
+ * @prefix before @format. @prefix must not be NULL, but can be an empty
+ * string; @prefix can and should include a level (such as KERN_INFO).
+ **/
+void scsi_paths_printk(Scsi_Device *sdev, char *prefix, char *format)
+{
+	struct list_head *lh;
+	struct scsi_mpath *mpath;
+	struct scsi_path *pathcur;
+	int not_first_path = 0;
+
+	if (sdev->sdev_paths != NULL) {
+		mpath = (struct scsi_mpath *) sdev->sdev_paths;
+		list_for_each(lh, &mpath->scsi_mp_paths_head) {
+			pathcur =
+			    list_entry(lh, struct scsi_path, sp_path_list);
+			if (not_first_path)
+				printk(prefix);
+			else
+				not_first_path = 1;
+			printk(format, pathcur->sp_path_id.spi_shpnt->host_no,
+			       pathcur->sp_path_id.spi_channel,
+			       pathcur->sp_path_id.spi_id,
+			       pathcur->sp_path_id.spi_lun);
+		}
+	} else
+		printk("no paths");
+}
+
+/**
+ * scsi_remove_path_from_list - remove a path from an active list
+ * @mpath: get an active list from here
+ * @oldpath:     path to remove
+ * @ind_active: remove from this last active list
+ *
+ * Description:
+ * Remove @oldpath from the active list @ind_active of @mpath. It is
+ * safe to call this function if path is not on the active list.
+ **/
+void scsi_remove_path_from_list(struct scsi_mpath *mpath,
+				struct scsi_path *oldpath, int ind_active)
+{
+	struct scsi_path *last_active;
+	struct scsi_path *pathcur;
+	int ind_next;
+
+	SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
+		"%s: path <%d, %d, %d, %d>, ind_active %d\n",
+		__FUNCTION__, oldpath->sp_path_id.spi_shpnt->host_no,
+		oldpath->sp_path_id.spi_id, oldpath->sp_path_id.spi_lun,
+		oldpath->sp_path_id.spi_channel, ind_active));
+
+	BUG_ON(ind_active >= SCSI_MAX_ACTIVE_LIST);
+	last_active = mpath->scsi_mp_last_active[ind_active];
+	if (last_active == NULL)
+		return;
+
+	if (ind_active == SCSI_PATHS_ALL_LIST) {
+		ind_next = SCSI_ALL_ACTIVE_NEXT_LIST;
+	} else {
+		ind_next = SCSI_NID_ACTIVE_NEXT_LIST;
+	}
+	pathcur = last_active;
+	do {
+		if (pathcur->sp_active_next[ind_next] == oldpath) {
+			if (pathcur == oldpath)
+				mpath->scsi_mp_last_active[ind_active] = NULL;
+			else {
+				pathcur->sp_active_next[ind_next] =
+				    oldpath->sp_active_next[ind_next];
+				if (last_active == oldpath)
+					mpath->scsi_mp_last_active[ind_active] =
+					    oldpath->sp_active_next[ind_next];
+			}
+			--mpath->scsi_mp_path_active_cnt[ind_active];
+			oldpath->sp_active_next[ind_next] = NULL;
+			return;
+		}
+		pathcur = pathcur->sp_active_next[ind_next];
+	} while (pathcur != last_active);
+}
+
+/**
+ * scsi_remove_active_path - Remove a path from all active lists
+ * @sdev:  Scsi_Device
+ * @oldpath: A scsi path
+ *
+ * Description:
+ * Remove @oldpath from the active lists of Scsi_Device @sdev. It is safe to
+ * call this function if path is not on the active list.
+ **/
+static void scsi_remove_active_path(Scsi_Device *sdev,
+				    struct scsi_path *oldpath)
+{
+	struct scsi_mpath *mpath;
+	int nid;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if (mpath == NULL)
+		return;
+
+	nid = scsihost_to_node(oldpath->sp_path_id.spi_shpnt);
+	scsi_remove_path_from_list(mpath, oldpath, nid);
+	if (nid != SCSI_PATHS_ALL_LIST)
+		/*
+		 * No CONFIG_NUMA
+		 */
+		scsi_remove_path_from_list(mpath, oldpath,
+					   SCSI_PATHS_ALL_LIST);
+}
+
+/**
+ * scsi_host_type_check - verify that the host-adapters are the same
+ * @host1 - the Scsi_Host pointer for the first adapter
+ * @host2 - the Scsi_Host pointer for the second adapter
+ *
+ * Description:
+ * Look at host pointers and check the values of certain fields,
+ * looking for incompatibilities that could cause problems.
+ *
+ * Return 1 if they don't match, 0 if they do.
+ **/
+static int scsi_host_type_check(struct Scsi_Host *host1,
+				struct Scsi_Host *host2)
+{
+	int ret = 0;
+
+	static const char message[] = {
+		KERN_WARNING "scsi: the parameter '%s' differs for two"
+			" adapters attached to the same device.\n"
+	};
+
+#define	CHECK_HOST_PARAMS(param) \
+	if (host1->param != host2->param) { \
+		printk(message, __stringify(param)); \
+		ret = 1; \
+	}
+
+	CHECK_HOST_PARAMS(hostt);
+	CHECK_HOST_PARAMS(sg_tablesize);
+	CHECK_HOST_PARAMS(max_sectors);
+	CHECK_HOST_PARAMS(highmem_io);
+	CHECK_HOST_PARAMS(unchecked_isa_dma);
+	CHECK_HOST_PARAMS(use_clustering);
+	CHECK_HOST_PARAMS(max_cmd_len);
+
+#undef CHECK_HOST_PARAMS
+
+	return ret;
+}
+
+/**
+ * scsi_add_active_path - Add a path to an active list
+ * @sdev:  Scsi_Device
+ * @pathcur: A scsi path
+ * @ind_active: index into the scsi_mp_last_active
+ * @ind_next:   index into the sp_active_next
+ *
+ * Description: Add @pathcur to the active list of Scsi_Device @sdev. It is
+ * safe to add a path that is already on the active list (the list will
+ * not be changed).
+ **/
+static void scsi_add_active_path(Scsi_Device *sdev, struct scsi_path *pathcur,
+				 int ind_active)
+{
+	struct scsi_mpath *mpath;
+	struct scsi_path *last_active;
+	int ind_next;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if (mpath == NULL)
+		return;
+	BUG_ON(ind_active >= SCSI_MAX_ACTIVE_LIST);
+	if (ind_active == SCSI_PATHS_ALL_LIST)
+		ind_next = SCSI_ALL_ACTIVE_NEXT_LIST;
+	else
+		ind_next = SCSI_NID_ACTIVE_NEXT_LIST;
+	if (pathcur->sp_active_next[ind_next] != NULL)
+		/*
+		 * The path is already on the active list.
+		 */
+		return;
+	else {
+		SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
+			"%s: sdev 0x%p, path <%d, %d, %d, %d> ind_active %d\n",
+			__FUNCTION__, sdev,
+			pathcur->sp_path_id.spi_shpnt->host_no,
+			pathcur->sp_path_id.spi_id,
+			pathcur->sp_path_id.spi_lun,
+			pathcur->sp_path_id.spi_channel, ind_active));
+
+		last_active = mpath->scsi_mp_last_active[ind_active];
+		if (last_active != NULL) {
+			pathcur->sp_active_next[ind_next] =
+				last_active->sp_active_next[ind_next];
+			last_active->sp_active_next[ind_next] = pathcur;
+		} else {
+			mpath->scsi_mp_last_active[ind_active] = pathcur;
+			pathcur->sp_active_next[ind_next] = pathcur;
+		}
+		++mpath->scsi_mp_path_active_cnt[ind_active];
+	}
+}
+
+/**
+ * scsi_add_path - Add a path to a scsi device
+ * @sdev:  Scsi_Device to add a path to
+ * @shost: Scsi_Host of the path
+ * @channel: Channel value of the path
+ * @id: Id value of the path
+ * @lun: Lun value of the path
+ *
+ * Description:
+ * Add a path corresponding to @shost, @channel, @id, and @lun to the
+ * Scsi_Device @sdev. The new path is also added to the active path. Must
+ * be called with user context (kmalloc GFP_KERNEL).
+ *
+ * Return 1 on error, 0 on success.
+ **/
+int scsi_add_path(Scsi_Device *sdev, struct Scsi_Host *shost,
+		  unsigned int channel, unsigned int id, unsigned int lun)
+{
+	struct scsi_mpath *mpath;
+	struct scsi_path *pathcur;
+	struct Scsi_Host *shostcur;
+	int i, nid;
+
+	SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
+		"%s: sdev 0x%p path: <%d, %d, %d, %d>\n", __FUNCTION__,
+		sdev, shost->host_no, channel, id, lun));
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+
+	pathcur = kmalloc(sizeof(*pathcur), GFP_KERNEL);
+	if (pathcur == NULL) {
+		printk(KERN_WARNING
+		       "%s: memory allocation failure.\n", __FUNCTION__);
+		return 1;
+	}
+	for (i = 0; i < SCSI_PATHS_MAX_PATH_LISTS; i++)
+		pathcur->sp_active_next[i] = NULL;
+	pathcur->sp_state = SCSI_PATH_STATE_GOOD;
+	pathcur->sp_failures = 0;
+	pathcur->sp_weight = 0;	/* lowest is best */
+	pathcur->sp_path_id.spi_shpnt = shost;
+	pathcur->sp_path_id.spi_id = id;
+	pathcur->sp_path_id.spi_lun = lun;
+	pathcur->sp_path_id.spi_channel = channel;
+
+	if (mpath == NULL) {
+		/*
+		 * First path.
+		 */
+		SCSI_LOG_SCAN_BUS(5, printk(KERN_INFO
+			"%s: adding first path\n", __FUNCTION__));
+		mpath = kmalloc(sizeof(*mpath), GFP_KERNEL);
+		if (mpath == NULL) {
+			printk(KERN_WARNING "%s: memory allocation failure.\n",
+			       __FUNCTION__);
+			kfree(pathcur);
+			return 1;
+		}
+		INIT_LIST_HEAD(&mpath->scsi_mp_paths_head);
+		mpath->scsi_mp_path_policy = scsi_path_dflt_path_policy;
+		for (i = 0; i < SCSI_MAX_ACTIVE_LIST; i++) {
+			mpath->scsi_mp_last_active[i] = NULL;
+			mpath->scsi_mp_path_active_cnt[i] = 0;
+		}
+		(struct scsi_mpath *) sdev->sdev_paths = mpath;
+	} else {
+		if (sdev->single_lun) {
+			printk(KERN_WARNING
+			       "scsi: Multi-path single LUN devices are not "
+			       "supported. path host %d chan %d id %d lun %d "
+			       "not added\n", shost->host_no, channel, id, lun);
+			kfree(pathcur);
+			return 1;
+		}
+		shostcur = scsi_get_host(sdev);
+		BUG_ON(shostcur == NULL);
+		if (scsi_host_type_check(shost, shostcur)) {
+			printk(KERN_ERR "scsi: path host %d chan %d id %d"
+			       " lun %d not added\n", shost->host_no, channel,
+			       id, lun);
+			kfree(pathcur);
+			return 1;
+		}
+		SCSI_LOG_SCAN_BUS(5, printk(KERN_INFO
+			"scsi: adding more paths\n"));
+	}
+
+	list_add_tail(&pathcur->sp_path_list, &mpath->scsi_mp_paths_head);
+	/*
+	 * Add the path to the all list, and possibly to a nid list.
+	 */
+	nid = scsihost_to_node(shost);
+	scsi_add_active_path(sdev, pathcur, nid);
+	if (nid != SCSI_PATHS_ALL_LIST)
+		/*
+		 * CONFIG_NUMA
+		 */
+		scsi_add_active_path(sdev, pathcur, SCSI_PATHS_ALL_LIST);
+
+	SCSI_LOG_SCAN_BUS(5, {
+			  printk(KERN_INFO "%s: All paths for sdev 0x%p:\n    ",
+				 __FUNCTION__, sdev);
+			  scsi_paths_printk(sdev, KERN_INFO "    ",
+					    "<%d, %d, %d, %d>\n");
+			  }
+	);
+	return 0;
+}
+
+/**
+ * scsi_remove_path - Remove a path from a scsi device
+ * @host_no: Host number of the path
+ * @channel: Channel value of the path
+ * @id: Id value of the path
+ * @lun: Lun value of the path
+ * @sdev:  Scsi_Device to add a path to
+ *
+ * Description:
+ * Remove the path corresponding to @host_no, @channel, @id, and @lun from
+ * the Scsi_Device @sdev. The path does not have to exist, so interfaces
+ * can wild card removal of all paths without first checking if any of the
+ * paths actually exist.
+ **/
+void scsi_remove_path(Scsi_Device *sdev, unsigned int host_no,
+		      unsigned int channel, unsigned int id, unsigned int lun)
+{
+	struct scsi_mpath *mpath;
+	struct list_head *lh, *tmplh;
+	struct scsi_path *pathcur;
+
+	SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
+		 "%s: sdev 0x%p path <%d, %d, %d, %d>\n", __FUNCTION__,
+		 sdev, host_no, channel, id, lun));
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if (mpath == NULL)
+		return;
+
+	/*
+	 * Look for a matching path, and remove it.
+	 *
+	 * XXX should be common code used by the scsi iterators.
+	 */
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	list_for_each_safe(lh, tmplh, &mpath->scsi_mp_paths_head) {
+		pathcur = list_entry(lh, struct scsi_path, sp_path_list);
+		if ((host_no == SCSI_FIND_ALL_HOST_NO ||
+		     host_no == pathcur->sp_path_id.spi_shpnt->host_no) &&
+		    (channel == SCSI_FIND_ALL_CHANNEL ||
+		     channel == pathcur->sp_path_id.spi_channel) &&
+		    (id == SCSI_FIND_ALL_ID ||
+		     id == pathcur->sp_path_id.spi_id) &&
+		    (lun == SCSI_FIND_ALL_LUN ||
+		     lun == pathcur->sp_path_id.spi_lun)) {
+			scsi_remove_active_path(sdev, pathcur);
+			list_del(&pathcur->sp_path_list);
+			kfree(pathcur);
+		}
+	}
+
+	if (list_empty(&mpath->scsi_mp_paths_head)) {
+		SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
+		    "%s: sdev 0x%p removed last path\n", __FUNCTION__, sdev));
+		kfree(mpath);
+		sdev->sdev_paths = NULL;
+	}
+	return;
+}
+
+/**
+ * scsi_replace_path - replace the current and only path to a Scsi_Device
+ * @sdev:  replace a path on this Scsi_Device
+ * @host_no: new host number
+ * @channel: new channel value
+ * @id: new id 
+ * @lun: new lun
+ *
+ * Description:
+ * Modify the one and only path on @sdev to use @host_no, @channel, @id,
+ * and @lun. This function is _only_ for use during scsi scan, where one
+ * sdev is used to scan an entire host. It is an optimization to avoid
+ * doing a scsi_remove_path and scsi_add_path for each LUN we want to
+ * scan.
+ **/
+void scsi_replace_path(Scsi_Device *sdev, struct Scsi_Host *shost,
+	unsigned int channel, unsigned int id, unsigned int lun)
+{
+	struct scsi_mpath *mpath;
+	struct scsi_path_id *pathid;
+	struct scsi_path *pathcur;
+	int nid;
+	struct list_head *lh;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	BUG_ON(mpath == NULL);
+	/*
+	 * There should be one and only one path for this sdev.
+	 */
+	list_for_each(lh, &mpath->scsi_mp_paths_head) {
+		pathcur = list_entry(lh, struct scsi_path, sp_path_list);
+		pathid = &pathcur->sp_path_id;
+		SCSI_LOG_SCAN_BUS(5, printk(KERN_INFO
+			 "%s: sdev* 0x%p replace <%d, %d, %d, %d> with"
+			 " <%d, %d, %d, %d>\n", __FUNCTION__, sdev,
+			 pathid->spi_shpnt->host_no, pathid->spi_channel,
+			 pathid->spi_id, pathid->spi_lun,
+			 shost->host_no, channel, id, lun));
+		pathid->spi_shpnt = shost;
+		pathid->spi_channel = channel;
+		pathid->spi_id = id;
+		pathid->spi_lun = lun;
+
+		/*
+		 * Make sure it is still an active path, in case previous
+		 * IO failed the path.
+		 */
+		nid = scsihost_to_node(pathcur->sp_path_id.spi_shpnt);
+		scsi_add_active_path(sdev, pathcur, nid);
+		if (nid != SCSI_PATHS_ALL_LIST)
+			/*
+			 * CONFIG_NUMA
+			 */
+			scsi_add_active_path(sdev, pathcur,
+				SCSI_PATHS_ALL_LIST);
+		return;
+	}
+	BUG();
+}
+
+/**
+ * scsi_get_host - get a Scsi_Host pointer to a Scsi_Device
+ *
+ * @sdev: Get the Scsi_Host of this Scsi_Device pointer
+ *
+ * Description:
+ * Return a pointer to a Scsi_Host so that the capabilities of the of the
+ * host driver can be determined; if no paths exist to sdev, return NULL.
+ *
+ * This should return some generic information rather than a Scsi_Host*.
+ * Alternatively (and probably even better) have one function for each
+ * value needed.
+ *
+ * This function assumes that all paths to a Scsi_Device use the same host
+ * driver - this is enforced during device scanning/discovery. This
+ * function must only be used to get capabilities or the template of the
+ * host - using it to set or get per-Scsi_Host (verus per-host driver)
+ * specific values is a bug (for example, using this to get a host pointer
+ * and then referencing host_busy).
+ **/
+struct Scsi_Host *scsi_get_host(Scsi_Device *sdev)
+{
+	struct scsi_path *pathcur;
+	struct list_head *lh;
+	struct scsi_mpath *mpath;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if (mpath == NULL)
+		return NULL;
+	list_for_each(lh, &mpath->scsi_mp_paths_head) {
+		pathcur = list_entry(lh, struct scsi_path, sp_path_list);
+		return pathcur->sp_path_id.spi_shpnt;
+	}
+	return NULL;
+}
+
+/**
+ * scsi_get_path - Get a path to a scsi device
+ * @sdev:  Scsi_Device
+ * @pathid: path id (tuple)
+ *
+ * Description:
+ * Get any @pathid to a Scsi_Device, used by semi-broken code that wants
+ * one host/channel/id/lun of a device. The path returned might not be
+ * active. Return 0 if a path is found, else return 1.
+ **/
+int scsi_get_path(Scsi_Device *sdev, struct scsi_path_id *pathid)
+{
+	struct scsi_path *pathcur;
+	struct scsi_mpath *mpath;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if (mpath == NULL)
+		return 1;
+	pathcur = list_entry(mpath->scsi_mp_paths_head.next, struct scsi_path,
+			     sp_path_list);
+	*pathid = pathcur->sp_path_id;
+	return 0;
+}
+
+/**
+ * scsi_path_traverse_sdevs - Return the next Scsi_Device matching the
+ * search requested
+ *
+ * @handle: Handle used to bookmark location of search thus far
+ * @host_no: Host to search for
+ * @channel: Channel to search for
+ * @id:	Id to search for
+ * @lun: Lun to search for
+ *
+ * Description:
+ * Returns - A pointer to Scsi_Device, NULL when the list is complete.
+ * Notes -  Assumes that we do not remove a device between calls.
+ **/
+Scsi_Device *scsi_traverse_sdevs(scsi_traverse_hndl_t *handle, uint
+				 host_no, uint channel, uint id, uint lun)
+{
+	Scsi_Device	*sdev;
+
+	if (handle == NULL)
+		/*
+		 * Really a locate and not a traversal.
+		 */
+		sdev = NULL;
+	else
+		sdev = handle->last_scsi_device_p;
+
+	if (sdev == NULL)
+		sdev = scsi_sdev_list;
+	else
+		sdev = sdev->sdev_next;
+
+	for (; sdev; sdev = sdev->sdev_next) {
+		if (sdev->sdev_paths != NULL) {
+			struct list_head *lh;
+			struct scsi_mpath *mpath_iopnt;
+			struct scsi_path *pathpnt;
+
+			mpath_iopnt = (struct scsi_mpath *) sdev->sdev_paths;
+			list_for_each(lh, &mpath_iopnt->scsi_mp_paths_head) {
+				pathpnt = list_entry(lh, struct scsi_path,
+						    sp_path_list);
+				if ((host_no == SCSI_FIND_ALL_HOST_NO ||
+				   host_no == pathpnt->sp_path_id.spi_shpnt->host_no ) &&
+				   (channel == SCSI_FIND_ALL_CHANNEL ||
+				   channel == pathpnt->sp_path_id.spi_channel ) &&
+				   (id == SCSI_FIND_ALL_ID ||
+				   id == pathpnt->sp_path_id.spi_id ) &&
+				   (lun == SCSI_FIND_ALL_LUN ||
+				   lun == pathpnt->sp_path_id.spi_lun )) {
+					goto done;
+				}
+			}
+		}
+	}
+
+done:
+	if (handle)
+		handle->last_scsi_device_p = sdev;
+	return sdev;
+}
+
+/**
+ * scsi_get_best_path - Get a path for a scsi device.
+ * @sdev:  Scsi_Device
+ * @pathid: A scsi path id (tuple)
+ * @req: request for NUMA so the node closest to req can be found
+ *
+ * Description:
+ * This code is used for normal IO. Get a @pathid for Scsi_Device @sdev.
+ * Skip paths on a busy or blocked host, mark hosts and devices as starved
+ * if needed. Return 2 if no paths at all, 1 if resources are busy, 0 if a
+ * path is found.
+ **/
+int scsi_get_best_path(Scsi_Device *sdev, struct scsi_path_id *pathid,
+		       struct request *req)
+{
+	struct scsi_path *pathcur, *first_path;
+	struct scsi_mpath *mpath;
+	struct Scsi_Host *shost;
+	request_queue_t *q;
+	int found_path, starving, ind_active, ind_next;
+	unsigned long flags = 0;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if ((mpath == NULL) || 
+	    (mpath->scsi_mp_last_active[SCSI_PATHS_ALL_LIST] == NULL)) {
+		/*
+		 * No paths or no active paths available.
+		 *
+		 * XXX Fix the following message to include a device name or ?
+		 */
+		printk(KERN_WARNING
+		       "scsi: No active paths available Scsi_Device 0x%p.\n",
+		       sdev);
+		return 2;
+	}
+
+	ind_active = req_to_nid(req);
+#if (MAX_NUMNODES != 1)
+	/*
+	 * If MAX_NUMNODES is 1, not NUMA, and the following check is not
+	 * needed.
+	 */
+	if (ind_active <= MAX_NUMNODES)
+		if (mpath->scsi_mp_last_active[ind_active] == NULL)
+			ind_active = SCSI_PATHS_ALL_LIST;
+#endif
+	first_path = pathcur = mpath->scsi_mp_last_active[ind_active];
+	BUG_ON(ind_active >= SCSI_MAX_ACTIVE_LIST);
+	if (ind_active == SCSI_PATHS_ALL_LIST)
+		ind_next = SCSI_ALL_ACTIVE_NEXT_LIST;
+	else
+		ind_next = SCSI_NID_ACTIVE_NEXT_LIST;
+	found_path = 0;
+	starving = 0;
+	do {
+		shost = pathcur->sp_path_id.spi_shpnt;
+		/*
+		 * XXX hack: host_lock might not equal queue_lock for
+		 * multi-path, or if code is changed. We already hold
+		 * queue_lock.
+		 */
+		q = &sdev->request_queue;
+		if (shost->host_lock != q->queue_lock)
+			spin_lock_irqsave(shost->host_lock, flags);
+		if (!shost->in_recovery) {
+			if ((shost->can_queue > 0 && 
+			     (shost->host_busy >= shost->can_queue))
+			    || (shost->host_blocked)
+			    || (shost->host_self_blocked)) {
+				if (sdev->device_busy == 0) {
+					starving = 1;
+				}
+			} else {
+				found_path = 1;
+				starving = 0;
+				/* do not unlock host shost */
+				break;
+			}
+		}
+		if (shost->host_lock != q->queue_lock)
+			spin_unlock_irqrestore(shost->host_lock, flags);
+		if (mpath->scsi_mp_path_policy != SCSI_PATH_POLICY_LPU)
+			pathcur = pathcur->sp_active_next[ind_next];
+	} while (first_path != pathcur);
+
+	if (starving) {
+		/*
+		 * For now, wait for the local node (or all paths) to get a
+		 * free slot. This means NUMA systems might have a path
+		 * available on a non-local node, but we do not try and
+		 * use it. A hung device should eventually cause
+		 * the local paths to fail, and then the non-local paths
+		 * would be used for futher IO.
+		 *
+		 * All available hosts (on all paths) are busy, and sdev
+		 * is starved. Mark all hosts as having a starved device.
+		 *
+		 * It would be better to put starved devices on a list,
+		 * rather than set a flag.
+		 */
+		sdev->starved = 1;
+		pathcur = first_path = mpath->scsi_mp_last_active[ind_active];
+		do {
+			if (shost->host_lock != q->queue_lock)
+				spin_lock_irqsave(shost->host_lock, flags);
+			shost->some_device_starved = 1;
+			if (shost->host_lock != q->queue_lock)
+				spin_unlock_irqrestore(shost->host_lock, flags);
+			pathcur = pathcur->sp_active_next[ind_next];
+		} while (first_path != pathcur);
+		return 1;
+	} else if (found_path) {
+		sdev->starved = 0;
+		shost->host_busy++;
+		if (shost->host_lock != q->queue_lock)
+			spin_unlock_irqrestore(shost->host_lock, flags);
+	} else
+		/*
+		 * All available hosts (on all paths) are busy, and sdev
+		 * is *not* starved.
+		 */
+		return 1;
+
+	if (mpath->scsi_mp_path_policy == SCSI_PATH_POLICY_ROUND_ROBIN)
+		/*
+		 * This actually sets scsi_mp_last_active[ind_active] to the next
+		 * path to be used, not the last path used.
+		 */
+		mpath->scsi_mp_last_active[ind_active] =
+		    mpath->scsi_mp_last_active[ind_active]->sp_active_next[ind_next];
+	else if (mpath->scsi_mp_path_policy != SCSI_PATH_POLICY_LPU) {
+		printk(KERN_ERR
+		       "%s: invalid scsi_mp_path_policy %d\n", __FUNCTION__,
+		       mpath->scsi_mp_path_policy);
+		return 1;
+	}
+
+	BUG_ON(pathcur->sp_state == SCSI_PATH_STATE_DEAD);
+	*pathid = pathcur->sp_path_id;
+	return 0;
+}
+
+/**
+ * scsi_check_paths - Check a path in a scsi device.
+ * @path_state: Path state to upate paths with
+ * @check_path: Paths to match
+ * @sdev:  Scsi_Device
+ *
+ * Description:
+ * For the paths in @sdev that match path_list_p, update its path state,
+ * and return a value based on the remaining available paths and the
+ * path_state argument. Called for every IO completion.
+ *
+ * XXX optimize so that the normal case (IO completed with no errors)
+ * requires no searching of all paths. Do this by caching if any paths are
+ * failing, and by caching paths_left. So, for an IO with no errors, the
+ * only time we have to search the paths is when there are any paths failing.
+ *
+ * This function currently allows wild carding of paths on @sdev, so all paths
+ * can be marked failing/failed or good
+ *
+ * Returns REQUEUE (redrive the IO) if any paths are left, else returns
+ * SUCCESS (meaning the IO completed, not that it was successful).
+ **/
+static int scsi_check_paths(enum scsi_path_state path_state,
+			    struct scsi_path_id *check_path,
+			    Scsi_Cmnd *scmd)
+{
+	struct scsi_path *pathcur;
+	struct list_head *lh;
+	struct scsi_mpath *mpath;
+	unsigned int paths_left;
+	Scsi_Device *sdev = scmd->device;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if ((mpath == NULL) || (sdev->scanning &&
+				(path_state != SCSI_PATH_STATE_GOOD)))
+		/*
+		 * IO should not be retried.
+		 */
+		return SUCCESS;
+	paths_left = 0;
+	list_for_each(lh, &mpath->scsi_mp_paths_head) {
+		pathcur = list_entry(lh, struct scsi_path, sp_path_list);
+		if ((check_path->spi_shpnt->host_no ==
+		     SCSI_FIND_ALL_HOST_NO
+		     || check_path->spi_shpnt->host_no ==
+		     pathcur->sp_path_id.spi_shpnt->host_no)
+		    && (check_path->spi_channel ==
+			SCSI_FIND_ALL_CHANNEL
+			|| check_path->spi_channel ==
+			pathcur->sp_path_id.spi_channel)
+		    && (check_path->spi_id == SCSI_FIND_ALL_ID
+			|| check_path->spi_id == pathcur->sp_path_id.spi_id)
+		    && (check_path->spi_lun == SCSI_FIND_ALL_LUN
+			|| check_path->spi_lun ==
+			pathcur->sp_path_id.spi_lun)) {
+			if (path_state == SCSI_PATH_STATE_GOOD) {
+				/*
+				 * Nothing for now - but this could be
+				 * used to decrement or reset sp_failures.
+				 */
+			} else if (path_state == SCSI_PATH_STATE_FAILING) {
+				pathcur->sp_failures++;
+				if (pathcur->sp_failures > 0) {
+					/*
+					 * For now, treat a possibly failing
+					 * path as a dead path.
+					 */
+					pathcur->sp_state = SCSI_PATH_STATE_DEAD;
+					scsi_remove_active_path(sdev, pathcur);
+					printk(KERN_ERR "scsi: result 0x%x caused path host %d"
+					       " channel %d id %d lun %d failure\n",
+					       scmd->result, 
+					       pathcur->sp_path_id.spi_shpnt->host_no,
+					       pathcur->sp_path_id.spi_channel, 
+					       pathcur->sp_path_id.spi_id, 
+					       pathcur->sp_path_id.spi_lun);
+				}
+			} else if (path_state == SCSI_PATH_STATE_DEAD) {
+				pathcur->sp_state = SCSI_PATH_STATE_DEAD;
+				scsi_remove_active_path(sdev, pathcur);
+				printk(KERN_ERR "scsi: result 0x%x caused path host %d"
+				       " channel %d id %d lun %d failure\n",
+				       scmd->result, 
+				       pathcur->sp_path_id.spi_shpnt->host_no,
+				       pathcur->sp_path_id.spi_channel, 
+				       pathcur->sp_path_id.spi_id, 
+				       pathcur->sp_path_id.spi_lun);
+			} else
+				BUG();
+		}
+		if (pathcur->sp_state == SCSI_PATH_STATE_GOOD)
+			paths_left++;
+	}
+	if (paths_left > 0)
+		return REQUEUE;
+	else
+		return SUCCESS;
+}
+
+/**
+ * scsi_path_decide_disposition - Check the result of a scsi command
+ * @scmd: Scsi command
+ *
+ * Description:
+ * Check the result of @scmd, and determine how to procede. This code is
+ * based on scsi_decide_disposition, and should really just replace
+ * scsi_decide_disposition.
+ **/
+int scsi_path_decide_disposition(Scsi_Cmnd *scmd)
+{
+	int rtn;
+	struct scsi_path_id pathid;
+
+	pathid.spi_shpnt = scmd->host;
+	pathid.spi_channel = scmd->channel;
+	pathid.spi_id = scmd->target;
+	pathid.spi_lun = scmd->lun;
+	/*
+	 * First check the host byte, to see if there is anything in there
+	 * that would indicate what we need to do.
+	 */
+	switch (host_byte(scmd->result)) {
+	case DID_PASSTHROUGH:
+		/*
+		 * No matter what, pass this through to the upper layer.
+		 * Nuke this special code so that it looks like we are saying
+		 * DID_OK.
+		 */
+		scmd->result &= 0xff00ffff;
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return SUCCESS;
+	case DID_OK:
+		/*
+		 * Looks good.  Drop through, and check the next byte.
+		 */
+		break;
+	case DID_NO_CONNECT:
+	case DID_BAD_TARGET:
+	case DID_ABORT:
+		/*
+		 * Assumes the IO could not have made it to the device.
+		 */
+		rtn = scsi_check_paths(SCSI_PATH_STATE_DEAD, &pathid, scmd);
+		return rtn;
+		/*
+		 * When the low level driver returns DID_SOFT_ERROR,
+		 * it is responsible for keeping an internal retry counter
+		 * in order to avoid endless loops (DB)
+		 *
+		 * Actually this is a bug in this function here.  We should
+		 * be mindful of the maximum number of retries specified
+		 * and not get stuck in a loop.
+		 */
+	case DID_SOFT_ERROR:
+		/*
+		 * Assumes the IO might have made it out to the device.
+		 */
+		goto maybe_retry;
+
+	case DID_ERROR:
+		if (msg_byte(scmd->result) == COMMAND_COMPLETE &&
+		    status_byte(scmd->result) == RESERVATION_CONFLICT)
+			/*
+			 * execute reservation conflict processing code
+			 * lower down
+			 */
+			break;
+		/* FALLTHROUGH */
+
+	case DID_BUS_BUSY:
+	case DID_PARITY:
+		/*
+		 * XXX set path to SCSI_PATH_STATE_FAILING?
+		 */
+		goto maybe_retry;
+	case DID_TIME_OUT:
+		/*
+		   * When we scan the bus, we get timeout messages for
+		   * these commands if there is no device available.
+		   * Other hosts report DID_NO_CONNECT for the same thing.
+		 */
+		if ((scmd->cmnd[0] == TEST_UNIT_READY ||
+		     scmd->cmnd[0] == INQUIRY)) {
+			/*
+			 * XXX check the sdev->scanning bit, return
+			 * success if it is set. TUR's should no longer be
+			 * a problem.
+			 */
+			(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid,
+						scmd);
+			return SUCCESS;
+		} else {
+			rtn = scsi_check_paths(SCSI_PATH_STATE_FAILING, &pathid,
+					       scmd);
+			if (rtn == REQUEUE)
+				/*
+				 * XXX could cause scsi_check_paths to
+				 * incorrectly be called again.
+				 */
+				goto maybe_retry;
+			else
+				return FAILED;
+		}
+	case DID_RESET:
+		/*
+		 * In the normal case where we haven't initiated a reset, this is
+		 * a failure.
+		 */
+		if (scmd->flags & IS_RESETTING) {
+			scmd->flags &= ~IS_RESETTING;
+			goto maybe_retry;
+		}
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return SUCCESS;
+	default:
+		/*
+		 * Bug?
+		 */
+		return FAILED;
+	}
+
+	/*
+	 * Next, check the message byte.
+	 */
+	if (msg_byte(scmd->result) != COMMAND_COMPLETE) {
+		/*
+		 * XXX Use SCSI_PATH_DEAD or SCSI_PATH_FAILING?
+		 *
+		 * FIXME this is a bug - don't requeue if scmd->allowed is 0.
+		 */
+		rtn = scsi_check_paths(SCSI_PATH_STATE_DEAD, &pathid, scmd);
+		return rtn;
+	}
+	/*
+	 * Now, check the status byte to see if this indicates anything special.
+	 */
+	switch (status_byte(scmd->result)) {
+	case QUEUE_FULL:
+		/*
+		 * The case of trying to send too many commands to a tagged
+		 * queueing device.
+		 *
+		 * XXX this is broken for shared (clustered) devices even
+		 * without multi-path IO, since the requeue marks a device
+		 * blocked - if another host keeps filling the device, we
+		 * might not ever unblock. Plus, code is broken if we
+		 * have only one command outstanding - conditional check
+		 * for ADD_TO_MLQUEUE is bad.
+		 */
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return ADD_TO_MLQUEUE;
+	case GOOD:
+	case COMMAND_TERMINATED:
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return SUCCESS;
+	case CHECK_CONDITION:
+		rtn = scsi_check_sense(scmd);
+		if (rtn == NEEDS_RETRY)
+			goto maybe_retry;
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return rtn;
+	case CONDITION_GOOD:
+	case INTERMEDIATE_GOOD:
+	case INTERMEDIATE_C_GOOD:
+		/*
+		 * Who knows?  FIXME(eric)
+		 */
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return SUCCESS;
+	case BUSY:
+		goto maybe_retry;
+
+	case RESERVATION_CONFLICT:
+		printk(KERN_ERR "scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n",
+		       scmd->host->host_no, scmd->channel,
+		       scmd->target, scmd->lun);
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return SUCCESS; /* causes immediate I/O error */
+	default:
+		(void) scsi_check_paths(SCSI_PATH_STATE_DEAD, &pathid, scmd);
+		return FAILED;
+	}
+	/*
+	 * Dead code.
+	 */
+	return FAILED;
+
+      maybe_retry:
+
+	if (scmd->allowed == 0)
+		/*
+		 * No retries for this command, normal for tape (st) commands.
+		 */
+		return SUCCESS;
+
+	/*
+	 * XXX have scsi_check_paths increment the scmd->retries, and
+	 * set return value as needed? Right now, we can retry forever for
+	 * cases such as a CHECK_CONDITION.
+	 *
+	 * If all paths are going to get the same CHECK_CONDITION, it
+	 * would be good to retry some number of times on each path, or
+	 * have a life-time of the IO limit the number of retries, rather
+	 * than a fixed number of retries independent of the number of
+	 * paths and the time taken to send the incomplete IO.
+	 */
+	return scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+}
+
+#ifdef CONFIG_PROC_FS
+
+/*
+ * FIXME Add locking to protect paths access via /proc. 
+ */
+
+/*
+ * FIXME: generally, use driverfs for attributes rather than procfs.
+ */
+
+/**
+ * scsi_paths_modify - modify a path of a Scsi_Device.
+ *
+ * @sdev:  Scsi_Device pointer to the device whose path is being
+ * modified.
+ * @host_no: Host number of path
+ * @channel: Channel value for lookup
+ * @dev: Id value for lookup
+ * @lun: Lun value for lookup
+ * @new_state: New value for the path's sp_state
+ * @new_failures: New value for the path's sp_failures count
+ * @new_weight: New value for the path's sp_weight
+ *
+ * Description:
+ * For @sdev, modify any path matching the path id with the new values
+ * passed. This is currently only used by the proc interface, but is
+ * likely useful for any user level interface (sysctl or ioctl).
+ **/
+static void scsi_paths_modify(Scsi_Device *sdev, unsigned int host_no,
+			      unsigned int channel, unsigned int id,
+			      unsigned int lun, enum scsi_path_state new_state,
+			      unsigned int new_failures,
+			      unsigned int new_weight)
+{
+	struct scsi_mpath *mpath;
+	struct list_head *lh;
+	struct scsi_path *pathcur;
+	unsigned int prev_path_state;
+
+	if ((sdev == NULL) || (sdev->sdev_paths == NULL))
+		return;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	list_for_each(lh, &mpath->scsi_mp_paths_head) {
+		pathcur = list_entry(lh, struct scsi_path, sp_path_list);
+		if ((host_no == SCSI_FIND_ALL_HOST_NO ||
+		     host_no == pathcur->sp_path_id.spi_shpnt->host_no) &&
+		    (channel == SCSI_FIND_ALL_CHANNEL ||
+		     channel == pathcur->sp_path_id.spi_channel) &&
+		    (id == SCSI_FIND_ALL_ID ||
+		     id == pathcur->sp_path_id.spi_id) &&
+		    (lun == SCSI_FIND_ALL_LUN ||
+		     lun == pathcur->sp_path_id.spi_lun)) {
+			prev_path_state = pathcur->sp_state;
+			pathcur->sp_state = new_state;
+			if (prev_path_state != new_state) {
+				if (new_state == SCSI_PATH_STATE_GOOD) {
+					int nid;
+
+					printk(KERN_WARNING "scsi: setting path host %d"
+					       " channel %d id %d lun %d"
+					       " to good\n",
+					       pathcur->sp_path_id.spi_shpnt->host_no,
+					       pathcur->sp_path_id.spi_channel, 
+					       pathcur->sp_path_id.spi_id, 
+					       pathcur->sp_path_id.spi_lun);
+					nid = scsihost_to_node(pathcur->sp_path_id.spi_shpnt);
+					scsi_add_active_path(sdev, pathcur,
+							     nid);
+					if (nid != SCSI_PATHS_ALL_LIST)
+						/*
+						 * CONFIG_NUMA
+						 */
+						scsi_add_active_path(sdev,
+							pathcur,
+							SCSI_PATHS_ALL_LIST);
+				} else if (new_state == SCSI_PATH_STATE_FAILING) {
+					/*
+					 * XXX handle failing case.
+					 */
+					printk(KERN_WARNING "scsi: setting path host %d"
+					       " channel %d id %d lun %d"
+					       " to failing\n",
+					       pathcur->sp_path_id.spi_shpnt->host_no,
+					       pathcur->sp_path_id.spi_channel, 
+					       pathcur->sp_path_id.spi_id, 
+					       pathcur->sp_path_id.spi_lun);
+					scsi_remove_active_path(sdev, pathcur);
+				} else {
+					/*
+					 * SCSI_PATH_STATE_DEAD
+					 */
+					printk(KERN_WARNING "scsi: setting path host %d"
+					       " channel %d id %d lun %d"
+					       " to failed\n",
+					       pathcur->sp_path_id.spi_shpnt->host_no,
+					       pathcur->sp_path_id.spi_channel, 
+					       pathcur->sp_path_id.spi_id, 
+					       pathcur->sp_path_id.spi_lun);
+					scsi_remove_active_path(sdev, pathcur);
+				}
+			}
+			if (pathcur->sp_failures != new_failures) {
+				pathcur->sp_failures = new_failures;
+				/*
+				 * XXX handle failing case
+				 */
+			}
+			if (pathcur->sp_weight != new_weight) {
+				pathcur->sp_weight = new_weight;
+				/*
+				 * XXX call a function to re-check active
+				 * paths.
+				 */
+			}
+		}
+	}
+}
+
+#include <linux/proc_fs.h>
+static struct proc_dir_entry *scsi_paths_proc_mpp = NULL;
+static const char *scsi_paths_proc_dirname = "scsi_path";
+static const char *scsi_paths_proc_leaf_names[] = { "paths", "version" };
+
+static int scsi_paths_proc_paths_read(char *buffer, char **start, off_t offset,
+				      int size, int *eof, void *data);
+static int scsi_paths_proc_paths_write(struct file *filp, const char *buffer,
+				       unsigned long count, void *data);
+static int scsi_paths_proc_version_read(char *buffer, char **start,
+					off_t offset, int size, int *eof,
+					void *data);
+static read_proc_t *scsi_paths_proc_leaf_reads[] = {
+	scsi_paths_proc_paths_read,
+	scsi_paths_proc_version_read
+};
+
+static write_proc_t *scsi_paths_proc_leaf_writes[] = {
+	scsi_paths_proc_paths_write,
+	NULL			/* version write */
+};
+
+/*
+ * These two macros where copied from
+ * Douglas Gilbert's sg.c
+ */
+#define PRINT_PROC(fmt,args...)                                 \
+    do {                                                        \
+	*len += sprintf(buffer + *len, fmt, ##args);            \
+	if (*begin + *len > offset + size)                      \
+		return 0;                                       \
+	if (*begin + *len < offset) {                           \
+		*begin += *len;                                 \
+		*len = 0;                                       \
+	}                                                       \
+    } while(0)
+
+#define SP_PROC_READ_FN(infofp)                                 \
+    do {                                                        \
+	int len = 0;                                            \
+	off_t begin = 0;                                        \
+	*eof = infofp(buffer, &len, &begin, offset, size);      \
+	if (offset >= (begin + len))                            \
+		return 0;                                       \
+	*start = buffer + offset - begin;                       \
+	return (size < (begin + len - offset)) ?                \
+				size : begin + len - offset;    \
+    } while(0)
+
+int scsi_paths_proc_init(void)
+{
+	int k, mask;
+	int leaves = sizeof(scsi_paths_proc_leaf_names) /
+	    sizeof(scsi_paths_proc_leaf_names[0]);
+	struct proc_dir_entry *pdep;
+
+	if (!proc_scsi)
+		return 1;
+	scsi_paths_proc_mpp = create_proc_entry(scsi_paths_proc_dirname,
+						S_IFDIR | S_IRUGO | S_IXUGO,
+						proc_scsi);
+	if (!scsi_paths_proc_mpp)
+		return 1;
+	for (k = 0; k < leaves; k++) {
+		mask = scsi_paths_proc_leaf_writes[k] ? S_IRUGO | S_IWUSR :
+		    S_IRUGO;
+		pdep = create_proc_entry(scsi_paths_proc_leaf_names[k], mask,
+					 scsi_paths_proc_mpp);
+		if (pdep) {
+			pdep->read_proc = scsi_paths_proc_leaf_reads[k];
+			/*
+			 * scsi_paths_proc_leaf_writes[k] can be NULL.
+			 */
+			pdep->write_proc = scsi_paths_proc_leaf_writes[k];
+		}
+	}
+
+	return 0;
+}
+
+void scsi_paths_proc_cleanup(void)
+{
+	int k;
+	int leaves =
+	    sizeof(scsi_paths_proc_leaf_names) /
+	    sizeof(scsi_paths_proc_leaf_names[0]);
+
+	if ((!proc_scsi) || (!scsi_paths_proc_mpp))
+		return;
+	for (k = 0; k < leaves; ++k)
+		remove_proc_entry(scsi_paths_proc_leaf_names[k],
+				  scsi_paths_proc_mpp);
+	remove_proc_entry(scsi_paths_proc_dirname, proc_scsi);
+}
+
+int scsi_paths_proc_print_paths(Scsi_Device *sdev, char *buffer,
+				char *format)
+{
+	int len = 0;
+	struct list_head *lh;
+	struct scsi_mpath *mpath;
+	struct scsi_path *pathcur;
+
+	if (sdev->sdev_paths != NULL) {
+		mpath = (struct scsi_mpath *) sdev->sdev_paths;
+		list_for_each(lh, &mpath->scsi_mp_paths_head) {
+			pathcur =
+			    list_entry(lh, struct scsi_path, sp_path_list);
+			len += sprintf(buffer + len, format,
+				    pathcur->sp_path_id.spi_shpnt->host_no,
+				    pathcur->sp_path_id.spi_channel,
+				    pathcur->sp_path_id.spi_id,
+				    pathcur->sp_path_id.spi_lun);
+		}
+	}
+	return len;
+}
+
+static int scsi_paths_proc_paths_info(char * buffer, int * len, off_t * begin,
+				      off_t offset, int size)
+{
+	Scsi_Device *sdev;
+	scsi_traverse_hndl_t STrav_hndl;
+
+	scsi_for_all_sdevs(&STrav_hndl, sdev) {
+		if (sdev->sdev_paths != NULL) {
+			struct list_head *lh;
+			struct scsi_mpath *mpath;
+			struct scsi_path *pathcur;
+
+			/*
+			 * For each path of each device, display:
+			 *
+			 * name:host_no:chan:id:lun:state:failures:weight
+			 *
+			 * The name can now includes spaces, so add a ':'
+			 * separator.
+			 */
+			mpath = (struct scsi_mpath *) sdev->sdev_paths;
+			list_for_each(lh, &mpath->scsi_mp_paths_head) {
+				pathcur = list_entry(lh, struct scsi_path,
+					       sp_path_list);
+				PRINT_PROC("%s", sdev->sdev_driverfs_dev.name);
+				PRINT_PROC(":%x:%x:%x:%x:%x:%x:%x\n",
+					   pathcur->sp_path_id.spi_shpnt->
+					   host_no,
+					   pathcur->sp_path_id.spi_channel,
+					   pathcur->sp_path_id.spi_id,
+					   pathcur->sp_path_id.spi_lun,
+					   pathcur->sp_state,
+					   pathcur->sp_failures,
+					   pathcur->sp_weight);
+			}
+		}
+	}
+
+	return 1;
+}
+
+static int scsi_paths_proc_paths_read(char * buffer, char ** start,
+				      off_t offset, int size, int * eof,
+				      void * data)
+{
+	SP_PROC_READ_FN(scsi_paths_proc_paths_info);
+}
+
+static int scsi_paths_proc_paths_write(struct file *filp, const char *buffer,
+				       unsigned long count, void *data)
+{
+	int res;
+	unsigned int host_no, channel, id, lun;
+	unsigned int path_failures, path_weight;
+	enum scsi_path_state path_state;
+	unsigned char *buff_in = NULL;
+	unsigned char *name_id = NULL;
+	unsigned char *ch_in, *ch_out;
+	Scsi_Device *sdev;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	/* 
+	 * We need one more byte for the '\0'
+	 */
+	buff_in = kmalloc(count + 1, GFP_KERNEL); 
+	if (buff_in == NULL) {
+		printk(KERN_WARNING "%s: could not malloc\n", __FUNCTION__);
+		count = -ENOMEM;
+		goto done;
+	}
+	name_id = kmalloc(count + 1, GFP_KERNEL); 
+	if (name_id == NULL) {
+		printk(KERN_WARNING "%s: could not malloc\n", __FUNCTION__);
+		count = -ENOMEM;
+		goto done;
+	}
+	name_id[0] = '\0';
+
+	if (copy_from_user(buff_in, buffer, count)) {
+		count = -EFAULT;
+		goto done;
+	}
+	buff_in[count] = '\0';
+
+	/*
+	 * For now, only support path state modification by passing in a
+	 * long string. The input string must be 8 values of the form:
+	 *
+	 * name_id:host_no:chan:id:lun:path_state:path_failures:path_weight
+	 *
+	 * name_id is an ASCII string, each of the other values must be hex.
+	 *
+	 * For driverfs, maybe have each path have a field for each value of
+	 * interest; this might be a bit execessive, as we will have (at
+	 * least) 3 values for each path for each device, more if we also
+	 * want to display non-writable values. For example, with 8 paths,
+	 * this is 24 values per Scsi_Device; with 100 Scsi_Devices, this
+	 * is 800 values (just path attributes).
+	 */
+
+	/*
+	 * Since sscanf stops parsing at a space character, pull out the
+	 * name_id first.
+	 */
+	ch_in = buff_in;
+	ch_out = name_id;
+	while (*ch_in != '\0' && *ch_in != ':')
+		*ch_out++ = *ch_in++;
+	*ch_out = '\0';
+
+	if (*ch_in == '\0') {
+		/*
+		 * No ':' at all.
+		 */
+		count = -EINVAL;
+		goto done;
+	}
+
+	res = sscanf(ch_in, ":%x:%x:%x:%x:%x:%x:%x", &host_no, &channel, &id,
+		     &lun, (unsigned int *) &path_state, &path_failures,
+		     &path_weight);
+	if ((res != 7) || ((path_state != SCSI_PATH_STATE_GOOD) &&
+	    (path_state != SCSI_PATH_STATE_FAILING) &&
+	    (path_state != SCSI_PATH_STATE_DEAD))) {
+		count = -EINVAL;
+		goto done;
+	}
+
+	sdev = scsi_lookup_id(name_id, NULL);
+	if (sdev != NULL) 
+		scsi_paths_modify(sdev, host_no, channel, id, lun, path_state,
+				  path_failures, path_weight);
+
+  done:
+	if (buff_in != NULL) 
+		kfree(buff_in);
+	if (name_id != NULL) 
+		kfree(name_id);
+	return count;
+}
+
+static int scsi_paths_proc_version_info(char *buffer, int *len, off_t *begin,
+					off_t offset, int size)
+{
+	PRINT_PROC("%s\n", SCSI_PATHS_VERSION);
+	return 1;
+}
+
+static int scsi_paths_proc_version_read(char *buffer, char **start,
+					off_t offset, int size, int *eof,
+					void *data)
+{
+	SP_PROC_READ_FN(scsi_paths_proc_version_info);
+}
+
+#endif				/* CONFIG_PROC_FS */
diff -Nru a/drivers/scsi/scsi_paths.h b/drivers/scsi/scsi_paths.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/scsi/scsi_paths.h	Mon Sep 16 16:11:26 2002
@@ -0,0 +1,152 @@
+/*
+ * Scsi Multi-path Support Library
+ *
+ * Copyright (c) 2002 IBM
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <patmans@us.ibm.com> and/or andmike@us.ibm.com
+ */
+
+#ifndef _SCSI_PATHS_H
+#define _SCSI_PATHS_H
+
+#include <linux/list.h>
+/*
+ * XXX asm/mmzone.h holds the xxx_to_nid and other information needed, but
+ * right now it is x86 specific, as well as patch specific, so a way is
+ * needed to correctly include it (rather than conditionally). The
+ * asm-i386 mmzone.h is created as part of the topo patch, and xxx_to_nid
+ * api's are added by pdorwin patch. The following is ugly and not even
+ * correct, since CONFIG_X86_NUMAQ means build for IBM NUMAQ box, it does
+ * not mean the API or even asm/mmzone.h exist.
+ */
+#ifdef CONFIG_X86_NUMAQ
+#include <asm/mmzone.h>
+#endif
+
+#ifndef MAX_NUMNODES
+/*
+ * NUMA API patches are not applied.
+ */
+#define MAX_NUMNODES	1
+#define req_to_nid(req)	0
+#define scsihost_to_node(host)	0
+#define	page_to_nid(page)	0
+#endif
+
+#if MAX_NUMNODES == 0
+#error Unexpected value of MAX_NUMNODES
+#endif
+
+#if MAX_NUMNODES == 1
+/*
+ * No NUMA support is configured or no NUMA patches. Use one
+ * last active pointer (SCSI_MAX_ACTIVE_LIST), and have one
+ * (SCSI_PATHS_MAX_PATH_LISTS) list of active paths.
+ */
+#define SCSI_MAX_ACTIVE_LIST	1
+#define SCSI_PATHS_MAX_PATH_LISTS	1
+#else
+/*
+ * NUMA support is configured, use one last active pointer per maximum
+ * number of nodes plus one last active pointer for all paths
+ * (SCSI_MAX_ACTIVE_LIST), and have two lists of paths
+ * (SCSI_PATHS_MAX_PATH_LISTS) - one for all paths and one for node local
+ * paths.
+ */
+#define SCSI_MAX_ACTIVE_LIST	(MAX_NUMNODES + 1)
+#define SCSI_PATHS_MAX_PATH_LISTS	2
+
+/*
+ * XXX use a real page_to_nid() API.
+ */
+#define page_to_nid(page) PFN_TO_NID(page_to_pfn(page))
+/*
+ * FIXME This does not properly handle requests with req->bio NULL, these are
+ * generated via scsi_do_req calls. Fix this by putting a node number in the
+ * request, and have scsi_do_req() and __make_request() set req->node.
+ */
+#define req_to_nid(req)	\
+	(((req)->bio == NULL) ? 0 : page_to_nid(bio_page((req)->bio)))
+#endif
+
+#define SCSI_PATHS_ALL_LIST	(SCSI_MAX_ACTIVE_LIST - 1)
+
+#define SCSI_ALL_ACTIVE_NEXT_LIST	0
+#define SCSI_NID_ACTIVE_NEXT_LIST	1
+
+/**
+ * enum scsi_path_policy - Path selection policy.
+ * @SCSI_PATH_POLICY_LPU: Use the same path that was used for the last IO
+ * @SCSI_PATH_POLICY_ROUND_ROBIN: Round robin across all active paths
+ **/
+enum scsi_path_policy {
+	SCSI_PATH_POLICY_LPU = 1,
+	SCSI_PATH_POLICY_ROUND_ROBIN
+};
+
+/**
+ * enum scsi_path_state - Path state flags
+ * @SCSI_PATH_STATE_GOOD: The path is active for IO.
+ * @SCSI_PATH_STATE_FAILING: The path might be failing (XXX not fully
+ * implemented yet)
+ * @SCSI_PATH_STATE_DEAD: The path has failed.
+ **/
+enum scsi_path_state {
+	SCSI_PATH_STATE_GOOD = 1,
+	SCSI_PATH_STATE_FAILING,
+	SCSI_PATH_STATE_DEAD
+};
+
+/**
+ * struct scsi_path - A single scsi path
+ * @sp_path_list: list head for all paths
+ * @sp_active_next: circular list of all active paths, list at 0 is for all
+ * active paths, the list at 1 for all active paths on a given node id.
+ * @sp_path_id: id of path (host/channel/target/lun)
+ * @sp_state: state of path
+ * @sp_failures: number of failures on this path
+ * @sp_weight: path weight 0 best, higher values worse (XXX path weighting
+ * is not implemented, for now setting this has no affect)
+ **/
+struct scsi_path {
+	struct list_head sp_path_list;
+	struct scsi_path *sp_active_next[SCSI_PATHS_MAX_PATH_LISTS];
+	struct scsi_path_id sp_path_id;
+	enum scsi_path_state sp_state;
+	unsigned int sp_failures;
+	unsigned int sp_weight;
+};
+
+/**
+ * struct scsi_mpath - All paths for a scsi device
+ * @scsi_mp_paths: list of scsi paths
+ * @scsi_mp_last_active: last active path used, one for each node, plus
+ * one for the all active list.
+ * @scsi_mp_path_policy: path selection policy - round robin or last used
+ * @scsi_mp_path_active_cnt: number of paths XXX change to an array
+ **/
+struct scsi_mpath {
+	struct list_head scsi_mp_paths_head;
+	struct scsi_path *scsi_mp_last_active[SCSI_MAX_ACTIVE_LIST];
+	unsigned int scsi_mp_path_active_cnt[SCSI_MAX_ACTIVE_LIST];
+	enum scsi_path_policy scsi_mp_path_policy;
+};
+
+#endif
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/scsi_scan.c	Mon Sep 16 16:11:26 2002
@@ -1292,7 +1292,7 @@
 static int scsi_add_lun(Scsi_Device *sdevscan, Scsi_Device **sdevnew,
 			Scsi_Request *sreq, char *inq_result, int *bflags)
 {
-	Scsi_Device *sdev;
+	Scsi_Device *sdev, *sdev_found;
 	struct Scsi_Device_Template *sdt;
 	char devname[64];
 	extern devfs_handle_t scsi_devfs_handle;
@@ -1344,6 +1344,27 @@
 	 */
 	scsi_load_identifier(sdev, sreq);
 
+	/*
+	 * sdev is linked onto the list, so we need to let the lookup id
+	 * know to skip sdev.
+	 */
+	sdev_found = scsi_lookup_id(sdev->sdev_driverfs_dev.name, sdev);
+	if (sdev_found != NULL) {
+		/*
+		 * Found a new path to an existing device, remove the just
+		 * allocated sdev.
+		 *
+		 * FIXME for now don't add any driverfs info for the new path.
+		 */
+		scsi_free_sdev(sdev);
+		(void)scsi_add_path(sdev_found, pathid.spi_shpnt,
+				    pathid.spi_channel, pathid.spi_id,
+				    pathid.spi_lun);
+		if (sdevnew != NULL)
+			*sdevnew = sdev_found;
+		return (SCSI_SCAN_TARGET_PRESENT | SCSI_SCAN_LUN_PRESENT);
+	}
+
 	if (*bflags & BLIST_ISROM) {
 		/*
 		 * It would be better to modify sdev->type, and set
@@ -2020,8 +2041,14 @@
 		 * plus have dynamic queue depth adjustment like the
 		 * aic7xxx driver.
 		 */
+#ifndef CONFIG_SCSI_MULTI_PATH_IO
+		/*
+		 * XXX this is broken anyway, Doug Ledford has a patch to
+		 * call slave_attach, eventually merge or use slave_attach.
+		 */
 		if (shost->select_queue_depths != NULL)
 			(shost->select_queue_depths) (shost, shost->host_queue);
+#endif
 		for (sdt = scsi_devicelist; sdt; sdt = sdt->next)
 			if (sdt->init && sdt->dev_noticed)
 				(*sdt->init) ();
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Mon Sep 16 16:11:26 2002
+++ b/drivers/scsi/sg.c	Mon Sep 16 16:11:26 2002
@@ -2988,6 +2988,8 @@
 				PRINT_PROC(" >>> device=sg%d ", dev);
 				if (sdp->detached)
 					PRINT_PROC("detached pending close ");
+#ifndef CONFIG_SCSI_MULTI_PATH_IO
+				/* XXX multi-path TBD */
 				else
 					PRINT_PROC
 					    ("scsi%d chan=%d id=%d lun=%d   em=%d",
@@ -2995,6 +2997,7 @@
 					     scsidp->channel, scsidp->id,
 					     scsidp->lun,
 					     scsidp->host->hostt->emulated);
+#endif
 				PRINT_PROC(" sg_tablesize=%d excl=%d\n",
 					   sdp->sg_tablesize, sdp->exclude);
 			}
@@ -3024,6 +3027,15 @@
 	for (j = 0; j < max_dev; ++j) {
 		sdp = sg_get_dev(j);
 		if (sdp && (scsidp = sdp->device) && (!sdp->detached))
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+			/* XXX multi-path TBD */
+			PRINT_PROC("%d\t%d\t%d\t%d\t%d\n",
+				(int)scsidp->type,
+				(int)scsidp->access_count,
+				(int)scsidp->queue_depth,
+				(int)scsidp->device_busy,
+				(int)scsidp->online);
+#else
 			PRINT_PROC("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n",
 				   scsidp->host->host_no, scsidp->channel,
 				   scsidp->id, scsidp->lun, (int) scsidp->type,
@@ -3031,6 +3043,7 @@
 				   (int) scsidp->queue_depth,
 				   (int) scsidp->device_busy,
 				   (int) scsidp->online);
+#endif
 		else
 			PRINT_PROC("-1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\n");
 	}
