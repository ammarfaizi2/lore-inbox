Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317802AbSGZQJK>; Fri, 26 Jul 2002 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317804AbSGZQJK>; Fri, 26 Jul 2002 12:09:10 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:63999 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317802AbSGZQJJ>;
	Fri, 26 Jul 2002 12:09:09 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF6180310A.A3D14E1B-ON85256C02.004FB178@pok.ibm.com>
From: "Ben Rafanello" <benr@us.ibm.com>
Date: Fri, 26 Jul 2002 11:12:15 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 07/26/2002 12:12:16 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jul 26, 2002 at 3:16AM Joe Thornber wrote:
>On Thu, Jul 25, 2002 at 12:36:45PM -0500, Ben Rafanello wrote:
>> This will work well for
>> cases where the metadata for the volume/volume group does not have to be
>> updated at runtime.  However, it appears that device mapper needs a
>> kernel module to handle those cases where the volume metadata must
>> be updated during runtime (cases such as RAID 5, Mirroring -
>> particularly the fancier forms with features like smart resync
>> and hot spot mirroring, bad block relocation, etc.).
>
>If you need to change the mapping all you have to do is suspend the
>device, load a new map, and then unsuspend the device.  This can be
>done from within the kernel, or from userland via the ioctl interface.
>
>There is a facility enabling targets to notify userland processes of
>events.  eg, a mirror has completed its initial sync, a bad block has
>occured, etc.
>

For cases where the metadata does not have to be changed frequently,
this may be acceptable.  Bad block relocation is not performance
critical - it is (hopefully) a rare event.  So having the BBR
metadata updated from userspace is probably acceptable.  However,
lets look at mirroring.  In particular, mirroring with smart
resync.  What is happening here is that a mirror is removed from
a mirror set with the expressed (or implied) intention to return
it to the mirror set at some point in the future.  This is typically
done to use the removed mirror as a source for a backup while the
rest of the mirror set continues to accept updates.  While the
removed mirror is out of the mirror set, the volume manager
tracks which blocks have changed in the mirror set so that when the
removed mirror is returned to the mirror set, only the blocks that
have changed need to be sync'ed.  This is typically done using a
bitmap in the metadata with one bit per block in the mirror.  Much
like snapshots and their cow tables, the changed blocks bitmap must
be updated and written to disk before a block is modified.  This
can't be done from userspace for many of the same reasons that
snapshot metadata updates are not done from userspace.  In general,
when you have metadata that must be updated frequently, or when
I/O to a device must be suspended until a metadata update is completed,
having the metadata updated from userspace is .... troublesome at best.
Of course, I haven't gone into the striping with parity case yet
either, which would be another example of the metadata update
problem just discussed.

On the facility used to notify userland processes of events, how
are the userland programs notified?  Does bad block relocation
have to have a daemon associated with it so that it can receive
notification of bbr events, or does the notification facility
launch a bbr provided program to handle this?  Or does the
notification facility accept plug-in modules to handle events?
Or is some other mechanism used (I haven't thought to much about
this yet so what follows are just some random ideas that popped
into my head).  If every volume management function needs its
own daemon to handle these notifications, that could get messy.
If the handler launches a program, then you have obvious performance
implications as well as deadlock issues (I/O is suspended pending a
metadata update, but the program to do the update in userspace must
be loaded from the volume where I/O is suspended ... ).  If the
notification facility accepts plug-in modules, are the plug-in
modules always loaded or are they only loaded when needed?  If
part of the notification facility is swapped out and is needed, you
could again have the deadlock issue.  Of course, most of these
issues go away or are more easily solved if they are dealt with in
the kernel, which is probably why you implemented your snapshot
support in the kernel. Hmmm ... I'll have to think about this
some more when I get the time.

>> Thus, to
>> support AIX (or any other enterprise level volume manager since
>> they all tend to have similar features) would require more than
>> "just a little bit of userland code", it would require a significant
>> amount of kernel code as well.
>
>No this can all be done from userland.

I think you are mistaken here.  I don't think it can be done completely
from userland for reasons just discussed.

>
>
>- Joe

Ben Rafanello
EVMS Team Lead
IBM Linux Technology Center
(512) 838-4762
benr@us.ibm.com




