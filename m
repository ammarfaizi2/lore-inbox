Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVEBAGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVEBAGg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 20:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVEBAGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 20:06:35 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:58034 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261489AbVEBAGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 20:06:25 -0400
Date: Sun, 1 May 2005 20:01:46 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] properly stop devices before poweroff
Message-ID: <20050502000146.GI3951@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@zip.com.au>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050421111346.GA21421@elf.ucw.cz> <20050501222403.GF3951@neo.rr.com> <20050501231635.GJ1909@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050501231635.GJ1909@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 01:16:35AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Without this patch, Linux provokes emergency disk shutdowns and
> > > similar nastiness. It was in SuSE kernels for some time, IIRC.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > 
> > Hi Pavel,
> > 
> > Although I like using pm_message_t, I'm not sure if we want to commit to only
> > PMSG_SUSPEND and PMSG_FREEZE for shutdown and reboot.  Would it be possible
> > to create a PMSG_HALT and PMSG_REBOOT?  I think this would give drivers more
> > control and flexability to make the right decision.  What is your opinion?
> > 
> > Of course, I'm still considering the posibility that we really want to do
> > PMSG_SUSPEND on a shutdown.  This may work ok on X86, I'm not sure about other
> > architectures.
> 
> Thats okay, nobody really knows yet. I believe that SUSPEND and HALT
> are very similar, and flags best way to separate them. I believe that
> FREEZE and REBOOT are very similar, too, and again would use flags to
> tell between them.

I'm not so sure about SUSPEND and HALT being similar.  It might be much faster
to have a routine that ignores slow state changes and goes directly for
stopping device activity.  Still, I'm not entirely decided.  On ACPI systems
SUSPEND should generally work, as it's the intended behavior for S4 which is
basically like S5 in many cases.  However, having a specific HALT message
might allow driver developers to clarify this ambiguity on a per-device basis.

As for FREEZE, it does seem to match with REBOOT well.  But it really depends
on what other things we intend to use FREEZE for (ex. CPUFREQ might require
something slightly different).

> 
> > I know you mentioned previously adding more flags and data to pm_message_t,
> > what exactly are your plans?
> 
> First I want type checking for pm_message_t. That's 2.6.12-early
> material. Then, when it is *really clear* that flags are needed, I'll
> add them. "really needed" as in "we have a driver where it matters".

I think it's already clear that we need to pass the specific device state.
Also the intended global system state transition might be helpful.

However, at the moment I'm considering using a slightly different API for
these sort of things.  It would include "->prepare_state_change()" and
"->complete_state_change()"  I'll have further justification for these
changes soon, however, I would like to leave the current stuff around also
as it would still be useful for shutdown and reboot, non-PM suspend issues,
and backward compatibilty.

Thanks,
Adam
