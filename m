Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSFTS1R>; Thu, 20 Jun 2002 14:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSFTS1Q>; Thu, 20 Jun 2002 14:27:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24336 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315413AbSFTS1O>; Thu, 20 Jun 2002 14:27:14 -0400
Date: Thu, 20 Jun 2002 11:27:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map 
In-Reply-To: <200206201658.g5KGwYL04775@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0206201115460.8225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, James Bottomley wrote:
>
> > And last but not least: I still don't see any kind of abstraction
> > there which would allow to easly enumerate for example all disks in
> > the system.
>
> Doesn't this depend on the semantics provided in the device node (leaf)?  If
> you had a way of identifying disk devices (say from an empty type=disk file)
> then you could do a simple find to list all the disks in the system regardless
> of being SCSI, IDE, SSA etc.

Right now, the _biggest_ problem with driverfs is that it only does the
infrastructure, and precious little of the "real work".

For example, to be useful, every driver that knows about disks should make
sure they show up with some standard name (the old "disk" vs "disc" war
;), exactly so that you _should_ be able to do something like

	find /devices -name disk*

and be able to enumerate every disk in the whole system.

Of course, this is also the kind of meta-information that driverfs can
give "for free", ie since the kernel basically knows it is a disk, the
kernel can also directly expose the relationship of "these are all the
disks I know about". Ie again

	"kernel device relationship" == "driverfs"

which means that it should be fairly trivial to just do

	/devices/disks/disk0 -> ../../pci0/00:02.0/02:1f.0/03:07.0/disk0
	               disk1 -> ../../pci0/00:02.3/usb_bus/001000/dev1

the same way that Pat already planned to do the mappings for network
devices in /devices/network/eth*.

Is this done? No. But is it fundamentally hard? Nope. Useful? You be the
judge.  Imagine yourself as a installer searching for disks. Or imagine
yourself as a initrd program that runs at boot, setting up irq routings
etc before the "real boot".

			Linus

