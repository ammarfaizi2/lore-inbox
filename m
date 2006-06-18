Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWFRXPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWFRXPO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 19:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWFRXPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 19:15:13 -0400
Received: from ns2.suse.de ([195.135.220.15]:14235 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750870AbWFRXPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 19:15:12 -0400
Date: Sun, 18 Jun 2006 16:12:04 -0700
From: Greg KH <gregkh@suse.de>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
Message-ID: <20060618231204.GB2212@suse.de>
References: <20060618221343.GA20277@kroah.com> <20060618230041.GG4744@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618230041.GG4744@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 01:00:41AM +0200, Samuel Thibault wrote:
> Greg KH, le Sun 18 Jun 2006 15:13:43 -0700, a ?crit :
> > Since 2.6.13 came out, I have seen no complaints about the fact that
> > devfs was not able to be enabled anymore,
> 
> There has been at least my complaint about udev not being able to
> auto-load modules on /dev entry lookup (28th March 2006):
> 
> ??Given a freshly booted linux box, hence uinput is not loaded (why
> would it be, it doesn't drive any real hardware) ; what is the right
> way(tm) for an application to have the uinput module loaded, so that it
> can open /dev/input/uinput for emulating keypresses?
> 
> - With good-old static /dev, we could just open /dev/input/uinput
>   (installed by the distribution), and thanks to a
>   alias char-major-10-223 uinput
>   line somewhere in /etc/modprobe.d, uinput gets auto-loaded.
> 
> - With devfs, it doesn't look like it works (/dev/misc/uinput is not
>   present and opening it just like if it existed doesn't work). But I
>   read in archives that it could be feasible.

But I don't think it ever worked, as you stated.

> - With udev, this just cannot work. As explained in an earlier thread,
>   even using a special filesystem that would report the opening attempt
>   to udevd wouldn't work fine since udevd takes time for creating the
>   device, and hence the original program needs to be notified ; this
>   becomes racy.
> 
> So what is the correct way to do it? I can see two approaches:

You forgot:
  - use a static /dev if you want this.
No one is forcing you to use udev :)

> Using modprobe:
> - try to use /dev/input/uinput ; if it succeeds, fine.
> - else, if errno != ENOENT, fail
> - else, (ENOENT)
>   - try to call `cat /proc/sys/kernel/modprobe` uinput
>   - try to use /dev/input/uinput again ; if it succeeds, fine
>     - else, assume that it really wasn't compiled, and hence fail.
> 
> Triggering auto-load by creating one's own node.
> - try to use /dev/input/uinput ; if it suceeds, fine.
> - else, if errno != ENOENT, fail
> - else, (ENOENT)
>   - mknod /somewhere/safe/uinput c 10 223
>   - use /somewhere/safe/uinput ; if it succeeds, fine
>     - else, assume that it really wasn't compiled, and hence fail.
> ?
> 
> Neither solution looks good to me... Just opening /dev/input/uinput
> should be sufficient, and udev doesn't let that for now.

No, just do what the distros that use udev do today, load the needed
modules at boot time, based on the hardware that is present in the
system.  This should work just fine for the uinput driver, and if not,
simply add it to the list of modules that need to be loaded every boot
(each distro has a different place to put this list), and you should be
fine.

Please realize that the method of loading a module based on the device
node number is very restrictive, and only works for a small minority of
drivers.  This is due to the wide range of hardware sharing device nodes
(do you want to load all of the possible sound drivers when you touch
the sound device node?, no, you just want it "to work automatically",
which is what happens today at boot time with udev.)

> The same situation holds for other virtual devices (loop, snd-seq-dummy,
> ...).

Yes, look at how the distros do this today for loop, they merely load it
at boot time and everyone's happy.

And this whole thing has nothing to do with devfs, as you stated above
:)

thanks,

greg k-h
