Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWGBALP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWGBALP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 20:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWGBALP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 20:11:15 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:6850 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751500AbWGBALO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 20:11:14 -0400
Subject: Re: 2.6.17-mm5
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       Grant Wilson <grant.wilson@zen.co.uk>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20060701225639.GC12703@havoc.gtf.org>
References: <20060701033524.3c478698.akpm@osdl.org>
	 <20060701142419.GB28750@tlg.swandive.local>
	 <20060701143047.b3975472.akpm@osdl.org>
	 <1151792765.3438.30.camel@mulgrave.il.steeleye.com>
	 <17574.63484.261979.866512@cse.unsw.edu.au>
	 <20060701225639.GC12703@havoc.gtf.org>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 19:10:42 -0500
Message-Id: <1151799042.3438.40.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 18:56 -0400, Jeff Garzik wrote:
> On Sun, Jul 02, 2006 at 08:32:28AM +1000, Neil Brown wrote:
> > The problem seems to be simply that on some hardware at least,
> > BIO_RW_BARRIER writes result in an EIO.  Don't know why yet.
> 
> Could be that <whatever device> is choking on FLUSH CACHE (ATA)
> or SYNCHRONIZE CACHE (SCSI).
> 
> That's one possible reason why EIO may result from a barrier...

There is no barrier implementation on SCSI (basically you can't maintain
barriers in the face of TCQ, so only depth one devices can do it and
hence all the scsi drivers turn it off), so it must be a FLUSH CACHE.

This one looks like it went down via prepare_flush rather than
issue_flush, so the normal error printing case that issue flush has is
skipped.  This patch should tell us what the error was on the command.

James

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3d04a9f..3e3e3b7 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1162,7 +1162,20 @@ static int scsi_issue_flush_fn(request_q
 
 static void scsi_blk_pc_done(struct scsi_cmnd *cmd)
 {
+	int res = cmd->result;
+	struct scsi_sense_hdr sshdr;
+
 	BUG_ON(!blk_pc_request(cmd->request));
+	if (!res) {
+		printk(KERN_ERR "REQ_BLOCK_PC FAILED for ");
+		__scsi_print_command(cmd->cmnd);
+		printk(KERN_ERR "FAILED\n  status = %x, message = %02x, "
+		       "host = %d, driver = %02x\n  ",
+		       status_byte(res), msg_byte(res),
+		       host_byte(res), driver_byte(res));
+		if (scsi_command_normalize_sense(cmd, &sshdr))
+			scsi_print_sense_hdr("sd", &sshdr);
+	}
 	/*
 	 * This will complete the whole command with uptodate=1 so
 	 * as far as the block layer is concerned the command completed


James


