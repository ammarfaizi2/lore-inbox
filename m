Return-Path: <linux-kernel-owner+w=401wt.eu-S1423003AbWLUST5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423003AbWLUST5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423004AbWLUST5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:19:57 -0500
Received: from brick.kernel.dk ([62.242.22.158]:25492 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423003AbWLUST4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:19:56 -0500
Date: Thu, 21 Dec 2006 19:21:47 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request() to be  called from interrupt context
Message-ID: <20061221182147.GY17199@kernel.dk>
References: <20061220184917.GJ10535@kernel.dk> <20061220.165549.39151582.k-ueda@ct.jp.nec.com> <20061221075305.GD17199@kernel.dk> <20061221.131118.39151032.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221.131118.39151032.k-ueda@ct.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21 2006, Kiyoshi Ueda wrote:
> Hi Jens,
> 
> OK, I understand that.
> But I think that the block layer assumption (depending on "current")
> is not ideal.
> Anyway, thank you for the information.

(don't top post)

Well, how else would you throttle request allocations on a process
basis? IO priorities don't extend to request allocation yet, but if/when
they do, this will extend it. It may not be ideal for your situation,
but it is for a host of other uses.

It's relatively easy to do this in the driver - you need one request
allocated at init time, as a backup. Then instead of using
blk_get_request(), you use use kmalloc or kmem_cache_alloc from the
block dev rq pool. If the allocation fails and you have nothing in
flight, you grab the request you allocated at init time and use that.
Export the rq initialization as needed from ll_rw_blk.c.

And that's it, really. Without uglification to ll_rw_blk.c or stripping
features from that.

-- 
Jens Axboe

