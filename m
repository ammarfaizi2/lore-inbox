Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSFTFGf>; Thu, 20 Jun 2002 01:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318120AbSFTFGe>; Thu, 20 Jun 2002 01:06:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58892 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318118AbSFTFGc>; Thu, 20 Jun 2002 01:06:32 -0400
Date: Wed, 19 Jun 2002 22:03:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <20020620004442.GA19824@gum01m.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.33.0206192149410.2638-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Jun 2002, Kurt Garloff wrote:
> 
> find attached a patch (against 2.5.23-dj2) to the SCSI subsystem which 
> adds a file /proc/scsi/map, which provides a listing of SCSI devices,
> enumerated by the CBTU/HCIL tuple and the high-level devices attached to
> them. 

I really despise this.

Sorry.

Can't you add the SCSI devices to the device tree, and be done with it? 

It's just _wrong_ to have one file with a collection of devices in it, and 
it is _doubly_ wrong when that one file

 - is limited to a (arbitrary) subset of the disks in your system

 - has completely bogus information about "location" that has nothing to 
   do with real life, yet pruports to be an "address" even though it 
   obviously isn't.

> +The format contains a variable number of columns, separated by a TAB '\t'
> +character.
> +
> +1st column: The Controller, Bus, Target, Unit (or call it Host, Channel, ID,
> +            LUN) tuple that identifies a SCSI device. The numbers are all
> +	    in decimal format and separated by commas.

These "addresses" are not addresses at all. They have no bearing on where 
the card is, will change if a host is added, yadda yadda.

All fixed at least to _some_ degree by giving the most complete address we 
can, ie something like

	/devices/root/pci0/00:02.0/02:1f.0/03:07.0

And yes, the above is a _real_ example, that exists today: it's my SCSI 
controller, and it's behind _two_ PCI bridges. 

Is is also "scsi controller 0"? Yes. But that's a meaningless thing, and 
should not matter.

Either you enumerate things without any structure (like the current SCSI
layer does: disk0, disk1, disk2 ...) or you give full their addresses.  
Don't do the half-assed thing.

PLEASE don't add these kinds of SCSI-specific hacks, that are _useless_ to
find other types of disks, and that makes no sense, and will not work for
things like DAC960, for IDE, or for anything else that just ignores the 
SCSI layer (even if it physically uses SCSI disks, like the DAC960 setup).

			Linus

