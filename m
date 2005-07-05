Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVGEXMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVGEXMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVGEXMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:12:39 -0400
Received: from dude3.usprocom.net ([69.222.0.8]:15627 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S261997AbVGEXLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:11:55 -0400
Date: Tue,  5 Jul 2005 18:12:14 -0500
Message-Id: <200507051812.AA590604@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-scsi@vger.kernel.org>
Subject: Re: REGRESSION in 2.6.13-rc1: Massive slowdown with Adaptec SCSI
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.6.13-rc1-git7 after applaying patch transfer back to 72MB/s on aha19160 with 15k rpm seagate with reiserfs3 but possible deadlock in heavy IO - rsync ~50000-files from /mnt/seagate15k/a to /mnt/seagate15k/b ended in middle with deadlock of rsync (3 instances), pdflush, and gam_server in uninteruptible state -- system cannot kill this deadlocked uninterruptibles
any clue ???

thanx

xboom


patch-----

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -2633,6 +2633,11 @@ static void ahc_linux_set_dt(struct scsi
 	ahc_unlock(ahc, &flags);
 }
 
+#if 0
+/* FIXME: This code claims to support IU and QAS.  However, the actual
+ * sequencer code and aic7xxx_core have no support for these parameters and
+ * will get into a bad state if they're negotiated.  Do not enable this
+ * unless you know what you're doing */
 static void ahc_linux_set_qas(struct scsi_target *starget, int qas)
 {
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
@@ -2688,6 +2693,7 @@ static void ahc_linux_set_iu(struct scsi
 			 ppr_options, AHC_TRANS_GOAL, FALSE);
 	ahc_unlock(ahc, &flags);
 }
+#endif
 
 static struct spi_function_template ahc_linux_transport_functions = {
 	.set_offset	= ahc_linux_set_offset,
@@ -2698,10 +2704,12 @@ static struct spi_function_template ahc_
 	.show_width	= 1,
 	.set_dt		= ahc_linux_set_dt,
 	.show_dt	= 1,
+#if 0
 	.set_iu		= ahc_linux_set_iu,
 	.show_iu	= 1,
 	.set_qas	= ahc_linux_set_qas,
 	.show_qas	= 1,
+#endif
 };

