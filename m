Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVDSWfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVDSWfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 18:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVDSWfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 18:35:34 -0400
Received: from mail.dif.dk ([193.138.115.101]:54920 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261705AbVDSWfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 18:35:25 -0400
Date: Wed, 20 Apr 2005 00:38:27 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Youngdale <eric@andante.org>, linux-scsi@vger.kernel.org
Subject: test of 'good_bytes' in scsi_io_completion is always true (in
 drivers/scsi/scsi_lib.c)
Message-ID: <Pine.LNX.4.62.0504200030180.2074@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in drivers/scsi/scsi_lib.c::scsi_io_completion() 'good_bytes' is tested 
for being >= 0, but 'good_bytes' is an unsigned int, so that test is 
always true. My *guess* is that what was intended was to test if 
good_bytes is > 0, but I don't know this code well enough to be sure. 
The patch below makes the change to test if it's > 0, but if the code in 
the 'if' really wants to run if it's >= 0, then we might as well just 
remove the 'if'.

In any case, the current code looks fishy.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm3-orig/drivers/scsi/scsi_lib.c	2005-04-11 21:20:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/scsi/scsi_lib.c	2005-04-20 00:29:14.000000000 +0200
@@ -766,7 +766,7 @@ void scsi_io_completion(struct scsi_cmnd
 	 * Next deal with any sectors which we were able to correctly
 	 * handle.
 	 */
-	if (good_bytes >= 0) {
+	if (good_bytes > 0) {
 		SCSI_LOG_HLCOMPLETE(1, printk("%ld sectors total, %d bytes done.\n",
 					      req->nr_sectors, good_bytes));
 		SCSI_LOG_HLCOMPLETE(1, printk("use_sg is %d\n", cmd->use_sg));




Please keep me on CC:


