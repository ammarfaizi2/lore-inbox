Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277148AbRJHVaT>; Mon, 8 Oct 2001 17:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277147AbRJHVaK>; Mon, 8 Oct 2001 17:30:10 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:20492 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S277144AbRJHVaC>;
	Mon, 8 Oct 2001 17:30:02 -0400
Date: Mon, 8 Oct 2001 14:23:21 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.11-pre5
Message-ID: <20011008142321.A29702@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another release of the Compaq Hotplug PCI driver is available against
2.4.11-pre5 is at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-2001_10_08-2.4.11-pre5.patch.gz
With a full changelog at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-Changelog

The latest version of modutils is required to use this version of the
patch.

I have also included the ddfs patch from Pat Mochel in this patch, as
the hotplug pci driver now uses it as its interface to userspace.  I
have fixed a few minor bugs that I ran into in the ddfs patch, so people
interested in ddfs might want to take a look at this version.

Changes since the last release:
 	- forward ported to 2.4.11-pre5
	- use EXPORT_SYMBOL_GPL for some exported symbols
	- removed all of the pci bus /proc code from the Compaq driver.
	- removed the character device code from the hotplug pci core.
	- added ddfs support to the hotplug pci core for user space
	  interaction.
	- fixed a few minor ddfs bugs.
	- fixed problem with DW state in the Compaq driver (thanks to
	  Arjan van de Ven for pointing this out to me)

The big change here is there is no more character device or /proc
interaction with the driver, it is all through the ddfs filesystem.  The
hotplug pci core creates a hotplug_pci directory at the root of the ddfs
file system and a separate directory for every slot registered with the
hotplug pci core.

So the tree on one of my servers looks like:
.
`-- hotplug_pci
    |-- 2
    |   |-- adapter
    |   |-- attention
    |   |-- latch
    |   |-- power
    |   `-- test
    |-- 3
    |   |-- adapter
    |   |-- attention
    |   |-- latch
    |   |-- power
    |   `-- test
    |-- 4
    |   |-- adapter
    |   |-- attention
    |   |-- latch
    |   |-- power
    |   `-- test
    |-- 5
    |   |-- adapter
    |   |-- attention
    |   |-- latch
    |   |-- power
    |   `-- test
    `-- 6
        |-- adapter
        |-- attention
        |-- latch
        |-- power
        `-- test

The numbers are the physical numbers of the pci slots that are
registered with the hotplug pci core (they come from the hotplug pci
controller, and have to be unique).

Every file in a slot directory can be read to get the value for that bit
of information about the slot.  The files "power" and "attention" can be
written to to set the power (0 or 1) or attention (0 or 1) values.  The
"test" file is used to send hardware test commands to the hardware.  The
"adapter" file describes if an adapter is present in that slot or not,
and the "latch" file describes the position of the physical latch (if
any) for that slot.

So you can enable the power in slot 5 to be turned on by doing:
	echo 1 > hotplug_pci/5/power	
from the ddfs root.  If a pci card is present in that slot, the whole
pci initialization sequence will happen for that card, including calling
out to /sbin/hotplug with the pci info so that the module for that
device can be loaded.

Because of this change, the old Compaq userspace tools will not work
anymore :)

TODO:
	- either remove the Compaq BIOS specific code or fix it to not
	  use direct memory accesses (any opinions?)
	- decide on using ddfs or changing the hotplug pci core to be
	  it's own filesystem.  There are some restrictions of ddfs that
	  I ran into that becoming a separate file system would remove,
	  but I'm still undecided right now.
	- clean up the *_sleep_on() races in the Compaq driver.
	- possibly merge the 2 passes of the pci bus when removing a
	  device as the /proc logic that required that is now gone.
	- Port the Linux PPC hotplug pci controller driver to the
	  hotplug pci core  interface, whenever Anton sends me an
	  updated file...

thanks,

greg k-h
