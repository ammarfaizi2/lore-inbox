Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTGOFd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTGOFd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:33:56 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:27833
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262714AbTGOFdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:33:41 -0400
Date: Tue, 15 Jul 2003 07:48:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Chris Mason <mason@suse.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715054806.GA30537@dualathlon.random>
References: <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <20030714201637.GQ16313@dualathlon.random> <20030715052640.GY833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715052640.GY833@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 07:26:40AM +0200, Jens Axboe wrote:
> On Mon, Jul 14 2003, Andrea Arcangeli wrote:
> > On Mon, Jul 14, 2003 at 09:51:39PM +0200, Jens Axboe wrote:
> > > -	rl = &q->rq;
> > > -	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
> > > +	if ((rw == WRITE) && (blk_oversized_queue(q) || (rl->count < 4)))
> > 
> > did you disable the oversized queue check completely for reads? This
> 
> Yes
> 
> > looks unsafe, you can end with loads of ram locked up this way, the
> > request queue cannot be limited in requests anymore. this isn't the
> > "request reservation", this a "nearly unlimited amount of ram locked in
> > for reads".
> 
> Sorry, but I think that is nonsense. This is the way we have always
> worked. You just have to maintain a decent queue length still (like we

But things don't work that way anymore. dropping the check now will lead
to an overkill amount of ram to be locked in.

I enlarged the queue further, since I could, there's no point in having
a few kbytes of queue during seeks, when the big queue helps most. Now
you can have mbytes (not kbytes) of queue during seeks. But you can't
keep it unlimited anymore or you'll generate troubles to the VM and
it'll generate a 90/10 distribution as well, if you start filling it
with many readers. 

the reasons things changed is that the "decent queue length" wasn't
decent nor for contigous I/O (it was way too permissive for contigous
I/O) nor for seeking I/O (it was way too restrictive for seeking I/O).

> It is _not_ unsafe, stop spewing nonsense like that. The patch should

it isn't only unsafe for the potentially full ram of the box going
locked (on lowmem boxes of course) but also because you can easily
starve writers completely, especially on my tree you will need only a
few readers to hang completely every write in a certain spindle. and the
more readers the more likely the writer will stall.

> make a difference like I described. And it had a big effect, so I posted
> results and went to bed. Know we have a grounds for further discussion,
> and I'll bench the changes seperately too as well. It's about getting
> data points you can use, you have to try extremese as well.

If you benchmarked with a 2-way or even better on an UP box, then likely
we can get still a relevant speedup even with the starvation fixed and w/o the
90/10 distribution (i.e. too many reads in the queue).

I thought contest was using a quite big -j, but it's ""only"" -j8 for a
2-way (HT cpus have to be included). So your results may still
apply, despite the patch wasn't safe and it could penalize writes to the
point of not allowing them to execute anymore for indefinite time (I
mean: a fixed patch that doesn't have those bugs could generate
similar good results [for reads] out of contest).

Andrea
