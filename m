Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTEIPNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 11:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTEIPNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 11:13:48 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:56021 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263280AbTEIPNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 11:13:45 -0400
Date: Fri, 9 May 2003 17:24:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl32_unregister_conversion & modules
Message-ID: <20030509152436.GA762@elf.ucw.cz>
References: <20030509100039$6904@gated-at.bofh.it> <200305091213.h49CDuO4029947@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305091213.h49CDuO4029947@post.webmailer.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ...what is the problem?
> > 
> > It seems that function pointers into modules do not need any special
> > treatmeant [I *know* there was talk about this on l-k; but I can't
> > find anything in Documentation/]:
> > 
> >                 if (!capable(CAP_SYS_ADMIN))
> >                         return -EACCES;
> >                 if (disk->fops->ioctl) {
> >                         ret = disk->fops->ioctl(inode, file, cmd, arg);
> >                         if (ret != -EINVAL)
> >                                 return ret;
> >                 }
> 
> This is protected against unload by the reference counting done in 
> open()/release(). ->ioctl() can be called only for open devices,
> so you know the ioctl handler is not getting unloaded while it
> is running.
>  
> > So... what's the problem with {un}register_ioctl32_conversion being
> > called from module_init/module_exit? Drivers in the tree do it
> > already...
> 
> The problem is that when the conversion handler is called, the reference
> counting is only done for the module listed as ->owner in the
> file operations. For example in the patch you submitted to add 
> register_ioctl32_conversion() to drivers/serial/core.c I see nothing
> stopping you from unloading core.ko while the handler is running
> on a device owned by drivers/char/cyclades.c or any other serial driver.
> It does not even have to be run on a serial driver, a user might try
> to do ioctl(TIOCGSERIAL, ...) on a regular file...

Oh.... Yep, that's pretty clear.

So what you are saying is that all existing
register_ioctl32_conversion-s that are in unloadable module are
broken. Ouch.

Fixing that would require resgister_ioctl32_conversion() to have 3-rd
parameter "this module" and some magic inside fs/compat_ioctl.c,
right?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
