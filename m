Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTLVXGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTLVXGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:06:14 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:60043 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264539AbTLVXGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:06:10 -0500
Date: Tue, 23 Dec 2003 00:05:59 +0100
From: Manuel Estrada Sainz <ranty@debian.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
       Greg KH <greg@kroah.com>
Message-ID: <20031222230559.GE15612@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <200312210137.41343.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200312210137.41343.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: ranty@ranty.pantax.net
Subject: Re: [2.6 PATCH/RFC] Firmware loader - fix races and resource dealloocation problems
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 3.1 (built Wed Nov 26 20:40:04 CET 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 01:37:39AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> It seems that implementation of the firmware loader is racy as it relies
> on kobject hotplug handler. Unfortunately that handler runs too early,
> before firmware class attributes controlling the loading process, are
> created. This causes firmware loading fail at least half of the times on
> my laptop.

 As Greg suggested, make your hotplug handler wait for the files to
 appear and you are set.

 Actually "sleep 1" will generally do the trick.

 What can actually be a problem is that hotplug delays event handling
 while booting, and if firmware needing drivers load at boot time they
 usually timeout before the event gets handled, and when hotplug tryies
 to handle the event the files are already gone.

 The only solution I see to the later is making the default timeout much
 bigger and  maybe having hotplug reset it to a shorter value once it
 starts handling events.
 
> Another problem that I see is that the present implementation tries to free
> some of the allocated resources manually instead of relying on driver model.
> Particularly damaging is freeing fw_priv in request_firmware. Although the
> code calls fw_remove_class_device (which in turns calls 
> class_device_unregister) the freeing of class device and all its attributes
> can be delayed as the attribute files may still be held open by the
> userspace handler or any other program. Subsequent access to these files
> could cause trouble.

 There are actually some oopses, which I believe come from incorrect
 refcounting in sysfs, when I get around to looking at it I'll also
 audit "use after free" issues with firmware_priv struct.

> Also, there is no protection from overwriting firmware image once it has
> been committed.

 The hotplug handler runs as root, and if buggy enough it could write a
 broken firmware image anyway, or write to /dev/mem or whatever, I don't
 see a point in this level of paranoia.
 
> I tried to correct all 3 problems in the patch below. It creates a custom
> hotplug handler that is called from request_hardware. I tried to mimic the
> hotplug handler from kobject - it's nice to have DEVPATH pointing to the
> right place - so I exported kobject_get_path_length and kobject_fill_path
> (former get_kobj_path_length and fill_kobj_patch). I think these 2 should
> not be considered "implementation details" and exporting them is OK.
> Write access to firmware device class attributes is protected by a semaphore
> and the code refuses any updates once firmware loading has been committed or
> aborted. Firmware 

 I am currently on Xmas vacation, until January I won't be very
 responsive.

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
