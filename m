Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTEIMBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbTEIMBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:01:34 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:61151 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262497AbTEIMBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:01:25 -0400
Message-Id: <200305091213.h49CDuO4029947@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ioctl32_unregister_conversion & modules
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Date: Fri, 09 May 2003 14:10:31 +0200
References: <20030509100039$6904@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> ...what is the problem?
> 
> It seems that function pointers into modules do not need any special
> treatmeant [I *know* there was talk about this on l-k; but I can't
> find anything in Documentation/]:
> 
>                 if (!capable(CAP_SYS_ADMIN))
>                         return -EACCES;
>                 if (disk->fops->ioctl) {
>                         ret = disk->fops->ioctl(inode, file, cmd, arg);
>                         if (ret != -EINVAL)
>                                 return ret;
>                 }

This is protected against unload by the reference counting done in 
open()/release(). ->ioctl() can be called only for open devices,
so you know the ioctl handler is not getting unloaded while it
is running.
 
> So... what's the problem with {un}register_ioctl32_conversion being
> called from module_init/module_exit? Drivers in the tree do it
> already...

The problem is that when the conversion handler is called, the reference
counting is only done for the module listed as ->owner in the
file operations. For example in the patch you submitted to add 
register_ioctl32_conversion() to drivers/serial/core.c I see nothing
stopping you from unloading core.ko while the handler is running
on a device owned by drivers/char/cyclades.c or any other serial driver.
It does not even have to be run on a serial driver, a user might try
to do ioctl(TIOCGSERIAL, ...) on a regular file...

        Arnd <><
