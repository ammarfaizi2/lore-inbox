Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTICXgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTICXgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:36:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:42188 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264314AbTICXgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:36:44 -0400
Date: Wed, 3 Sep 2003 16:34:08 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: <torvalds@transmeta.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: revert to 2.6.0-test3 state
In-Reply-To: <20030903190442.GA2787@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0309031621380.944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch reverts swsusp to known good state (before Patrick made his
> untested changes to it). I had to do some changes to both swsusp.c and
> power.c to keep it compilable. Please apply,

Pavel, why do you have to be so difficult? I realize you're sore that I 
modified the code you maintain and unintentionally broke. However, it does 
not benefit either of us for you to intentionally break my code in return, 
especially considering I've since fixed the outstanding problems in my 
changes. 

> --- clean/kernel/power/main.c	2003-08-27 12:00:53.000000000 +0200
> +++ linux/kernel/power/main.c	2003-09-03 20:57:00.000000000 +0200
> @@ -178,25 +178,7 @@
>  	if (pm_disk_mode == PM_DISK_FIRMWARE)
>  		return pm_ops->enter(PM_SUSPEND_DISK);
>  
> -	if (!have_swsusp)
> -		return -EPERM;
> -
> -	pr_debug("PM: snapshotting memory.\n");
> -	in_suspend = 1;
> -	if ((error = swsusp_save()))
> -		goto Done;
> -
> -	if (in_suspend) {
> -		pr_debug("PM: writing image.\n");
> -		error = swsusp_write();
> -		if (!error)
> -			error = power_down(pm_disk_mode);
> -		pr_debug("PM: Power down failed.\n");
> -	} else
> -		pr_debug("PM: Image restored successfully.\n");
> -	swsusp_free();
> - Done:
> -	return error;
> +	BUG();
>  }

This is bullshit. It will not only introduce a compile warning, but it's
not user-friendly (I can forward flames from Linus about adding gratuitous
BUG()s to the kernel if you like). You also intentionally break my code,
instead of doing something reasonable like


+	return 0; 


> @@ -228,6 +210,11 @@
>  {
>  	int error = 0;
>  
> +	if ((state == PM_SUSPEND_DISK) && (pm_disk_mode != PM_DISK_FIRMWARE)) {
> +		software_suspend();
> +		return -EAGAIN;
> +	}

Why return -EAGAIN? 

Why even call software_suspend() at all. That's not the right thing to do, 
nor is it what I want to do (which I implied in saying that I would not 
use it). And, you've broken the possiblity of using the actualy ACPI S4 
low-power state. 

...

>  static int pm_resume(void)

> +	software_resume();
>  	return 0;
>  }

This is just silly, from a design point of view. You now have two 
functions that do the same thing, one just calls the other. Why? 

Please resubmit the patch without this crap, and I will not argue. 



	Pat

