Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266639AbUBDVtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266638AbUBDVtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:49:15 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:9996 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id S266640AbUBDVsl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:48:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: odain2@mindspring.com
To: root@chaos.analogic.com
Subject: Re: proper place for devfs_register_chrdev with pci_module_init
Date: Wed, 4 Feb 2004 16:48:29 -0500
User-Agent: KMail/1.4.3
References: <18852317.1075926209540.JavaMail.root@wamui01.slb.atl.earthlink.net> <Pine.LNX.4.53.0402041616230.3277@chaos>
In-Reply-To: <Pine.LNX.4.53.0402041616230.3277@chaos>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402041648.29096.odain2@mindspring.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 4 2004 4:30 pm, you wrote:
> On Wed, 4 Feb 2004, Oliver Dain wrote:
> > I'm writing a char driver for a PCI card.  Looking at examples of such
> > things I've found that most have a module_init like this:
> >
> > int foo_init(void)
> > {
> > 	/* stuff... */
> > 	devfs_register_chrdev(...);
> > 	/* more stuff... */
> > 	pci_module_init(...);
> > }
> >
> > This seems strange to me.  The devfs_register_chrdev call will register
> > the module and cause it to be held in memory even if the associated
> > PCI device isn't present on the system.  It seems like a better way
> > to do this is to have the init method just call pci_module_init(...)
> > and then in that method, after the PCI device has been initialized, call
> > devfs_register_chrdev to associate the driver with the device.  That way
> > the kernel can unload the module if no such device is present, but if
> > the device is present (or if one appears via hotplug) the module will
> > be loaded and can then register itself.  Will this work?  Is there a
> > reason people don't do this?
>
> First! Fix your mailer. There wasn't a '\n' in the entire bunch
> of text above. Unix/Linux people use the [Enter] key and don't
> just auto-warp around the screen.
>
> > I'm not subscribed to the LKML so please CC me on any responses.
> >
> > Thanks,
> > Oliver
>
> Well the "standard way" to start up a module is to allocate
> resources for the module (like RAM), then register the module.
>
> Then if the device isn't found, it's unregistered and the resources
> freed. If the code to which you refer doesn't free its resources,
> including unregistering if the device isn't found, then it's a bug.
>
> Otherwise it doesn't make any difference. You can certainly probe
> the PCI bus for your device first, and if it isn't found, you just
> return -ENODEV or whatever. It's entirely up to you.
>
> What is important is to make sure that you free any resources
> that you acquired (like address space) if you decide not to
> install the module. This makes it so you can write the module,
> debug it, and add functionality without ever having to re-boot.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.

Thanks for the reply and sorry for the mailer issue (sent it from one of those 
pop->web interfaces, not my usual mail client).


If I understand how pci_module_init works it registers a function (the probe 
function) to be called with all harware that matches the id_table.  Thus the 
probe function won't be called at all unless some device matching the the 
parameters passed to it is found.  In that case there is no opportunity to 
unregister the driver since the driver never gets control again.  So I guess 
I could restate my question as:

1) Is it correct that the driver won't get control again if no matching 
devices are found?

2) If that's correct is it "legal" to call devfs_register_chrdev from a 
function other than init (specifically from the probe function)?

Thanks,
Oliver

PS: I'm not subscribed to LKML so please CC responses.

