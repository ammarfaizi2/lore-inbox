Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270784AbTGNUIF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTGNUG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:06:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5264
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270796AbTGNUE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:04:58 -0400
Date: Mon, 14 Jul 2003 22:19:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030714201924.GR16313@dualathlon.random>
References: <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <1058213348.13313.274.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058213348.13313.274.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 04:09:08PM -0400, Chris Mason wrote:
> On Mon, 2003-07-14 at 15:51, Jens Axboe wrote:
> > --- 1.47/drivers/block/ll_rw_blk.c	Fri Jul 11 10:30:54 2003
> > +++ edited/drivers/block/ll_rw_blk.c	Mon Jul 14 20:42:36 2003
> > @@ -549,10 +549,12 @@
> >  static struct request *get_request(request_queue_t *q, int rw)
> >  {
> >  	struct request *rq = NULL;
> > -	struct request_list *rl;
> > +	struct request_list *rl = &q->rq;
> >  
> > -	rl = &q->rq;
> > -	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
> > +	if ((rw == WRITE) && (blk_oversized_queue(q) || (rl->count < 4)))
> > +		return NULL;
> > +
> > +	if (!list_empty(&rl->free)) {
> >  		rq = blkdev_free_rq(&rl->free);
> >  		list_del(&rq->queue);
> >  		rl->count--;
> > @@ -947,7 +949,7 @@
> 
> Could I talk you into trying a form of this patch that honors
> blk_oversized_queue for everything except the BH_sync requests?

not honoring blk_oversized_queue for BH_sync isn't safe either (still it
would be an order of magnitude safer than not honoring it for all reads
unconditonally)  there must be a secondary limit, eating all the
requests with potentially 512k of ram queued into each requests is
unsafe (one can generate many sync requests by forking some hundred
thousand tasks, this isn't only x86).

Andrea
