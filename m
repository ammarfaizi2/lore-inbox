Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSGQNsG>; Wed, 17 Jul 2002 09:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSGQNsG>; Wed, 17 Jul 2002 09:48:06 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:13505 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314138AbSGQNsF>; Wed, 17 Jul 2002 09:48:05 -0400
Message-Id: <5.1.0.14.2.20020717143540.02021920@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Jul 2002 14:54:05 +0100
To: Joerg Schilling <schilling@fokus.gmd.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: IDE/ATAPI in 2.5
Cc: James.Bottomley@steeleye.com, schilling@fokus.gmd.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <200207171232.g6HCWhbE027917@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:32 17/07/02, Joerg Schilling wrote:
> >Error handling is more than local.  Some errors, you are correct, can 
> only be
> >handled at the SCSI layer.  However, a large class of drivers (Think
> >multi-path or software raid) want the ability to direct how SCSI handles
> >errors themselves.  It is unacceptable to have SCSI all on its own retry a
> >medium error command x times, taking minutes before the upper layers become
> >aware anything went wrong.
>
>It looks like you have the wrong ideas about software raid. If you have
>software raid, you will stack a SW raid driver just on top of the disk 
>drivers
>that handle the access to the real drives. The real drives first do own error
>handling and if they cannot correct errors, the error is handled inside the
>raid layer. As the raid layer itself will at it's top level act as if it 
>was a
>disk driver, there is no relation to the block layer.

Of course it has relation to the block layer! How else are the errors going 
to be passed from the disk drivers to the raid layer and then to the fs? In 
an ideal world, this is what should happen so that the fs can deal with the 
problem, for example on a write, the fs can mark the block as bad in the 
file systems list of bad blocks, and it can change the allocation of the 
block to a different location and write the data again (assuming the lower 
layer cannot handle this, e.g. hardware block remapping at disk level). 
Without a full error passing from the lowest to the highest level this 
cannot be done and this is something that Linux needs IMO.

> >The solution is to have a stacking error handler where the error handler 
> for
> >upper devices would be notified of a problem and asked for direction as 
> soon
> >as it occurs.
>
>See above, this makes no sense.

It makes perfect sense actually. Also, see above.

> >But the new scheme allows that.  The block queues accept translated 
> requests
> >(that's really what sg does).
>
>A SCSI request is _not_ a translated request. It is the real request itself.
>You usually even cannot translate a SCSI request into something else.

That is what you are not understanding. Ideally the block layer will be 
creating the scsi, request not you. And you want to do it the other way 
round. You want to create the SCSI request and pass it to the kernel for 
giving it to the hardware and if the hardware is not SCSI the request will 
need translation. And what other people are trying to tell you is that this 
is too specific for a generic block interface and that Linux wants to have 
a generic block interface that will convert requests into SCSI ones or 
"plug your favourite request type here" requests depending on the attached 
device driver but the interface itself is abstracted above SCSI. Ok?

> >But you're still too SCSI transport specific.  The ongoing goal is to 
> make the
> >physical transport protocol an adjunct to the Linux internal transport (the
> >struct request) so that we can treat all block/character devices on an 
> equal
> >footing.
>
>You seem to forget that all main control is done via SCSI commands.

No it is not at all. SCSI is _one_of_many_ ways to talk to hardware. And as 
many people have reiterated several times SCSI is _not_sufficient_ to talk 
to all hardware. So there is no way in hell SCSI is going to be the generic 
block interface in Linux. We now have the struct request, which is way 
better than a SCSI request and is certainly going to evolve over time to be 
even more powerful than it already is.

Your argument that all other OS use SCSI as the block interface is no 
argument at all. Linux doesn't do what everyone else does. It does the 
technically better thing, which of course can be what other OS do, but in 
this case it is not. In other words, if all people jump off a cliff, are 
you going to follow just because all of the others do it? I certainly 
won't... (-;

Anyway, this thread has been going on for far too long. If you believe so 
strongly that SCSI is generic enough for a block interface then why don't 
you code that, and then submit your code to LKML? I highly suspect you will 
not be able to do something that fulfills all the different device type 
requirements and maintain a clean, efficient layer at the same time. Feel 
free to prove me wrong by showing me the code which does it.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

