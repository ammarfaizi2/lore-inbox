Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTFKAbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTFKAbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:31:18 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:24750 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262321AbTFKAbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:31:16 -0400
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030611001619.GL26270@dualathlon.random>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
	 <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de>
	 <200306041246.21636.m.c.p@wolk-project.de>
	 <20030604104825.GR3412@x30.school.suse.de>
	 <3EDDDEBB.4080209@cyberone.com.au>
	 <1055194762.23130.370.camel@tiny.suse.com>
	 <20030609221950.GF26270@dualathlon.random>
	 <1055286825.24111.155.camel@tiny.suse.com>
	 <20030611001619.GL26270@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1055292254.24111.169.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Jun 2003 20:44:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 20:16, Andrea Arcangeli wrote:
> On Tue, Jun 10, 2003 at 07:13:45PM -0400, Chris Mason wrote:
> > On Mon, 2003-06-09 at 18:19, Andrea Arcangeli wrote:
> > The avg throughput per process with vanilla rc7 is 3MB/s, the best I've
> > been able to do was with nr_requests at higher levels was 1.3MB/s.  With
> > smaller of iozone threads (10 and lower so far) I can match rc7 speeds,
> > but not with 20 procs.
> 
> at least with my patches, I also made this change:
> 
> -#define ELV_LINUS_SEEK_COST    16
> +#define ELV_LINUS_SEEK_COST    1
> 
>  #define ELEVATOR_NOOP                                                  \
>  ((elevator_t) {                                                                \
> @@ -93,8 +93,8 @@ static inline int elevator_request_laten
> 
>  #define ELEVATOR_LINUS                                                 \
>  ((elevator_t) {                                                                \
> -       2048,                           /* read passovers */            \
> -       8192,                           /* write passovers */           \
> +       128,                            /* read passovers */            \
> +       512,                            /* write passovers */           \
>                                                                         \
> 

Right, I had forgotten to elvtune these in before my runs.  It shouldn't
change the __get_request_wait numbers, except for changes in the
percentage of merged requests leading to a different number of requests
overall (which my numbers did show).

> you didn't change the I/O scheduler at all compared to mainline, so
> there can be quite a lot of difference in the bandwidth average per
> process between my patches and mainline and your patches (unless you run
> elvtune or unless you backed out the above).
> 
> Anyways the 130671 < 100, 0 < 200, 0 < 300, 0 < 400, 0 < 500 from your
> patch sounds perfectly fair and that's unrelated to I/O scheduler and
> size of runqueue. I believe the most interesting difference is the
> blocking of tasks until the waitqueue is empty (i.e. clearing the
> waitqueue-full bit only when nobody is waiting). That is the right thing
> to do of course, that was a bug in my patch I merged by mistake from
> Nick's original patch, and that I'm going to fix immediatly of course.

Ok, Increasing q->nr_requests also changes the throughput in high merge
workloads.

Basically if we have 20 procs doing streaming buffered io, the buffers
end up mixed together on the dirty list.  So assuming we hit the hard
dirty limit and all 20 procs are running write_some_buffers() the only
way we'll be able to efficiently merge the end result is if we can get
in 20 * 32 requests before unplugging.

This is because write_some_buffers grabs 32 buffers at a time, and each
caller has to wait fairly in __get_request_wait.  With only 128 requests
in the run queue, the disk is unplugged before any of the 20 procs has
submitted each of their 32 buffers.

It might make sense to change write_some_buffers to work in smaller
units, 32 seems like a lot of times to wait in __get_request_wait just
for an atime update.

-chris


