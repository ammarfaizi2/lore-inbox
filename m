Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUITTZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUITTZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUITTY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:24:56 -0400
Received: from mailout.zma.compaq.com ([161.114.64.103]:27662 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S267165AbUITTYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:24:49 -0400
Date: Mon, 20 Sep 2004 14:24:20 -0500
From: mike.miller@hp.com
To: linux-kernel@vger.kernel.org, axboe@suse.de
Cc: linux-scsi@vger.kernel.org
Subject: fix for cpqarray for 2.6.9-rc2
Message-ID: <20040920192420.GA5651@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net, mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem with cpqarray and the SA4200 controller.
Our online config utility cannot properly communicate with the controller.
Patch by Chirag.Kantharia@hp.com.
Applies to 2.6.9-rc2. Please consider this for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burNp lx269-rc2.orig/drivers/block/cpqarray.c lx269-rc2/drivers/block/cpqarray.c
--- lx269-rc2.orig/drivers/block/cpqarray.c	2004-08-14 00:36:17.000000000 -0500
+++ lx269-rc2/drivers/block/cpqarray.c	2004-09-20 14:15:39.781595280 -0500
@@ -1286,6 +1286,7 @@ static int ida_ctlr_ioctl(ctlr_info_t *h
 		c->req.hdr.sg_cnt = 1;
 		break;
 	case IDA_READ:
+	case SENSE_SURF_STATUS:
 	case READ_FLASH_ROM:
 	case SENSE_CONTROLLER_PERFORMANCE:
 		p = kmalloc(io->sg[0].size, GFP_KERNEL);
@@ -1351,6 +1352,7 @@ static int ida_ctlr_ioctl(ctlr_info_t *h
                                 sizeof(ida_ioctl_t),
                                 PCI_DMA_BIDIRECTIONAL);
 	case IDA_READ:
+	case SENSE_SURF_STATUS:
 	case DIAG_PASS_THRU:
 	case SENSE_CONTROLLER_PERFORMANCE:
 	case READ_FLASH_ROM:
diff -burNp lx269-rc2.orig/drivers/block/ida_cmd.h lx269-rc2/drivers/block/ida_cmd.h
--- lx269-rc2.orig/drivers/block/ida_cmd.h	2004-08-14 00:36:44.000000000 -0500
+++ lx269-rc2/drivers/block/ida_cmd.h	2004-09-20 14:15:39.782595128 -0500
@@ -318,6 +318,8 @@ typedef struct {
 	__u8	reserved[510];
 } mp_delay_t;
 
+#define SENSE_SURF_STATUS       0x70
+
 #define PASSTHRU_A	0x91
 typedef struct {
 	__u8	target;
