Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTFKAyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFKAyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:54:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10723
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262451AbTFKAyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:54:02 -0400
Date: Wed, 11 Jun 2003 03:07:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Chris Mason <mason@suse.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
Message-ID: <20030611010726.GP26270@dualathlon.random>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de> <3EDDDEBB.4080209@cyberone.com.au> <1055194762.23130.370.camel@tiny.suse.com> <20030611003356.GN26270@dualathlon.random> <3EE67C57.1000303@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE67C57.1000303@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 10:48:23AM +1000, Nick Piggin wrote:
> 
> 
> Andrea Arcangeli wrote:
> 
> >On Mon, Jun 09, 2003 at 05:39:23PM -0400, Chris Mason wrote:
> >
> >>+	if (!waitqueue_active(&q->wait_for_requests[rw]))
> >>+		clear_queue_full(q, rw);
> >>
> >
> >you've an smp race above, the smp safe implementation is this:
> >
> >	if (!waitqueue_active(&q->wait_for_requests[rw])) {
> >		clear_queue_full(q, rw);
> >		mb();
> >		if (unlikely(waitqueue_active(&q->wait_for_requests[rw])))
> >			wake_up(&q->wait_for_requests[rw]);
> >	}
> >
> >I'm also unsure what the "waited" logic does, it doesn't seem necessary.
> >
> 
> When a task is woken up, it is quite likely that the
> queue is still marked full.

but we don't care if it's marked full, see __get_request. If we cared
about full it would deadlock anyways (no matter the waited logic)

Andrea
