Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTEZRel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTEZRel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:34:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7864 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261840AbTEZRei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:34:38 -0400
Message-ID: <3ED2533A.1000602@pobox.com>
Date: Mon, 26 May 2003 13:47:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
References: <Pine.LNX.4.44.0305260947430.11328-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305260947430.11328-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 26 May 2003, Jeff Garzik wrote:
> 
>>>>I think with SATA + drivers/ide, you reach a point of diminishing 
>>>>returns versus amount of time spent on mid-layer coding.
>>>
>>>I think that's a valid approach, and just have a special driver for SATA. 
>>>That's not the part I worry about. 
>>
>>You're still at a point of diminishing returns for a native driver too.
> 
> 
> No, because for a block-queue native driver there would be one huge 
> advantage: making sure the native queueing is brought up to be a fully 
> used interface.
> 
> Originally, native queueing was all there was, and all drivers interfaced 
> directly to it. The IDE and SCSI layers ended up being used largely
> because they allowed drivers to use a global naming scheme, not because 
> they were "better". In fact, in many ways they were a lot worse than the 
> native queues, but then they had some other infrastructure that did help.
> 
> My bet is that most of that infrastructure today is just not worth it.

[...]

> Clue-in-time: if hotplugging doesn't work on a native level, it won't work 
> on a SCSI level either. So that _cannot_ be a real issue.
> 
> Device model stuff and power management all comes from other areas, and 
> have little to do with SCSI.

Correct, but precisely by saying that, you're missing something.

The SCSI midlayer provides infrastructure I need -- which is not 
specific to SCSI at all.

Device registration, host registration, major/minor sub-allocation, 
device model, power management, command queueing features, command 
timeout, error handling thread, userland command submission interface (a 
la taskfile ioctl or SG_IO)...  all these are possible via the generic 
block layer -- but the generic block layer does not directly provide 
these facilities.  Each subsystem (ide, scsi, ...) has to provide bits 
on top of that to make it usable.  Each native block driver must 
re-create these for its own subsystem.

All those "little bits" add up to code I have to write, for a native 
driver, which I don't have to write for SCSI.

IF you are willing to sign off on a generic /dev/disk (bus agnostic), 
then I am interested.  That allows me to code up the above stuff ONCE, 
and not see others do the same work when they write a native blk driver 
(or avoid this work, by using SCSI like I do now).  Otherwise. I'm 
writing all those little bits YET AGAIN, duplicating stuff scsi already 
does.

Taking that to a concrete level, that basically means more helpers at 
the native block level.

Given that I have always agreed a native block driver is the best 
eventual method, what's stopping me?  Time:

If /dev/disk is a non-starter for 2.6, the best route is to take my SCSI 
driver and evolve it over time to be a native block driver.  Not start 
with a native block driver.  That gives us a SATA framework now, and 
SCSI can disappear eventually.
#include <linux_is_usable_not_pie_in_sky_theory.h>


(re-arranged msg a bit)
>> Userland support is nonexistent, and users would have start using yet 
>> another set of tools to deal with their disks, instead of the existing 
>> [scsi] ones.

> That's not true. The command set is already exported, so that even things 
> like packet commands can be sent (that's how you write CD-RW under 2.5.x, 
> and it's the _generic_ layer that does all the command queueing). 
> 
> That, btw, i show you should do the ATA transport thing. Even SCSI devices 
> can get the commands fed that way. It's neither ATA nor SCSI, it's a 
> "packet interface for the generic queue".

I agree the capabilities are there for packet interface, but one still 
has to define the userland interface.  Yes, I know about SG_IO.  It's: 
somewhat SCSI-specific, and sub-optimal.   Think back to December 2001, 
when you described a packet interface using read(2) and write(2). 
Basically SG_IO, but better and without scsi specifics.


> The only remaining piece of the puzzle (from a user land perspective) ends 
> up being the mapping from major/minor -> queue. That used to be a _huge_
> issue, and the main reason you couldn't write a SCSI driver outside the 
> SCSI layer, for example (but look at DAC960 - it decided to do so 
> _anyway_, even if it meant being ostracised and put on a separate major).
> 
> But that should be much less of an issue now, since our queue mapping is a 
> lot more flexible these days.

The mapping part is easy, IMO.  I would just have the "generic 
infrastructure" export chrdrvs for each queue I manage, using the 
interface you described in December 2001.  sysfs can then describe the 
{major+minor | CIDR | whatever}-to-queue mapping.

For example, when /dev/disk device registration occurs at runtime, the 
/dev/disk infrastructure would make a new chrdrv appear.


Anyway, stepping back to the larger issue of "userland tools", I'm not 
just talking about a taskfile I/O interface.  I'm talking about all the 
little distro tools for IDE and SCSI, like /usr/bin/scsi_unique_id or 
/sbin/hdparm.  And the assumptions that distro installers make.

Creating yet another set of these tools and standard practices is just 
not worth it, without bus-agnostic /dev/disk.  Sysadmins are going to be 
annoyed at yet another interface and yet another not-IDE, not-SCSI (and 
thus second-class) block major.

It's not worth it for me, with working code now, and it's not worth for 
the next person who wants to add a bus type to Linux.

Unless I am to be creating infrastructure which non-SATA people can use, 
your suggestion equates to making the SATA driver a second-class 
citizen, with lots of additional coding for little gain, and with lots 
of pain on the distro side that must be repeated again and again for 
each native block driver.

	Jeff



