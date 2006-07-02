Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWGBPGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWGBPGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 11:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWGBPGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 11:06:47 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:30156 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932215AbWGBPGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 11:06:46 -0400
Subject: Re: 2.6.17-mm5 dislikes raid-1, just like mm4
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Grant Wilson <grant.wilson@zen.co.uk>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Neil Brown <neilb@suse.de>
In-Reply-To: <44A7D82A.80909@zen.co.uk>
References: <20060701033524.3c478698.akpm@osdl.org>
	 <20060701181455.GA16412@aitel.hist.no>
	 <20060701152258.bea091a6.akpm@osdl.org>  <44A7560B.3050000@reub.net>
	 <1151848394.3558.2.camel@mulgrave.il.steeleye.com>
	 <44A7D82A.80909@zen.co.uk>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 10:06:28 -0500
Message-Id: <1151852788.3558.10.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 15:28 +0100, Grant Wilson wrote:
> With the patch applied to 2.6.17-mm5 my RAID-1 is up and running on both
> SATA drives with no problems.

That's great, thanks.  Now we know what the problem patch is, I'd like
to try an 11th our correction of the logic fault in the original.  Could
you try this patch against original -mm (by reversing the previous
patch).  I think it should correct the problem?

Thanks,

James

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index bf5191f..08af9aa 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -920,22 +920,20 @@ void scsi_io_completion(struct scsi_cmnd
 	 * Next deal with any sectors which we were able to correctly
 	 * handle.
 	 */
-	if (good_bytes > 0) {
-		SCSI_LOG_HLCOMPLETE(1, printk("%ld sectors total, "
-					      "%d bytes done.\n",
-					      req->nr_sectors, good_bytes));
-		SCSI_LOG_HLCOMPLETE(1, printk("use_sg is %d\n", cmd->use_sg));
-
-		if (clear_errors)
-			req->errors = 0;
-
-		/* A number of bytes were successfully read.  If there
-		 * is leftovers and there is some kind of error
-		 * (result != 0), retry the rest.
-		 */
-		if (scsi_end_request(cmd, 1, good_bytes, !!result) == NULL)
-			return;
-	}
+	SCSI_LOG_HLCOMPLETE(1, printk("%ld sectors total, "
+				      "%d bytes done.\n",
+				      req->nr_sectors, good_bytes));
+	SCSI_LOG_HLCOMPLETE(1, printk("use_sg is %d\n", cmd->use_sg));
+
+	if (clear_errors)
+		req->errors = 0;
+
+	/* A number of bytes were successfully read.  If there
+	 * are leftovers and there is some kind of error
+	 * (result != 0), retry the rest.
+	 */
+	if (scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
+		return;
 
 	/* good_bytes = 0, or (inclusive) there were leftovers and
 	 * result = 0, so scsi_end_request couldn't retry.


