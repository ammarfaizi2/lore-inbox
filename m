Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWBGHYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWBGHYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 02:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWBGHYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 02:24:23 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:20903 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964986AbWBGHYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 02:24:23 -0500
Date: Tue, 7 Feb 2006 10:23:54 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Dan Williams <dan.j.williams@gmail.com>
Cc: Neil Brown <neilb@suse.de>, Dan Williams <dan.j.williams@intel.com>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       Chris Leech <christopher.leech@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC][PATCH 000 of 3] MD Acceleration and the ADMA interface: Introduction
Message-ID: <20060207072354.GB11041@2ka.mipt.ru>
References: <1138931168.6620.8.camel@dwillia2-linux.ch.intel.com> <17382.49851.373366.929920@cse.unsw.edu.au> <e9c3a7c20602061125j4a1fb48agd23cd600b0cdf6d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c3a7c20602061125j4a1fb48agd23cd600b0cdf6d0@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 07 Feb 2006 10:23:55 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 12:25:22PM -0700, Dan Williams (dan.j.williams@gmail.com) wrote:
> On 2/5/06, Neil Brown <neilb@suse.de> wrote:
> > I've looked through the patches - not exhaustively, but hopefully
> > enough to get a general idea of what is happening.
> > There are some things I'm not clear on and some things that I could
> > suggest alternates too...
> 
> I have a few questions to check that I understand your suggestions.
> 
> >  - Each ADMA client (e.g. a raid5 array) gets a dedicated adma thread
> >    to handle all its requests.  And it handles them all in series.  I
> >    wonder if this is really optimal.  If there are multiple adma
> >    engines, then a single client could only make use of one of them
> >    reliably.
> >    It would seem to make more sense to have just one thread - or maybe
> >    one per processor or one per adma engine - and have any ordering
> >    between requests made explicit in the interface.
> >
> >    Actually as each processor could be seen as an ADMA engine, maybe
> >    you want one thread per processor AND one per engine.  If there are
> >    no engines, the per-processor threads run with high priority, else
> >    with low.
> 
> ...so the engine thread would handle explicit client requested
> ordering constraints and then hand the operations off to per processor
> worker threads in the "pio" case or queue directly to hardware in the
> presence of such an engine.  In md_thread you talk about priority
> inversion deadlocks, do those same concerns apply here?

Just for reference: the more threads you have, the less stable your
system is. Ping-ponging work between several completely independent
entities is always a bad idea. Even completion of the request postponed
to workqueue from current execution unit introduces noticeble latencies.
System should be able to process as much as possible of it's work in one
flow.

> Dan

-- 
	Evgeniy Polyakov
