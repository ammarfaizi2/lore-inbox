Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbTEHWju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTEHWju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:39:50 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:62857 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262211AbTEHWjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:39:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pavel Machek <pavel@ucw.cz>, "David S. Miller" <davem@redhat.com>
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Date: Fri, 9 May 2003 00:48:05 +0200
User-Agent: KMail/1.5.1
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20030507104008$12ba@gated-at.bofh.it> <1052323484.9817.14.camel@rth.ninka.net> <20030508203313.GA2787@elf.ucw.cz>
In-Reply-To: <20030508203313.GA2787@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="euc-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305090048.05081.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 May 2003 22:33, Pavel Machek wrote:

> > BTW, need to extend this to netdev->do_ioctl as well for the
> > handling of SIOCDEVPRIVATE based stuff.  Oh goody, we can finally
> > fix up that crap :))))
>
> There's a *lot* of structs that contain *ioctl:

> atmdev.h:       int (*ioctl)(struct atm_dev *dev,unsigned int cmd,void *arg);
> atmdev.h:       int (*ioctl)(struct atm_dev *dev,unsigned int cmd,void *arg);
> fs.h:   int (*ioctl) (struct inode *, struct file *, unsigned, unsigned long);
> fs.h:   int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long); 
> hdlc.h: int (*ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd); 
> ...

There are even some more that your grep did not catch. However, only 
few of them actually need to be changed if we add ->compat_ioctl(). 

For those subsystems that have a clearly defined set of ioctls that 
are implemented by the specific drivers, the compatibility code can
be put in a higher level ioctl handler, e.g. atm_ioctl() instead of
each of the atm drivers.
Finding out exactly which interfaces need to be extended can be done
in the process.

> What about this one: redefine it to (*ioctl)( ...., unsigned *long*,
> unsinged long). That means we can add
>
> #define IOCTL_COMPAT 0x1 0000 0000

I had the same idea before but in addition to the problem that davem
mentioned, this would require changing every single ioctl handler
in the kernel and in third party drivers to use 'long' numbers.
Not really something we want to do during the current freeze.

The three options that currently make sense to me are:

a) keep using register_ioctl32_conversion() for everything
b) add a compat_task() function that handlers may use to decide
   if they should use the compat data structures, list those ioctls
   as COMPATIBLE_IOCTL()
c) add ->compat_ioctl() to some interfaces, with HANDLE_IOCTL() as
   fallback

	Arnd <><
