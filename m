Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRCNVJ6>; Wed, 14 Mar 2001 16:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131567AbRCNVJj>; Wed, 14 Mar 2001 16:09:39 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:50685 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131563AbRCNVJb>; Wed, 14 Mar 2001 16:09:31 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103142107.f2EL7ba10641@webber.adilger.int>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <3AAFCD2E.59A3A809@austin.ibm.com> from Dave Kleikamp at "Mar 14,
 2001 01:57:34 pm"
To: Dave Kleikamp <shaggy@austin.ibm.com>
Date: Wed, 14 Mar 2001 14:07:37 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Kleikamp writes:
> Let me start  with a disclaimer stating that it's been a few years since
> I've worked with AIX, but this is what I believe happens.
> 
> mount itself doesn't do anything except read /etc/filesytems (AIX's
> version of /etc/fstab).  LVM maintains the information primarily in the
> ODM (yuck).  The utilities such as mkfs, mklv, chfs, etc. modify this
> information in the ODM.  The exportvg command extracts the information
> from the ODM (and /etc/filesystems?) and stores it somewhere in the
> volume group.  Only then can the volume group be imported by another
> system with the importvg command, which then populates the ODM and
> /etc/filesystems.

Actually, I'm pretty sure you _never_ need to exportvg in order to have
it work on another system.  That's one of the great things about AIX LVM,
because it means you can move a VG to another system after a hardware
problem, and not have any problems importing it (journaled fs also helps).
AFAIK, the only think exportvg does is remove VG information from the
ODM and /etc/filesystems.

I suppose it is possible that because AIX is so tied into the ODM and
SMIT, that it updates the VGDA mountpoint info whenever a filesystem
mountpoint is changed, but this will _never_ work on Linux because of
different tools versions, distributions, etc.  Also, it would mean on
AIX that anyone editing /etc/filesystems might have a broken system at
vgimport time (wouldn't be the first time that not using ODM/SMIT caused
such a problem).

> ... I do think that the LVM is a reasonable place to store this kind of
> information.

Yes, even though it would tie the user into using a specific version of
mount(), I suppose it is a better solution than storing it inside the
filesystem.  It will work with non-ext2 filesystems, and it also allows
you to store more information than simply the mountpoint (e.g. mount
options, dump + fsck info, etc).  In the end, I will probably just
save the whole /etc/fstab line into the LV header somewhere, and extract
it at importvg time (possibly with modifications for vgname and mountpoint).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
