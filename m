Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVL0Ad5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVL0Ad5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 19:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVL0Ad5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 19:33:57 -0500
Received: from thunk.org ([69.25.196.29]:45453 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932173AbVL0Ad5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 19:33:57 -0500
Date: Mon, 26 Dec 2005 19:33:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Message-ID: <20051227003348.GA7951@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Daniel Petrini <d.pensator@gmail.com>,
	Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
	ck list <ck@vds.kolivas.org>, Pavel Machek <pavel@ucw.cz>,
	Adam Belay <abelay@novell.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200512210310.51084.kernel@kolivas.org> <20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org> <20051226221942.GA16837@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051226221942.GA16837@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2005 at 11:19:43PM +0100, Dominik Brodowski wrote:
> Hi,
> 
> On Sun, Dec 25, 2005 at 09:55:26PM -0500, Theodore Ts'o wrote:
> > With dyntick enabled, the laptop never enters the C4 state, but
> > instead bounces back and forth between C2 and C3 (and I notice that we
> > never enter C1 state, even when the CPU is completely pegged, but
> > that's true with or without dyntick).  
> 
> Could you try out this patch on top of it? It also adds some debug output to
> /proc/acpi/processor/CPU0/power which I'd be interested in during normal
> usage on your notebook.

Sure!  Before I tried your patch, I first tried commenting out the
fast demotion test, as you had suggested, but that had essentially no
effect.  

The patch which you sent does seem to help.  Now with dynticks
enabled, my T40p is now entering C4, and although I haven't done a
careful controlled power test (that takes more time than I had at the
time), I can say that in maximal power saving configuration (USB and
sound drivers disabled and unloaded, network ifconfig'ed down,
laptop_mode enabled, screen brightness turned all the way down, etc.)
the minimal power utilization went from approximately 9900 mW/hr
(dynticks disabled) to approximately 9500 mW/hr (dynticks enabled).

If I could keep the system at 9500 mW/hr continuously, that would
translate to approximately 7.5 hours on the extended battery, which
wouldn't be bad; unfortunately this doesn't take into account random
things like cron waking up and driving the power utilization up, and
it's not fair to do a power test when the laptop is not doing anything
at all.  A much more interesting number would be with my entire
mailbox in cache, how long could I read and respond to email while on
battery and with minimal disk usage.

Here's the status of /proc/acpi/processor/CPU/power after a number of
tests, with and without dynticks enabled:

<tytso@think>   {/home/tytso}, level 3
515% cat /proc/acpi/processor/CPU/power
active state:            C4
max_cstate:              C8
bus master activity:     68890a90
promotion:    00002463
demotion:     00000621
bm_demotion:  00019522
fastpath_demotion:  00000214
fastpath:     00004495
sfastpath:    00001775
kickback:     00012525
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[001] usage[00000010] time[00000000000000000000]
    C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[00002129] time[00000000000036902671]
    C3:                  type[C3] promotion[C4] demotion[C2] latency[085] usage[00000430] time[00000000000003215582]
   *C4:                  type[C3] promotion[--] demotion[C3] latency[185] usage[00001486] time[00000000000036966581]

BTW, I noticed this time around at least on my T40p, when I go from on
to off AC mains, and C4 disappears/appears, all of the ACPI C states
usage/time counters reset; however, the promotion/demotion/
bm_demotion/fast_demotion/fastpath/sfastpath/kickback counters do
_not_ reset.  Probably not a serious issue, but I thought I should
mention it in case the numbers looked inconsistent.

One other strange thing happened I noticed while testing your patch.
One of the times when I was switching between on and off battery
power, I ended up in a wierd state where I was on AC mains, but the
bus master activity was reading something like fffffffe, and the
asterick by the last active C state completely disappeared, presumably
because the system wasn't entering sleep state at all.  (And I from
the OS level, I couldn't see any reason for this behavior; the disk
wasn't active, and as near as I could tell the system was completely
idle.)  Scary, but I was only able to reproduce it once or twice, and
the only times I saw it was when I was on AC power, so if in fact I
was drawing extra power, the only thing that would have noticed would
be the heatsink fan....

I'll keep an eye on it, but for now, your patch definitely seems to be
helpful.  I'll keep using it and see what else I might find.

Thanks, regards,

					- Ted
