Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135403AbRDRWKu>; Wed, 18 Apr 2001 18:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135404AbRDRWKk>; Wed, 18 Apr 2001 18:10:40 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:30675 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S135403AbRDRWKa>;
	Wed, 18 Apr 2001 18:10:30 -0400
From: Khalid Aziz <khalid@lyra.fc.hp.com>
Message-Id: <200104182211.QAA09466@lyra.fc.hp.com>
Subject: [PATCH] SCSI command bytes are copied twice
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Apr 2001 16:11:04 -0600 (MDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI subsystem needs to copy the SCSI command bytes into a Scsi_Request 
structure for a SCSI command being issued by one of the higher level
drivers before it queues the command up. It does this copy twice. Even
though this will cause no more than 12 bytes to be copied twice, this
code is still invoked frequently enough to justify not incurring the 
overhead of a redundant copy. Following patch should fix this.

Thanks,
Khalid

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO



--- linux-2.4.3-orig/drivers/scsi/scsi.c	Fri Feb  9 12:30:23 2001
+++ linux-2.4.3/drivers/scsi/scsi.c	Wed Apr 18 14:22:00 2001
@@ -832,9 +832,6 @@
 	SRpnt->sr_allowed = retries;
 	SRpnt->sr_done = done;
 	SRpnt->sr_timeout_per_command = timeout;
-
-	memcpy((void *) SRpnt->sr_cmnd, (const void *) cmnd, 
-	       sizeof(SRpnt->sr_cmnd));
 
 	if (SRpnt->sr_cmd_len == 0)
 		SRpnt->sr_cmd_len = COMMAND_SIZE(SRpnt->sr_cmnd[0]);
