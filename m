Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVDTLsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVDTLsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 07:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVDTLsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 07:48:11 -0400
Received: from isilmar.linta.de ([213.239.214.66]:31974 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261338AbVDTLof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 07:44:35 -0400
Date: Wed, 20 Apr 2005 13:44:33 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thomas Renninger <trenn@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Frank Sorenson <frank@tuxrocks.com>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       ML ACPI-devel <acpi-devel@lists.sourceforge.net>,
       Bodo Bauer <bb@suse.de>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1 - C-state measures
Message-ID: <20050420114433.GA28362@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Renninger <trenn@suse.de>, Tony Lindgren <tony@atomide.com>,
	Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Pavel Machek <pavel@suse.cz>,
	Arjan van de Ven <arjan@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrea Arcangeli <andrea@suse.de>,
	George Anzinger <george@mvista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Lee Revell <rlrevell@joe-job.com>,
	ML ACPI-devel <acpi-devel@lists.sourceforge.net>,
	Bodo Bauer <bb@suse.de>, Andi Kleen <ak@suse.de>
References: <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <42566C22.4040509@suse.de> <20050408115535.GI4477@atomide.com> <42651C38.6090807@suse.de> <20050419152723.GA9509@isilmar.linta.de> <42657222.5080601@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42657222.5080601@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 11:03:30PM +0200, Thomas Renninger wrote:
> > "All" we need to do is to update the "diff". Without dynamic ticks, if the
> > idle loop didn't get called each jiffy, it was a big hint that there was so
> > much activity in between, and if there is activity, there is most likely
> > also bus master activity, or at least more work to do, so interrupt activity
> > is likely. Therefore we assume there was bm_activity even if there was none.
> >
> If I understand this right you want at least wait 32 (or whatever value) ms if there was bm activity,
> before it is allowed to trigger C3/C4?

That's the theory of operation of the current algorithm. I think that we
should do that small change to the current algorithm which allows us to keep
C3/C4 working with dyn-idle first, and then think of a very small abstraction
layer to test different idle algroithms, and -- possibly -- use different
ones for different usages.

> I think the problem is (at least I made the experience with this particular
> machine) that bm activity comes very often and regularly (each 30-150ms?).
> 
> I think the approach to directly adjust the latency to a deeper sleep state if the
> average bus master and OS activity is low is very efficient.
> 
> Because I don't consider whether there was bm_activity the last ms, I only
> consider the average, it seems to happen that I try to trigger
> C3/C4 when there is just something copied and some bm active ?!?

I don't think that this is perfect behaviour: if the system is idle, and
there is _currently_ bus master activity, the CPU should be put into C1 or
C2 type sleep. If you select C3 and actually enter it, you're risking
DMA issues, AFAICS.

> The patch is useless if these failures end up in system freezes on
> other machines...

I know that my patch is useless in its current form, but I wanted to share
it as a different way of doing things. 

> The problem with the old approach is, that after (doesn't matter C1-Cx)
> sleep and dyn_idle_tick, the chance to wake up because of bm activity is
> very likely.
> You enter idle() again -> there was bm_activity -> C2. Wake up after e.g.
> 50ms, because of bm_activity again (bm_sts bit set) -> stay in C2, wake up
> after 40ms -> bm activity... You only have the chance to get into deeper
> states if the sleeps are interrupted by an interrupt, not bm activity.

That's a side-effect, indeed. However: if there _is_ bus master activity, we
must not enter C3, AFAICS.

	Dominik
