Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVFMSXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVFMSXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVFMSXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:23:47 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:56982 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261159AbVFMSXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:23:41 -0400
Date: Mon, 13 Jun 2005 11:22:27 -0700
From: Tony Lindgren <tony@atomide.com>
To: Thomas Renninger <trenn@suse.de>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2
Message-ID: <20050613182227.GF8020@atomide.com>
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <200506130454.j5D4suNY006032@turing-police.cc.vt.edu> <20050613152507.GB7862@atomide.com> <200506131647.j5DGl0ke009926@turing-police.cc.vt.edu> <42ADC9E7.30901@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ADC9E7.30901@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Renninger <trenn@suse.de> [050613 11:01]:
> Valdis.Kletnieks@vt.edu wrote:
> > On Mon, 13 Jun 2005 08:25:07 PDT, Tony Lindgren said:
> > 
> >>You may also want to check out the patch by Thomas Renninger for ACPI
> >>C-states. I've added a link to it at:
> >>
> >>http://muru.com/dyntick/
> > 
> > I think that's muru.com/linux/dyntick ?

Oops, that's correct.

> > I'm not sure what Thomas's patch will do for me
> Not much.
> The one measures how long your machine really stays in
> each C-state (Tony's pmstats should be sufficient for you).
> 
> The other one tried to calc the next C-state to go, based on
> statistics of bus master activity and idleness of the machine.
> But it is *wrong*.
> Tony could you please remove the link to:
> ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/dynamic_tick_cstate_patch.diff
> Therefore we also will never get such good results as stated in:
> ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine

OK, removed.

> The problem is that if there is bus master activity, a certain amount of time
> has to be waited (nobody could tell me how long this must be, currently
> it's 40 ms. Then it's assumed bm transfers have been finished) before C3/C4 can be called ->
> -> bm activity is not interrupt driven -> this needs ticks to be enabled.
> 
> Therefore a final patch could look like:
> Let ticks be enabled (maybe reduced?) as long as machine is still in C1/C2 and
> only disable them for deeper sleeping states (C3/C4).
> 
>  - here's what I currently have:
> > 
> > % cat /proc/acpi/processor/CPU0/power 
> > active state:            C2
> > max_cstate:              C8
> > bus master activity:     00000000
> > states:
> >     C1:                  type[C1] promotion[C2] demotion[--] latency[000] usage[00000010]
> >    *C2:                  type[C2] promotion[--] demotion[C1] latency[050] usage[01314979]
> > 
> > Near as I can tell, we start off in C1, drop into C2, and stay there no
> > matter what happens - we never move back up to C1, and there's no C3 to drop
> > into....
> > 
> > Should there be a C3/C4?  Is my laptop just plain borked? :)
> Depends on your machine and BIOS, whether it's supported -> seems as if it's not.
> 
> You could verify by having a deeper look in your FADT/DSDT.
> You need the acpi tools from Len Brown (acpidmp/acpixtract) and the iasl Intel ACPI
> compiler.
> AFAIK checking for C-support is rather robust in recent kernels as long as you don't have a broken
> DSDT table.
> Maybe you find a newer BIOS supporting C3?
> 
> To be honest, I doubt you save much power even with dyn tick enabled if you only have support
> for C1 and C2. The pmstats tool from Tony (see link above)
> could tell you nicely whether you gain anything.

Yes, the savings are hard to get currently. In the long run using C4 and
idling some devices when the ticks to skip is longer should give better
savings.

Tony
