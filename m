Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTLRCrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 21:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTLRCrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 21:47:20 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:33544 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S264905AbTLRCrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 21:47:18 -0500
Date: Wed, 17 Dec 2003 18:47:13 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
Message-ID: <20031218024713.GG9137@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws> <3FDF1C03.2020509@aitel.hist.no> <Pine.LNX.4.58.0312160825570.1599@home.osdl.org> <20031217192244.GB12121@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217192244.GB12121@mail.shareable.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This space available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 07:22:44PM +0000, Jamie Lokier wrote:
> Linus Torvalds wrote:
> > My personal guess is that modern RAID0 stripes should be on the order of
> > several MEGABYTES in size rather than the few hundred kB that most people
> > use (not to mention the people who have 32kB stripes or smaller - they
> > just kill their IO access patterns with that, and put the CPU at
> > ridiculous strain).
> 
> If a large fs-level I/O transaction is split into lots of 32k
> transactions by the RAID layer, many of those 32k transactions will be
> contiguous on the disks.
> 
> That doesn't mean they're contiguous from the fs point of view, but
> given that all modern hardware does scatter-gather, shouldn't the
> contiguous transactions be merged before being sent to the disk?
> 
> It may strain the CPU (splitting and merging in a different order lots
> of requests), but I don't see why it should kill I/O access patterns,
> as they can be as large as if you had large stripes in the first place.

Only now instead of the latency of one disk seeking to
service the request you have the worst case latency of all
the disks.

Years ago i had a SCSI outboard HW RAID-5 array of 5 disks
on two chains.  The controller used a 512 byte chunk so a
stripe was 2KB.  A single 2KB read would flash lights on 4
drives simultaneously.  An aligned 2KB write would calculate
parity without any reads and write to all 5 at once.  Any
I/O 4KB or larger would engage all 5 drives in parallel.
Given that the OS in question had a 2KB page size and the
filesystems had a 2KB block size it worked pretty well.
When i spec'd the array i made sure the stripe size would
align with access -- one drive more or less and the whole
thing would have been a disaster.

At that time the xfer rate of the drives was a fraction of
what it was today and this setup allowed the array to
saturate the SCSI connection to the host.  Which is
something the drives could not do individually.  However,
disk latency was worst case of the drives although since
they ran almost lock-step wasn't much longer than single
drive latency.  This was just one step up from RAID-3.

Today xfer rates are an order of magnitude higher while
latency has not shrunk.  In fact, by reducing platter count
many drives today have worse latency.  I don't think i'd
ever recommend such a small stripe size today, the latency
of handshaking and the overhead of splitting and merging
would outweigh the bandwidth gains in all but a few rare
applications.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
