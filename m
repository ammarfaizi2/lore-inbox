Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSFTPNH>; Thu, 20 Jun 2002 11:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSFTPNG>; Thu, 20 Jun 2002 11:13:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38916 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314783AbSFTPND>; Thu, 20 Jun 2002 11:13:03 -0400
Date: Thu, 20 Jun 2002 08:13:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Schwenke <martin@meltin.net>
cc: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <200206200711.RAA10165@thucydides.inspired.net.au>
Message-ID: <Pine.LNX.4.44.0206200800260.8012-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Martin Schwenke wrote:
>
> Do you mean the /devices tree or the Open Firmware (OF) device-tree
> (as in IEEE Std 1275).  I suspect that you mean the former, but...

The "struct device" tree that is already built up by

>
>     Linus> [...]
>
>     Linus> All fixed at least to _some_ degree by giving the most
>     Linus> complete address we can, ie something like
>
>     Linus> 	/devices/root/pci0/00:02.0/02:1f.0/03:07.0
>
> That looks similar, but not identical to an Open Firmware node for a
> SCSI device:
>
>   device-tree/pci@3fff5e09000/pci@b,6/scsi@1,1/sd/...

Try it out yourself. Just do

	mount -t driverfs /devices /devices

and then look at the whole glory in some graphical file manager to get a
view of the tree (actually, most file managers are somewhat confused about
the fact that the directory counts don't reflect sub-directories, so you
may have to open the subdirectories by hand, whatever. That's a bug.
Should be fixed. I'm cc'ing Pat)

> Why not use the structure of, and a subset of the capabilities of, an
> OF device-tree for building /devices?  It's a little more verbose, but
> it's a standard and it fits the current problem pretty well.

Because an OF devices tree has nothing to do with Linux?

Open Firmware is dead, dead, dead. It's not sleeping. It's an ex-standard.
Intel and the PC market never bought into it, so it doesn't exist.

End result: Linux has a notion of a "struct device", and it's an internal
kernel representation of the whole bus structure as far as Linux can tell.
It's then exported as a filesystem, but that's not the important part: the
device tree is valid (and important) even when it's not exported to user
space, simply because things like power-management events etc have to
honor the tree and traverse it in the right order.

If you like OF, you can actually use OF to _populate_ the Linux device
tree. The people who like ACPI (yet, they exist) do that with ACPI. The
Linux device tree is _completely_ agnostic, and absolutely does _not_ want
to know or depend on firmware issues, since firmware is not portable.

(Right now ACPI does this, so all the strange ACPI nodes will show up in
/devices/root/ACPI if you have ACPI enabled).

Right now you cannot do a lot with it, but it does already give you a
global view of the system - at least for those buses that use "struct
device", namely USB and PCI.

It should be possible to export _any_ bus using this. Most definitely
including SCSI.

		Linus

