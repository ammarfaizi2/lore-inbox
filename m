Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVCHDdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVCHDdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVCHDav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 22:30:51 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:12013 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261233AbVCHD3D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 22:29:03 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Michal Januszewski <spock@gentoo.org>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Tue, 8 Mar 2005 04:18:07 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
References: <20050308021706.GH26249@spock.one.pl>
In-Reply-To: <20050308021706.GH26249@spock.one.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503080418.08804.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 08 März 2005 03:17, Michal Januszewski wrote:

> +It's possible to set path to the splash helper by writing it to 
> +/proc/sys/kernel/fbsplash.

It should probably just use its own hotplug agent instead of calling
the helper directly.

> +Splash protocol v1 specified an additional 'fbsplash mode' after the 
> +framebuffer number. Splash protocol v1 is deprecated and should not be used.

When you're submitting a patch for inclusion, the interface should really
be stable. I'd completely drop all references to the old version and only
support one interface here. Moreover, you should not do versioned interfaces
unless you expect incompatible changes in future releases. As long as you
still do, that is a sign that the patch is not ready for inclusion.

> +Splash protocol v2 specifies the following commands:
> +
> +getpic
> +------
> + The kernel issues this command to request image data. It's up to the userspace
> + helper to find a background image appropriate for the specified theme and the 
> + current resolution. The userspace helper should respond by issuing the
> + FBIOSPLASH_SETPIC ioctl.
> +
> +init
> +----
> + The kernel issues this command after the fbsplash device is created and
> + the fbsplash interface is initialized. Upon receiving 'init', the userspace 
> + helper should parse the kernel command line (/proc/cmdline) or otherwise
> + decide whether fbsplash is to be activated. 
> +
> + To activate fbsplash on the first console the helper should issue the
> + FBIOSPLASH_SETCFG, FBIOSPLASH_SETPIC and FBIOSPLASH_SETSTATE commands,
> + in the above-mentioned order.
> +
> + When the userspace helper is called in an early phase of the boot process
> + (right after the initialization of fbcon), no filesystems will be mounted.
> + The helper program should mount sysfs and then create the appropriate 
> + framebuffer, fbsplash and tty0 devices (if they don't already exist) to get 
> + current display settings and to be able to communicate with the kernel side.
> + It should probably also mount the procfs to be able to parse the kernel 
> + command line parameters.

Nothing about the init command seems really necessary. Why not just do 
that stuff from an /sbin/init script?

> +modechange
> +----------
> + The kernel issues this command on a mode change. The helper's response should
> + be similar to the response to the 'init' command. Note that this time the
> + console sem is held and all ioctls must be performed with origin set to
> + FB_SPLASH_IO_ORIG_KERNEL.
>
> +FB_SPLASH_IO_ORIG_KERNEL instructs fbsplash not to try to acquire the console
> +semaphore. Not surprisingly, FB_SPLASH_IO_ORIG_USER instructs it to acquire
> +the console sem.

That sounds really dangerous. Can you guarantee that nothing unexpected happens
when a malicious user calls the ioctls with FB_SPLASH_IO_ORIG_KERNEL from a
regular user process?

> +Info on used structures:
> +
> +Definition of struct vc_splash can be found in linux/console_splash.h. It's
> +heavily commented. Note that the 'theme' field should point to a string

Not that heavily documented, actually ;-). 

> +no longer than FB_SPLASH_THEME_LEN. When FBIOSPLASH_GETCFG call is 
> +performed, the theme field should point to a char buffer of length
> +FB_SPLASH_THEME_LEN.

Then don't make it pointer but instead a field of that length. Pointers
in ioctl arguments only cause trouble in mixed 32/64 bit environments.

> +Definition of struct fb_splash_iowrapper can be found in linux/fb.h.
> +The fields in this struct have the following meaning:
> +
> +vc: 
> +Virtual console number.

This should not be needed. I notice you are creating your own miscdevice
for passing ioctl commands. That seems a little backwards since there
already is a character device for the frame buffer. Can't you simply
add your ioctl commands there?

> +origin: 
> +Specifies if the ioctl is performed as a response to a kernel request. The
> +splash helper should set this field to FB_SPLASH_IO_ORIG_KERNEL, userspace
> +programs should set it to FB_SPLASH_IO_ORIG_USER. This field is necessary to
> +avoid console semaphore deadlocks.

As I mentioned, this means there is thinko in your locking scheme.

> +data: 
> +Pointer to a data structure appropriate for the performed ioctl. Type of
> +the data struct is specified in the ioctls description.

This is very wrong. Using ioctl() for anything is bad enough because it
contains an indirection from a system call. Here, you add yet another
indirection. Instead of this, you should at least have a single data
structure for each ioctl number, without using pointers to other structures.

 Arnd <><
