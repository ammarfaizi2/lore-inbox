Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVCIAjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVCIAjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVCIAgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:36:20 -0500
Received: from natpreptil.rzone.de ([81.169.145.163]:16320 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S262433AbVCIA3C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:29:02 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Michal Januszewski <spock@gentoo.org>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Wed, 9 Mar 2005 01:17:11 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
References: <20050308021706.GH26249@spock.one.pl> <200503080418.08804.arnd@arndb.de> <20050308223728.GA11065@spock.one.pl>
In-Reply-To: <20050308223728.GA11065@spock.one.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503090117.12755.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 08 März 2005 23:37, Michal Januszewski wrote:
> On Tue, Mar 08, 2005 at 04:18:07AM +0100, Arnd Bergmann wrote:
> 
> > It should probably just use its own hotplug agent instead of calling
> > the helper directly.
> 
> I've just had a look at it, and it seems possible. From what I have seen
> in the firmware_class.c code, it would require:
>  - registering a class somewhere in the initializaton code
>  - every time a request from fbcon is generated:
>    - register the class device
>    - create a timer
>    - call kobject_hotplug() to send the event to userspace
>    - unregister the device
> 
> This requests sent to userspace are generated while switching consoles
> and resetting the graphics mode. This whole create device - send the
> event - remove device thing seems a little long to me. Would it be
> acceptable?

Sorry, I had forgotten about the recent changes to the kernel side of the
hotplug interface, i.e. that it now needs a kobject to work.
It used to be possible to just call_usermodehelper() with hotplug_path
as its argv[0], but that is currently being phased out.

You also shouldn't create a class device every time you want to call
kobject_hotplug. Note that every character device already has a class
device associated with it, so you might be able to just use that to call 
kobject_hotplug on it.

If there is no obvious way to do that, just leave the code as it is
for calling the helper.

> > > + When the userspace helper is called in an early phase of the boot process
> > > + (right after the initialization of fbcon), no filesystems will be mounted.
> > > + The helper program should mount sysfs and then create the appropriate 
> > > + framebuffer, fbsplash and tty0 devices (if they don't already exist) to get 
> > > + current display settings and to be able to communicate with the kernel side.
> > > + It should probably also mount the procfs to be able to parse the kernel 
> > > + command line parameters.
> > Nothing about the init command seems really necessary. Why not just do 
> > that stuff from an /sbin/init script?
> 
> The reason for calling init in that place is the ability to use the
> userspace helper to display a nice picture while the kernel is still
> loading. Sure, you can just drop it and use the 'quiet' command line
> option, but that will give you a black screen for a good few seconds.
> And people who want eye-candy like fbsplash generally don't like that. 

Ok, understood. I think you should make that an extra patch and completely
remove that feature from the base patchset in order to make it less
controversial.

> > > +FB_SPLASH_IO_ORIG_KERNEL instructs fbsplash not to try to acquire the console
> > > +semaphore. Not surprisingly, FB_SPLASH_IO_ORIG_USER instructs it to acquire
> > > +the console sem.
> > 
> > That sounds really dangerous. Can you guarantee that nothing unexpected happens
> > when a malicious user calls the ioctls with FB_SPLASH_IO_ORIG_KERNEL from a
> > regular user process?
> 
> This is pretty nasty, right, but I just can't see a way around it. The
> thing is, when the splash helper is called from the kernel, the console
> semaphore is already held so we have to avoid trying to acquire it
> again. And we can't just release it prior to calling the helper, as it
> would break things badly.

I don't understand. Does the kernel code need to wait for the helper
to finish while holding the semaphore? AFAICS, the helper is completely
asynchronous, so it can simply do its job when the kernel has given
up the semaphore.

> > > +Info on used structures:
> > > +
> > > +Definition of struct vc_splash can be found in linux/console_splash.h. It's
> > > +heavily commented. Note that the 'theme' field should point to a string
> > Not that heavily documented, actually ;-). 
> 
> Anything that needs some clearing-up?

No, probably not. Maybe just remove that sentence from the text.

> > > +no longer than FB_SPLASH_THEME_LEN. When FBIOSPLASH_GETCFG call is 
> > > +performed, the theme field should point to a char buffer of length
> > > +FB_SPLASH_THEME_LEN.
> > Then don't make it pointer but instead a field of that length. Pointers
> > in ioctl arguments only cause trouble in mixed 32/64 bit environments.
> 
> That could be arranged, but this would require a separate structure for
> communicating with userspace and with in-kernel data storage (currently
> both these tasks are handled with struct vc_splash), or changing
> vc_splash in vc_data to a pointer to a structure. The latter option
> would be better I think.

Yes, that makes sense.

> - fbsplash calls aren't really related to a particular framebuffer
>   device, they are related to a tty. 

ok.

>                                       And we can't do ioctls on ttys when 
>   answering a kernel request because to the console sem problems
>   (opening a tty = a call to acquire_console_sem(), which we need to
>   avoid).

Hmm. One of us has misunderstood the interaction between 
call_usermodehelper() and acquire_console_sem(). If I'm the one
who's wrong, please tell me where that semaphore is held.

> The original idea behind this was to group the fields that are common to
> all fbsplash ioctl calls (ie. vc and origin) in one place. Of course,
> it can be changed to three differents structs, each containing the vc
> and origin fields and an int/struct vc_splash/struct fb_image, if that
> is the preferred way of doing things.

It definitely is. Actually, it would be preferred to have only a single
value as ioctl argument (or even better, no ioctl at all), but if you
need to pass an aggregate data type, it should at least have an identical
layout for all architectures. That means every member should be naturally
aligned and you can't use pointers or other types that have sizeof(x)
== sizeof(long).

 Arnd <><
