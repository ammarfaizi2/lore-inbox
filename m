Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266083AbUALIa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 03:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUALIa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 03:30:57 -0500
Received: from [61.51.120.139] ([61.51.120.139]:17653 "EHLO exavio.com.cn")
	by vger.kernel.org with ESMTP id S266080AbUALIay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 03:30:54 -0500
Message-ID: <4002CC23.6000105@exavio.com.cn>
Date: Mon, 12 Jan 2004 16:32:35 +0000
From: Peter Yao <peter@exavio.com.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: smp dead lock of io_request_lock/queue_lock patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: peter@exavio.com.cn
X-Spam-Processed: exavio.com.cn, Mon, 12 Jan 2004 16:30:05 +0800
	(not processed: message from valid local sender)
X-Return-Path: peter@exavio.com.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I found a smp dead lock in io_request_lock/queue_lock patch in redhat's
2.4.18-4 kernel. I don't know how this patch is going on, just put my
fix for it here. :)
The dead lock is for scsi host->lock and scsi q->queue_lock between
scsi_restart_operations@scsi_error.c and scsi_request_fn@scsi_lib.c.


Index: scsi_error.c
===================================================================
RCS file:
/home/cvsroot/ieee1394_driver/linux-2.4.18-3/drivers/scsi/scsi_error.c,v
retrieving revision 1.13
retrieving revision 1.13.8.1
diff -Llinux-2.4.18-3/drivers/scsi/scsi_error.c
-Llinux-2.4.18-3/drivers/scsi/scsi_error.c -u -d -r1.13 -r1.13.8.1
--- linux-2.4.18-3/drivers/scsi/scsi_error.c
+++ linux-2.4.18-3/drivers/scsi/scsi_error.c
@@ -1293,11 +1293,11 @@
 			break;
 		}
 		q = &SDpnt->request_queue;
-		spin_lock(q->queue_lock);
 		spin_unlock(host->lock);
+		spin_lock(q->queue_lock);
 		q->request_fn(q);
-		spin_lock(host->lock);
 		spin_unlock(q->queue_lock);
+		spin_lock(host->lock);
 	}
 	spin_unlock_irqrestore(host->lock, flags);
 }

