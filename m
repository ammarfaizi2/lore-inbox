Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWFRVgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWFRVgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 17:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWFRVgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 17:36:25 -0400
Received: from 1wt.eu ([62.212.114.60]:54792 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751228AbWFRVgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 17:36:24 -0400
Date: Sun, 18 Jun 2006 23:33:42 +0200
From: Willy Tarreau <w@1wt.eu>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060618213342.GG13255@w.ods.org>
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618212303.GD4744@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 11:23:03PM +0200, Samuel Thibault wrote:
> Hi,
> 
> There's a long-standing issue in init=/bin/sh mode: pressing control-C
> doesn't send a SIGINT to programs running on the console. The incurred
> typical pitfall is if one runs ping without a -c option... no way to
> stop it!
> 
> This is because no session is set up by the kernel, and shells don't
> start sessions on their own, so that no session (hence no controlling
> tty) is set up.
> 
> The attached patch sets such session and controlling tty up, which fixes
> the issue. The unfortunate effect is that init might be killed if one
> presses control-C very fast after its start.

This downside is a little problematic. Wouldn't it be possible to disable
the interrupt signal on the terminal, and let the user re-enable it when
needed using "stty intr ^C" ?

I too am used to starting with init=/bin/sh, but I'm also used to launch
ping in the background. However, if getting Ctrl-C working implies a risk
of killing init, then I'd rather keep it the old way.

> Samuel

Regards,
Willy

> --- linux-2.6.17-orig/init/main.c	2006-06-18 19:22:40.000000000 +0200
> +++ linux-2.6.17-perso/init/main.c	2006-06-18 23:00:00.000000000 +0200
> @@ -703,9 +703,13 @@
>  	system_state = SYSTEM_RUNNING;
>  	numa_default_policy();
>  
> +	sys_setsid();
> +
>  	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
>  		printk(KERN_WARNING "Warning: unable to open an initial console.\n");
>  
> +	sys_ioctl(0, TIOCSCTTY, 1);
> +
>  	(void) sys_dup(0);
>  	(void) sys_dup(0);
>  

