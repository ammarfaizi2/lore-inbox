Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbUKRKCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbUKRKCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbUKRKCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:02:23 -0500
Received: from almesberger.net ([63.105.73.238]:4870 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262695AbUKRKCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:02:17 -0500
Date: Thu, 18 Nov 2004 07:01:38 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Chris Ross <chris@tebibyte.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrea Arcangeli <andrea@novell.com>,
       Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041118070137.T28844@almesberger.net>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <1099706150.2810.147.camel@thomas> <20041117195417.A3289@almesberger.net> <419BDE53.1030003@tebibyte.org> <20041117210410.R28844@almesberger.net> <419BECB0.70801@tebibyte.org> <20041117221419.S28844@almesberger.net> <419C5B45.2080100@tebibyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419C5B45.2080100@tebibyte.org>; from chris@tebibyte.org on Thu, Nov 18, 2004 at 09:20:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross wrote:
> All I'm advocating is just swapping something out if possible 
> instead.

Yes, but this only works if a) your system can make progress
towards lowering its memory needs without the process(es) you've
picked for swapping, and b) these processes don't happen to be
something that cannot tolerate long suspension, and c) the total
memory needs are such that they can be better satisfied after
these processes have been swapped out.

Examples where this isn't the case: a) if you swap out your
hoursekeeping cron job, the system will just sit idle, then you
swap it in again after a few minutes, and the agony repeats.
b) if you swap out my X server while I'm sitting at the machine,
all you've done was to force me to press the big red switch
manually. c) if there's a process with excessive memory demands
that can't be met anyway, it's better to end its misery quickly,
instead of spending a day thrashing.

So again, your automatic OOM kill^H^H^H^Hcounsellor doesn't only
have to follow a fixed policy, but it also has to sense what kind
of situation we're in.

A SIGSWAP would help with a) and b). In case a), the cron jobs
would signal anything that's not them. In case b), by definition,
I'd not be working when this happens. This can be assisted by
user detection heuristics as used in some batch distribution
systems. (Now we have a fairly complex user space already, with
lots of policy.) The usual "runaway process" heuristics can
probably take care of c).

> Too often at present the machine just doesn't know what to do,

See, that's exactly what I mean :-) So, why not just tell it ?
"Hey, things are going to get a little rough for a while. Why
don't you take a nap on that comfty swap disk while I clean up
the house ?"

> [ * I just looked it up: "of, relating to, or resembling the mental or 
> emotional state believed induced by the god Pan". Cool ]

Hmm, you're suggesting we follow Morpheus instead of Pan then ?
And I always thought the OOM killer was more like Eris' work :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
