Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283411AbRK3EQD>; Thu, 29 Nov 2001 23:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283431AbRK3EPy>; Thu, 29 Nov 2001 23:15:54 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:54061 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S283411AbRK3EPi>; Thu, 29 Nov 2001 23:15:38 -0500
Date: Thu, 29 Nov 2001 23:15:37 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: Patch to update scsi_debug.c
Message-ID: <20011129231537.A26388@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone:

I would like to have scsi_debug with a variable number of hosts.
Patch is attached. Does anyone object to the demise of scsi_debug.h?

Greetings,
-- Pete

diff -urN -X dontdiff linux-2.4.16/drivers/scsi/scsi_debug.c linux-2.4.16-niph/drivers/scsi/scsi_debug.c
--- linux-2.4.16/drivers/scsi/scsi_debug.c	Fri Oct 12 15:35:54 2001
+++ linux-2.4.16-niph/drivers/scsi/scsi_debug.c	Thu Nov 29 20:11:41 2001
@@ -2,9 +2,12 @@
  *  linux/kernel/scsi_debug.c
  *
  *  Copyright (C) 1992  Eric Youngdale
+ *  Copyright (C) 2001  Red Hat, Inc.
  *  Simulate a host adapter with 2 disks attached.  Do a lot of checking
  *  to make sure that we are not getting blocks mixed up, and panic if
  *  anything out of the ordinary is seen.
+ *
+ * 2001/11/25 Variable number of hosts by Pete Zaitcev <zaitcev@yahoo.com>.
  */
 
 #include <linux/config.h>
@@ -19,6 +22,7 @@
 #include <linux/genhd.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
+#include <linux/kdev_t.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -29,12 +33,11 @@
 
 #include "sd.h"
 
-#include<linux/stat.h>
+#include <linux/stat.h>
 
 /* A few options that we want selected */
 
-#define NR_HOSTS_PRESENT 1
-#define NR_FAKE_DISKS   3
+#define NR_FAKE_TGTS      3
 #define N_HEAD          255
 #define N_SECTOR        63
 #define N_CYLINDER      524
@@ -51,9 +54,6 @@
 /* Read return zeros. Undefine for benchmarking */
 #define CLEAR
 
-/* Number of real scsi disks that will be detected ahead of time */
-static int NR_REAL = -1;
-
 #define NR_BLK_DEV  12
 #ifndef MAJOR_NR
 #define MAJOR_NR 8
@@ -72,13 +72,29 @@
  CAPACITY, 0};
 static int npart = 0;
 
-#include "scsi_debug.h"
+int scsi_debug_detect(Scsi_Host_Template *);
+int scsi_debug_command(Scsi_Cmnd *);
+int scsi_debug_queuecommand(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
+int scsi_debug_abort(Scsi_Cmnd *);
+int scsi_debug_biosparam(Disk *, kdev_t, int[]);
+int scsi_debug_reset(Scsi_Cmnd *, unsigned int);
+int scsi_debug_proc_info(char *, char **, off_t, int, int, int);
+
+#define SCSI_DEBUG_MAILBOXES 1
+
 #ifdef DEBUG
 #define DEB(x) x
 #else
 #define DEB(x)
 #endif
 
+struct scsi_debug_host {
+	int instance;
+};
+
+static int nhosts = 1;
+MODULE_PARM(nhosts, "i");
+
 #ifdef SPEEDY
 #define VERIFY1_DEBUG(RW)
 #define VERIFY_DEBUG(RW)
@@ -219,7 +235,7 @@
 	if (done == NULL) {
 		return 0;
 	}
-	DEB(if (target >= NR_FAKE_DISKS) {
+	DEB(if (target >= NR_FAKE_TGTS) {
 	    SCpnt->result = DID_TIME_OUT << 16; done(SCpnt); return 0;
 	    }
 	);
@@ -237,7 +253,7 @@
                 return 0;
         }
 
-	if (target >= NR_FAKE_DISKS || SCpnt->lun != 0) {
+	if (target >= NR_FAKE_TGTS || SCpnt->lun != 0) {
 		SCpnt->result = DID_NO_CONNECT << 16;
 		done(SCpnt);
 		return 0;
@@ -301,8 +317,6 @@
 	case READ_CAPACITY:
 		SCSI_LOG_LLQUEUE(3, printk("Read Capacity\n"));
                 SHpnt = SCpnt->host;
-		if (NR_REAL < 0)
-			NR_REAL = (MINOR(SCpnt->request.rq_dev) >> 4) & 0x0f;
 		memset(buff, 0, bufflen);
 		buff[0] = (CAPACITY >> 24);
 		buff[1] = (CAPACITY >> 16) & 0xff;
@@ -612,16 +626,25 @@
 #endif
 }
 
-
 int scsi_debug_detect(Scsi_Host_Template * tpnt)
 {
+	struct Scsi_Host *host;
+	struct scsi_debug_host *hp;
 	int i;
 
-	for (i = 0; i < NR_HOSTS_PRESENT; i++) {
-		tpnt->proc_name = "scsi_debug";	/* Huh? In the loop??? */
-		scsi_register(tpnt, 0);
+	for (i = 0; i < nhosts; i++) {
+		host = scsi_register(tpnt, sizeof(struct scsi_debug_host));
+		if (host == NULL) {
+			printk(KERN_ERR
+			    "scsi_debug: cannot register host %d\n", i);
+			return i;
+		}
+		hp = (struct scsi_debug_host *) &host->hostdata[0];
+		hp->instance = i;
+		DEB(printk("scsi_debug: #%d registered, host %p hostdata %p\n",
+		    i, host, hp));
 	}
-	return NR_HOSTS_PRESENT;
+	return nhosts;
 }
 
 int scsi_debug_abort(Scsi_Cmnd * SCpnt)
@@ -687,11 +710,13 @@
 	return SCSI_RESET_SUCCESS;
 }
 
+#if 0 /* later */
 const char *scsi_debug_info(void)
 {
 	static char buffer[] = " ";	/* looks nicer without anything here */
 	return buffer;
 }
+#endif
 
 /* scsi_debug_proc_info
  * Used if the driver currently has no own support for /proc/scsi
@@ -756,6 +781,17 @@
 	return (len);
 }
 
+/*
+ * This happens when module is going to be unloaded.
+ */
+int scsi_debug_release(struct Scsi_Host *host)
+{
+	struct scsi_debug_host *hp = (struct scsi_debug_host *) host->hostdata;
+
+	DEB(printk("scsi_debug: #%d release\n", hp->instance));
+	return (0);
+}
+
 #ifdef CONFIG_USER_DEBUG
 /*
  * This is a hack for the user space emulator.  It allows us to
@@ -773,8 +809,30 @@
 }
 #endif
 
-/* Eventually this will go into an include file, but this will be later */
-static Scsi_Host_Template driver_template = SCSI_DEBUG;
+/*
+ * Allow the driver to reject commands.  Thus we accept only one, but
+ * and the mid-level will queue the remainder.
+ */
+#define SCSI_DEBUG_CANQUEUE  255
+
+/* Going into a header file? I don't think so, Eric. */
+static Scsi_Host_Template driver_template = {
+	proc_info:         scsi_debug_proc_info,
+	proc_name:         "scsi_debug",
+	name:              "SCSI DEBUG",
+	detect:            scsi_debug_detect,
+	queuecommand:      scsi_debug_queuecommand,
+	abort:             scsi_debug_abort,
+	reset:             scsi_debug_reset,
+	bios_param:        scsi_debug_biosparam,
+	can_queue:         SCSI_DEBUG_CANQUEUE,
+	this_id:           7,
+	sg_tablesize:      16,
+	cmd_per_lun:       3,
+	unchecked_isa_dma: 0,
+	use_clustering:    ENABLE_CLUSTERING,
+	use_new_eh_code:   1,
+};
 
 #include "scsi_module.c"
 
diff -urN -X dontdiff linux-2.4.16/drivers/scsi/scsi_debug.h linux-2.4.16-niph/drivers/scsi/scsi_debug.h
--- linux-2.4.16/drivers/scsi/scsi_debug.h	Mon Dec 11 13:19:52 2000
+++ linux-2.4.16-niph/drivers/scsi/scsi_debug.h	Wed Dec 31 16:00:00 1969
@@ -1,42 +0,0 @@
-#ifndef _SCSI_DEBUG_H
-
-#include <linux/types.h>
-#include <linux/kdev_t.h>
-
-int scsi_debug_detect(Scsi_Host_Template *);
-int scsi_debug_command(Scsi_Cmnd *);
-int scsi_debug_queuecommand(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
-int scsi_debug_abort(Scsi_Cmnd *);
-int scsi_debug_biosparam(Disk *, kdev_t, int[]);
-int scsi_debug_reset(Scsi_Cmnd *, unsigned int);
-int scsi_debug_proc_info(char *, char **, off_t, int, int, int);
-
-#ifndef NULL
-#define NULL 0
-#endif
-
-
-#define SCSI_DEBUG_MAILBOXES 1
-
-/*
- * Allow the driver to reject commands.  Thus we accept only one, but
- * and the mid-level will queue the remainder.
- */
-#define SCSI_DEBUG_CANQUEUE  255
-
-#define SCSI_DEBUG {proc_info:         scsi_debug_proc_info,	\
-		    name:              "SCSI DEBUG",		\
-		    detect:            scsi_debug_detect,	\
-		    queuecommand:      scsi_debug_queuecommand, \
-		    abort:             scsi_debug_abort,	\
-		    reset:             scsi_debug_reset,	\
-		    bios_param:        scsi_debug_biosparam,	\
-		    can_queue:         SCSI_DEBUG_CANQUEUE,	\
-		    this_id:           7,			\
-		    sg_tablesize:      16,			\
-		    cmd_per_lun:       3,			\
-		    unchecked_isa_dma: 0,			\
-		    use_clustering:    ENABLE_CLUSTERING,	\
-		    use_new_eh_code:   1,			\
-}
-#endif
