Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWAKXHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWAKXHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWAKXHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:07:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:1190 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932517AbWAKXHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:07:17 -0500
Date: Wed, 11 Jan 2006 15:07:04 -0800
From: Greg KH <greg@kroah.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060111230704.GA32558@kroah.com>
References: <43C53DA0.60704@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C53DA0.60704@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 12:17:20PM -0500, Mike D. Day wrote:
> The included patch provides some sysfs helper routines so that xen 
> domain kernel processes can easily attributes to sysfs. The intent is 
> that any kernel process can add an attribute under /sys/xen just as 
> easily as adding a file under /proc. In other words, without using the 
> driver core to create a subsystem, dealing with kobjects and ksets, etc.

Why is xen special from the rest of the kernel in regards to adding
files to sysfs?  What does your infrastructure add that is not currently
already present for everyone to use today?

> One example adds xen version info under /sys/xen/version

Why is the xen version any different from any other module or driver
version in the kernel? (hint, use the interface that is availble for
this already...)

> The comments desired are (1) do the helper routines in xen_sysfs 
> duplicate code already present in linux (or under development somewhere 
> else).

You have access to the current tree as well as we do to be able to
answer this question :)

> (2) Is it appropriate for a process to create sysfs attributes without
> implementing a driver subsystem

You don't have to create a driver subsystem to be able to add stuff to
sysfs, what makes you think that?

> or (3) are such attributes better off living under /proc.

No, they belong in the sysfs tree like everything else.  Unless you have
process specific attributes, do NOT add anything new to /proc.

> (4) any other feedback is appreciated.

did you look at debugfs?  configfs?

What is wrong with the current kobject/sysfs/driver model interface that
made you want to create this extra code?

Aren't you already going to have a xen virtual bus in sysfs and the
driver model?  Why not just put your needed attributes there, where they
belong (on the devices themselves)?


> linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs.c
> --- /dev/null   Tue Jan 10 17:53:44 2006
> +++ b/linux-2.6-xen-sparse/arch/xen/kernel/xen_sysfs.c  Tue Jan 10 
> 23:30:37 2006

Your patch is linewrapped :(

> +#ifdef DEBUG
> +#define DPRINTK(fmt, args...)   printk(KERN_DEBUG "xen_sysfs: ",  fmt, 
> ## args)
> +#else
> +#define DPRINTK(fmt, args...)
> +#endif

Don't create your own, use dev_dbg() and friends instead.  pr_debug if
you absolutely don't have access to a struct device.

> +#ifndef BOOL
> +#define BOOL    int
> +#endif

Heh, what OS is this code for?

> +#ifndef FALSE
> +#define FALSE   0
> +#endif
> +
> +#ifndef TRUE
> +#define TRUE    1
> +#endif

No, don't add this, it's pointless.

> +#ifndef NULL
> +#define NULL    0
> +#endif

No, that will just break sparse.  Why did you add this?

> +#define __sysfs_ref__

Why?

> +struct xen_sysfs_object;
> +
> +struct xen_sysfs_attr {
> +       struct bin_attribute attr;
> +       ssize_t (*show)(void *, char *) ;
> +       ssize_t (*store)(void *, const char *, size_t) ;
> +       ssize_t (*read)(void *, char *, loff_t, size_t );
> +       ssize_t (*write)(void *, char *, loff_t, size_t) ;
> +};

Why a binary attribute?  Do you want to have more than one single piece
of info in here?  If so, no.

I'll stop here and say that you should use the internal-to-IBM code
review process, it would probably save you a lot of time in the
future...

thanks,

greg k-h
