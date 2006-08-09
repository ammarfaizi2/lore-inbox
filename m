Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWHIPf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWHIPf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWHIPfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:35:25 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:59517 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751020AbWHIPfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:35:21 -0400
Date: Wed, 9 Aug 2006 17:31:16 +0200
From: Andreas Herrmann <aherrman@de.ibm.com>
To: James Bottomley <jejb@steeleye.com>
Cc: Linux SCSI <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] limit recursion when flushing shost->starved_list
Message-ID: <20060809153116.GA14043@lion28.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Attached is a patch that should limit a possible recursion that can
lead to a stack overflow like follows:

Kernel stack overflow.
CPU:    3    Not tainted
Process zfcperp0.0.d819
(pid: 13897, task: 000000003e0d8cc8, ksp: 000000003499dbb8)
Krnl PSW : 0404000180000000 000000000030f8b2 (get_device+0x12/0x48)
Krnl GPRS: 00000000135a1980 000000000030f758 000000003ed6c1e8 0000000000000005
           0000000000000000 000000000044a780 000000003dbf7000 0000000034e15800
           000000003621c048 070000003499c108 000000003499c1a0 000000003ed6c000
           0000000040895000 00000000408ab630 000000003499c0a0 000000003499c0a0
Krnl Code: a7 fb ff e8 a7 19 00 00 b9 02 00 22 e3 e0 f0 98 00 24 a7 84 
Call Trace:
([<000000004089edc2>] scsi_request_fn+0x13e/0x650 [scsi_mod])
 [<00000000002c5ff4>] blk_run_queue+0xd4/0x1a4
 [<000000004089ff8c>] scsi_queue_insert+0x22c/0x2a4 [scsi_mod]
 [<000000004089779a>] scsi_dispatch_cmd+0x8a/0x3d0 [scsi_mod]
 [<000000004089f1ec>] scsi_request_fn+0x568/0x650 [scsi_mod]
...
 [<000000004089f1ec>] scsi_request_fn+0x568/0x650 [scsi_mod]
 [<00000000002c5ff4>] blk_run_queue+0xd4/0x1a4
 [<000000004089ff8c>] scsi_queue_insert+0x22c/0x2a4 [scsi_mod]
 [<000000004089779a>] scsi_dispatch_cmd+0x8a/0x3d0 [scsi_mod]
 [<000000004089f1ec>] scsi_request_fn+0x568/0x650 [scsi_mod]
 [<00000000002c5ff4>] blk_run_queue+0xd4/0x1a4
 [<000000004089fa9e>] scsi_run_host_queues+0x196/0x230 [scsi_mod]
 [<00000000409eba28>] zfcp_erp_thread+0x2638/0x3080 [zfcp]
 [<0000000000107462>] kernel_thread_starter+0x6/0xc
 [<000000000010745c>] kernel_thread_starter+0x0/0xc
<0>Kernel panic - not syncing: Corrupt kernel stack, can't continue.

This stack overflow occurred during tests on s390 using zfcp.
Recursion depth for this panic was 19.

Usually recursion between blk_run_queue and a request_fn is avoided
using QUEUE_FLAG_REENTER. But this does not help if the scsi stack
tries to flush the starved_list of a scsi_host.


Regards,

Andreas


Limit recursion depth when flushing the starved_list
of a scsi_host.

Signed-off-by: Andreas Herrmann <aherrman@de.ibm.com>

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 077c1c6..d6743b9 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -551,7 +551,15 @@ static void scsi_run_queue(struct reques
 		list_del_init(&sdev->starved_entry);
 		spin_unlock_irqrestore(shost->host_lock, flags);
 
-		blk_run_queue(sdev->request_queue);
+
+		if (test_bit(QUEUE_FLAG_REENTER, &q->queue_flags) &&
+		    !test_and_set_bit(QUEUE_FLAG_REENTER,
+				      &sdev->request_queue->queue_flags)) {
+			blk_run_queue(sdev->request_queue);
+			clear_bit(QUEUE_FLAG_REENTER,
+				  &sdev->request_queue->queue_flags);
+		} else
+			blk_run_queue(sdev->request_queue);
 
 		spin_lock_irqsave(shost->host_lock, flags);
 		if (unlikely(!list_empty(&sdev->starved_entry)))
