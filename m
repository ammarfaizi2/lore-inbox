Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSIJPzV>; Tue, 10 Sep 2002 11:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSIJPzU>; Tue, 10 Sep 2002 11:55:20 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:2957 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316544AbSIJPzT>;
	Tue, 10 Sep 2002 11:55:19 -0400
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ? [OFF TOPIC]
To: linux-kernel@vger.kernel.org
Cc: lmb@suse.de, alan@lxorguk.ukuu.org.uk
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFD26579C4.CE195ECA-ON85256C2F.005426A9@pok.ibm.com>
From: "Ben Rafanello" <benr@us.ibm.com>
Date: Tue, 10 Sep 2002 10:59:08 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 09/10/2002 11:59:14 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This post is rather long, so I  apologize for that up front.

On Mon, 2002-09-09 at 12:23, Alan Cox wrote:

>Its nice clean code unlike EVMS, and doesn't duplicate half the
>kernel so its easier to hack on

It seems that nobody understands why EVMS was designed and coded
the way it was, so perhaps this is a good time to explain what
drove us in the direction we went.

EVMS was designed during the 2.3x time frame and was targeted at
the 2.4x series of kernels.  We were given some very interesting
requirements, which included:

      Support the 2.3x/2.4x series of kernels
      Support at least 1024 disks
      Support at least 1024 volumes
      Support at least 32 partitions per disk
      Support bad block relocation (potentially on every disk)
      Support drive linking
      Support existing Linux technologies (LVM1 and MD)
      Support AIX volume management on Linux
      Support OS/2 volume management on Linux
      EVMS must be expandable to support other volume managers
      Integrate all storage management functionality into a
            single, integrated system

Whether or not you agree with these requirements, these were some
of the requirements that were given to the EVMS Team.  We didn't
make them up, we just had to find ways to meet them, if possible.

In order to meet these requirements, particularly the ones
requiring support for MD, LVM1, AIX, and OS/2, we decided upon a
plug-in architecture.  We initially anticipated having at least
10 plug-in modules.  This raised problems in using the block
layer as defined in 2.3/2.4.  If we made each plug-in a device
driver for the block layer, then we would need one major number
per plug-in module, and each plug-in module would be limited in
the number of instances it could create due to the minor number
limitations.  The minor number limitation would violate the
requirement to put BBR on at least 1024 disks (unless we had
more than 1 major number per plug-in).  Furthermore, with 10
plug-ins plus EVMS itself, we did not think that we could get
one major number per plug-in.  Thus, we decided to make plug-in
modules plug into EVMS itself, instead of making each plug-in a
separate driver.  This removed all limits on the number of
plug-in modules we could have, and it removed the limit on how
many instances a plug-in module could have.  Now we only needed
one major number, the major number for EVMS itself.  (Having
only one major number for EVMS would limit the number of volumes
that EVMS could produce, which would violate the requirement for
more than 1024 volumes, but we did not think that we could get
multiple major numbers for EVMS initially.  We had hoped that
EVMS would be accepted and then, perhaps in the future, we
could get additional major numbers for EVMS.)

Next, we needed to meet the 32 partitions per disk
requirement.  While this was not a problem for IDE disks,
it was a significant problem for SCSI disks.  The current
Linux methodology for handling disks limited the number of
partitions that could appear on a disk.  We wanted to remove
that limitation.  By having EVMS handle disk partitioning
itself, and not exposing the partitions it found (thereby
eliminating the need for a minor number for each partition),
we could have as many partitions on a disk as we wanted.
If the user wanted a partition to be a volume, we could
easily do that, at which point the partition would consume
one of the EVMS minor numbers.

A potential side benefit of having the plug-ins plug in to EVMS
directly is that, in volumes where you have multiple layers in
use (such as LVM on top of MD), there may be a performance
benefit.  I say maybe because I have not measured it, so I
can't say for sure.  But, if each plug-in was a separate driver,
the transition from one layer to another in the volume (ex.
going from LVM to MD)would require the overhead of a request
queue, which would be the communication mechanism between layers.
With all of the plug-ins inside of EVMS, the transition from one
layer to another becomes just an indirect function call.  While
this would use more stack space, we calculated that a heavily
layered volume would require about 200 bytes of stack space
on IA32, a value that we felt was acceptable.

Thus, by having plug-in modules plug in to EVMS directly
instead of using the block layer, we eliminated all
limitations on EVMS that would have existed except for the
limitation on the number of volumes that EVMS could produce,
which would require additional major numbers for EVMS
before we could meet the requirement for 1024 volumes.

As for LVM and MD, after examining the LVM code we felt that
the existing LVM code would be more difficult to port to
the EVMS framework than if we wrote the LVM piece from
scratch.  With MD, on the other hand, we felt that we could
successfully port it to the EVMS framework.  Also, it seemed
that MD was held in high regard by the Community, which gave
us confidence in the code and increased our desire to port it
as opposed to rewrite it.  However, we now have two code
bases for MD.  We are currently looking for ways to get back
to only one MD code base.

I hope this clears up some things about the design and
implementation of EVMS.  Since this post is already too
long, I'll talk about Multi-path I/O and EVMS in another
one.

Regards,

Ben Rafanello
EVMS Team Lead
IBM Linux Technology Center
(512) 838-4762
benr@us.ibm.com


