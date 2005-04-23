Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVDWWmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVDWWmp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVDWWmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:42:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26315 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262154AbVDWWm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:42:27 -0400
Date: Sun, 24 Apr 2005 00:41:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Li Shaohua <shaohua.li@intel.com>, "Antonino A. Daplas" <adaplas@pol.net>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com, zwane@linuxpower.ca,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Message-ID: <20050423224154.GG1884@elf.ucw.cz>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com> <20050412105115.GD17903@elf.ucw.cz> <1113309627.5155.3.camel@sli10-desk.sh.intel.com> <20050413083202.GA1361@elf.ucw.cz> <1113467253.2568.10.camel@sli10-desk.sh.intel.com> <20050423153501.5286b6c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423153501.5286b6c6.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Code: d2 74 bd fc 8b 44 24 28 b9 0e 00 00 00 8b 74 24 14 01 c6 b8 0e
> > > 00 00 00 89 74 24 1c 8b 74 24 30 89 44 24 10 8b 7c 24 1c 83 c6 10 <f3>
> > > a5 8b 74 24 24 8b 44 24 1c 89 4c 24 10 01 ee f7 d5 21 ee 89
> > >  <0>Kernel panic - not syncing: Attempted to kill the idle task!
> > >  Stuck ??
> > > Inquiring remote APIC #0...
> > > ... APIC #0 ID: 00000000
> > > ... APIC #0 VERSION: 00040011
> > > ... APIC #0 SPIV: 000000ff
> > > root@hobit:/sys/devices/system/cpu/cpu1#
> > Andrew,
> > Below patch fixed Pavel's oops. But strange is the 'system_state' check
> > is added for CPU hotplug by Rusty. This really makes me confused. Could
> > you please look at it.
> 
> Well as the comment says, if this CPU isn't online yet, and if the system
> has not yet reached SYSTEM_RUNNING state then we bale out of the printk
> because this cpu's per-cpu resources may not yet be fully set up.
> 
> 
> > This can be reproduced 100% with radeonfb driver load. Attached is the
> > dmesg of an oops. It seems the 'objp' parameter for
> > 'cache_alloc_debugcheck_after' is invalid.
> > 
> > --- a/kernel/printk.c	2005-04-12 10:12:19.000000000 +0800
> > +++ b/kernel/printk.c	2005-04-13 17:22:40.912897328 +0800
> > @@ -624,8 +624,7 @@ asmlinkage int vprintk(const char *fmt, 
> >  			log_level_unknown = 1;
> >  	}
> >  
> > -	if (!cpu_online(smp_processor_id()) &&
> > -	    system_state != SYSTEM_RUNNING) {
> > +	if (!cpu_online(smp_processor_id())) {
> >  		/*
> >  		 * Some console drivers may assume that per-cpu resources have
> >  		 * been allocated.  So don't allow them to be called by this
> > 
> 
> That being said, I don't see why your patch should fix the oops.  The test
> (system_state != SYSTEM_RUNNING) should be returning true at this time.

We were booting CPU on running system. system_state was definitely
SYSTEM_RUNNING, but we were trying to bring CPU#1 online...

Check is wrong. If cpu is not yet online, we may not printk on
it... It does not really depend on system_state...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
