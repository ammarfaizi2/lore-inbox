Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVCaIjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVCaIjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVCaIjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:39:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38062 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261192AbVCaIjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:39:25 -0500
Date: Thu, 31 Mar 2005 10:39:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Isaacson <adi@hexapodia.org>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050331083909.GA1387@elf.ucw.cz>
References: <20050329181831.GB8125@elf.ucw.cz> <1112135477.29392.16.camel@desktop.cunningham.myip.net.au> <20050329223519.GI8125@elf.ucw.cz> <200503310226.03495.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503310226.03495.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > We currently freeze processes for suspend-to-ram, too. I guess that
> > > > disable_usermodehelper is probably better and that in_suspend() should
> > > > only be used for sanity checks... go with disable_usermodehelper and
> > > > sorry for the noise.
> > > 
> > > Here's another possibility: Freeze the workqueue that
> > > call_usermodehelper uses (remember that code I didn't push hard enough
> > > to Andrew?), and let invocations of call_usermodehelper block in
> > > TASK_UNINTERRUPTIBLE. In refrigerating processes, don't choke on
> > 
> > There may be many devices in the system, and you are going to need
> > quite a lot of RAM for all that... That's why they do not queue it
> > during boot, IIRC. Disabling usermode helper seems right.
> 
> Ok, what do you think about this one?
> 
> ===================================================================
> 
> swsusp: disable usermodehelper after generating memory snapshot and
>         before resuming devices, so when device fails to resume we
>         won't try to call hotplug - userspace stopped anyway.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> 
>  include/linux/kmod.h  |    3 +++
>  kernel/kmod.c         |   14 +++++++++++++-
>  kernel/power/disk.c   |    2 ++
>  kernel/power/swsusp.c |    1 -
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> Index: dtor/kernel/power/disk.c
> ===================================================================
> --- dtor.orig/kernel/power/disk.c
> +++ dtor/kernel/power/disk.c
> @@ -205,6 +205,8 @@ int pm_suspend_disk(void)
>  
>  	if (in_suspend) {
>  		pr_debug("PM: writing image.\n");
> +		usermodehelper_disable();
> +		device_resume();
>  		error = swsusp_write();
>  		if (!error)
>  			power_down(pm_disk_mode);
> Index: dtor/kernel/power/swsusp.c
> ===================================================================
> --- dtor.orig/kernel/power/swsusp.c
> +++ dtor/kernel/power/swsusp.c
> @@ -853,7 +853,6 @@ static int suspend_prepare_image(void)
>  int swsusp_write(void)
>  {
>  	int error;
> -	device_resume();
>  	lock_swapdevices();
>  	error = write_suspend_image();
>  	/* This will unlock ignored swap devices since writing is

Looks good, except... why move code around? Could you just call
usermodehelper_disable from swsusp_write?
							Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
