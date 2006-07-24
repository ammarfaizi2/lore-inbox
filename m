Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWGXRjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWGXRjW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWGXRjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:39:22 -0400
Received: from colin.muc.de ([193.149.48.1]:34313 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932083AbWGXRjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:39:21 -0400
Date: 24 Jul 2006 19:39:20 +0200
Date: Mon, 24 Jul 2006 19:39:20 +0200
From: Andi Kleen <ak@muc.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Matthias Urlichs <smurf@smurf.noris.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, bunk@stusta.de,
       lethal@linux-sh.org, hirofumi@mail.parknet.co.jp
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060724173920.GC50320@muc.de>
References: <20060722233638.GC27566@kiste.smurf.noris.de> <20060722173649.952f909f.akpm@osdl.org> <20060723081604.GD27566@kiste.smurf.noris.de> <20060723044637.3857d428.akpm@osdl.org> <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153756738.9440.14.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 08:58:58AM -0700, john stultz wrote:
> On Sun, 2006-07-23 at 05:37 -0700, Andrew Morton wrote:
> > On Sun, 23 Jul 2006 14:08:29 +0200
> > Matthias Urlichs <smurf@smurf.noris.de> wrote:
> > 
> > > Hi,
> > > 
> > > Andrew Morton:
> > > > - CPU0 and CPU1 share a TSC and CPU2 and CPU3 share another TSC.
> > > > 
> > > That mmakes sense, since they're one dual-core Xeon each.
> > 
> > OK.
> > 
> > > > - Earlier kernels didn't use the TSC as a time source whereas this one
> > > >   does, hence the problems which you're observing.
> > > > 
> > > Correct; see below.
> > > 
> > > > I assume that booting with clock=pit or clock=pmtmr fixes it?
> > > > 
> > > Testing... yes, both.
> > > 
> > > > It would be useful to check your 2.6.17 boot logs, see if we can work out
> > > > what 2.6.17 was using for a clock source.
> > > > 
> > > That's easy:
> > > 
> > > 2.6.17    -Using pmtmr for high-res timesource
> > > 2.6.18git +Time: tsc clocksource has been installed.
> > > 
> > > I missed those two lines, as in the boot logs they're not really
> > > adjacent, so they got lost in the jumble of other differences.
> > 
> > OK, thanks.  Marking the TSC as bad in this case is simple to do - let us
> > let John work out the best way.
> > 
> > We must have lost a TSC sanity check somewhere along the way.  I wonder
> > what it was?
> 
> Well, I changed the TSC vs ACPI PM timer priority ordering to be more
> like x86-64 (Andi had a similar patch he was proposing as well). For
> awhile suse/redhat kernels have been swapping them, as the TSC gives
> such a performance boost, however the ACPI PM timer is usually the safer
> option (distro customers are often told to use clock=pmtmr on some
> boxes).
> 
> I'll see what we can do to narrow it down, but its been assumed by both
> x86-64 and the new i386 code that the TSCs on Intel SMP boxes are
> synched, unless we're explicitly told they aren't (Summit, etc).

Or it supports C3. I just had to add that check on 64bit too
for Merom.


> With the current code it is trivial to mark the TSC as unstable and the
> system will automatically fall back to the next best clocksource. The
> difficulty is just making sure we've got all the cases covered without
> needlessly disqualifying synced systems.
> 
> Andi: If this is a generic issue, and not specific to Matthias' box, we
> may need to re-think the assumption that Intel SMP is synced. You're
> thoughts?

I'm missing context. Full log files/full system description?

At least on x86-64 I'm doing it like this for a long time and didn't
have any complaints so I would assume that the 64bit capable boxes are
near completely ok.

-Andi

