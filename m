Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbTLaWdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbTLaWdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:33:07 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:30864 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S265267AbTLaWdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:33:02 -0500
Date: Wed, 31 Dec 2003 23:32:44 +0100
From: Manuel Estrada Sainz <ranty@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Message-ID: <20031231223244.GO24577@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <200312210137.41343.dtor_core@ameritech.net> <20031222093759.GB30235@kroah.com> <200312222229.17991.dtor_core@ameritech.net> <1072169289.2876.57.camel@pegasus>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1072169289.2876.57.camel@pegasus>
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: ranty@ranty.pantax.net
Subject: Re: [2.6 PATCH/RFC] Firmware loader - fix races and resource dealloocation problems
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 3.1 (built Wed Nov 26 20:40:04 CET 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 09:48:09AM +0100, Marcel Holtmann wrote:
> Hi Dmitry,
> 
> > > > It seems that implementation of the firmware loader is racy as it
> > > > relies on kobject hotplug handler. Unfortunately that handler runs
> > > > too early, before firmware class attributes controlling the loading
> > > > process, are created. This causes firmware loading fail at least half
> > > > of the times on my laptop.
> > >
> > > Um, why not have your script wait until the files are present?  That
> > > will remove any race conditions you will have.
> > 
> > How long should the userspace wait? One second as Manuel suggested?
> > Indefinitely? Or should the firmware agent have some timeout? If userspace
> > uses a timeout how should it correlate with the timeout on the kernel side?
> 
> the timeout of the kernel (which can be set from userspace) is for the
> whole firmware loading process. What we talk about is waiting a little
> bit before the files become visible for the firmware.agent.
> 
> > I am sorry but I have to disagree with you. Kernel should not call user
> > space until it has all infrastructure in place and is ready. Anything
> > else is just a sloppy practice.
> 
> The firmware.agent script has 3 extra lines to check for the visibility
> of the "loading" file and if it is not present it will sleep one second.
> This is a actual good practice compared to adding much more code to the
> kernel and have an own way of running hotplug.

 I would say that we will get into this with other issues.

 Maybe some generic mechanism could be implemented to make the hotplug
 event wait for the files.

 The least intrusive solution, although it doesn't sound quite clean could be:

 - Kernel side:
 	- sysfs_hotplug_frezze()
 		- Creates a dummy file /sys/.hotplug_frozen
 	- sysfs_hotplug_thaw()
 		- Removes /sys/.hotplug_frozen
 - Userspace:
	- Main hotplug script waits "while [ -f /sys/.hotplug_frozen ]".

 sysfs_hotplug_[frezze|thaw]() should be treated almost like spinlocks,
 so the system's behabiour doesn't get afected.

 Dmitry's patch is probably cleaner, but since I already had written the
 email when I noticed ...

 Happy new year everyone

 	Manuel
 
	

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
