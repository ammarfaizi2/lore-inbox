Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbUK2KuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUK2KuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbUK2Kta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:49:30 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:24483 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261658AbUK2Kpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:45:44 -0500
Date: Mon, 29 Nov 2004 19:47:18 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [ANNOUNCE 6/7] Diskdump 1.0 Release
In-reply-to: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org, lkdump-develop@lists.sourceforge.net
Message-id: <40C4D600CC314Dindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.71
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for sym53c8xx driver.


diff -Nur linux-2.6.9.org/drivers/scsi/sym53c8xx_2/sym_glue.c linux-2.6.9/drivers/scsi/sym53c8xx_2/sym_glue.c
--- linux-2.6.9.org/drivers/scsi/sym53c8xx_2/sym_glue.c	2004-10-19 06:55:36.000000000 +0900
+++ linux-2.6.9/drivers/scsi/sym53c8xx_2/sym_glue.c	2004-11-24 19:24:09.903045793 +0900
@@ -956,6 +956,28 @@
 	return sym_eh_handler(SYM_EH_HOST_RESET, "HOST RESET", cmd);
 }
 
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+static int sym53c8xx_sanity_check_handler(struct scsi_device *sd)
+{
+	struct sym_hcb *np = ((struct host_data *)sd->host->hostdata)->ncb;
+
+	if (np == NULL)
+		return -ENXIO;
+
+	del_timer(&np->s.timer);
+	add_timer_on(&np->s.timer, smp_processor_id());
+
+	return 0;
+}
+
+static void sym53c8xx_poll_handler(struct scsi_device *sd)
+{
+	struct sym_hcb *np = ((struct host_data *)sd->host->hostdata)->ncb;
+
+	sym_interrupt(np);
+}
+#endif
+
 /*
  *  Tune device queuing depth, according to various limits.
  */
@@ -2231,6 +2253,10 @@
 	.eh_device_reset_handler = sym53c8xx_eh_device_reset_handler,
 	.eh_bus_reset_handler	= sym53c8xx_eh_bus_reset_handler,
 	.eh_host_reset_handler	= sym53c8xx_eh_host_reset_handler,
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+	.dump_sanity_check	= sym53c8xx_sanity_check_handler,
+	.dump_poll		= sym53c8xx_poll_handler,
+#endif
 	.this_id		= 7,
 	.use_clustering		= DISABLE_CLUSTERING,
 #ifdef SYM_LINUX_PROC_INFO_SUPPORT
