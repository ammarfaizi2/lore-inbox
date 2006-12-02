Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162442AbWLBDqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162442AbWLBDqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 22:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162760AbWLBDqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 22:46:53 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:25555 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162442AbWLBDqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 22:46:52 -0500
Date: Fri, 1 Dec 2006 19:49:47 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org, dm-crypt@saout.de,
       Andrey <dm-crypt-revealed-address@lelik.org>,
       Andrew Morton <akpm@osdl.org>, agk@redhat.com,
       Neil Brown <neilb@suse.de>, Jens Axboe <jens.axboe@oracle.com>,
       Chris Wright <chrisw@sous-sol.org>, stable@kernel.org
Subject: Re: [stable][PATCH < 2.6.19] Fix data corruption with dm-crypt over RAID5
Message-ID: <20061202034947.GE6602@sequoia.sous-sol.org>
References: <456B732F.6080906@lelik.org> <20061129145208.GQ4409@agk.surrey.redhat.com> <456F46E3.6030702@lelik.org> <1164983209.24524.20.camel@leto.intern.saout.de> <20061201152143.GE4409@agk.surrey.redhat.com> <45704B95.3020308@lelik.org> <1165026116.29307.18.camel@leto.intern.saout.de> <1165026476.29307.23.camel@leto.intern.saout.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165026476.29307.23.camel@leto.intern.saout.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: please Cc: stable@kernel.org on -stable patches]

* Christophe Saout (christophe@saout.de) wrote:
> Fix corruption issue with dm-crypt on top of software raid5. Cancelled
> readahead bio's that report no error, just have BIO_UPTODATE cleared
> were reported as successful reads to the higher layers (and leaving
> random content in the buffer cache). Already fixed in 2.6.19.

I take it this is fixed a different way in 2.6.19?  Mind clarifying the
difference?

> Signed-off-by: Christophe Saout <christophe@saout.de>
> 
> 
> --- linux-2.6.18.orig/drivers/md/dm-crypt.c	2006-09-20 05:42:06.000000000 +0200
> +++ linux-2.6.18/drivers/md/dm-crypt.c	2006-12-02 03:03:36.000000000 +0100
> @@ -717,13 +717,15 @@
>  	if (bio->bi_size)
>  		return 1;
>  
> +	if (!bio_flagged(bio, BIO_UPTODATE) && !error)
> +		error = -EIO;
> +                        

Minor nit:  introduces trailing whitespaces, cleaned it up locally.

thanks,
-chris
--

This is a note to let you know that we have just queued up the patch titled

    Subject: dm crypt: Fix data corruption with dm-crypt over RAID5

to the 2.6.18-stable tree.  Its filename is

    dm-crypt-fix-data-corruption-with-dm-crypt-over-raid5.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From linux-kernel-owner+chrisw=40sous-sol.org-S1162719AbWLBC2Z@vger.kernel.org  Fri Dec  1 18:36:19 2006
Date: 	Sat, 02 Dec 2006 03:27:56 +0100
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
Cc: dm-crypt@saout.de, Andrey <dm-crypt-revealed-address@lelik.org>, Andrew Morton <akpm@osdl.org>, agk@redhat.com, Neil Brown <neilb@suse.de>, Jens Axboe <jens.axboe@oracle.com>, Chris Wright <chrisw@sous-sol.org>
Subject: dm crypt: Fix data corruption with dm-crypt over RAID5

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
