Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277298AbRJLKMn>; Fri, 12 Oct 2001 06:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277324AbRJLKMe>; Fri, 12 Oct 2001 06:12:34 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:37778 "EHLO nixpbe.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S277298AbRJLKM0>;
	Fri, 12 Oct 2001 06:12:26 -0400
Date: Fri, 12 Oct 2001 12:12:49 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: <Matt_Domsch@Dell.com>, <rgooch@ras.ucalgary.ca>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EFI GUID Partition Tables
In-Reply-To: <20011009222359.M6348@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0110121035030.9327-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Andreas Dilger wrote:

> > Yes, UUIDs and GUIDs are the same thing, fortunately.
> > I'll have to defer this to the author of this piece of code.  Martin, any
> > reason why it shouldn't be renamed?  Richard, any preferred name?
>
> Well, the "common" usage is in /etc/fstab, where we allow "UUID=" and
> "LABEL=", so it would be nice to stick with "uuid" or "UUID".
>

uuid is fine, I have no objections.
/dev/disks/uuid or /dev/volumes/uuid is also ok. I can see other potential
applications of UUIDs apart from disks and partitions, but not in the
short term. Windows doesn't seem to use them for other things, either.

> > > On a side note, I have a user-space library which locates/identifies
> > > devices by UUID/LABELs as well.  It is likely to become part
> > > of e2fsprogs
> > > and mount as a way to consolidate all of the fs identification code,
> > > but it could easily to partition identification also (hasn't
> > > been possible until now).

My thinking was that devfs was an obvious facility to use for this
information. Of course having the functionality in user space would be
cleaner, but I thought it was most effective to hook into
grok_partitions(), because the kernel is reading the complete partition
information there anyway, later discarding most of it. Thus basically
all I did was take care that the UUID information was not discarded at
that point.

In any case, we should try determine where this functionality actually
belongs, and not duplicate it in kernel and user space.

> 1) Currently libblkid is only doing identification of "content" (e.g.
>    filesystems, RAID, swap, LVM, etc) and not actual "partition tables".
>    Is it possible to get the GPT data when reading the actual partitioned
>    device (e.g. /dev/hda1) or do you need to read the whole-disk device
>    (e.g. /dev/hda)?

AFAIK you need to read the partition table, i.e. /dev/hda.

> 2) What to do with multiple identifiers for a single partition?  Current
>    partitioning schemes don't have any identifiers, so I've assumed that
>    there will only be one "correct" identifier for each block device.
>    With GPT, you could have a GPT GUID+LABEL and a filesystem UUID+LABEL.
>    It would be nice NOT to introduce new "types" for each possible ID
>    (i.e. I have been calling all "serial number" type things "UUID" and
>    all "name" type things "LABEL" to match current usage).

I see a dilemma here: the partition and the file system residing on it are
not "the same entity", therefore they should in principle have different
unique IDs.
On the other hand, in practice both can equally well be used to identify
a file system on a partition, so it would be less confusing to assign an
identical UUID to them. I think with parted it would be possible to
synchronize partition UUID/label and file system UUID/label automatically.
e2fstools should check if they are working on a GPT disk, and if yes,
use the UUID/label in the partition table (or not??).

> I was actually in the process of
> adding LABEL support to swap and reiserfs, because we will still be stuck
> with DOS partitions a long time.

 - partition labels/UUIDs will work bo matter what file system is on the
   partition, but only if GPT is used,

 - file system labels/UUIDs will work no matter what partition table is
   used, but only if the file system supports it.

It seems that in the short term file system labels are the more powerful
solution. Keeping the UUIDs in sync will be useful, though, if GPT
partition tables eventually get wide spread use.

The question is if we need to have /dev/[whatever]/uuid, after all.
After reading this thread I am more and more convinced we don't really need it.
What is needed is mounting and fscking by UUID (also for the root file
system). If this can be done in user space, fine for me if the
UUID part of the patch is left out (it seems to be the most controversial
part of the patch anyway).

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy






