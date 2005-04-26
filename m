Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVDZXEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVDZXEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 19:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVDZXEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 19:04:30 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:16303 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261838AbVDZXET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 19:04:19 -0400
Subject: Re: [PATCH 1b/7] dlm: core locking
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Daniel Phillips <phillips@istop.com>
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <200504261824.22382.phillips@istop.com>
References: <20050425165826.GB11938@redhat.com>
	 <20050426054933.GC12096@redhat.com>
	 <1114537223.31647.10.camel@persist.az.mvista.com>
	 <200504261824.22382.phillips@istop.com>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1114556655.31647.90.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 26 Apr 2005 16:04:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 15:24, Daniel Phillips wrote:
> On Tuesday 26 April 2005 13:40, Steven Dake wrote:
> > Hate to admit ignorance, but I'm not really sure what SCTP does..  I
> > guess point to point communication like tcp but with some other kind of
> > characteristics..  I wanted to have some idea of how locking messages
> > are related to the current membership.  I think I understand the system
> > from your descriptions and reading the code.  One scenario I could see
> > happeing is that there are 2 processors A, B.
> >
> > B drops out of membership
> > A sends lock to lock master B (but A doens't know B has dropped out of
> > membership yet)
> > B gets lock request, but has dropped out of membership or failed in some
> > way
> >
> > In this case the order of lock messages with the membership changes is
> > important.  This is the essential race that describes almost every issue
> > with distributed systems...  virtual synchrony makes this scenario
> > impossible by ensuring that messages are ordered in relationship to
> > membership changes.
> 
> It sounds great, but didn't somebody benchmark your virtual synchrony code and 
> find that it only manages to deliver some tiny dribble of messages/second?  I 
> could be entirely wrong about that, but I got the impression that your 
> algorithm as implemented is not in the right performance ballpark for 
> handling the cfs lock traffic itself.

Daniel,

Please point me at the benchmark.  I am unaware of any claims that
virtual synchrony performs poorly...  Your performance impressions may
be swayed by the benchmark results in this message...

We have been over this before...  In September 2004, I posted benchmarks
to lkml (in a response to your questions about performance numbers) 
which show messages per second of 7820 for 100 byte messages.  I'd be
impressed to see any other protocol deliver that number of messages per
second (in and of itself), maintain self delivery, implicit
acknowledgement, agreed ordering, and virtual synchrony...

Here is the original response to your request for performance
information:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109410546919884&w=2

The same benchmark run on the current code in bk (with turning off some
printk debug junk) is:

Intel Xeon 2.4ghz between a 2 node cluster on 100mbit WITH encryption
shows 15182 messages/sec.  The improvement is from code improvements,
and also a clear factor of the cpu, since messages are packed which
consumes more cpu cycles.   (note TP/S is messages per second, MB/s is
the megabytes per second of data delivered).  On my network at home of
3.2/3.4ghz, I get about 30000 messages per second.

151825 Writes   100 bytes per write  10.000 Seconds runtime 15182.931
TP/s   1.518 MB/s.
140711 Writes   200 bytes per write  10.000 Seconds runtime 14071.252
TP/s   2.814 MB/s.
133149 Writes   300 bytes per write  10.000 Seconds runtime 13314.929
TP/s   3.994 MB/s.
120282 Writes   400 bytes per write  10.000 Seconds runtime 12028.057
TP/s   4.811 MB/s.
108876 Writes   500 bytes per write  10.000 Seconds runtime 10887.878
TP/s   5.444 MB/s.
99360 Writes   600 bytes per write  10.000 Seconds runtime  9936.053
TP/s   5.962 MB/s.
92615 Writes   700 bytes per write  10.000 Seconds runtime  9261.535
TP/s   6.483 MB/s.
85734 Writes   800 bytes per write  10.000 Seconds runtime  8573.459
TP/s   6.859 MB/s.
77132 Writes   900 bytes per write  10.000 Seconds runtime  7713.086
TP/s   6.942 MB/s.
71927 Writes  1000 bytes per write  10.000 Seconds runtime  7192.771
TP/s   7.193 MB/s.
68304 Writes  1100 bytes per write  10.000 Seconds runtime  6830.465
TP/s   7.514 MB/s.
65767 Writes  1200 bytes per write  10.000 Seconds runtime  6576.728
TP/s   7.892 MB/s.
64288 Writes  1300 bytes per write  10.000 Seconds runtime  6428.909
TP/s   8.358 MB/s.

When you consider that no reply is required to implement a lock service
with virtual synchrony, the performance is even more improved.  This
essentially, could provide 15182 lock acquisitions per second on 2.4 ghz
cpu (if the lock request is 100 bytes).

Are you suggesting this is a dribble?  What kind of performance would
you find acceptable?

Your suggestion, reworking redhat's cluster suite to use virtual
synchrony (as a demo?), sounds intrigueing.  However, I just don't have
the bandwidth at this time to take on any more projects (although I am
happy to support redhat's use of virtual synchrony).  The community,
however, would very much benefit from redhat leading such an effort.

regards,
-steve

