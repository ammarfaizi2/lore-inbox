Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVAaMww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVAaMww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVAaMwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:52:42 -0500
Received: from gprs214-156.eurotel.cz ([160.218.214.156]:24963 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261179AbVAaMvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:51:46 -0500
Date: Mon, 31 Jan 2005 13:51:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mjg59@srcf.ucam.org
Subject: Re: [PATCH] Resume from initramfs
Message-ID: <20050131125110.GD6279@elf.ucw.cz>
References: <41FE24F5.5070906@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FE24F5.5070906@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> seeing as it is that the current software suspend allows suspending only 
> from built-in devices I've hacked the swsusp code to allow also for 
> manual resume. Thus it is now be capable to suspend to modular devices also.
> This is actually based on a previous patch by mjg59 at scrf.ucam.org, 
> augmented by suggestions from Pavel Machek.
> For a clean implementation I've split up the function swsusp_read() into 
> the distinct functions swsusp_check() and swsusp_read().
> Furthermore the function prepare() has been split into 
> prepare_processes() and prepare_devices().
> With this we now have the functionality to first check whether the 
> device really contains a resume image, then freeze all processes and 
> free some memory, read in the resume image and shut down all devices.
> It actually makes checking for a resume image faster than the current 
> implementation.
> 
> resume can be started by 'echo <major>:<minor> > /sys/power/resume".
> Note that this _only_ works from within initramfs when _no_ devices are 
> mounted. Otherwise resume will not be able to freeze the swapper task 
> and consequently fail.
> And yes, it needs to be properly documented. Will do once the patch is 
> accepted in principle :-).

In priciple it looks okay, but minor details still need to be ironed
out.

> Oh, and the usual applies: works for me, might eat your disk, beware of 
> nasal demons.

:-) Please try to inline patches, it makes it easier to reply to
them.

At one point you did something like

	read_data()
	blk_device_put()

If read_data does blk_device_get(), it should also do the put()
itself. Otherwise some caller will forget it.

									Pavel

> --- linux-2.6.10/init/do_mounts.c.orig	2005-01-28 10:25:35.000000000 +0100
> +++ linux-2.6.10/init/do_mounts.c	2005-01-28 10:30:43.000000000 +0100
> @@ -135,7 +135,7 @@ fail:
>   *	is mounted on rootfs /sys.
>   */
>  
> -dev_t __init name_to_dev_t(char *name)
> +dev_t name_to_dev_t(char *name)
>  {
>  	char s[32];
>  	char *p;

Why do you need this one? /sys/power/resume accepts numeric values, it
should not need to translate...

> @@ -144,7 +144,8 @@ dev_t __init name_to_dev_t(char *name)
>  
>  #ifdef CONFIG_SYSFS
>  	int mkdir_err = sys_mkdir("/sys", 0700);
> -	if (sys_mount("sysfs", "/sys", "sysfs", 0, NULL) < 0)
> +	int mount_err = sys_mount("sysfs", "/sys", "sysfs", 0, NULL);
> +	if (mount_err < 0 && mount_err != -EBUSY)
>  		goto out;
>  #endif
>  

This is probably not acceptable. Why do you need it? It should be
easily doable from initrd.

> --- linux-2.6.10/kernel/power/disk.c.orig	2005-01-28 10:25:28.000000000 +0100
> +++ linux-2.6.10/kernel/power/disk.c	2005-01-31 11:59:04.308199464 +0100
> @@ -121,45 +125,54 @@ static void finish(void)
>  }
>  
>  
> -static int prepare(void)
> +static int prepare_processes(void)
>  {
>  	int error;
>  
>  	pm_prepare_console();
>  
>  	sys_sync();
> -	if (freeze_processes()) {
> +
> +	if (freeze_processes() > 1) {
>  		error = -EBUSY;
> -		goto Thaw;
> +		return error;
>  	}

What does freeze_processes() == 1 mean and why is it suddenly ok?

> -	pr_debug("PM: Preparing system for restore.\n");
> +	pr_debug("PM: Preparing devices for restore.\n");
>  
> -	if ((error = prepare()))
> +	if ((error = prepare_devices())) {
>  		goto Free;
> +	}

I'd not add parenthesis for single command....

> +	if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
> +		res = MKDEV(maj,min);
> +		if (maj == MAJOR(res) && min == MINOR(res)) {
> +			swsusp_resume_device = res;
> +			printk("Attempting manual resume\n");
> +			noresume = 0;
> +			set_current_state(TASK_STOPPED);
> +			software_resume();
> +			set_current_state(TASK_RUNNING);

Ugh, now that is "interesting" hack. You set yourself as stopped to
avoid refrigerator.... Is it really needed?

> --- linux-2.6.10/kernel/power/swsusp.c.orig	2005-01-28 10:25:28.000000000 +0100
> +++ linux-2.6.10/kernel/power/swsusp.c	2005-01-28 16:45:14.000000000 +0100
> +	} else {
> +		pr_debug("swsusp: Resume From Partition %d:%d\n",
> +			 MAJOR(swsusp_resume_device),MINOR(swsusp_resume_device));

Missing space after ",".

> -	resume_bdev = open_by_devnum(resume_device, FMODE_READ);
> +	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
>  	if (!IS_ERR(resume_bdev)) {
>  		set_blocksize(resume_bdev, PAGE_SIZE);
> -		error = read_suspend_image();
> -		blkdev_put(resume_bdev);
> +		if((error = check_suspend_image()))
> +		    blkdev_put(resume_bdev);

Please put space after "if" and fix formatting here.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
