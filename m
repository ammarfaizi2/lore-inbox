Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbUKRBR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbUKRBR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 20:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUKRBPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 20:15:45 -0500
Received: from almesberger.net ([63.105.73.238]:15890 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262669AbUKRBPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 20:15:18 -0500
Date: Wed, 17 Nov 2004 22:14:19 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Chris Ross <chris@tebibyte.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrea Arcangeli <andrea@novell.com>,
       Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041117221419.S28844@almesberger.net>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <1099706150.2810.147.camel@thomas> <20041117195417.A3289@almesberger.net> <419BDE53.1030003@tebibyte.org> <20041117210410.R28844@almesberger.net> <419BECB0.70801@tebibyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419BECB0.70801@tebibyte.org>; from chris@tebibyte.org on Thu, Nov 18, 2004 at 01:28:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross wrote:
> with the sshd. If the daemon was swapped out you wouldn't be able to log 
> into the box while it was thrashing, but in practice you can't really 
> anyway.

Nor would you want to, in the scenario you're describing, because
the system is doing housekeeping while you're away/asleep. I
agree that this makes sense.

The tricky bit is now to identify such part-time interactive tasks,
i.e. the ones who won't receive a trigger for a while. To make
things worse, there are those who may be happily doing something,
like spinning some animated GIF, which would be perfectly fine
being put to a long sleep. That in turn may make the X server idle,
etc.

Again, if you have such a clearly defined scenario, perhaps the
cron jobs should just loudly announce that housekeeping is now
starting and that this changes some of the rules. Or perhaps,
there could be a SIGSWAP to swap out a process (maybe SIGSUSP it
first so that it doesn't come back on its own).

> Well yes, in typical fashion everything depends on everything else. That 
> in a nutshell is also my argument against the kill-me flag.

I think it may be more subtle: everybody seems to have a set of
scenarios where the best solution is quite obvious and could
be easily implemented. Also, every once in a while, you find
that system loads which clearly demand a specific action in
scenario A need something very different in scenario B.

E.g. if you go by load spike, you'll be able to contain some
of the less inspired experiments on that undergrad mainframe,
but you may end up killing the cron jobs in your housekeeping
scenario. (And in this case, swapping wouldn't even help.) Or,
if you never kill anything big with a long run time, you'll
protect that simulation of an universe that's just on the
verge of developing intelligent life, but you may completely
miss the Web browser that's been rotating banner ads for weeks.
(Here, swapping might help.)

So I think that you also need to know what the processes are,
and not only what they're doing. This should greatly improve
predictions of what they will do in the future, and why
they're doing it in the first place.

It's ultimately policy decisions, and that's where I see a place
for light-weight markup mechanisms like a "kill me first" bit.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
