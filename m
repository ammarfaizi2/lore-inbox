Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751975AbWKBQbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbWKBQbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWKBQbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:31:44 -0500
Received: from palrel12.hp.com ([156.153.255.237]:20175 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1751975AbWKBQbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:31:43 -0500
Date: Thu, 2 Nov 2006 10:31:35 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 9/8] cciss: add busy_configuring test to check_queues
Message-ID: <20061102163135.GA23148@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 9 of 8

Sorry for the messed up sequence. There are actually 11 total patches.
This patch adds a check for busy_configuring to prevent starting a queue
on a drive that may be in the midst of updating, configuring, deleting, etc.

This had a test for if the queue was stopped or plugged but that seemed
to cause issues and others thought the test unnecessary.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)
--------------------------------------------------------------------------------
diff -urNp linux-2.6-p00008/drivers/block/cciss.c linux-2.6-p00009/drivers/block/cciss.c
--- linux-2.6-p00008/drivers/block/cciss.c	2006-10-31 16:10:12.000000000 -0600
+++ linux-2.6-p00009/drivers/block/cciss.c	2006-11-02 09:42:39.000000000 -0600
@@ -1190,8 +1190,11 @@ static void cciss_check_queues(ctlr_info
 		/* make sure the disk has been added and the drive is real
 		 * because this can be called from the middle of init_one.
 		 */
-		if (!(h->drv[curr_queue].queue) || !(h->drv[curr_queue].heads))
+		if (!(h->drv[curr_queue].queue) ||
+		    !(h->drv[curr_queue].heads) ||
+		    h->drv[curr_queue].busy_configuring)
 			continue;
+
 		blk_start_queue(h->gendisk[curr_queue]->queue);
 
 		/* check to see if we have maxed out the number of commands
