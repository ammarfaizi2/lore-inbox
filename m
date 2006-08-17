Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWHQW1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWHQW1v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWHQW1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:27:50 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:25991 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1030276AbWHQW1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:27:49 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=fhtjHXqBL4RtmkqFLkhbAZ3vzwsooo+AergSbb4sBq7X3jHOUTIHlW1vqdY7jXKQkfdnyjk75NrpyZqDrKPPeIQmhjbS5kpQsEVMgqaCJTqKELjQjqBSPHHJlon9ha4v;
X-IronPort-AV: i="4.08,140,1154926800"; 
   d="scan'208"; a="63172002:sNHT25449264"
Date: Thu, 17 Aug 2006 17:27:52 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: rq_flag_bits and bio bi_rw flags
Message-ID: <20060817222752.GA19442@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, I'm hoping you can clear something up for me.

ll_rw_blk.c:
void blk_rq_bio_prep(request_queue_t *q, struct request *rq, struct
bio *bio)
{
        /* first three bits are identical in rq->flags and bio->bi_rw
	*/
        rq->flags |= (bio->bi_rw & 7);

That was recently changed to be the first 2 bits not 3.  But it made
me look.

/*
 * bio bi_rw flags
 *
 * bit 0 -- read (not set) or write (set)
 * bit 1 -- rw-ahead when set
 * bit 2 -- barrier
 * bit 3 -- fail fast, don't want low level driver retries
 * bit 4 -- synchronous I/O hint: the block layer will unplug immediately
 */
#define BIO_RW          0
#define BIO_RW_AHEAD    1
#define BIO_RW_BARRIER  2
#define BIO_RW_FAILFAST 3
#define BIO_RW_SYNC     4


/*
 * first three bits match BIO_RW* bits, important
 */
enum rq_flag_bits {
        __REQ_RW,               /* not set, read. set, write */
        __REQ_FAILFAST,         /* no low level driver retries */
        __REQ_SORTED,           /* elevator knows about this request
	*/


The first bit matches.  The second doesn't (BIO_RW_AHEAD vs
__REQ_FAILFAST).  And obviously you just fixed the third bit.

Should BIO_RW_FAILFAST == __REQ_FAILFAST instead?

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
