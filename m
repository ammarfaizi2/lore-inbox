Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266614AbUBDVeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266576AbUBDVbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:31:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16256 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266575AbUBDVaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:30:22 -0500
Date: Wed, 4 Feb 2004 16:30:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Oliver Dain <odain2@mindspring.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: proper place for devfs_register_chrdev with pci_module_init
In-Reply-To: <18852317.1075926209540.JavaMail.root@wamui01.slb.atl.earthlink.net>
Message-ID: <Pine.LNX.4.53.0402041616230.3277@chaos>
References: <18852317.1075926209540.JavaMail.root@wamui01.slb.atl.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Oliver Dain wrote:

> I'm writing a char driver for a PCI card.  Looking at examples of such things I've found that most have a module_init like this:
>
> int foo_init(void)
> {
> 	/* stuff... */
> 	devfs_register_chrdev(...);
> 	/* more stuff... */
> 	pci_module_init(...);
> }
>
> This seems strange to me.  The devfs_register_chrdev call will register
> the module and cause it to be held in memory even if the associated
> PCI device isn't present on the system.  It seems like a better way
> to do this is to have the init method just call pci_module_init(...)
> and then in that method, after the PCI device has been initialized, call
> devfs_register_chrdev to associate the driver with the device.  That way
> the kernel can unload the module if no such device is present, but if
> the device is present (or if one appears via hotplug) the module will
> be loaded and can then register itself.  Will this work?  Is there a
> reason people don't do this?
>

First! Fix your mailer. There wasn't a '\n' in the entire bunch
of text above. Unix/Linux people use the [Enter] key and don't
just auto-warp around the screen.

> I'm not subscribed to the LKML so please CC me on any responses.
>
> Thanks,
> Oliver

Well the "standard way" to start up a module is to allocate
resources for the module (like RAM), then register the module.

Then if the device isn't found, it's unregistered and the resources
freed. If the code to which you refer doesn't free its resources,
including unregistering if the device isn't found, then it's a bug.

Otherwise it doesn't make any difference. You can certainly probe
the PCI bus for your device first, and if it isn't found, you just
return -ENODEV or whatever. It's entirely up to you.

What is important is to make sure that you free any resources
that you acquired (like address space) if you decide not to
install the module. This makes it so you can write the module,
debug it, and add functionality without ever having to re-boot.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


