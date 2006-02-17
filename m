Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWBQOKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWBQOKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWBQOKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:10:49 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:17830 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1750737AbWBQOKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:10:48 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcYzy/EOh2p8dYDHQvmqBRnRt90cfw==
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43F5D963.9080009@bfh.ch>
Date: Fri, 17 Feb 2006 15:10:43 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <matthew@wil.cx>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [PATCH] sym53c8xx_2: Add bios_param to sym_glue.c
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 14:10:43.0801 (UTC) FILETIME=[F0CD6C90:01C633CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the scsi common function bios_param to the sym53c8xx
driver. For simplicity i just copied the code from the sym53c416 driver.

Patch applies to 2.6.16-rc3

Signed-off-by: Seewer Philippe <philippe.seewer@bfh.ch>


--- linux-2.6.16-rc3/drivers/scsi/sym53c8xx_2/sym_glue.c.orig   2006-02-17 14:49:12.000000000 +0100
+++ linux-2.6.16-rc3/drivers/scsi/sym53c8xx_2/sym_glue.c        2006-02-17 14:50:55.000000000 +0100
@@ -1963,6 +1963,28 @@ static int sym_detach(struct sym_hcb *np
 }

 /*
+ * Bios param for sd.
+ * Copied from sym53c416 driver
+ */
+static int sym53c8xx_bios_param(struct scsi_device *sdev,
+               struct block_device *dev,
+               sector_t capacity, int *ip)
+{
+       int size;
+
+       size = capacity;
+       ip[0] = 64;                             /* heads                        */
+       ip[1] = 32;                             /* sectors                      */
+       if((ip[2] = size >> 11) > 1024)         /* cylinders, test for big disk */
+       {
+               ip[0] = 255;                    /* heads                        */
+               ip[1] = 63;                     /* sectors                      */
+               ip[2] = size / (255 * 63);      /* cylinders                    */
+       }
+       return 0;
+}
+
+/*
  * Driver host template.
  */
 static struct scsi_host_template sym2_template = {
@@ -1977,6 +1999,7 @@ static struct scsi_host_template sym2_te
        .eh_device_reset_handler = sym53c8xx_eh_device_reset_handler,
        .eh_bus_reset_handler   = sym53c8xx_eh_bus_reset_handler,
        .eh_host_reset_handler  = sym53c8xx_eh_host_reset_handler,
+       .bios_param             = sym53c8xx_bios_param,
        .this_id                = 7,
        .use_clustering         = DISABLE_CLUSTERING,
 #ifdef SYM_LINUX_PROC_INFO_SUPPORT
