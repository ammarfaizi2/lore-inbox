Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSJaLDR>; Thu, 31 Oct 2002 06:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbSJaLDQ>; Thu, 31 Oct 2002 06:03:16 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:17630 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264853AbSJaLCm>;
	Thu, 31 Oct 2002 06:02:42 -0500
Date: Thu, 31 Oct 2002 16:40:35 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: John Gardiner Myers <jgmyers@netscape.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021031164035.A3178@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3DC0904B.1070009@netscape.com> <Pine.LNX.4.44.0210301834540.1452-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210301834540.1452-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Wed, Oct 30, 2002 at 07:21:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 07:21:24PM -0800, Davide Libenzi wrote:
> On Wed, 30 Oct 2002, John Gardiner Myers wrote:
> 
> > Epoll creates a new callback mechanism and plugs into this new callback
> > mechansim.  It adds a new set of notification hooks which feed into this
> > new callback mechansim.  The end result is that there is one set of
> > notification hooks for classic poll and another set for epoll.  When
> > epoll is not being used, the poll and socket code makes an additional
> > set of checks to see that nobody has registered interest through the new
> > callback mechanism.
> 
> Where epoll hooks has nothing to do with ->f_po->poll()
> 

I think what John means, and what Jamie has also brought up in a 
separate note is that now when an event happens on an fd, in some cases
there are tests for 3 kinds of callbacks that get triggered -- the wait
queue for poll type registrations, the fasync list for sigio, and the
new epoll file send notify type callbacks. There is a little overhead
(not sure if significant) for each kind of test ...  

> 
> 
> > > It fits _exactly_
> > >the rt-signal hooks. One of the design goals for me was to add almost
> > >nothing on the main path. You can lookup here for a quick compare between
> > >aio poll and epoll for a test where events delivery efficency does matter
> > >( pipetest ) :
> > >
> > This is a comparison of the cost of using epoll to the cost of using aio
> > in one particular situation.  It is irrelevant to the point I was making.
> 
> See, I believe numbers talks. And it does make a pretty clear point
> indeed.
> 
> 
> 
> > My understanding of the efficiency of the epoll event notification
> > subsystem is:
> >
> > 1) Unlike the current aio poll, it amortizes the cost of interest
> > registration/deregistration across multiple events for a given connection.
> 
> Yep
> 

Adding persistent iocb support to aio doesn't appear too hard, and 
to be fair to aio, it does seem to help it come much closer to epoll, 
in fact very much closer at least for pipetest with a quickly hacked 
version that I tried. There still appears to be a gap remaining to 
be covered i.e epoll continuing to lead :) albeit by a smaller margin.

A little more magic is going on than just interest registration 
amortization (and I suspect its not just the threading argument), 
worth analysing if not for any other reason but to gain a better 
understanding of these 2 event delivery mechanisms the core for both
of which are now in the mainline kernel.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

