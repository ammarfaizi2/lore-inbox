Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270575AbTGZWQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270516AbTGZWQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:16:29 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:62212 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270575AbTGZWQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:16:27 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test1 devfs question
Date: Sun, 27 Jul 2003 02:30:01 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307262351.33808.arvidjaar@mail.ru> <20030726135012.6386c185.akpm@osdl.org>
In-Reply-To: <20030726135012.6386c185.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307270230.01823.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 July 2003 00:50, Andrew Morton wrote:
> Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > > Is the problem simply that the device has moved from /dev/md1 to
> > > /dev/md/1? If so, is this change sufficient?
> > >
> > > diff -puN drivers/md/md.c~a drivers/md/md.c
> > > --- 25/drivers/md/md.c~a        2003-07-26 11:24:58.000000000 -0700
> > > +++ 25-akpm/drivers/md/md.c     2003-07-26 11:25:15.000000000 -0700
> > > @@ -3505,7 +3505,7 @@ int __init md_init(void)
> > >         for (minor=0; minor < MAX_MD_DEVS; ++minor) {
> > >                 devfs_mk_bdev(MKDEV(MAJOR_NR, minor),
> > >                                 S_IFBLK|S_IRUSR|S_IWUSR,
> > > -                               "md/%d", minor);
> > > +                               "md%d", minor);
> > >         }
> >
> > should not such things be done by devfsd in user space?
>
> Darned if I know - I do not have operational experience with devfs.
>
> > This patch makes it even more incompatible with 2.4 ...
>
> The patch is broken - 2.4 does /dev/md/2 as well.
>
> So what is the bug?  Why are people suddenly having problems with this?

it is hard to tell with the amount of information provided in bug report (even 
error message is not given). We have three cases here:

root=123456 (real major/minor number) or root=/dev/md2 (literal string). In 
both cases init/do_mount_devfs.c:create_dev() should notice that neither 
/dev/123456 nor /dev/md2 exist, search /dev for ROOT_DEV and create link from 
/dev/root to real device. If it does not work somethig is broken here, people 
who can reproduce it should add printk's to create_dev and find_in_devfs to 
see what happens. It may fail for /dev/md2 if block device name in sysfs 
differs from "md2" because then it won't find correct ROOT_DEV

root=/dev/md/2 (literal string) should work simply because /dev/root is linked 
directly to /dev/md/2

I do not have any raid devices nor possibility to create them so I cannot 
test.

-andrey
