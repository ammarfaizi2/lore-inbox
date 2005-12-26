Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVLZWxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVLZWxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVLZWxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:53:03 -0500
Received: from thunk.org ([69.25.196.29]:38534 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751093AbVLZWxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:53:00 -0500
Date: Mon, 26 Dec 2005 17:52:48 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Message-ID: <20051226225246.GA9915@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Pavel Machek <pavel@ucw.cz>, Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Daniel Petrini <d.pensator@gmail.com>,
	Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
	ck list <ck@vds.kolivas.org>, Adam Belay <abelay@novell.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200512210310.51084.kernel@kolivas.org> <20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org> <20051226203806.GC1974@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051226203806.GC1974@elf.ucw.cz>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2005 at 09:38:06PM +0100, Pavel Machek wrote:
> Stupid IBM. I've seen it appearing/disappearing, but did not work out
> when.
> 
> No-C4-on-AC is bad -- if you just disconnect AC and walk away, you are
> running without benefits of C4. Bad. Changing benchmarks depending on
> you booting on AC or battery also look nasty.

The moment you disconnect AC, it C4 automagically appears.  When you
reconnect to the AC mains, the C4 state disappears again, at least
from the listing displayed by /proc/acpi/processor/CPU0/power.  So the
first issue you brought up isn't a problem.

The fact that it could change the benchmarks results depending on
whether or you're running on battery or not is unfortunate, but in the
real world does it matter?   

More of an issue is that there are times when the laptop might think
that it's running of the AC mains, but in fact the owner may have
connected an external battery, and might _want_ the system to be as
frugal as possible with the power.

> > If dyntick is enabled, the laptop enters C4 state, which presumably is
> > a deeper, more power saving state, and it appears power saving effects
> > of dyntick is getting balanced off against the fact that C4 is never
> > getting entered when it is enabled.
> 
> Can you boot on AC power, then go to battery power to verify this theory?

Yep.  As I said, at least on my laptop, this is what
/proc/acpi/processor/CPU/power looks like when I am running on the AC
mains:

active state:            C2
max_cstate:              C8
bus master activity:     e7d24db4
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[001] usage[00000010] time[00000000000000000000]
   *C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[00084296] time[00000000000306642441]
    C3:                  type[C3] promotion[--] demotion[C2] latency[085] usage[00000000] time[00000000000000000000]

... and this is what it looks like when I am on battery:

active state:            C2
max_cstate:              C8
bus master activity:     6ef5bbbd
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[001] usage[00000010] time[00000000000000000000]
   *C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[00001162] time[00000000000004425803]
    C3:                  type[C3] promotion[C4] demotion[C2] latency[085] usage[00000000] time[00000000000000000000]
    C4:                  type[C3] promotion[--] demotion[C3] latency[185] usage[00000000] time[00000000000000000000]

Whether I boot from AC power battery seems to be immaterial; what
seems to matter is whether or not the laptop is running on battery at
the moment that /proc/acpi/processor/CPU0/power is sampled.

						- Ted
