Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbULGJp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbULGJp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 04:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbULGJp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 04:45:28 -0500
Received: from gprs214-221.eurotel.cz ([160.218.214.221]:31363 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261569AbULGJpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 04:45:11 -0500
Date: Tue, 7 Dec 2004 10:44:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
Message-ID: <20041207094439.GC1469@elf.ucw.cz>
References: <1102279686.9384.22.camel@tyrosine> <20041205211823.GD1012@elf.ucw.cz> <1102374924.13483.9.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102374924.13483.9.camel@tyrosine>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj!

> Ok, how does this one look? (applies on top of the __init patch from
> last time)

It looks way better than last time :-).

> resume_device has been renamed to swsusp_resume_device to avoid
> confusion with the resume_device function in drivers/power. If a resume
> device has been set, it's assumed that userspace has been started. If
> not, it behaves as before. name_to_dev_t is only called if userspace
> hasn't been started - otherwise, we depend on the values provided by
> userspace being correct. If userspace has been started, we freeze tasks
> and free memory before starting the resume. If this looks ok, I'll merge
> it to your changes after 2.6.10.

Ugh, we probably should always stop tasks and always free memory. To
get code paths tested etc.


> @@ -28,7 +29,7 @@
>  extern int swsusp_read(void);
>  extern int swsusp_resume(void);
>  extern int swsusp_free(void);
> -
> +extern dev_t swsusp_resume_device;
>  
>  static int noresume = 0;
>  char resume_file[256] = CONFIG_PM_STD_PARTITION;

Move it to include/linux/suspend.h

> @@ -223,6 +224,18 @@
>  
>  	pr_debug("PM: Reading pmdisk image.\n");
>  
> +	if (swsusp_resume_device) {
> +		/* We want to be really sure that userspace isn't touching
> +		   anything at this point... */
> +		if (freeze_processes()) {
> +			goto Done;
> +		}
> +		
> +		/* And then make sure that we have enough memory to do the
> +		   resume */
> +		free_some_memory();
> +	}
> +
>  	if ((error = swsusp_read()))
>  		goto Done;
>  

This should not be conditional. 

> @@ -327,8 +340,42 @@
>  
>  power_attr(disk);
>  
> +static ssize_t resume_show(struct subsystem * subsys, char * buf) {
> +        return sprintf(buf,"%d:%d\n", MAJOR(swsusp_resume_device),
> +                       MINOR(swsusp_resume_device));
> +}
> +
> +static ssize_t resume_store(struct subsystem * s, const char * buf, size_t n)
> +{
> +        int error = 0;
> +        int len;
> +        char *p;
> +        unsigned maj, min;
> +        dev_t (res);

Why the ()s?

> +        p = memchr(buf, '\n', n);
> +        len = p ? p - buf : n;
> +
> +        if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
> +                res = MKDEV(maj, min);
> +                if (maj == MAJOR(res) && min == MINOR(res)) {

You mkdev, than test that MKDEV worked? Could you add a comment why
its needed?

I'd write it as "if (sscanf ... !=2) return -EINVAL". If (MKDEV is
broken) return -EINVAL, but Andrew would hate me then.

> @@ -1220,13 +1220,16 @@
>  {
>  	int error;
>  
> -	if (!strlen(resume_file))
> -		return -ENOENT;
> +	if (!swsusp_resume_device) {
> +		if (!strlen(resume_file))
> +			return -ENOENT;
>  
> -	resume_device = name_to_dev_t(resume_file);
> -	pr_debug("swsusp: Resume From Partition: %s\n", resume_file);
> +		swsusp_resume_device = name_to_dev_t(resume_file);
> +		pr_debug("swsusp: Resume From Partition: %s\n", resume_file);
> +	}

So... if userspace echos "0:0" into resume file, you attempt to do the
resume, and oops the kernel? Why not doing name_to_dev_t,
unconditionally, while doing resume_setup? And probably kill
CONFIG_PM_STD_PARTITION; I do not like idea of kernel automagically
trying to resume without anything on command line anyway.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
