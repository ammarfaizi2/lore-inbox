Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbREOWpI>; Tue, 15 May 2001 18:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbREOWo6>; Tue, 15 May 2001 18:44:58 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:7933 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261680AbREOWop>; Tue, 15 May 2001 18:44:45 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105152242.f4FMgCqp021866@webber.adilger.int>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <344250272.989965778@[169.254.198.40]> "from Alex Bligh - linux-kernel
 at May 15, 2001 10:29:38 pm"
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Date: Tue, 15 May 2001 16:42:12 -0600 (MDT)
CC: Linus Torvalds <torvalds@transmeta.com>,
        Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh writes:
> Q: Let us assume you have dynamic numbering disk0..N as you suggest,
>    and you have some s/w RAID of SCSI disks. A disk fails, and is (hot)
>    removed. Life continues. You reboot the machine. Disks are now numbered
>    disk0..(N-1). If the RAID config specifies using disk0..N thusly, it
>    is going to be very confused, as stripes will appear in the wrong place.

But this already happens with the SCSI device numbering, so no big change.
It would also happen if you have multi-path access to the RAID box (i.e.
two SCSI controllers), or with FC where there IS no "physical address",
or move the disks to a different type of SCSI controller (with a different
detection order than other controllers in the system), etc.

>    Doesn't that mean the file specifying the RAID config is going to have
>    to enumerate SCSI IDs (or something configuration invariant) as
>    opposed to use the disk0..N numbering anyway?

No such thing as configuration invariant in some cases.

>    Sure it can interrogate each disk0..N to see which has the ID that
>    it actually wanted, but doesn't this rather subvert the purpose?

Not at all.  To be robust, the (software) RAID system should ONLY access
disks that it knows belong to a given RAID set.  To do otherwise is
useless.  This is what LVM does, and it surprises me if MD RAID does
anything else (never really looked into it...).

In any case, a sane system would likely not expose all of the underlying
disks that make up a RAID set as a "disk", after that RAID set was built.
At configuration time, any /dev/disk{A,B,C} that went into the RAID
set would be removed, and the resulting RAID volume would become a new
/dev/diskX, just like any other disk in the system.  If you really needed
more information about the RAID configuration, use the RAID tools to
query the attributes of /dev/diskX.  That would solve a _lot_ of problems
with disks that make up meta-volumes being accessed via /dev/hdX instead
of /dev/mdY.

> IE, given one could create /dev/disk/?.+, isn't the important
> argument that they share common major device numbers etc., not whether
> they linearly reorder precisely to 0..N as opposed to have some form
> of identifier guaranteed to be static across reboot & config change.

I don't think the objective is necessarily to have a _packed_ device
numbering, nor one that changes randomly after each reboot, but just a
generic device naming independent of physical location, access method, etc.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
