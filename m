Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135498AbRDZOii>; Thu, 26 Apr 2001 10:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135504AbRDZOi2>; Thu, 26 Apr 2001 10:38:28 -0400
Received: from oxmail3.ox.ac.uk ([129.67.1.180]:25340 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S135498AbRDZOiR>;
	Thu, 26 Apr 2001 10:38:17 -0400
Date: Thu, 26 Apr 2001 15:38:15 +0100
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Block device strategy and requests
Message-ID: <20010426153815.B2101@sable.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm designing a block device driver for a high performance disk
subsystem with unusual characteristics. To what extent is the
limited number of "struct request"s (128 by default) necessary for
back-pressure? With this I/O subsystem it would be possible for the
strategy function to rip the requests from the request list straight
away, arrange for the I/Os to be done to/from the buffer_heads (with
no additional state required) with no memory "leak". This would
effectively mean that the only limit on the number of I/Os queued
would be the number of buffer_heads allocated; not a fixed number of
"struct request"s in flight. Is this reasonable or does any memory or
resource balancing depend on the number of I/Os outstanding being
bounded?

Also, there is a lot of flexibility in how often interrupts are sent
to mark the buffer_heads up-to-date. (With the requests pulled
straight off the queue, the job of end_that_request_first() in doing
the linked list updates and bh->b_end_io() callbacks would be done by
the interrupt routine directly.) At one extreme, I could take an
interrupt for each 4K block issued and mark it up-to-date very
quickly making for very low-latency I/O but a very large interrupt
rate when I/O throughput is high. The alternative would be to arrange
for an interrupt every n buffer_heads (or based on some other
criterion) and only take an interrupt and mark buffers up-to-date on
each of those). Are there any rules of thumb on which is best or
doesn't it matter too much?

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
