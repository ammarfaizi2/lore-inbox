Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbTBPPw1>; Sun, 16 Feb 2003 10:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbTBPPw1>; Sun, 16 Feb 2003 10:52:27 -0500
Received: from [195.39.17.254] ([195.39.17.254]:13572 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267084AbTBPPwK>;
	Sun, 16 Feb 2003 10:52:10 -0500
Date: Sun, 16 Feb 2003 17:01:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030216160119.GA2367@elf.ucw.cz>
References: <200302161243.NAA18253@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302161243.NAA18253@kim.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> @@ -1263,6 +1264,11 @@
> >>  		}
> >>  		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
> >>  	}
> >> +
> >> +	device_suspend(3, SUSPEND_NOTIFY);
> >> +	device_suspend(3, SUSPEND_SAVE_STATE);
> >
> >Comment these two lines... and all RESTORE_STATEs. System needs to be
> >stopped in order for SAVE_STATE to work, and it is not in apm case.
> 
> What's the proper fix? apm must be able to initiate suspend &
> resume.

Not sure.

In theory, apm must be able to initiate suspend & resume. But by the
same theory, apm bios should be doing hardware save stating itself --
and it obviously does not.

freeze_processes() should not fail, anyway, so right fix is to wrap
this with freeze_processes() and resume_processes().

Alternate fix is to invent level 6 and use it for apm. Things like ide
would then ignore level 6 (as apm is likely to do the right thing in
that case).

> >Do you think it is neccessary to call it "*local_*apic_nmi_driver"? It
> >seems way too long.
> 
> Local APIC != I/O APIC. I try to be a caretaker for the former,
> so I dislike the ambiguous term "APIC".

Ok.

> >Why did you convert device_apic_nmi to *sys_*device?
> 
> Otherwise the NMI watchdog device wouldn't show up in /sys.

Strange, it was there for me, IIRC.

> >This is good, if we have disable_, we should have enable_, not setup_;
> >but I killed _local_ part as it is way too long, then.
> 
> Note that there is also an I/O APIC NMI generator.
> If you drop the "local" qualifier, things get ambiguous.
> 
> Although I find it ugly, I could accept "lapic" as a shorter
> replacement for "local_apic" in identifiers.

Yep, lapic seems okay.
							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
