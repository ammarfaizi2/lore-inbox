Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTDIQag (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTDIQag (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:30:36 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:11531 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S263432AbTDIQae (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 12:30:34 -0400
Date: Wed, 9 Apr 2003 18:42:10 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andries.Brouwer@cwi.nl, <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <b6vnig$q86$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304091415460.12110-100000@serv>
References: <20030408195305.F19288@almesberger.net>
 <Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com>
 <b6vnig$q86$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8 Apr 2003, H. Peter Anvin wrote:

> So far, *none* of the schemes used for dynamics have gotten it right.
> They just ignore a fair number of the problems.  People keep focusing
> on disks, and they are nearly uniformly the almost-trivial case in
> comparison with especially character devices, where you don't have the
> layer of indirection called /etc/fstab, persistent labels, etc.
> 
> [...]
> 
> Given that it has taken, literally, 8 years to get to this point, and
> based on collective global experience with numberspaces, I'm arguing
> for enlarging it far more than anyone can currently imagine being
> necessary.

Let's try it with a real example:
I have two onboard SCSI channels, the first one is for external devices 
and the second for internal devices. This means the internal drives are 
renumbered depending on whether I have my MO-drive turned on or off. Now I 
also want to access the MO-drive as normal user, but the device name 
can be /dev/sda or /dev/sdd.
So what options do I have here?
1. devfs: it would work in this situation, but it doesn't offer really 
stable device names.
2. scsidev: it's more flexible, but it is limited to scsi devices.

Another example:
Let's take a legacy free pc, where a serial port is only available via a 
usb port replicator. Is there really a good reason, why that port isn't 
available via /dev/ttyS0? Why has the user to find out, how that thing is 
called? Or why should a terminal program maintain a growing list of 
possible serial device names?

The information exported via sysfs offers now for the first time a more 
general mechanism to manage these problems. I'm trying very hard here to 
get an answer to the question "How are we going to manage a lot of 
devices?", instead I only get answers to the question "How do we get a lot 
of devices?". If we concentrate only on the latter, we neglect a major 
part of the problem.

I have to come back to the two questions I already asked earlier:
1. How do we want to manage devices in the future?
2. What compromises can we make for 2.6?

The first question requires a look at how we want to register devices, how 
is device information exported to the user and how the user can access the 
devices.
The second question requires a look at what we already have and what is 
still missing.

I think there is a general agreement that we need to manage more 
dynamically, so what do have already? Block devices are already the 
furthest and also need a larger dev_t the most. A lot of drivers which 
only use add_disk/register_blkdev (but not blk_register_region) care about 
the device number only during registration and don't need it otherwise. 
scsi already exports a lot of information via sysfs.
So if we just look at scsi we already have everything to manage devices 
more dynamically, userspace only has to make use of that information now. 
To manage now a lot of scsi devices, we only have to generate new device 
numbers for them, preferably in a way that a) other drivers can benefit 
from it and b) it doesn't break existing setups. The required kernel 
changes are minimal and certainly no reason to hold up any kernel release, 
but simply changing the kernel major/minor split breaks compatibility and 
should be avoided.

Character devices still need more work and that is mostly 2.7 material, 
but basically it's possible to give more control to user space similiar to 
block devices.

The only questions I still can't answer myself are:
1. What exactly do we need a 64bit dev_t for and what has "collective 
global experience with numberspaces" to do with the local device 
numberspace?
2. What advantage does a more static scheme have and what are the problems 
ignored by the dynamic schemes?
Above examples should help to demonstrate how to deal with the various 
problems.

Peter and Andries, I would really appreciate it, if you would stop 
ignoring me and start answering my questions or explain what is wrong in 
above explanation.
If anyone else can answer these question, you are of course welcome to do 
so, otherwise I hope you have more luck than me to get some answers here.

bye, Roman

