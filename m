Return-Path: <linux-kernel-owner+w=401wt.eu-S1751439AbXARB1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbXARB1O (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 20:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXARB1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 20:27:14 -0500
Received: from smtp-3.smtp.ucla.edu ([169.232.48.136]:45123 "EHLO
	smtp-3.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXARB1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 20:27:13 -0500
X-Greylist: delayed 1101 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 20:27:13 EST
Date: Wed, 17 Jan 2007 17:08:51 -0800
From: Chris Frost <frost@cs.ucla.edu>
To: linux-kernel@vger.kernel.org
Cc: KudOS <kudos@lists.ucla.edu>
Subject: block_device usage and incorrect block writes
Message-ID: <20070118010851.GA28129@pooh.cs.ucla.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	KudOS <kudos@lists.ucla.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: Send email with subject 'retrieve pgp key'
X-PGP-Fingerprint: Send email with subject 'retrieve pgp fingerprint'
User-Agent: Mutt/1.5.12-2006-07-14
X-Probable-Spam: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are working on a kernel module which uses the linux block device
interface as part of a larger project, are seeing unexpected block write
behavior from our usage of the noop scheduler, and were wondering whether
anyone might have feedback on what the behavior we see?

We would like to send block writes such that they are written to the
drive controller in fifo order, so we are using the noop scheduler.
However, a small percentage (1-5 of ~50,000) of block writes
end up with incorrect data on the disk. We have determined that for each
of these incorrect blocks, the last write for the block was issued while
a previous write to the block was still queued (that is, the bio end
function had not yet been called) and that the next to last issued
write (that is, the generic_make_request function call) for the block contains
the data that ends up on the disk.

Here are more details we have noticed. The behavior appears to be
timing sensitive; multiple runs each may or may not work and
introducing slow downs (i.e. write barriers or many printks) make the
problem disappear with high certainty. About 2% of our block device
writes are writes to a block when there is still a write to that block
in the queue. About 0.3% of these 2% result in incorrect data on
the disk.

A possibly related (and unexpected) behavior we have noticed is that the
bio end function is not always called in the same order as our calls
to generic_make_request(). We are not sure whether this indicates that
the requests are being written to disk in the callback order, but would
like to fix this if so (since we want the writes made in the order of our
requests).

Below is the essence of our write code. We also make read requests, but do
not include the read code below.

struct block_device *dev;

int my_end(struct bio *bio, unsigned int done, int error)
{
	if (bio->bi_size)
		return 1; /* everyone else (in 2.6.12) returns in this case */
	__free_page(bio_iovec_idx(bio, 0)->bv_page);
	bio_iovec_idx(bio, 0)->bv_page = NULL:
	bio_iovec_idx(bio, 0)->bv_len = 0:
	bio_iovec_idx(bio, 0)->bv_offset = 0:
	bio_put(bio);
	return error;
}

void write_block(...)
{
	struct bio *bio = bio_alloc(GFP_KERNEL, 1);

	struct bio_vec *bv = bio_iovec_idx(bio, 0);
	bv->bv_page = alloc_page(GFP_KERNEL | GFP_DMA);
	memcpy(page_address(bv->bv_page), ...);
	bv->bv_len = ...;
	bv->bv_offset = 0;

	bio->bi_idx = 0;
	bio->bi_vcnt = 1;
	bio->bi_sector = ...;
	bio->bi_size = ...;
	bio->bi_bdev = dev;
	bio->bi_rw = WRITE;
	bio->bi_end_io = my_end;

	generic_make_request(bio);
}

void init(const char *path)
{
	path_lookup(path, LOOKUP_FOLLOW, nd);
	dev = open_by_devnum(nd.dentry->d_inode->i_rde, mode);
	bd_claim(dev, claimer);
}

thanks in advance for any feedback!
-- 
Chris Frost  |  <http://www.frostnet.net/chris/>
-------------+----------------------------------
Public PGP Key:
   Email chris@frostnet.net with the subject "retrieve pgp key"
   or visit <http://www.frostnet.net/chris/about/pgp_key.phtml>
