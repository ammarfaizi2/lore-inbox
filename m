Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274910AbTHABPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 21:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274911AbTHABPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 21:15:47 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:35307 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S274910AbTHABPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 21:15:44 -0400
Date: Fri, 01 Aug 2003 13:18:12 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PATCH] Allow initrd_load() before software_resume()
In-reply-to: <20030801002742.1033FE8003AE@mwinf0502.wanadoo.fr>
To: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Message-id: <1059700691.1750.1.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030801002742.1033FE8003AE@mwinf0502.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'll try to apply it to the 2.4 version and include it in the upcoming
2.6 version. (Yes, upcoming means it's finally on the way).

Regards,

Nigel

On Fri, 2003-08-01 at 12:29, Pascal Brisset wrote:
> This patch adds a boot parameter "resume_initrd".
> If present, init will load the initrd before trying to resume.
> 
> This makes it posssible to resume from an encrypted suspend image.
> The initrd should insmod cryptoloop.o or loop-AES.o and perform
> losetup -e so that resume=/dev/loopX makes sense.
> Note: software_resume() should not be allowed to complete if
> initrd has altered disks (e.g. by flushing journals).
> 
> /initrd
> |-- bin
> |   |-- ash
> |   |-- insmod
> |   `-- losetup
> |-- dev
> |   |-- console
> |   |-- hdaX
> |   |-- loopX
> |   |-- null
> |   `-- tty
> |-- linuxrc
> |-- loop.o
> `-- lost+found
> 
> Resuming works, but suspension seems to fail more frequently when
> the swap is encrypted. I am using loop-AES-v1.7d + patch for 2.6.
> 
> Is it safe to suspend to loop devices ?
> 
> -- Pascal
> 
> 
> ______________________________________________________________________
> 
> diff -ur linux-2.6.0-test1.orig/Documentation/kernel-parameters.txt linux-2.6.0-test1/Documentation/kernel-parameters.txt
> --- linux-2.6.0-test1.orig/Documentation/kernel-parameters.txt	2003-07-14 05:39:36.000000000 +0200
> +++ linux-2.6.0-test1/Documentation/kernel-parameters.txt	2003-08-01 01:19:46.000000000 +0200
> @@ -816,6 +816,8 @@
>  
>  	resume=		[SWSUSP] Specify the partition device for software suspension
>  
> +	resume_initrd   [SWSUSP] Run initrd before resuming from software suspension
> +
>  	riscom8=	[HW,SERIAL]
>  			Format: <io_board1>[,<io_board2>[,...<io_boardN>]]
>  
> diff -ur linux-2.6.0-test1.orig/init/do_mounts.c linux-2.6.0-test1/init/do_mounts.c
> --- linux-2.6.0-test1.orig/init/do_mounts.c	2003-07-14 05:32:44.000000000 +0200
> +++ linux-2.6.0-test1/init/do_mounts.c	2003-08-01 01:21:44.000000000 +0200
> @@ -49,6 +49,15 @@
>  __setup("ro", readonly);
>  __setup("rw", readwrite);
>  
> +static int resume_initrd = 0;
> +static int __init set_resume_initrd(char *str)
> +{
> +	resume_initrd = 1;
> +	return 1;
> +}
> +
> +__setup("resume_initrd", set_resume_initrd);
> +
>  static dev_t __init try_name(char *name, int part)
>  {
>  	char path[64];
> @@ -365,12 +374,21 @@
>  
>  	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
>  
> -	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
> -	   log corrupting stuff */
> -	software_resume();
> +	/* software_resume() has to be before mounting root, because even
> +	   readonly mount of reiserfs would replay log corrupting stuff.
> +	   However, users may still want to run initrd first. */
> +	if (resume_initrd) {
> +		if (initrd_load()) {
> +			software_resume();
> +			goto out;
> +		}
> +	}
> +	else {
> +		software_resume();
>  
> -	if (initrd_load())
> -		goto out;
> +		if (initrd_load())
> +			goto out;
> +	}
>  
>  	if (is_floppy && rd_doload && rd_load_disk(0))
>  		ROOT_DEV = Root_RAM0;
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

