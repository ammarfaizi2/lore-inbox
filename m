Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVAaSQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVAaSQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVAaSQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:16:18 -0500
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:55680 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261295AbVAaSQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:16:04 -0500
Date: Mon, 31 Jan 2005 19:15:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mjg59@srcf.ucam.org
Subject: Re: [PATCH] Resume from initramfs
Message-ID: <20050131181553.GA1583@elf.ucw.cz>
References: <41FE24F5.5070906@suse.de> <20050131125110.GD6279@elf.ucw.cz> <41FE3C34.4000200@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FE3C34.4000200@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>--- linux-2.6.10/init/do_mounts.c.orig	2005-01-28 
> >>10:25:35.000000000 +0100
> >>+++ linux-2.6.10/init/do_mounts.c	2005-01-28 10:30:43.000000000 +0100
> >>@@ -135,7 +135,7 @@ fail:
> >> *	is mounted on rootfs /sys.
> >> */
> >>
> >>-dev_t __init name_to_dev_t(char *name)
> >>+dev_t name_to_dev_t(char *name)
> >>{
> >>	char s[32];
> >>	char *p;
> >
> >
> >Why do you need this one? /sys/power/resume accepts numeric values, it
> >should not need to translate...
> >
> swsusp_check is used by both entry points, and is itself not a init 
> function.
> I simply found it bad style to reference a __init function from there.
> And name_to_dev_t is evil in itself. I'd gladly be rid of it if
> possible.

Can you do name_to_dev_t during resume= parsing? That's always done
during early boot...

> How about this version? Better?

Yes, a bit :-). We still need the docs :-).
								Pavel

> @@ -121,45 +126,54 @@ static void finish(void)
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
> +
>  	if (freeze_processes()) {
>  		error = -EBUSY;
> -		goto Thaw;
> +		return error;
>  	}
> 
>  	if (pm_disk_mode == PM_DISK_PLATFORM) {
>  		if (pm_ops && pm_ops->prepare) {
>  			if ((error = pm_ops->prepare(PM_SUSPEND_DISK)))
> -				goto Thaw;
> +				return error;
>  		}
>  	}

If freezing processes fails, it returns with processes running, here
it returns with processes frozen. Bug?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
