Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTFKAxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTFKAxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:53:06 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:1251
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262439AbTFKAxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:53:03 -0400
Date: Wed, 11 Jun 2003 03:06:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
Message-ID: <20030611010628.GO26270@dualathlon.random>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de> <3EDDDEBB.4080209@cyberone.com.au> <1055194762.23130.370.camel@tiny.suse.com> <20030611003356.GN26270@dualathlon.random> <1055292839.24111.180.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055292839.24111.180.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 08:54:00PM -0400, Chris Mason wrote:
> On Tue, 2003-06-10 at 20:33, Andrea Arcangeli wrote:
> > On Mon, Jun 09, 2003 at 05:39:23PM -0400, Chris Mason wrote:
> > > +	if (!waitqueue_active(&q->wait_for_requests[rw]))
> > > +		clear_queue_full(q, rw);
> > 
> > you've an smp race above, the smp safe implementation is this:
> > 
> 
> clear_queue_full has a wmb() in my patch, and queue_full has a rmb(), I
> thought that covered these cases?  I'd rather remove those though, since
> the spot you point out is the only place done outside the
> io_request_lock.
> 
> > 	if (!waitqueue_active(&q->wait_for_requests[rw])) {
> > 		clear_queue_full(q, rw);
> > 		mb();
> > 		if (unlikely(waitqueue_active(&q->wait_for_requests[rw])))
> > 			wake_up(&q->wait_for_requests[rw]);
> > 	}
> > 
> I don't think we need the extra wake_up (this is in __get_request_wait,
> right?), since it gets done by get_request_wait_wakeup()

there's no get_request_wait_wakeup in blkdev_release_request. I put the
construct in both places though (i've the clear_queue_full explicit as
q->full = 0).

And I don't think any of your barriers is needed at all, I mean, we only
need to be careful to clear it right, we don't need to be careful to set
or read it right when it transits from 0 to 1. And the above seems
enough to me to get right the clearing.

> > I'm also unsure what the "waited" logic does, it doesn't seem necessary.
> 
> Once a process waits once, they are allowed to ignore the q->full flag. 
> This way existing waiters can make progress even when q->full is set. 
> Without the waited check, q->full will never get cleared because the
> last writer wouldn't proceed until the last writer was gone.  I had to
> make __get_request for the same reason.

__get_request makes perfect sense of course and it's needed, this is not
the issue, my point about the waited check is that the last writer has
to get the wakeup (and the wakeup has nothing to do with the waited
check since waited == 0), and after the wakeup it will get the request
and it won't re-run the loop, so I don't see why waited is needed.
Furthmore even if for whatever reason it doesn't get the request, it
will re-set full to 1 and it'll be still the first to get the wakeup,
and it will definitely get another wakeup if none request was available.

Andrea
