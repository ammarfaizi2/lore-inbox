Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUAHCOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbUAHCOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:14:07 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:45328 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263435AbUAHCOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:14:03 -0500
Date: Thu, 8 Jan 2004 03:13:57 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040108031357.A1396@pclin040.win.tue.nl>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>; from torvalds@osdl.org on Wed, Jan 07, 2004 at 10:38:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 10:38:31AM -0800, Linus Torvalds wrote:

> > Doesn't the kernel always create the main block device for this device?
> > If so, udev will catch that.
> 
> But udev should probably also create all the sub-nodes if it doesn't 
> already.
> 
> And it really has to create _all_ of them, exactly because there's no way
> to know ahead-of-time which of them will be available.
> 
> Then, user space can just access "/dev/sda1" or whatever, and the act of 
> accessing it will force the re-scan.

1. That is a bad idea.
2. There is no problem.

Ad 1)

- All, how many is that? 16? 64? more?
  Today IDE disks have 64 minors.

- I hate to think of the sysfs tree. Today I am unhappy already:
# ls /sys/block
.       nbd102  nbd116  nbd15  nbd29  nbd42  nbd56  nbd7   nbd83  nbd97  ram6
..      nbd103  nbd117  nbd16  nbd3   nbd43  nbd57  nbd70  nbd84  nbd98  ram7
fd0     nbd104  nbd118  nbd17  nbd30  nbd44  nbd58  nbd71  nbd85  nbd99  ram8
hda     nbd105  nbd119  nbd18  nbd31  nbd45  nbd59  nbd72  nbd86  ram0   ram9
hdb     nbd106  nbd12   nbd19  nbd32  nbd46  nbd6   nbd73  nbd87  ram1   sda
hdd     nbd107  nbd120  nbd2   nbd33  nbd47  nbd60  nbd74  nbd88  ram10  sdb
hde     nbd108  nbd121  nbd20  nbd34  nbd48  nbd61  nbd75  nbd89  ram11  sdc
hdf     nbd109  nbd122  nbd21  nbd35  nbd49  nbd62  nbd76  nbd9   ram12  sdd
hdg     nbd11   nbd123  nbd22  nbd36  nbd5   nbd63  nbd77  nbd90  ram13  sde
md0     nbd110  nbd124  nbd23  nbd37  nbd50  nbd64  nbd78  nbd91  ram14  sr0
nbd0    nbd111  nbd125  nbd24  nbd38  nbd51  nbd65  nbd79  nbd92  ram15
nbd1    nbd112  nbd126  nbd25  nbd39  nbd52  nbd66  nbd8   nbd93  ram2
nbd10   nbd113  nbd127  nbd26  nbd4   nbd53  nbd67  nbd80  nbd94  ram3
nbd100  nbd114  nbd13   nbd27  nbd40  nbd54  nbd68  nbd81  nbd95  ram4
nbd101  nbd115  nbd14   nbd28  nbd41  nbd55  nbd69  nbd82  nbd96  ram5

Someone decided to create "all" nbd devices.
If a similar thing is done for all disks then soon this directory will have
more nodes that current /dev.

Ad 2)
On the other hand, there is no need at all for udev or the kernel
to do anything special.
If hotplug and udev do their work, then the node for the whole device
is created.
Now the plan (or at least my plan) has always been to remove all
partition detection from the kernel. It can all be done from user space.
We have had the infrastructure for a long time, and it works.

So, it is trivial to create the utility parsept+mount that takes
a device, reads its partition table, tells the kernel about the
partitions found there, and mounts the desired partition.
It can be a mount option to do a parsept if the device does not
exist yet.

Andries

