Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVLZSiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVLZSiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVLZSiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:38:00 -0500
Received: from thunk.org ([69.25.196.29]:18404 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932086AbVLZSh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:37:59 -0500
Date: Sun, 25 Dec 2005 21:55:26 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Message-ID: <20051226025525.GA6697@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Daniel Petrini <d.pensator@gmail.com>,
	Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
	ck list <ck@vds.kolivas.org>, Pavel Machek <pavel@ucw.cz>,
	Adam Belay <abelay@novell.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200512210310.51084.kernel@kolivas.org> <20051225171617.GA6929@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225171617.GA6929@thunk.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing some extended and more careful measurements of power
consumption with and without dynticks, and it appears that at least on
my Thinkpad T40p laptop (1.6 GHz Pentium-M, model #2373G1U), dyntick
isn't helping the power consumption by any appreciable amount.  It's
not hurting, but it's not helping.

I believe the reason why is that the T40 has an extra C state which
only shows up if you are running on battery; if you are running on the
AC mains, C4 disappears:

   *C1:                  type[C1] promotion[C2] demotion[--] latency[001] usage[00000000] time[00000000000000000000]
    C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[00000000] time[00000000000000000000]
    C3:                  type[C3] promotion[C4] demotion[C2] latency[085] usage[00000000] time[00000000000000000000]
    C4:                  type[C3] promotion[--] demotion[C3] latency[185] usage[00000000] time[00000000000000000000]

With dyntick enabled, the laptop never enters the C4 state, but
instead bounces back and forth between C2 and C3 (and I notice that we
never enter C1 state, even when the CPU is completely pegged, but
that's true with or without dyntick).  

If dyntick is enabled, the laptop enters C4 state, which presumably is
a deeper, more power saving state, and it appears power saving effects
of dyntick is getting balanced off against the fact that C4 is never
getting entered when it is enabled.

Looking at acpi/processor_idle.c, there is all sorts of magic special
cases code for the C2 and C3 states (both for promotion/demotion
polcies, as well as what to do when idling in those particular
states), and which doesn't exist for other states, such as C4.
Presumably this explains why we are only never entering C1, and why
dyntick enabled C4 never gets reached.  What I don't understand is
_why_ all of the magic is present for those two states, but not for
any of the others.

For future work when I have time, is to actually do some performance
benchmarks; given that the power consumption doesn't appear to be
changed either way with dyntick enabled or disabled, does the time
needed to compile a kernel change significantly with or without
dyntick?

						- Ted
