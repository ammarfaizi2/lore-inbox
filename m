Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTHVV2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 17:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTHVV2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 17:28:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:26810 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261179AbTHVV1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 17:27:51 -0400
Date: Fri, 22 Aug 2003 14:25:46 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: <torvalds@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs
 explaining to you?
In-Reply-To: <20030822210800.GA4403@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As far as I can see, I'm still maintainer of software suspend. That
> did not stop you from crying "split those patches" when I tried to
> submit changes to my code, and you were pretty pissed off when I tried
> to push trivial one liners without contacting maintainers.

Ok, I'm sorry. I should not have broken anything in your code, and 
actually significantly improved it. 

> And now you pushed ton of crap into Linus' tree, breaking userland
> interfaces in the stable series (/proc/acpi/sleep)

/proc/acpi/sleep is useless. For one, we want an interface that handles 
quiescing the system that is not tied to a particular low-level details. 
The ACPI bits are trivial. And, you really don't want an interface to 
swsusp that depends on ACPI, do you? 

On top of that, the way it was implemented was broken. You could not 
actually enter a low-power state (S4) if you used swsusp. You had to 
shutdown the system


> killing copyrights
> (Andy Grover has copyright on drivers/acpi/sleep/main.c)

Everything in that file, with the exception of one line fixes/checks, is 
mine, from either 2 years ago or now. 

> rewriting code without even sending diff to maintainer (no, I did not
> see a mail from you, and you modified swsusp heavily). 

I removed code from swsusp and moved into a central, shared location. I 
apoloigize for the hypocrasy on my part, but I contend that the result is 
much prettier.

> Great. This way we are going to have stable PM code... in 2056.

Yes, but we should also have it a lot sooner than that. 

Note that we have never had stable PM code; we've had crap. It is a lot 
more stable now, based solely on the fact that someone has actually taken 
the time to look at it, clean it up, and start fixing it. 

What is your idea of stability? The point when all the people that report
bugs to you, and you reply 'Fix it yourself' actually buckle down and fix 
all the problems? Or, when someone steps up and tries to make it work 
reliably for a majority of users? 

My intent is to do that, and to do it soon. And, with a minimal amount of 
pain during the transitions. 


> +
> +enum {
> +	PM_SUSPEND_ON,
> +	PM_SUSPEND_STANDBY,
> +	PM_SUSPEND_MEM,
> +	PM_SUSPEND_DISK,
> +	PM_SUSPEND_MAX,
> +};
> +
> +extern int (*pm_power_down)(u32 state);
> 
> If you defined enum, you should also use it. 

As a typedef parameter to the function? 

>  static int __init resume_setup(char *str)
>  {
> -	strncpy( resume_file, str, 255 );
> +	if (strlen(str))
> +		strncpy(resume_file, str, 255);
>  	return 1;
>  }
> 
> Why are you obfuscating the code?

Eh? First, why would you want to copy a NULL string? 

Secondly, you can actually remove the second command line parameter 
("noresume") by simply specifying a NULL partition to this parameter. It 
requires about a 5-line change, and makes things simpler. 

> You changed return type of do_magic() to int, but did not bother to
> update assembly code, as far as I can see. Did you test those changes?

I noticed that, and it's already fixed. 

> +Some devices are broken and will inevitably have problems powering
> +down or disabling themselves with interrupts enabled. For these
> +special cases, they may return -EAGAIN. This will put the device on a
> +list to be taken care of later. When interrupts are disabled, before
> +we enter the low-power state, their drivers are called again to put
> +their device to sleep. 
> 
> Returning EAGAIN to be called with interrupts disabled is extremely
> ugly hack. We were passing suspend level before. Why did you have to
> break it?

Because you can power down most devices with interrupts enabled, and you
really want to. Especially for devices that support runtime power
management, which by definition, requires interrupts to always be enabled. 

-EAGAIN allows the drivers/devices that really need special care to 
specify it. Otherwise, we'll end up calling ->suspend() twice for power 
down for each device (those that can do w/ interrupts enabled and those 
that need interrupts disabled), which also requires every single driver to 
check whether or not interrupts are enabled, instead of just those that 
need it. 


	Pat

