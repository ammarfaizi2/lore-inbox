Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWJKMun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWJKMun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWJKMun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:50:43 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:58092 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751243AbWJKMum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:50:42 -0400
Subject: [PATCH 1/3] drivers/scsi/ibmmca.c: Replacing yield() with a better
	alternative
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: James.Bottomley@steeleye.com,
       kernel Janitors <kernel-janitors@lists.osdl.org>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 18:24:01 +0530
Message-Id: <1160571241.19143.318.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6, the semantics of calling yield() changed from "sleep for a
bit" to "I really don't want to run for a while".  This matches POSIX
better, but there's a lot of drivers still using yield() when they mean
cond_resched(), schedule() or even schedule_timeout().

For this driver cond_resched() seems to be a better
alternative

Tested compile only

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/scsi/ibmmca.c linux-2.6.19-rc1/drivers/scsi/ibmmca.c
--- linux-2.6.19-rc1-orig/drivers/scsi/ibmmca.c	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.19-rc1/drivers/scsi/ibmmca.c	2006-10-11 17:57:02.000000000 +0530
@@ -2268,7 +2268,7 @@ static int __ibmmca_host_reset(Scsi_Cmnd
 		if (!(inb(IM_STAT_REG(host_index)) & IM_BUSY))
 			break;
 		spin_unlock_irq(shpnt->host_lock);
-		yield();
+		cond_resched();
 		spin_lock_irq(shpnt->host_lock);
 	}
 	/*write registers and enable system interrupts */


