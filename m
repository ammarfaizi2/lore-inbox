Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbTBCT73>; Mon, 3 Feb 2003 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbTBCT6a>; Mon, 3 Feb 2003 14:58:30 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4100 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267005AbTBCTyp>;
	Mon, 3 Feb 2003 14:54:45 -0500
Date: Mon, 3 Feb 2003 16:40:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Levon <levon@movementarian.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, ak@suse.de,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
Message-ID: <20030203154008.GC480@elf.ucw.cz>
References: <200301280121.CAA13798@harpo.it.uu.se> <20030202124235.GA133@elf.ucw.cz> <20030203103254.GA25619@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203103254.GA25619@compsoc.man.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This one should be okay. [oprofile not tested because I don't know how
> > to use it...
> 
> It's not hard you know[1].

should apt-get install oprofile then opcontrol --setup
--vmlinux=/boot/vmlinux --ctr0-count=20000
--ctr0-event=CPU_CLK_UNHALTED && opcontrol --start

do the trick? If that works does it mean oprofile is okay?

> > -struct pm_dev * set_nmi_pm_callback(pm_callback callback)
> > +static int nmi_resume(struct device *dev, u32 level)
> >  {
> > -	apic_pm_unregister(nmi_pmdev);
> > -	return apic_pm_register(PM_SYS_DEV, 0, callback);
> > -}
> > +	if (level != RESUME_POWER_ON)
> > +		return 0;
> > +	setup_apic_nmi_watchdog();
> > +	return 0;
> 
> I don't pretend to understand the PM layer at all, but it looks like
> that both nmi.c's and oprofile's resume functions will get called. This
> won't work: if oprofile has control of the perfctr's/nmi stuff, you
> can't let the NMI watchdog's resume() be called, as it may conflict with
> what oprofile is trying to resume.

oprofile() should already have checks to prevent that, and I added one

[        if (nmi_watchdog == NMI_LOCAL_APIC)
]

to nmi.c. I hope that's okay.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
