Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317752AbSG0T6s>; Sat, 27 Jul 2002 15:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318812AbSG0T6s>; Sat, 27 Jul 2002 15:58:48 -0400
Received: from www.transvirtual.com ([206.14.214.140]:52236 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317752AbSG0T6r>; Sat, 27 Jul 2002 15:58:47 -0400
Date: Sat, 27 Jul 2002 13:01:56 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Ewan Mac Mahon <ecm103@york.ac.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [PATCH] Second set of console changes.
In-Reply-To: <Pine.LNX.4.44.0207251402530.31229-100000@kitt.york.ac.uk>
Message-ID: <Pine.LNX.4.44.0207271244040.17619-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Jul 2002, Ewan Mac Mahon wrote:

> On Wed, 24 Jul 2002, James Simmons wrote:
> >
> >    To the people with the devfs issues. Please send me a log of what
> > exactly happened and a detail ksymoop if you can. I just tried it on my
> > system with devfs enabled and it works for me.
>
> It doesn't oops, it just doesn't register the devices so you can't open
> gettys on them. Other than that the kernel boots fine and you can log in
> over the network. Doing that you can see a couple of big difference in
> /dev:

I tracked down the problem. Originally the code initialized the VT tty
early before kmalloc. So we had this:

console_driver.flags |= TTY_DRIVER_NO_DEVFS;

Now in tty_register_driver, which was called right afterwards, we have
this bit of code.

if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
                for(i = 0; i < driver->num; i++)
                    tty_register_devfs(driver, 0, driver->minor_start + i);
}

In the old code code the above was never called. Instead the code in
con_init_devfs was called.

Now in the new code we don't have TTY_DRIVER_NO_DEVFS set so the above is
called. The problem is the default flag that is passed into
tty_register_devfs. It is automatically 0 whereas before it was
DEVFS_FL_AOPEN_NOTIFY. The problem is the flag being passed.

I tried out devfs and found the problem is only root is now only allowed
to access vc/X. This is the problem. I haven't figured out a solution yet.
Any ideas anyone?


