Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTEHUYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTEHUYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:24:51 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:6547 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262110AbTEHUYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:24:49 -0400
Date: Thu, 8 May 2003 22:33:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030508203313.GA2787@elf.ucw.cz>
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <20030507135600.A22642@infradead.org> <20030507152856.GF412@elf.ucw.cz> <1052323484.9817.14.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052323484.9817.14.camel@rth.ninka.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Not sure if we are not too close to stable release to do that? And I
> > see no incremental way how to get there. Moving compatibility stuff
> > closer to drivers can be done close to stable release...
> 
> You can define it as follows:
> 
> 1) If entry exists in COMPAT or TRANSLATE table, invoke
>    fops->ioctl(), else
> 
> 2) If ->compat_ioctl() exists, invoke that, else
> 
> 3) Fail.
> 
> The COMPAT tables are sort of valuable, in that it eliminates
> the need to duplicate code when all of a drivers ioctls need
> no translation.
> 
> BTW, need to extend this to netdev->do_ioctl as well for the
> handling of SIOCDEVPRIVATE based stuff.  Oh goody, we can finally
> fix up that crap :))))

There's a *lot* of structs that contain *ioctl:
pavel@amd:/usr/src/linux-test/include/linux$ grep "*ioctl" *
pavel@amd:/usr/src/linux-test/include/linux$ grep "*ioctl" *
atmdev.h:       int (*ioctl)(struct atm_dev *dev,unsigned int cmd,void *arg);
atmdev.h:       int (*ioctl)(struct atm_dev *dev,unsigned int cmd,void *arg);
fs.h:   int (*ioctl) (struct inode *, struct file *, unsigned, unsigned long);
fs.h:   int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
hdlc.h: int (*ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
hdlcdrv.h:      int (*ioctl)(struct net_device *, struct ifreq *,
ide.h:  int             (*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
if_bridge.h:extern void brioctl_set(int (*ioctl_hook)(unsigned long));
if_pppox.h:     int             (*ioctl)(struct socket *sock, unsigned int cmd,
ioctl32.h:typedef int (*ioctl_trans_handler_t)(unsigned int, unsigned int, unsigned long, struct file *);
loop.h: int             (*ioctl)(struct loop_device *, int cmd,
loop.h: int (*ioctl)(struct loop_device *, int cmd, unsigned long arg);
net.h:  int             (*ioctl)     (struct socket *sock, unsigned int cmd,
ppp_channel.h:  int     (*ioctl)(struct ppp_channel *, unsigned int, unsigned long);
serial_core.h:  int             (*ioctl)(struct uart_port *, unsigned int, unsigned long);
tty_driver.h: * int  (*ioctl)(struct tty_struct *tty, struct file * file,
tty_driver.h:   int  (*ioctl)(struct tty_struct *tty, struct file * file,
tty_ldisc.h: * int      (*ioctl)(struct tty_struct * tty, struct file * file,
tty_ldisc.h:    int     (*ioctl)(struct tty_struct * tty, struct file * file,
usb.h:  int (*ioctl) (struct usb_interface *intf, unsigned int code, void *buf);
wanrouter.h:    int (*ioctl) (struct wan_device *wandev, unsigned cmd,
pavel@amd:/usr/src/linux-test/include/linux$

What about this one: redefine it to (*ioctl)( ...., unsigned *long*,
unsinged long). That means we can add 

#define IOCTL_COMPAT 0x1 0000 0000

and avoid adding new field to each such structure. Also I will not
have to duplicate lots of middle-level code (I will have to modify
unsigned int -> unsigned long, but no second copies of everything). It
means that architecture with CONFIG_COMPAT needs to have unsigned long
> 32 bits, but I guess we can live with that.

What do you think?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
