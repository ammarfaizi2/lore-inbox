Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272397AbTGZA3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 20:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272398AbTGZA3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 20:29:15 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:52237 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S272397AbTGZA3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 20:29:14 -0400
Date: Fri, 25 Jul 2003 17:44:20 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Net device byte statistics
Message-ID: <20030726004420.GE25838@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <E19fqMF-0007me-00@calista.inka.de> <20030725105818.6bc97653.rddunlap@osdl.org> <20030725215548.GB25838@pegasys.ws> <200307251852.03441.jeffpc@optonline.net> <3F21C68E.4080209@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F21C68E.4080209@candelatech.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content offensive to Atheists and servants of false gods.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 05:08:46PM -0700, Ben Greear wrote:
> Jeff Sipek wrote:
> >-----BEGIN PGP SIGNED MESSAGE-----
> >Hash: SHA1
> >
> >On Friday 25 July 2003 17:55, jw schultz wrote:
> >
> 
> >>My thought would be to use 96bits for each counter.  In-kernel
> >>code would run periodically doing something like this:
> >>
> >>	curval = counter.in_kernel;
> >>			/* get it in a register for atomicity */
> >>	if (counter.user_low < curval)
> >>		++counter.user_high;
> >>	counter.user_low = curval;
> 
> What about every 30 seconds or so, detect wraps, and bump the 'high' counter
> if it wraps.  (Check more often if you can wrap more than once in 30 secs).

Yes, how often the component needs run will depend on the
fastest counter.

> Then, upon read by user-space (or whatever needs 64-bit counters):
> 
> 1) check wrap
> 2) grab low bits and OR them with the high bits.
> 3) check wrap again.  If wrap happened, try again.  Assumption is it could 
> never wrap
>    more than once during the time you are checking.

If you need to have userspace get instantaneous values it
would be more efficient to have userspace do the
update_64bit_counter code for just its counter than to have
multiple wrap checks.

> I think this could give us very low overhead, and extremely precise 64-bit
> reads.  And, I think it would not need locks in the fast path..but I could
> also be missing something :)

Per-cpu counters.  If this is done a variant of this for
per-cpu counters would be helpful.  Per-cpu counters have
the advantage of reducing cache-line bouncing.  I don't
think per-cpu counters should be used as a band-aid
(elasto-plast) for counter wrapping.  Besides, how many
12Ghz 4-way hypertheaded (shared cache) CPUs do you need?
And if you only have one should you have per-cpu counters?
I don't think so.  

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
