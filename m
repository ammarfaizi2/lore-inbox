Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbUB2Rbl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 12:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbUB2Rbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 12:31:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6603 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262083AbUB2Rbd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 12:31:33 -0500
Message-ID: <404221E8.6040303@pobox.com>
Date: Sun, 29 Feb 2004 12:31:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
CC: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFT] libata "DMA timeout" fix
References: <4040E7B5.4020709@pobox.com> <1078001357.2020.90.camel@mulgrave>	 <404106D7.8050809@pobox.com> <1078075560.12938.1420.camel@lotte.street-vision.com>
In-Reply-To: <1078075560.12938.1420.camel@lotte.street-vision.com>
Content-Type: multipart/mixed;
 boundary="------------080409080001090903070800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080409080001090903070800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Justin Cormack wrote:
> Thanks, testing James's fix on one machine at the moment. Will have
> another six or so machines as a libata test farm tomorrow.


You'll need a few more changes...  here's the final patch.

	Jeff



--------------080409080001090903070800
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1682  -> 1.1683 
#	drivers/scsi/libata-core.c	1.19    -> 1.20   
#	 drivers/scsi/scsi.c	1.136   -> 1.137  
#	drivers/scsi/scsi_priv.h	1.30    -> 1.31   
#	include/scsi/scsi_cmnd.h	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/28	jgarzik@redhat.com	1.1683
# [libata] Use scsi_finish_command as completion function,
# in our error handling thread callback.
# 
# This also exports scsi_finish_command in the SCSI layer.
# 
# Thanks much to James Bottomley and his patience, as this solution
# was figured out.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Sun Feb 29 12:30:47 2004
+++ b/drivers/scsi/libata-core.c	Sun Feb 29 12:30:47 2004
@@ -2005,6 +2005,14 @@
 		goto out;
 	}
 
+	/* hack alert!  We cannot use the supplied completion
+	 * function from inside the ->eh_strategy_handler() thread.
+	 * libata is the only user of ->eh_strategy_handler() in
+	 * any kernel, so the default scsi_done() assumes it is
+	 * not being called from the SCSI EH.
+	 */
+	qc->scsidone = scsi_finish_command;
+
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA_READ:
 	case ATA_PROT_DMA_WRITE:
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Sun Feb 29 12:30:47 2004
+++ b/drivers/scsi/scsi.c	Sun Feb 29 12:30:47 2004
@@ -847,6 +847,7 @@
 
 	cmd->done(cmd);
 }
+EXPORT_SYMBOL(scsi_finish_command);
 
 /*
  * Function:	scsi_adjust_queue_depth()
diff -Nru a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
--- a/drivers/scsi/scsi_priv.h	Sun Feb 29 12:30:47 2004
+++ b/drivers/scsi/scsi_priv.h	Sun Feb 29 12:30:47 2004
@@ -77,7 +77,6 @@
 extern int scsi_setup_command_freelist(struct Scsi_Host *shost);
 extern void scsi_destroy_command_freelist(struct Scsi_Host *shost);
 extern void scsi_done(struct scsi_cmnd *cmd);
-extern void scsi_finish_command(struct scsi_cmnd *cmd);
 extern int scsi_retry_command(struct scsi_cmnd *cmd);
 extern int scsi_insert_special_req(struct scsi_request *sreq, int);
 extern void scsi_init_cmd_from_req(struct scsi_cmnd *cmd,
diff -Nru a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
--- a/include/scsi/scsi_cmnd.h	Sun Feb 29 12:30:47 2004
+++ b/include/scsi/scsi_cmnd.h	Sun Feb 29 12:30:47 2004
@@ -159,5 +159,6 @@
 extern struct scsi_cmnd *scsi_get_command(struct scsi_device *, int);
 extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int, unsigned int);
+extern void scsi_finish_command(struct scsi_cmnd *cmd);
 
 #endif /* _SCSI_SCSI_CMND_H */

--------------080409080001090903070800--

