Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbVKRTlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbVKRTlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbVKRTlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:41:21 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:43683 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161020AbVKRTlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:41:20 -0500
Message-ID: <437E2E5D.1050300@us.ibm.com>
Date: Fri, 18 Nov 2005 11:41:17 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 4/8] Fix a bug in scsi_get_command
References: <437E2C69.4000708@us.ibm.com>
In-Reply-To: <437E2C69.4000708@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------070300010604030905020002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070300010604030905020002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Testing this patch series uncovered a small bug in scsi_get_command.  This
patch fixes that bug.

-Matt

--------------070300010604030905020002
Content-Type: text/x-patch;
 name="scsi_get_command-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_get_command-fix.patch"

scsi_get_command() attempts to write into a structure that may not have been
successfully allocated.  Move this write inside the if statement that ensures
we won't panic the kernel with a NULL pointer dereference.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.15-rc1+critical_pool/drivers/scsi/scsi.c
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/drivers/scsi/scsi.c	2005-11-15 13:45:38.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/drivers/scsi/scsi.c	2005-11-17 16:49:54.279656112 -0800
@@ -265,10 +265,10 @@ struct scsi_cmnd *scsi_get_command(struc
 		spin_lock_irqsave(&dev->list_lock, flags);
 		list_add_tail(&cmd->list, &dev->cmd_list);
 		spin_unlock_irqrestore(&dev->list_lock, flags);
+		cmd->jiffies_at_alloc = jiffies;
 	} else
 		put_device(&dev->sdev_gendev);
 
-	cmd->jiffies_at_alloc = jiffies;
 	return cmd;
 }				
 EXPORT_SYMBOL(scsi_get_command);

--------------070300010604030905020002--
