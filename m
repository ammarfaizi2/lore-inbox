Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267272AbUBSU7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267305AbUBSU7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:59:52 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:34279 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S267272AbUBSU7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:59:47 -0500
Date: Thu, 19 Feb 2004 21:59:07 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, Andrew Morton <akpm@osdl.org>,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       thornber@redhat.com
Subject: Re: IO scheduler, queue depth, nr_requests
Message-ID: <20040219205907.GE32263@drinkel.cistron.nl>
References: <20040216131609.GA21974@cistron.nl> <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <20040218172622.52914567.akpm@osdl.org> <20040219021159.GE30621@drinkel.cistron.nl> <20040218182628.7eb63d57.akpm@osdl.org> <20040219101519.GG30621@drinkel.cistron.nl> <20040219101915.GJ27190@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040219101915.GJ27190@suse.de> (from axboe@suse.de on Thu, Feb 19, 2004 at 11:19:15 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 11:19:15, Jens Axboe wrote:
> On Thu, Feb 19 2004, Miquel van Smoorenburg wrote:
>
> > > Shouldn't the controller itself be performing the insertion?
> > 
> > Well, you would indeed expect the 3ware hardware to be smarter than
> > that, but in its defence, the driver doesn't set sdev->simple_tags or
> > sdev->ordered_tags at all. It just has a large queue on the host, in
> > hardware.
> 
> A too large queue. IMHO the simple and correct solution to your problem
> is to diminish the host queue (sane solution), or bump the block layer
> queue size (dumb solution).

Well, I did that. Lowering the queue size of the 3ware controller to 64
does help a bit, but performance is still not optimal - leaving it at 254
and increasing the nr_requests of the queue to 512 helps the most.

But the patch I posted does just as well, without any tuning. I changed
it a little though - it only has the "new" behaviour (instead of blocking
on allocating a request, allocate it, queue it, _then_ block) for WRITEs.
That results in the best performance I've seen, by far.

Now the style of my patch might be ugly, but what is conceptually wrong
with allocating the request and queueing it, then block if the queue is
full, versus blocking on allocating the request and keeping a bio
"stuck" for quite some time, resulting in out-of-order requests to the
hardware ?

Note that this is not an issue of '2 processes writing to 1 file', really.
It's one process and pdflush writing the same dirty pages of the same file.

Mike.
