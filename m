Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTFJATx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 20:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFJATx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 20:19:53 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:169 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262227AbTFJATw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 20:19:52 -0400
Subject: Re: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <3EE51D99.2080604@cyberone.com.au>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
	 <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de>
	 <200306041246.21636.m.c.p@wolk-project.de>
	 <20030604104825.GR3412@x30.school.suse.de>
	 <3EDDDEBB.4080209@cyberone.com.au>
	 <1055194762.23130.370.camel@tiny.suse.com>
	 <3EE51D99.2080604@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1055205179.23130.406.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Jun 2003 20:32:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 19:51, Nick Piggin wrote:

> >
> >The latency results are better, with average time spent in
> >__get_request_wait being around 28 jiffies, and a max of 170 jiffies. 
> >The cost is throughput, further benchmarking needs to be done but, but I
> >wanted to get this out for review and testing.  It should at least help
> >us decide if the request allocation code really is causing our problems.
> >
> 
> Well the latency numbers are good - is this with dbench 90?
> 

Yes, that number was dbench 90, but dbench 50,90, and 120 gave about the
same stats with the final patch.

> snip

> >+
> >+static inline int queue_full(request_queue_t *q, int rw)
> >+{
> >+	rmb();
> >+	if (rw == READ)
> >+		return q->read_full;
> >+	else
> >+		return q->write_full;
> >+}
> >+
> >
> 
> I don't think you need the barriers here, do you?
> 

I put the barriers in early on when almost all the calls were done
outside spin locks, the current flavor of the patch only does one
clear_queue_full without the io_request_lock held.  It should be enough
to toss a barrier in just that one spot.  But I wanted to leave them in
so I could move things around until the final version (if there ever is
one ;-)

-chris


