Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTFIXjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTFIXjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:39:51 -0400
Received: from [203.221.72.225] ([203.221.72.225]:38928 "EHLO chimp.local.net")
	by vger.kernel.org with ESMTP id S262283AbTFIXjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:39:49 -0400
Message-ID: <3EE51D99.2080604@cyberone.com.au>
Date: Tue, 10 Jun 2003 09:51:53 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>	 <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de>	 <200306041246.21636.m.c.p@wolk-project.de>	 <20030604104825.GR3412@x30.school.suse.de>	 <3EDDDEBB.4080209@cyberone.com.au> <1055194762.23130.370.camel@tiny.suse.com>
In-Reply-To: <1055194762.23130.370.camel@tiny.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

>Ok, there are lots of different problems here, and I've spent a little
>while trying to get some numbers with the __get_request_wait stats patch
>I posted before.  This is all on ext2, since I wanted to rule out
>interactions with the journal flavors.
>
>Basically a dbench 90 run on ext2 rc6 vanilla kernels can generate
>latencies of over 2700 jiffies in __get_request_wait, with an average
>latency over 250 jiffies.
>
>No, most desktop workloads aren't dbench 90, but between balance_dirty()
>and the way we send stuff to disk during memory allocations, just about
>any process can get stuck submitting dirty buffers even if you've just
>got one process doing a dd if=/dev/zero of=foo.
>
>So, for the moment I'm going to pretend people seeing stalls in X are
>stuck in atime updates or memory allocations, or reading proc or some
>other silly spot.  
>
>For the SMP corner cases, I've merged Andrea's fix-pausing patch into
>rc7, along with an altered form of Nick Piggin's queue_full patch to try
>and fix the latency problems.
>
>The major difference from Nick's patch is that once the queue is marked
>full, I don't clear the full flag until the wait queue is empty.  This
>means new io can't steal available requests until every existing waiter
>has been granted a request.
>

Yes, this is probably a good idea.

>
>The latency results are better, with average time spent in
>__get_request_wait being around 28 jiffies, and a max of 170 jiffies. 
>The cost is throughput, further benchmarking needs to be done but, but I
>wanted to get this out for review and testing.  It should at least help
>us decide if the request allocation code really is causing our problems.
>

Well the latency numbers are good - is this with dbench 90?

snip

> 
>+static inline void set_queue_full(request_queue_t *q, int rw)
>+{
>+	wmb();
>+	if (rw == READ)
>+		q->read_full = 1;
>+	else
>+		q->write_full = 1;
>+}
>+
>+static inline void clear_queue_full(request_queue_t *q, int rw)
>+{
>+	wmb();
>+	if (rw == READ)
>+		q->read_full = 0;
>+	else
>+		q->write_full = 0;
>+}
>+
>+static inline int queue_full(request_queue_t *q, int rw)
>+{
>+	rmb();
>+	if (rw == READ)
>+		return q->read_full;
>+	else
>+		return q->write_full;
>+}
>+
>

I don't think you need the barriers here, do you?

