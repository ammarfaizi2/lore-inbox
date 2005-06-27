Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVF0Ors@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVF0Ors (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVF0Ors
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:47:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:34512 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262096AbVF0MV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:21:29 -0400
Message-ID: <42BFEF45.8000302@pobox.com>
Date: Mon, 27 Jun 2005 08:21:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patch] 2.6.x libata fix
Content-Type: multipart/mixed;
 boundary="------------000005040907070609080203"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000005040907070609080203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from the 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the fix (and cleanup) described in the attachment.


--------------000005040907070609080203
Content-Type: text/plain;
 name="libata-dev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev.txt"

 drivers/scsi/libata-scsi.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)


Philip Pokorny:
  libata fix read capacity handling for more than 2TB


diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1176,8 +1176,12 @@ unsigned int ata_scsiop_read_cap(struct 
 		n_sectors = ata_id_u32(args->id, 60);
 	n_sectors--;		/* ATA TotalUserSectors - 1 */
 
-	tmp = n_sectors;	/* note: truncates, if lba48 */
 	if (args->cmd->cmnd[0] == READ_CAPACITY) {
+		if( n_sectors >= 0xffffffffULL )
+			tmp = 0xffffffff ;  /* Return max count on overflow */
+		else
+			tmp = n_sectors ;
+
 		/* sector count, 32-bit */
 		rbuf[0] = tmp >> (8 * 3);
 		rbuf[1] = tmp >> (8 * 2);
@@ -1191,10 +1195,12 @@ unsigned int ata_scsiop_read_cap(struct 
 
 	} else {
 		/* sector count, 64-bit */
-		rbuf[2] = n_sectors >> (8 * 7);
-		rbuf[3] = n_sectors >> (8 * 6);
-		rbuf[4] = n_sectors >> (8 * 5);
-		rbuf[5] = n_sectors >> (8 * 4);
+		tmp = n_sectors >> (8 * 4);
+		rbuf[2] = tmp >> (8 * 3);
+		rbuf[3] = tmp >> (8 * 2);
+		rbuf[4] = tmp >> (8 * 1);
+		rbuf[5] = tmp;
+		tmp = n_sectors;
 		rbuf[6] = tmp >> (8 * 3);
 		rbuf[7] = tmp >> (8 * 2);
 		rbuf[8] = tmp >> (8 * 1);

--------------000005040907070609080203--
