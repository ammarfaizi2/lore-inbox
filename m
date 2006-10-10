Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030669AbWJJXWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030669AbWJJXWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030646AbWJJXWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:22:33 -0400
Received: from havoc.gtf.org ([69.61.125.42]:43435 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030641AbWJJXWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:22:32 -0400
Date: Tue, 10 Oct 2006 19:22:31 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI: minor bug fixes and cleanups
Message-ID: <20061010232231.GA19015@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BusLogic: use kzalloc(), remove cast to/from void*

aic7xxx_old: fix typo in cast

NCR53c406a: ifdef out static built code

fd_mcs: ifdef out static built code

ncr53c8xx: ifdef out static built code

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/scsi/BusLogic.c       |   12 ++++++------
 drivers/scsi/NCR53c406a.c     |    5 +++++
 drivers/scsi/aic7xxx_old.c    |    2 +-
 drivers/scsi/fd_mcs.c         |    2 ++
 drivers/scsi/ncr53c8xx.c      |   19 +++++++++++--------

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 7c59bba..689dc4c 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2186,21 +2186,21 @@ #endif
 
 	if (BusLogic_ProbeOptions.NoProbe)
 		return -ENODEV;
-	BusLogic_ProbeInfoList = (struct BusLogic_ProbeInfo *)
-	    kmalloc(BusLogic_MaxHostAdapters * sizeof(struct BusLogic_ProbeInfo), GFP_ATOMIC);
+	BusLogic_ProbeInfoList =
+	    kzalloc(BusLogic_MaxHostAdapters * sizeof(struct BusLogic_ProbeInfo), GFP_KERNEL);
 	if (BusLogic_ProbeInfoList == NULL) {
 		BusLogic_Error("BusLogic: Unable to allocate Probe Info List\n", NULL);
 		return -ENOMEM;
 	}
-	memset(BusLogic_ProbeInfoList, 0, BusLogic_MaxHostAdapters * sizeof(struct BusLogic_ProbeInfo));
-	PrototypeHostAdapter = (struct BusLogic_HostAdapter *)
-	    kmalloc(sizeof(struct BusLogic_HostAdapter), GFP_ATOMIC);
+
+	PrototypeHostAdapter =
+	    kzalloc(sizeof(struct BusLogic_HostAdapter), GFP_KERNEL);
 	if (PrototypeHostAdapter == NULL) {
 		kfree(BusLogic_ProbeInfoList);
 		BusLogic_Error("BusLogic: Unable to allocate Prototype " "Host Adapter\n", NULL);
 		return -ENOMEM;
 	}
-	memset(PrototypeHostAdapter, 0, sizeof(struct BusLogic_HostAdapter));
+
 #ifdef MODULE
 	if (BusLogic != NULL)
 		BusLogic_Setup(BusLogic);
diff --git a/drivers/scsi/NCR53c406a.c b/drivers/scsi/NCR53c406a.c
index d461381..8578555 100644
--- a/drivers/scsi/NCR53c406a.c
+++ b/drivers/scsi/NCR53c406a.c
@@ -220,9 +220,11 @@ #endif				/* USE_BIOS */
 static unsigned short ports[] = { 0x230, 0x330, 0x280, 0x290, 0x330, 0x340, 0x300, 0x310, 0x348, 0x350 };
 #define PORT_COUNT ARRAY_SIZE(ports)
 
+#ifndef MODULE
 /* possible interrupt channels */
 static unsigned short intrs[] = { 10, 11, 12, 15 };
 #define INTR_COUNT ARRAY_SIZE(intrs)
+#endif /* !MODULE */
 
 /* signatures for NCR 53c406a based controllers */
 #if USE_BIOS
@@ -605,6 +607,7 @@ #endif
 	return 0;
 }
 
+#ifndef MODULE
 /* called from init/main.c */
 static int __init NCR53c406a_setup(char *str)
 {
@@ -661,6 +664,8 @@ static int __init NCR53c406a_setup(char 
 
 __setup("ncr53c406a=", NCR53c406a_setup);
 
+#endif /* !MODULE */
+
 static const char *NCR53c406a_info(struct Scsi_Host *SChost)
 {
 	DEB(printk("NCR53c406a_info called\n"));
diff --git a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
index bcd7fff..46eed10 100644
--- a/drivers/scsi/aic7xxx_old.c
+++ b/drivers/scsi/aic7xxx_old.c
@@ -2646,7 +2646,7 @@ static void aic7xxx_done_cmds_complete(s
 
 	while (p->completeq.head != NULL) {
 		cmd = p->completeq.head;
-		p->completeq.head = (struct scsi_Cmnd *) cmd->host_scribble;
+		p->completeq.head = (struct scsi_cmnd *) cmd->host_scribble;
 		cmd->host_scribble = NULL;
 		cmd->scsi_done(cmd);
 	}
diff --git a/drivers/scsi/fd_mcs.c b/drivers/scsi/fd_mcs.c
index ef8285c..668569e 100644
--- a/drivers/scsi/fd_mcs.c
+++ b/drivers/scsi/fd_mcs.c
@@ -294,6 +294,7 @@ static struct Scsi_Host *hosts[FD_MAX_HO
 static int user_fifo_count = 0;
 static int user_fifo_size = 0;
 
+#ifndef MODULE
 static int __init fd_mcs_setup(char *str)
 {
 	static int done_setup = 0;
@@ -311,6 +312,7 @@ static int __init fd_mcs_setup(char *str
 }
 
 __setup("fd_mcs=", fd_mcs_setup);
+#endif /* !MODULE */
 
 static void print_banner(struct Scsi_Host *shpnt)
 {
diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index 6cc2bc2..5a88fa0 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -589,10 +589,12 @@ #define map_scsi_sg_data(np, cmd)	__map_
 static struct ncr_driver_setup
 	driver_setup			= SCSI_NCR_DRIVER_SETUP;
 
+#ifndef MODULE
 #ifdef	SCSI_NCR_BOOT_COMMAND_LINE_SUPPORT
 static struct ncr_driver_setup
 	driver_safe_setup __initdata	= SCSI_NCR_DRIVER_SAFE_SETUP;
 #endif
+#endif /* !MODULE */
 
 #define initverbose (driver_setup.verbose)
 #define bootverbose (np->verbose)
@@ -641,6 +643,13 @@ #ifdef SCSI_NCR_IARB_SUPPORT
 #define OPT_IARB		26
 #endif
 
+#ifdef MODULE
+#define	ARG_SEP	' '
+#else
+#define	ARG_SEP	','
+#endif
+
+#ifndef MODULE
 static char setup_token[] __initdata = 
 	"tags:"   "mpar:"
 	"spar:"   "disc:"
@@ -660,12 +669,6 @@ #ifdef SCSI_NCR_IARB_SUPPORT
 #endif
 	;	/* DONNOT REMOVE THIS ';' */
 
-#ifdef MODULE
-#define	ARG_SEP	' '
-#else
-#define	ARG_SEP	','
-#endif
-
 static int __init get_setup_token(char *p)
 {
 	char *cur = setup_token;
@@ -682,7 +685,6 @@ static int __init get_setup_token(char *
 	return 0;
 }
 
-
 static int __init sym53c8xx__setup(char *str)
 {
 #ifdef SCSI_NCR_BOOT_COMMAND_LINE_SUPPORT
@@ -804,6 +806,7 @@ #endif
 #endif /* SCSI_NCR_BOOT_COMMAND_LINE_SUPPORT */
 	return 1;
 }
+#endif /* !MODULE */
 
 /*===================================================================
 **
@@ -8321,12 +8324,12 @@ char *ncr53c8xx;	/* command line passed 
 module_param(ncr53c8xx, charp, 0);
 #endif
 
+#ifndef MODULE
 static int __init ncr53c8xx_setup(char *str)
 {
 	return sym53c8xx__setup(str);
 }
 
-#ifndef MODULE
 __setup("ncr53c8xx=", ncr53c8xx_setup);
 #endif
 
