Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSJUHaD>; Mon, 21 Oct 2002 03:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbSJUHaD>; Mon, 21 Oct 2002 03:30:03 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:25056 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261206AbSJUHaA>; Mon, 21 Oct 2002 03:30:00 -0400
Date: Mon, 21 Oct 2002 00:37:18 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi_error device offline fix
Message-ID: <20021021073718.GB3197@beaverton.ibm.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects a problem in scsi error handling.

When a device is offlined indicated by a message like ...Device offlined
- not ready...

the command return status was not being updated with a failure status if
the IO was a timeout.

I tested the patch on system with ips, aic, and qlogic fc adapters, but
was unable to generate a satisfactory device offline test case.

I did test this fix on uml with scsi_debug and generated a device
offline condition with verified this fix was working correctly.

-andmike
--
Michael Anderson
andmike@us.ibm.com

 scsi_error.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)
------

===== drivers/scsi/scsi_error.c 1.18 vs edited =====
--- 1.18/drivers/scsi/scsi_error.c	Thu Oct 17 10:52:39 2002
+++ edited/drivers/scsi/scsi_error.c	Sat Oct 19 15:24:06 2002
@@ -1145,14 +1145,18 @@
 		if (!scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR))
 			continue;
 
-		printk(KERN_INFO "%s: Device offlined - not"
+		printk(KERN_INFO "scsi: Device offlined - not"
 				" ready or command retry failed"
 				" after error recovery: host"
 				" %d channel %d id %d lun %d\n",
-				__FUNCTION__, shost->host_no,
+				shost->host_no,
 				scmd->device->channel,
 				scmd->device->id,
 				scmd->device->lun);
+
+		if (scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_TIMEOUT))
+			scmd->result |= (DRIVER_TIMEOUT << 24);
+
 		scmd->device->online = FALSE;
 		scsi_eh_finish_cmd(scmd, shost);
 	}
