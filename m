Return-Path: <linux-kernel-owner+w=401wt.eu-S1751899AbXARCM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbXARCM4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 21:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXARCM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 21:12:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27523 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbXARCMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 21:12:55 -0500
Date: Thu, 18 Jan 2007 13:13:06 +1100
From: Jens Axboe <jens.axboe@oracle.com>
To: linux-kernel@vger.kernel.org, KudOS <kudos@lists.ucla.edu>
Subject: Re: block_device usage and incorrect block writes
Message-ID: <20070118021306.GA22842@kernel.dk>
References: <20070118010851.GA28129@pooh.cs.ucla.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118010851.GA28129@pooh.cs.ucla.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17 2007, Chris Frost wrote:
> We are working on a kernel module which uses the linux block device
> interface as part of a larger project, are seeing unexpected block
> write behavior from our usage of the noop scheduler, and were
> wondering whether anyone might have feedback on what the behavior we
> see?
> 
> We would like to send block writes such that they are written to the
> drive controller in fifo order, so we are using the noop scheduler.
> However, a small percentage (1-5 of ~50,000) of block writes end up
> with incorrect data on the disk. We have determined that for each of
> these incorrect blocks, the last write for the block was issued while
> a previous write to the block was still queued (that is, the bio end
> function had not yet been called) and that the next to last issued
> write (that is, the generic_make_request function call) for the block
> contains the data that ends up on the disk.

noop doesn't guarentee that IO will be queued with the device in the
order in which they are submitted, and it definitely doesn't guarentee
that the device will process them in the order in which they are
dispatched. noop being FIFO basically means that it will not sort
requests. You can still have reordering if one request gets merged with
another, for instance.

The block layer in general provides no guarentees about ordering of
requests, unless you use barriers. So if you require ordering across a
given write request, it needs to be a write barrier.

> A possibly related (and unexpected) behavior we have noticed is that
> the bio end function is not always called in the same order as our
> calls to generic_make_request(). We are not sure whether this
> indicates that the requests are being written to disk in the callback
> order, but would like to fix this if so (since we want the writes made
> in the order of our requests).

The drive could complete requests in any order it sees fit, within the
depth level of the drive. If write caching is enabled, it can reorder
writes easily.

-- 
Jens Axboe

