Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTEHXLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTEHXLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:11:33 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:15016 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262227AbTEHXLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:11:31 -0400
Date: Fri, 9 May 2003 01:22:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030508232226.GA156@elf.ucw.cz>
References: <20030507104008$12ba@gated-at.bofh.it> <1052323484.9817.14.camel@rth.ninka.net> <20030508203313.GA2787@elf.ucw.cz> <200305090048.05081.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305090048.05081.arnd@arndb.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > BTW, need to extend this to netdev->do_ioctl as well for the
> > > handling of SIOCDEVPRIVATE based stuff.  Oh goody, we can finally
> > > fix up that crap :))))
> >
> > There's a *lot* of structs that contain *ioctl:
> 
> > atmdev.h:       int (*ioctl)(struct atm_dev *dev,unsigned int cmd,void *arg);
> > atmdev.h:       int (*ioctl)(struct atm_dev *dev,unsigned int cmd,void *arg);
> > fs.h:   int (*ioctl) (struct inode *, struct file *, unsigned, unsigned long);
> > fs.h:   int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long); 
> > hdlc.h: int (*ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd); 
> > ...
> 
> There are even some more that your grep did not catch. However, only 
> few of them actually need to be changed if we add ->compat_ioctl(). 

Having few structs with ->ioctl() and few with both ->ioctl() and
->compat_ioctl() seems pretty ugly to me...

> For those subsystems that have a clearly defined set of ioctls that 
> are implemented by the specific drivers, the compatibility code can
> be put in a higher level ioctl handler, e.g. atm_ioctl() instead of
> each of the atm drivers.

If it is clearly defined, it should not be an ioctl() in the first
place. Yep, you are right ioctl is probably abused for that at few
points... And finding out where it ->compat_ioctl() is going to be
"interesting".

> Finding out exactly which interfaces need to be extended can be done
> in the process.

> > What about this one: redefine it to (*ioctl)( ...., unsigned *long*,
> > unsinged long). That means we can add
> >
> > #define IOCTL_COMPAT 0x1 0000 0000
> 
> I had the same idea before but in addition to the problem that davem
> mentioned, this would require changing every single ioctl handler
> in the kernel and in third party drivers to use 'long' numbers.

Oops; yep, that's a showstopper.

> Not really something we want to do during the current freeze.
> 
> The three options that currently make sense to me are:
> 
> a) keep using register_ioctl32_conversion() for everything

I believe this makes sense: its too close to 2.6 to do anything else.

> b) add a compat_task() function that handlers may use to decide
>    if they should use the compat data structures, list those ioctls
>    as COMPATIBLE_IOCTL()

Unfortunately missing compat handler silently does the wrong thing in
this case.

> c) add ->compat_ioctl() to some interfaces, with HANDLE_IOCTL() as
>    fallback

Seems like too much rewriting to me...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
