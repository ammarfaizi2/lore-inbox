Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbUK0FkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbUK0FkG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbUK0Dx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:53:26 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262523AbUKZTdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:37 -0500
Date: Fri, 26 Nov 2004 12:52:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: [linux-pm] [PATCH] make pm_suspend_disk suspend/resume sysdev and dpm_off_irq
Message-ID: <20041126115226.GC1028@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8403BD586C@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD586C@pdsmsx403>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, this should be better patch. It works here.
> 
> device_power_down() might fail, in this case we should
> bail out, right?

Hmm, yes, you might want to add error=device_power_down(), if (error)
{ local_irq_enable(); return error; }. But I do not think system
devices really fail, and if they fail during resume, there's no good
way to recover the system, anyway...

I'd just apply this one, it will have to change after 2.6.10 anyway.

								Pavel

> > --- clean/kernel/power/swsusp.c	2004-10-19
> > 14:16:29.000000000 +0200
> > +++ linux/kernel/power/swsusp.c	2004-11-25
> > 12:27:35.000000000 +0100
> > @@ -854,11 +840,13 @@
> >  	if ((error = arch_prepare_suspend()))
> >  		return error;
> >  	local_irq_disable();
> > +	device_power_down(3);
> >  	save_processor_state();
> >  	error = swsusp_arch_suspend();
> >  	/* Restore control flow magically appears here */ 
> >  	restore_processor_state(); restore_highmem();
> > +	device_power_up();
> >  	local_irq_enable();
> >  	return error;
> >  }
> > @@ -878,6 +866,7 @@
> >  {
> >  	int error;
> >  	local_irq_disable();
> > +	device_power_down(3);
> >  	/* We'll ignore saved state, but this gets preempt count (etc)
> >  	right */ save_processor_state();
> >  	error = swsusp_arch_resume();
> > @@ -887,6 +876,7 @@
> >  	BUG_ON(!error);
> >  	restore_processor_state();
> >  	restore_highmem();
> > +	device_power_up();
> >  	local_irq_enable();
> >  	return error;
> >  }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
