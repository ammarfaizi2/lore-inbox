Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270469AbTGNAXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270470AbTGNAXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:23:30 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:19918 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S270469AbTGNAX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:23:27 -0400
Subject: Re: RFC on io-stalls patch
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20030713193548.GL16313@dualathlon.random>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva>
	 <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com>
	 <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com>
	 <20030713090116.GU843@suse.de> <1058113238.13313.127.camel@tiny.suse.com>
	 <20030713174709.GA843@suse.de>  <20030713193548.GL16313@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1058142999.13317.137.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Jul 2003 20:36:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-13 at 15:35, Andrea Arcangeli wrote:
> On Sun, Jul 13, 2003 at 07:47:09PM +0200, Jens Axboe wrote:
> > Just catering to the sync reads is probably good enough, and I think
> > that passing in that extra bit of information is done the best through
> > just a b_state bit.
> 
> not sure if we should pass this bit of info, I guess if we add it we can
> just threats all reads equally and give them the spare reserved
> requests unconditionally, so the highlevel isn't complicated (of course
> it would be optional, so nothing would break but it would be annoying
> for benchmarking new fs having to patch stuff first to see the effect of
> the spare reserved requests).
> 

By goal with the b_state bit was to change this:

bread
submit_bh
__get_request_wait (unplugs just to get a free rq)
wait_on_buffer (run tq_disk)

Into this:

bread
set BH_Sync
submit_bh
__make_request (get a reserved sync request, unplugs to start the read)
buffer up to date

It's wishful thinking, since the unplug doesn't mean we end up with an
unlocked buffer.  But at the very least, taking a reserved sync request
and unplugging right away shouldn't be worse than the current method of
unplugging just to get a request.  

And on boxes with lots of busy drives, avoiding tq_disk is a good thing,
even if we only manage to avoid it for a small percentage of the reads.

> > I'll try and bench a bit tomorrow with that patched in.
> 
> Cool thanks.

Thanks Jens

-chris



