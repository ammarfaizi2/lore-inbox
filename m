Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267196AbUBMUhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267210AbUBMUh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:37:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:19627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267200AbUBMUe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:34:58 -0500
Date: Fri, 13 Feb 2004 12:34:49 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Tommi Virtanen <tv@tv.debian.net>, Leann Ogasawara <ogasawara@osdl.org>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't allow / in class device names
Message-ID: <20040213203448.GB14048@kroah.com>
References: <20040213102755.27cf4fcd.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213102755.27cf4fcd.shemminger@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 10:27:55AM -0800, Stephen Hemminger wrote:
> 
> > [0 tv@tao /sys/class/misc]$ uname -a
> > Linux tao 2.6.2-rc2 #6 Mon Jan 26 10:54:50 EET 2004 i686 GNU/Linux
> > [0 tv@tao /sys/class/misc]$ echo *
> > intermezzo net/tun psaux rtc uinput
> > [0 tv@tao /sys/class/misc]$
> >
> > Seems like that's all because of this:
> >
> > static struct miscdevice tun_miscdev = {
> >         .minor = TUN_MINOR,
> >         .name = "net/tun",
> >         .fops = &tun_fops
> > };
> >
> > Name is apparently meant to be a filename, not a path.
> > Don't know what should be done to it; maybe
> >
> > static struct miscdevice tun_miscdev = {
> >         .minor = TUN_MINOR,
> >         .name = "tun",
> >         .fops = &tun_fops,
> >         .devfs_name = "misc/net/tun",
> > };
> >
> > But I havent tried that out.
> >
> > I'd suggest this, to flush out all the problems. Later,
> > it can be changed to return -EINVAL or BUG_ON.
> >
> > --- 1.26/drivers/char/misc.c    Thu Jan 15 13:05:56 2004
> > +++ edited/misc.c       Fri Feb 13 19:35:45 2004
> > @@ -212,6 +212,9 @@
> >  int misc_register(struct miscdevice * misc)
> >  {
> >         struct miscdevice *c;
> > +
> > +       if (misc->name && strchr(misc->name, '/'))
> > +         printk("%s: name contains slash when registering %s.\n", __func__, misc->name);
> >
> >         down(&misc_sem);
> >         list_for_each_entry(c, &misc_list, list) {
> >
> Don't fix it just for misc_register, the fix needs to go into class_device.

No, the "fix" is to just not do this in the driver.  I'm not going to
apply this patch, sorry.

thanks,

greg k-h
