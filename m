Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUCWAk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 19:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUCWAk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 19:40:57 -0500
Received: from av7-1-sn1.fre.skanova.net ([81.228.11.113]:51686 "EHLO
	av7-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261708AbUCWAk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 19:40:56 -0500
Date: Tue, 23 Mar 2004 01:40:49 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: linux-kernel@vger.kernel.org
Subject: ide-cd bug (MODE_SENSE/CDROM_SEND_PACKET)
Message-ID: <20040323004049.GA931@ibrium.se>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If a MODE_SENSE(6) command is sent to an IDE cd using the CDROM_SEND_PACKET
ioctl, then the kernel freezes solidly. To reproduce this, one can take the
SCSI cmd [1a 08 31 00 10 00] and a 16 byte data buffer.

After some bug hunting, I found out that the following is what happens:

- ide-cd recognizes that MODE_SENSE(6) isn't supported and tries
to abort the request from ide_cdrom_prep_pc by returning BLKPREP_KILL.

- in elv_next_request(), the kill request is handled by
the following code:

	while (end_that_request_first(rq, 0, rq->nr_sectors))
		;
	end_that_request_last(rq);

The while loop never exits. The end_that_request_first() doesn't do anything
since rq->nr_sectors is 0; it just returns "not-done" after handling those 0
bytes (rq->bio->bi_size is 16).

I'm not quite sure how to fix this properly. For one thing, the data buffer
associated with the MODE_SENSE command is not sector sized in the first
place...

This is with a recent 2.6.5-rc1 kernel built from the BK tree.


/Samuel
