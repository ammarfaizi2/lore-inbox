Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTFKAlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFKAlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:41:14 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:27822 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262427AbTFKAlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:41:01 -0400
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030611003356.GN26270@dualathlon.random>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
	 <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de>
	 <200306041246.21636.m.c.p@wolk-project.de>
	 <20030604104825.GR3412@x30.school.suse.de>
	 <3EDDDEBB.4080209@cyberone.com.au>
	 <1055194762.23130.370.camel@tiny.suse.com>
	 <20030611003356.GN26270@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1055292839.24111.180.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Jun 2003 20:54:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 20:33, Andrea Arcangeli wrote:
> On Mon, Jun 09, 2003 at 05:39:23PM -0400, Chris Mason wrote:
> > +	if (!waitqueue_active(&q->wait_for_requests[rw]))
> > +		clear_queue_full(q, rw);
> 
> you've an smp race above, the smp safe implementation is this:
> 

clear_queue_full has a wmb() in my patch, and queue_full has a rmb(), I
thought that covered these cases?  I'd rather remove those though, since
the spot you point out is the only place done outside the
io_request_lock.

> 	if (!waitqueue_active(&q->wait_for_requests[rw])) {
> 		clear_queue_full(q, rw);
> 		mb();
> 		if (unlikely(waitqueue_active(&q->wait_for_requests[rw])))
> 			wake_up(&q->wait_for_requests[rw]);
> 	}
> 
I don't think we need the extra wake_up (this is in __get_request_wait,
right?), since it gets done by get_request_wait_wakeup()

> I'm also unsure what the "waited" logic does, it doesn't seem necessary.

Once a process waits once, they are allowed to ignore the q->full flag. 
This way existing waiters can make progress even when q->full is set. 
Without the waited check, q->full will never get cleared because the
last writer wouldn't proceed until the last writer was gone.  I had to
make __get_request for the same reason.

-chris


