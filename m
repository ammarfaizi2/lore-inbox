Return-Path: <linux-kernel-owner+w=401wt.eu-S932163AbWLOBdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWLOBdM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWLOBdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:33:12 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45976 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbWLOBdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:33:10 -0500
Message-Id: <20061215013546.475996000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:44 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Christophe Saout <christophe@saout.de>
Subject: [patch 07/24] dm crypt: Fix data corruption with dm-crypt over RAID5
Content-Disposition: inline; filename=dm-crypt-fix-data-corruption-with-dm-crypt-over-raid5.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Christophe Saout <christophe@saout.de>

Fix corruption issue with dm-crypt on top of software raid5. Cancelled
readahead bio's that report no error, just have BIO_UPTODATE cleared
were reported as successful reads to the higher layers (and leaving
random content in the buffer cache). Already fixed in 2.6.19.

Signed-off-by: Christophe Saout <christophe@saout.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/md/dm-crypt.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.18.5.orig/drivers/md/dm-crypt.c
+++ linux-2.6.18.5/drivers/md/dm-crypt.c
@@ -717,13 +717,15 @@ static int crypt_endio(struct bio *bio, 
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

--
