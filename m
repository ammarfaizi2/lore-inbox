Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUHAL7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUHAL7D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbUHAL7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:59:03 -0400
Received: from mail.dif.dk ([193.138.115.101]:6079 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265893AbUHAL64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:58:56 -0400
Date: Sun, 1 Aug 2004 14:02:50 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       Oliver Neukum <oliver@neukum.name>, Ali Akcaagac <aliakc@web.de>,
       Jamie Lenehan <lenehan@twibble.org>, Adrian Bunk <bunk@fs.tum.de>
Subject: [PATCH] fix gcc 3.4 inlining errors in drivers/scsi/dc395x.c
Message-ID: <Pine.LNX.4.60.0408011355080.2535@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/scsi/dc395x.c fails to build in 2.6.8-rc2-mm1 with gcc 3.4.0 with 
the following errors :

drivers/scsi/dc395x.c: In function `dc395x_handle_interrupt':
drivers/scsi/dc395x.c:388: sorry, unimplemented: inlining failed in call to 'enable_msgout_abort': function body not available
drivers/scsi/dc395x.c:1740: sorry, unimplemented: called from here

drivers/scsi/dc395x.c: In function `msgin_set_async':
drivers/scsi/dc395x.c:394: sorry, unimplemented: inlining failed in call to 'set_xfer_rate': function body not available
drivers/scsi/dc395x.c:2677: sorry, unimplemented: called from here

The patch below fixes the build by un-inlining the functions (an 
alternative would be to rework the file so the functions move before their 
first use). As for 'set_xfer_rate' the function itself was not declared 
inline, only the prototype.

Patch against 2.6.8-rc2-mm1

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


diff -up linux-2.6.8-rc2-mm1-orig/drivers/scsi/dc395x.c linux-2.6.8-rc2-mm1/drivers/scsi/dc395x.c
--- linux-2.6.8-rc2-mm1-orig/drivers/scsi/dc395x.c	2004-07-31 13:09:46.000000000 +0200
+++ linux-2.6.8-rc2-mm1/drivers/scsi/dc395x.c	2004-07-31 23:22:47.000000000 +0200
@@ -384,13 +384,13 @@ static void scsi_reset_detect(struct Ada
 static void pci_unmap_srb(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb);
 static void pci_unmap_srb_sense(struct AdapterCtlBlk *acb,
 		struct ScsiReqBlk *srb);
-static inline void enable_msgout_abort(struct AdapterCtlBlk *acb,
+static void enable_msgout_abort(struct AdapterCtlBlk *acb,
 		struct ScsiReqBlk *srb);
 static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 		struct ScsiReqBlk *srb);
 static void request_sense(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 		struct ScsiReqBlk *srb);
-static inline void set_xfer_rate(struct AdapterCtlBlk *acb,
+static void set_xfer_rate(struct AdapterCtlBlk *acb,
 		struct DeviceCtlBlk *dcb);
 static void waiting_timeout(unsigned long ptr);
 
@@ -2604,7 +2604,7 @@ static inline void msgin_reject(struct A
 
 
 /* abort command */
-static inline void enable_msgout_abort(struct AdapterCtlBlk *acb,
+static void enable_msgout_abort(struct AdapterCtlBlk *acb,
 		struct ScsiReqBlk *srb)
 {
 	srb->msgout_buf[0] = ABORT;


--
Jesper Juhl <juhl-lkml@dif.dk>


