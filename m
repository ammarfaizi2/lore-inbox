Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbTEDUJU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 16:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbTEDUJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 16:09:20 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32180 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261618AbTEDUJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 16:09:18 -0400
Date: Sun, 4 May 2003 22:21:26 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make floppy driver useable for 2.5
Message-ID: <Pine.SOL.4.30.0305042201080.7538-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I fixed two bugs introduced by some 2.5 changes:

- O_NDELAY handling typo in floppy_open()

- handling of failed transfers in floppy_end_request()
  (do equivalent of what 2.4 does)

Without first fix I was getting "floppy0: disk absent or changed during
operation" infinite loop on opening and without second fix, infinite loop
on error retry.

Now floppy driver seems to be (somehow) working :-).

Please apply,
--
Bartlomiej

--- linux-2.5.68-bk6/drivers/block/floppy.c	Sat Apr 26 18:14:24 2003
+++ linux/drivers/block/floppy.c	Sun May  4 21:57:36 2003
@@ -2293,7 +2293,12 @@

 static void floppy_end_request(struct request *req, int uptodate)
 {
-	if (end_that_request_first(req, uptodate, current_count_sectors))
+	unsigned int nr_sectors = current_count_sectors;
+
+	/* current_count_sectors can be zero if transfer failed */
+	if (!uptodate)
+		nr_sectors = req->current_nr_sectors;
+	if (end_that_request_first(req, uptodate, nr_sectors))
 		return;
 	add_disk_randomness(req->rq_disk);
 	floppy_off((long)req->rq_disk->private_data);
@@ -3768,7 +3773,7 @@
 	if (UFDCS->rawcmd == 1)
 		UFDCS->rawcmd = 2;

-	if (!filp->f_flags & O_NDELAY) {
+	if (!(filp->f_flags & O_NDELAY)) {
 		if (filp->f_mode & 3) {
 			UDRS->last_checked = 0;
 			check_disk_change(inode->i_bdev);

