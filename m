Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVDZWfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVDZWfB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVDZWfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:35:01 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:11693 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261825AbVDZWex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:34:53 -0400
Subject: Re: [PATCH 0/7] dlm: overview
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: David Teigland <teigland@redhat.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20050426184845.GA938@ca-server1.us.oracle.com>
References: <20050425151136.GA6826@redhat.com>
	 <20050425203952.GE25002@ca-server1.us.oracle.com>
	 <20050426053930.GA12096@redhat.com>
	 <20050426184845.GA938@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1114554881.31647.60.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 26 Apr 2005 15:34:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 11:48, Mark Fasheh wrote:
> On Tue, Apr 26, 2005 at 01:39:30PM +0800, David Teigland wrote:
> > On Mon, Apr 25, 2005 at 01:39:52PM -0700, Wim Coekaerts wrote:
> > > > This is a distributed lock manager (dlm) that we'd like to see added to
> > > > the kernel.  The dlm programming api is very similar to that found on
> > > > other operating systems, but this is modeled most closely after that in
> > > > VMS.
> > > 
> > > do you have any performance data at all on this ? I like to see a dlm
> > > but I like to see something that will also perform well. 
> > 
> > No.  What kind of performance measurements do you have in mind?  Most dlm
> > lock requests involve sending a message to a remote machine and waiting
> > for a reply.  I expect this network round-trip is the bulk of the time for
> > a request, which is why I'm a bit confused by your question.
> Resource lookup times, times to deliver events to clients (asts, basts,
> etc) for starters. How long does recovery take after a node crash? How does
> all of this scale as you increase the number of nodes in your cluster?
> Sure, network speed is a part of the equation, but it's not the *whole*
> equation and I've seen dlms that can get downright nasty when it comes to
> recovery speeds, etc.
> 

Reading these requests and information about how locking works and
performs, I have a suggestion to improve performance dramatically.

Use implicit acknowledgement, self delivery, and message packing.  With
these approaches I think it is possible to support acquisition of
15,000-30,000 locks per second on modern 3ghz cpus with 100mbit
networking.

Most important of these is implicit acknoweldgement, whereby instead of
sending a request and waiting for a response from one node, the request
is sent to all processors.  Then self delivery is used to deliver the
lock request to the lock service which processes it and accepts it if
the lock can be taken or rejects it if the lock cannot be granted (or
puts it in a list to be granted later, or whatever).  This does require
that all processors agree upon the order of the messages sent through
implicit acknowledgement.  But it removes the *reply* step which reduces
latency and allows a processor to obtain a lock as soon as the message
is self-delivered to the requesting processor.  It also creates a
redundant copy of the lock state that all processors maintain, likely
improving availability in the face of stop or restart faults.

Message packing is an important improvement, since I assume the size of
the lock request structures are small.  the grant time on ethernet is
about the same for small or large packets, so reducing the number of
times access to the ethernet must be granted can make a huge
improvement.  This allows packing a grouping of lock requests from one
processor into a full MTU sized packet for 8x-10x performance gains for
150 byte messages on 1500 mtu networks...

Without these approaches, I'd expect performance somewhere in the
1,000-2,000 grants per second...  How does the implementation in this
patch perform?  I'd also be interested to know how long it takes from
the time the request is made on the processor to the time it is
completed (perhaps as measured by gettimeofday, or something similiar).

Mark, how does oracle's dlm perform for your questions above?

> > Now, sometimes there are two remote messages (when a resource directory
> > lookup is needed).  You can eliminate that by not using a resource
> > directory, which will soon be a configurable option.
> > 
> > 
> > > My main concern is that I have not seen anything relying on this code do
> > > "reasonably well". eg can you show gfs numbers w/ number of nodes and
> > > scalability ?
> > 
> > I'd suggest that if some cluster application is using the dlm and has poor
> > performance or scalability, the reason and solution lies mostly in the
> > app, not in the dlm.  That's assuming we're not doing anything blatantly
> > dumb in the dlm, butI think you may be placing too much emphasis on the
> > role of the dlm here.
> Well, obviously the dlm is only one component of an entire system, but for a
> cluster application it can certainly be an important component, one whose
> performance is worth looking into. I don't think asking for this
> information is out of the question.
> 	--Mark
> 
> > > I think it's time we submit ocfs2 w/ it's cluster stack so that folks
> > > can compare (including actual data/numbers), we have been waiting to
> > > stabilize everything but I guess there is this preemptive strike going
> > > on so we might just as well. at least we have had hch and folks comment,
> > > before sending to submit code.
> > 
> > Strike?  Preemption?  That sounds frightfully conspiratorial and
> > contentious; who have you been talking to?  It's obvious to me that ocfs2
> > and gfs each have their own happy niche; they're hardly equivalent (more
> > so considering all the flavors of local file systems.)  This is surely a
> > case of "different", not "conflict"!
> > 
> > 
> > > Andrew - we will submit ocfs2 so you can have a look, compare and move
> > > on.  we will work with any stack that eventuslly gets accepted, just want 
> > > to see the choice out there and an educated decision.
> > > 
> > > hopefully tomorrow, including data comparing single node and multinode
> > > performance.
> > 
> > I'd really like to see ocfs succeed, but good heavens, why do we need to
> > study an entire cluster fs when looking at a dlm!?  A cluster fs may use a
> > dlm, but a dlm is surely a stand-alone entity with _many_ applications
> > beyond a cluster fs (which is frankly a rather obscure app.)
> >
> > We've made great effort to make the dlm broadly useful beyond the realm of
> > gfs or cluster file systems.  In the long run I expect other cluster apps
> > will out-use the dlm by far.
> >
> > Dave
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> --
> Mark Fasheh
> Senior Software Developer, Oracle
> mark.fasheh@oracle.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

