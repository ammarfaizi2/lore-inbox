Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWC0RPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWC0RPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWC0RPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:15:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50103 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750746AbWC0RPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:15:46 -0500
Date: Mon, 27 Mar 2006 09:15:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Douglas Gilbert <dougg@torque.net>
cc: Bodo Eggert <7eggert@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
In-Reply-To: <4427FEC9.4010803@torque.net>
Message-ID: <Pine.LNX.4.64.0603270854570.15714@g5.osdl.org>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
 <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org> <4427FEC9.4010803@torque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Mar 2006, Douglas Gilbert wrote:
>
> There are two things that really count:
>   1) the identifier (preferably a world wide unique name)
>      of the logical unit that is being addressed
>   2) a topological description of how that logical unit
>      is connected

And "SCSI ID" doesn't describe either.

> Linux's <hctl> may be a ham fisted way of describing
> a path through a topology, but it easily beats /dev/sdabc
> and /dev/sg4711 .

Sure, you can easily beat it by selecting what you compare it against.

But face it, /dev/sdabc or /dev/sg4711 simply isn't what you should 
compare against. What you should compare against is

	/dev/cdrom
	/sys/bus/ide/devices/0.0/block:hda/dev
	/dev/uuid/3d9e6e8dfaa3d116
	..

and a million OTHER ways to specify which device you're interested in.

The fact is, they can potentially all do the SCSI command set. And a "SCSI 
ID" makes absolutely zero sense for them (those three devices may be the 
same device, they may not be, they might be on another machine, who 
knows..)

> With a device node name like /dev/sdabc, a SCSI INQUIRY or
> an ATA IDENTIFY DEVICE command can be sent to ascertain 1)
> but I am unaware of any command sent to a logical unit that
> will yield 2).

AND NEITHER WILL SCSI_ID. So what the h*ll is your point?

If you want to know how the damn thing is physically connected, you want 
to use a path like

	/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.0/host0/target0:0:0/0:0:0:0/block:sda/dev

Note how, for example, this says 0:0:0:0, which happens to be the 
controller/channel/id/lun information for that "SCSI device". Notice how 
it is all zeroes? It's because that whole concept doesn't make any sense 
for things like USB storage, which has a totally different way to address 
the things.

But that thing really _does_ describe the physical location of that block 
device (actually, that particular file just contains the information about 
what the device node is for the device, but never mind).

And if you want to _use_ the device, you'd probably use a name like 
/dev/disk/by-path/usb-0F406C5032802890:0:0:0 (which is that same device, 
actually), or, more commonly /dev/disk/by-uuid/1468B594FC37ECF8, which 
happens to be the second partition on that physical device and which 
stays the same even when you plug that same disk in with firewire.

(Or, in this case, you migt actually want to use /dev/disk/by-label/rEFIt, 
which is that same partition on that USB device, but in a human-readable 
labeled form).

Again, the "SCSI ID" is a total and utter crock. IT HAS ABSOLUTELY NO 
VALID USE. It does _not_ describe what you claim it describes, and it is 
_not_ in any way superior to all the other ways of getting to that device.

		Linus
