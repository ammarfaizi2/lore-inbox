Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTDPQZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264458AbTDPQZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:25:19 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:54912 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264455AbTDPQZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:25:17 -0400
Date: Wed, 16 Apr 2003 18:36:41 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: David Gibson <david@gibson.dropbear.id.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: firmware separation filesystem (fwfs)
Message-ID: <20030416163641.GA2183@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030416005710.GB29682@ranty.ddts.net> <1050492681.28586.39.camel@dhcp22.swansea.linux.org.uk> <20030416144631.GB899@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416144631.GB899@zax>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 12:46:31AM +1000, David Gibson wrote:
> On Wed, Apr 16, 2003 at 12:31:21PM +0100, Alan Cox wrote:
> > How is this better than simply having your hotplug helper load
> > the firmware from disk ? Its nice code but you have to ask the
> > question "why". I don't want the firmware wasting ram, I don't
> > need the firmware fs wasting ram. I may need to load the right
> > firmware from a choice of 16 odd types (usb_serial has some
> > examples there).
> 
> The obvious case is where it's impossible, or at least difficult/messy
> for userspace to directly access the device to upload the firmware.
> The latter is the case for the orinoco devices: the same firmwares can
> be used by USB, PCMCIA and PCI devices - these all have somewhat
> different register configurationss and different upload methods.
> Having an upload program that handles all these cases (not to mention
> endian and IO vs. memory mapped registers) seems silly when the driver
> already knows how to talk to the devices properly (actually we don't
> do firmware upload yet, but one day).  

 In the case of Orinoco USB devices, we even have fxload to download the
 ez-usb firmware, but the device doesn't change identity on firmware
 load, so both the hotplug helper and the driver end up accessing the
 device at the same time and it blows up.
 
> The driver could provide a chardev interface to upload the firmware
> through, but that's a lot more work - and there are issues of mapping
> the right chardev to the right network device instance, coping with
> the device in half-alive mode (i.e. initialized enough that firmware
> can be uploaded, but not ready to use because there's no firmware yet)
> etc.
> 
> I believe the idea is that hotplug (or other scripts) would copy the
> appropriate firmware into the relevant path in fwfs, so you don't need
> RAM for every firmware variant - just the one you're using. 

 Yes, that is the idea, although "hotplug" support is not implemented
 jet. I wanted some more feedback before expending more time on this.

 Taking a closer look, it should be easy to hook into the regular
 hotplug mechanism. I could just run '/sbin/hotplug firmware' setting
 FW_NAME=image_name in the environment and wait for it to finish like
 kmod does with modprobe.

 And if I also run it with 'ACTION=unload' when the firmware is not
 needed, it can easily be removed to save memory.

> And if we're really worried about memory it shouldn't be hard for the
> driver to arrange to unlink the firmware image once it's done with it
> (at the cost of not being able to reload the firmware on a
> reset/reinitialize, which might be sensible or necessary for some
> devices).

 On the other hand, there are already many drivers in the kernel that
 include firmware in headers, keyspan, io_edgeport, dabusb, ser_a2232,
 sym53c8xx_2, ...
 
 Something like fwfs would allow the removal of such firmware and save
 memory.

 If the firmware is not needed to boot, it could simply be removed from
 the kernel and be loaded from userspace.
 
 If the firmware is needed to boot, the driver could declare the
 firmware as __init data and register it on boot via fwfs_write_default.
 And after boot it could just be unlinked from fwfs recovering the
 memory.

 Currently the firmware image is copied into kmalloced memory then a
 drivers asks for the image, but if memory is such an issue, I'll look
 for a way to use the page cache data directly all the time. I'll take a
 closer look to the vmalloc code.
 
 Have a nice day

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
