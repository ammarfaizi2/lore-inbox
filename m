Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUC1AHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUC1AH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:07:26 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:6023 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261979AbUC1AGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:06:54 -0500
X-BrightmailFiltered: true
Message-Id: <5.1.0.14.2.20040328094233.0546fec8@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 28 Mar 2004 10:06:42 +1000
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: "Enhanced" MD code avaible for review
Cc: Jeff Garzik <jgarzik@pobox.com>, Kevin Corry <kevcorry@us.ibm.com>,
       linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-raid@vger.kernel.org
In-Reply-To: <1564440000.1080322989@aslan.btc.adaptec.com>
References: <406375B0.5040406@pobox.com>
 <760890000.1079727553@aslan.btc.adaptec.com>
 <16480.61927.863086.637055@notabene.cse.unsw.edu.au>
 <40624235.30108@pobox.com>
 <200403251200.35199.kevcorry@us.ibm.com>
 <40632804.1020101@pobox.com>
 <1030470000.1080257746@aslan.btc.adaptec.com>
 <406375B0.5040406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:43 AM 27/03/2004, Justin T. Gibbs wrote:
>I posted a rather detailed, technical, analysis of what I believe would
>be required to make this work correctly using a userland approach.  The
>only response I've received is from Neil Brown.  Please, point out, in
>a technical fashion, how you would address the feature set being proposed:

i'll have a go.

your position is one of "put it all in the kernel".
Jeff, Neil, Kevin et al is one of "it can live in userspace".

to that end, i agree with the userspace approach.
the way i personally believe that it SHOULD happen is that you tie your 
metadata format (and RAID format, if its different to others) into DM.

you boot up using an initrd where you can start some form of userspace 
management daemon from initrd.
you can have your binary (userspace) tools started from initrd which can 
populate the tables for all disks/filesystems, including pivoting to a new 
root filesystem if need-be.

the only thing your BIOS/int13h redirection needs to do is be able to 
provide sufficient information to be capable of loading the kernel and the 
initial ramdisk.
perhaps that means that you guys could provide enhancements to grub/lilo if 
they are insufficient for things like finding a secondary copy of 
initrd/vmlinuz. (if such issues exist, wouldn't it be better to do things 
the "open source way" and help improve the overall tools, if the end goal 
ends up being the same: enabling YOUR system to work better?)

moving forward, perhaps initrd will be deprecated in favour of initramfs - 
but until then, there isn't any downside to this approach that i can see.

with all this in mind, and the basic premise being that as a minimum, the 
kernel has booted, and initrd is working
then answering your other points:

>  o Rebuilds

userspace is running.
rebuilds are simply a process of your userspace tools recognising that 
there are disk groups in a inconsistent state, and don't bring them online, 
but rather, do whatever is necessary to rebuild them.
nothing says that you cannot have a KERNEL-space 'helper' to help do the 
rebuild..

>  o Auto-array enumeration

your userspace tool can receive notification (via udev/hotplug) when new 
disks/devices appear.  from there, your userspace tool can read whatever 
metadata exists on the disk, and use that to enumerate whatever block 
devices exist.

perhaps DM needs some hooks to be able to do this - but i believe that the 
DM v4 ioctls cover this already.

>  o Meta-data updates for topology changes (failed members, spare activation)

a failed member may be as a result of a disk being pulled out.  for such an 
event, udev/hotplug should tell your userspace daemon.
a failed member may be as a result of lots of I/O errors.  perhaps there is 
work needed in the linux block layer to indicate some form of hotplug event 
such as 'excessive errors', perhaps its something needed in the DM 
layer.  in either case, it isn't out of the question that userspace can be 
notified.

for a "spare activation", once again, that can be done entirely from userspace.

>  o Meta-data updates for "safe mode"

seems implementation specific to me.

>  o Array creation/deletion

the short answer here is "how does one create or remove DM/LVM/MD 
partitions today?"
it certainly isn't in the kernel ...

>  o "Hot member addition"

this should also be possible today.
i haven't looked too closely at whether there are sufficient interfaces for 
quiescence of I/O or not - but once again, if not, why not implement 
something that can be used for all?

>Only then can a true comparative analysis of which solution is "less
>complex", "more maintainable", and "smaller" be performed.

there may be less lines of code involved in "entirely in kernel" for YOUR 
hardware --
but what about when 4 other storage vendors come out with such a card?
what if someone wants to use your card in conjunction with the storage 
being multipathed or replicated automatically?
what about when someone wants to create snapshots for backups?

all that functionality has to then go into your EMD driver.

Adaptec may decide all that is too hard -- at which point, your product may 
become obsolete as the storage paradigms have moved beyond what your EMD 
driver is capable of.
if you could tie it into DM -- which i believe to be the defacto path 
forward for lots of this cool functionality -- you gain this kind of 
functionality gratis -- or at least with minimal effort to integrate.

better yet, Linux as a whole benefits from your involvement -- your 
time/effort isn't put into something specific to your hardware -- but 
rather your time/effort is put into something that can be used by all.

this conversation really sounds like the same one you had with James about 
the SCSI Mid layer and why you just have to bypass items there and do your 
own proprietary things.  in summary, i don't believe you should be 
focussing on a short-term viiew of "but its more lines of code", but rather 
a more big-picture view of "overall, there will be LESS lines of code" and 
"it will fit better into the overall device-mapper/block-remapper 
functionality" within the kernel.


cheers,

lincoln.

