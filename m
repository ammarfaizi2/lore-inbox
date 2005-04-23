Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVDWWY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVDWWY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVDWWY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:24:27 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49679 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262099AbVDWWOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:14:42 -0400
Date: Sun, 24 Apr 2005 00:14:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] SCSI: make code static
Message-ID: <20050423221434.GI4355@stusta.de>
References: <20050327202139.GQ4285@stusta.de> <1112023305.5531.2.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112023305.5531.2.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:21:45AM -0600, James Bottomley wrote:
> On Sun, 2005-03-27 at 22:21 +0200, Adrian Bunk wrote:
> > This patch contains the following cleanups:
> [..]
> 
> No to all of this:
> 
> > - remove the following unused functions:
> >   - scsi.h: print_driverbyte
> >   - scsi.h: print_hostbyte
> > - #if 0 the following unused functions:
> >   - constants.c: scsi_print_hostbyte
> >   - constants.c: scsi_print_driverbyte
> 
> These are useful to those of us who debug drivers.
> 
> > - remove the following unneeded EXPORT_SYMBOL's:
> >   - hosts.c: scsi_host_lookup
> >   - scsi.c: scsi_device_cancel
> >   - scsi_lib.c: scsi_device_resume
> 
> These are part of the SCSI API.

Below is a patch with only the parts you didn't veto.

> James

cu
Adrian


<--  snip  -->


This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/hosts.c      |    2 +-
 drivers/scsi/scsi.c       |    6 ++++--
 drivers/scsi/scsi_debug.c |    2 +-
 drivers/scsi/scsi_lib.c   |    2 +-
 drivers/scsi/scsi_priv.h  |    4 ----
 drivers/scsi/scsi_sysfs.c |    4 ++--
 6 files changed, 9 insertions(+), 11 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/hosts.c.old	2005-02-28 18:33:14.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/hosts.c	2005-03-01 00:58:19.000000000 +0100
@@ -56,7 +56,7 @@
  * @shost:	pointer to struct Scsi_Host
  * recovery:	recovery requested to run.
  **/
-void scsi_host_cancel(struct Scsi_Host *shost, int recovery)
+static void scsi_host_cancel(struct Scsi_Host *shost, int recovery)
 {
 	struct scsi_device *sdev;
 
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_priv.h.old	2005-02-28 19:59:30.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_priv.h	2005-03-01 00:58:19.000000000 +0100
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
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi.c	2005-03-01 00:58:19.000000000 +0100
@@ -68,6 +68,8 @@
 #include "scsi_priv.h"
 #include "scsi_logging.h"
 
+static void scsi_done(struct scsi_cmnd *cmd);
+static int scsi_retry_command(struct scsi_cmnd *cmd);
 
 /*
  * Definitions and constants.
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
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_debug.c.old	2005-02-28 20:22:08.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_debug.c	2005-03-01 00:58:19.000000000 +0100
@@ -1783,7 +1783,7 @@
 device_initcall(scsi_debug_init);
 module_exit(scsi_debug_exit);
 
-void pseudo_0_release(struct device * dev)
+static void pseudo_0_release(struct device * dev)
 {
 	if (SCSI_DEBUG_OPT_NOISE & scsi_debug_opts)
 		printk(KERN_INFO "scsi_debug: pseudo_0_release() called\n");
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_lib.c.old	2005-02-28 20:14:23.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_lib.c	2005-03-01 00:58:19.000000000 +0100
@@ -44,7 +44,7 @@
 #endif
 
 #define SP(x) { x, "sgpool-" #x } 
-struct scsi_host_sg_pool scsi_sg_pools[] = { 
+static struct scsi_host_sg_pool scsi_sg_pools[] = { 
 	SP(8),
 	SP(16),
 	SP(32),
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_sysfs.c.old	2005-02-28 20:19:41.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_sysfs.c	2005-03-01 00:58:19.000000000 +0100
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

