Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270715AbTHFLbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270716AbTHFLbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:31:14 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:47294 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270715AbTHFLbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:31:03 -0400
Date: Wed, 6 Aug 2003 13:30:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: [PATCH] Allow initrd_load() before software_resume() (version 2)
Message-ID: <20030806113045.GB583@elf.ucw.cz>
References: <20030801002742.1033FE8003AE@mwinf0502.wanadoo.fr> <1059700691.1750.1.camel@laptop-linux> <20030801103054.9E75F30003B9@mwinf0201.wanadoo.fr> <1059734493.11684.0.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059734493.11684.0.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Okay. I hadn't tried it yet. I'll happily take up the barrow for you and
> push it to Pavel and Linus with the rest, if you like.

Don't even think about that.

It is not safe to run userspace *before* doing resume. You don't want
to see problems this would bring in. Forget it.
								Pavel

> > [Sorry, new version already... I hadn't noticed that mount_root() is
> >  also called from within initrd_load(). resume() must run before.]
> > 
> > 
> > This patch adds a boot parameter "resume_initrd".  If present,
> > init will load the initrd before trying to resume from swsusp.
> > 
> > This makes it posssible to resume from an encrypted suspend image.
> > The initrd should insmod cryptoloop.o or loop-AES.o and perform
> > losetup -e so that resume=/dev/loopX makes sense.
> > Note: software_resume() should not be allowed to complete if
> > initrd has altered disks (e.g. by flushing journals).
> > 
> > 
> > 
> > ______________________________________________________________________
> > 
> > diff -ur linux-2.6.0-test2.orig/Documentation/kernel-parameters.txt linux-2.6.0-test2/Documentation/kernel-parameters.txt
> > --- linux-2.6.0-test2.orig/Documentation/kernel-parameters.txt	2003-07-27 19:12:45.000000000 +0200
> > +++ linux-2.6.0-test2/Documentation/kernel-parameters.txt	2003-08-01 11:28:10.000000000 +0200
> > @@ -816,6 +816,8 @@
> >  
> >  	resume=		[SWSUSP] Specify the partition device for software suspension
> >  
> > +	resume_initrd	[SWSUSP] Run initrd before resuming from software suspension
> > +
> >  	riscom8=	[HW,SERIAL]
> >  			Format: <io_board1>[,<io_board2>[,...<io_boardN>]]
> >  
> > diff -ur linux-2.6.0-test2.orig/init/do_mounts.c linux-2.6.0-test2/init/do_mounts.c
> > --- linux-2.6.0-test2.orig/init/do_mounts.c	2003-07-27 19:00:37.000000000 +0200
> > +++ linux-2.6.0-test2/init/do_mounts.c	2003-08-01 11:31:17.000000000 +0200
> > @@ -15,6 +15,7 @@
> >  extern int get_filesystem_list(char * buf);
> >  
> >  int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */
> > +unsigned char resume_initrd = 0; /* Run initrd before resuming from swsusp */
> >  
> >  int root_mountflags = MS_RDONLY | MS_VERBOSE;
> >  char * __initdata root_device_name;
> > @@ -49,6 +50,13 @@
> >  __setup("ro", readonly);
> >  __setup("rw", readwrite);
> >  
> > +static int __init set_resume_initrd(char *str)
> > +{
> > +	resume_initrd = 1;
> > +	return 1;
> > +}
> > +__setup("resume_initrd", set_resume_initrd);
> > +
> >  static dev_t __init try_name(char *name, int part)
> >  {
> >  	char path[64];
> > @@ -365,9 +373,11 @@
> >  
> >  	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
> >  
> > -	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
> > -	   log corrupting stuff */
> > -	software_resume();
> > +	/* software_resume() has to be before mounting root, because even
> > +	   readonly mount of reiserfs would replay log corrupting stuff.
> > +	   However, users may want to run a special initrd first. */
> > +	if (!resume_initrd)
> > +		software_resume();
> >  
> >  	if (initrd_load())
> >  		goto out;
> > diff -ur linux-2.6.0-test2.orig/init/do_mounts.h linux-2.6.0-test2/init/do_mounts.h
> > --- linux-2.6.0-test2.orig/init/do_mounts.h	2003-07-27 19:04:19.000000000 +0200
> > +++ linux-2.6.0-test2/init/do_mounts.h	2003-08-01 11:31:41.000000000 +0200
> > @@ -28,6 +28,7 @@
> >  void  mount_root(void);
> >  extern int root_mountflags;
> >  extern char *root_device_name;
> > +extern unsigned char resume_initrd;
> >  
> >  #ifdef CONFIG_DEVFS_FS
> >  
> > diff -ur linux-2.6.0-test2.orig/init/do_mounts_initrd.c linux-2.6.0-test2/init/do_mounts_initrd.c
> > --- linux-2.6.0-test2.orig/init/do_mounts_initrd.c	2003-07-27 18:57:13.000000000 +0200
> > +++ linux-2.6.0-test2/init/do_mounts_initrd.c	2003-08-01 11:33:36.000000000 +0200
> > @@ -6,6 +6,7 @@
> >  #include <linux/romfs_fs.h>
> >  #include <linux/initrd.h>
> >  #include <linux/sched.h>
> > +#include <linux/suspend.h>
> >  
> >  #include "do_mounts.h"
> >  
> > @@ -74,6 +75,10 @@
> >  		return;
> >  	}
> >  
> > +	/* Must resume from swsusp before mounting a journalling root fs */
> > +	if (resume_initrd)
> > +		software_resume();
> > +
> >  	ROOT_DEV = real_root_dev;
> >  	mount_root();
> >  

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
