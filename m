Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270721AbTHAKtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275215AbTHAKtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:49:50 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:19427 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S270721AbTHAKs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:48:56 -0400
Date: Fri, 01 Aug 2003 22:41:34 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: [PATCH] Allow initrd_load() before
	software_resume() (version 2)
In-reply-to: <20030801103054.9E75F30003B9@mwinf0201.wanadoo.fr>
To: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Message-id: <1059734493.11684.0.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030801002742.1033FE8003AE@mwinf0502.wanadoo.fr>
 <1059700691.1750.1.camel@laptop-linux>
 <20030801103054.9E75F30003B9@mwinf0201.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay. I hadn't tried it yet. I'll happily take up the barrow for you and
push it to Pavel and Linus with the rest, if you like.

Regards,

Nigel

On Fri, 2003-08-01 at 22:32, Pascal Brisset wrote:
> [Sorry, new version already... I hadn't noticed that mount_root() is
>  also called from within initrd_load(). resume() must run before.]
> 
> 
> This patch adds a boot parameter "resume_initrd".  If present,
> init will load the initrd before trying to resume from swsusp.
> 
> This makes it posssible to resume from an encrypted suspend image.
> The initrd should insmod cryptoloop.o or loop-AES.o and perform
> losetup -e so that resume=/dev/loopX makes sense.
> Note: software_resume() should not be allowed to complete if
> initrd has altered disks (e.g. by flushing journals).
> 
> 
> 
> ______________________________________________________________________
> 
> diff -ur linux-2.6.0-test2.orig/Documentation/kernel-parameters.txt linux-2.6.0-test2/Documentation/kernel-parameters.txt
> --- linux-2.6.0-test2.orig/Documentation/kernel-parameters.txt	2003-07-27 19:12:45.000000000 +0200
> +++ linux-2.6.0-test2/Documentation/kernel-parameters.txt	2003-08-01 11:28:10.000000000 +0200
> @@ -816,6 +816,8 @@
>  
>  	resume=		[SWSUSP] Specify the partition device for software suspension
>  
> +	resume_initrd	[SWSUSP] Run initrd before resuming from software suspension
> +
>  	riscom8=	[HW,SERIAL]
>  			Format: <io_board1>[,<io_board2>[,...<io_boardN>]]
>  
> diff -ur linux-2.6.0-test2.orig/init/do_mounts.c linux-2.6.0-test2/init/do_mounts.c
> --- linux-2.6.0-test2.orig/init/do_mounts.c	2003-07-27 19:00:37.000000000 +0200
> +++ linux-2.6.0-test2/init/do_mounts.c	2003-08-01 11:31:17.000000000 +0200
> @@ -15,6 +15,7 @@
>  extern int get_filesystem_list(char * buf);
>  
>  int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */
> +unsigned char resume_initrd = 0; /* Run initrd before resuming from swsusp */
>  
>  int root_mountflags = MS_RDONLY | MS_VERBOSE;
>  char * __initdata root_device_name;
> @@ -49,6 +50,13 @@
>  __setup("ro", readonly);
>  __setup("rw", readwrite);
>  
> +static int __init set_resume_initrd(char *str)
> +{
> +	resume_initrd = 1;
> +	return 1;
> +}
> +__setup("resume_initrd", set_resume_initrd);
> +
>  static dev_t __init try_name(char *name, int part)
>  {
>  	char path[64];
> @@ -365,9 +373,11 @@
>  
>  	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
>  
> -	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
> -	   log corrupting stuff */
> -	software_resume();
> +	/* software_resume() has to be before mounting root, because even
> +	   readonly mount of reiserfs would replay log corrupting stuff.
> +	   However, users may want to run a special initrd first. */
> +	if (!resume_initrd)
> +		software_resume();
>  
>  	if (initrd_load())
>  		goto out;
> diff -ur linux-2.6.0-test2.orig/init/do_mounts.h linux-2.6.0-test2/init/do_mounts.h
> --- linux-2.6.0-test2.orig/init/do_mounts.h	2003-07-27 19:04:19.000000000 +0200
> +++ linux-2.6.0-test2/init/do_mounts.h	2003-08-01 11:31:41.000000000 +0200
> @@ -28,6 +28,7 @@
>  void  mount_root(void);
>  extern int root_mountflags;
>  extern char *root_device_name;
> +extern unsigned char resume_initrd;
>  
>  #ifdef CONFIG_DEVFS_FS
>  
> diff -ur linux-2.6.0-test2.orig/init/do_mounts_initrd.c linux-2.6.0-test2/init/do_mounts_initrd.c
> --- linux-2.6.0-test2.orig/init/do_mounts_initrd.c	2003-07-27 18:57:13.000000000 +0200
> +++ linux-2.6.0-test2/init/do_mounts_initrd.c	2003-08-01 11:33:36.000000000 +0200
> @@ -6,6 +6,7 @@
>  #include <linux/romfs_fs.h>
>  #include <linux/initrd.h>
>  #include <linux/sched.h>
> +#include <linux/suspend.h>
>  
>  #include "do_mounts.h"
>  
> @@ -74,6 +75,10 @@
>  		return;
>  	}
>  
> +	/* Must resume from swsusp before mounting a journalling root fs */
> +	if (resume_initrd)
> +		software_resume();
> +
>  	ROOT_DEV = real_root_dev;
>  	mount_root();
>  
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

