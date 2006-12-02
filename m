Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162719AbWLBC2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162719AbWLBC2Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 21:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162720AbWLBC2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 21:28:25 -0500
Received: from websrv.werbeagentur-aufwind.de ([88.198.253.206]:5055 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S1162719AbWLBC2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 21:28:24 -0500
Subject: [stable][PATCH < 2.6.19] Fix data corruption with dm-crypt over
	RAID5
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
Cc: dm-crypt@saout.de, Andrey <dm-crypt-revealed-address@lelik.org>,
       Andrew Morton <akpm@osdl.org>, agk@redhat.com,
       Neil Brown <neilb@suse.de>, Jens Axboe <jens.axboe@oracle.com>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <1165026116.29307.18.camel@leto.intern.saout.de>
References: <456B732F.6080906@lelik.org>
	 <20061129145208.GQ4409@agk.surrey.redhat.com> <456F46E3.6030702@lelik.org>
	 <1164983209.24524.20.camel@leto.intern.saout.de>
	 <20061201152143.GE4409@agk.surrey.redhat.com>  <45704B95.3020308@lelik.org>
	 <1165026116.29307.18.camel@leto.intern.saout.de>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 03:27:56 +0100
Message-Id: <1165026476.29307.23.camel@leto.intern.saout.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix corruption issue with dm-crypt on top of software raid5. Cancelled
readahead bio's that report no error, just have BIO_UPTODATE cleared
were reported as successful reads to the higher layers (and leaving
random content in the buffer cache). Already fixed in 2.6.19.

Signed-off-by: Christophe Saout <christophe@saout.de>


--- linux-2.6.18.orig/drivers/md/dm-crypt.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/drivers/md/dm-crypt.c	2006-12-02 03:03:36.000000000 +0100
@@ -717,13 +717,15 @@
 	if (bio->bi_size)
 		return 1;
 
+	if (!bio_flagged(bio, BIO_UPTODATE) && !error)
+		error = -EIO;
+                        
 	bio_put(bio);
 
 	/*
 	 * successful reads are decrypted by the worker thread
 	 */
-	if ((bio_data_dir(bio) == READ)
-	    && bio_flagged(bio, BIO_UPTODATE)) {
+	if (bio_data_dir(io->bio) == READ && !error) {
 		kcryptd_queue_io(io);
 		return 0;
 	}


