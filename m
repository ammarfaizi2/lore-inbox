Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291082AbSBSKdO>; Tue, 19 Feb 2002 05:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291091AbSBSKdF>; Tue, 19 Feb 2002 05:33:05 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:17682 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S291082AbSBSKc6>; Tue, 19 Feb 2002 05:32:58 -0500
Message-Id: <200202191025.g1JAPMm11153@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jos Hulzink <josh@stack.nl>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: VFS issues (was: Re: 2.5.5-pre1: mounting NTFS partitions -t VFAT)
Date: Tue, 19 Feb 2002 12:25:24 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20020219102539.J93925-100000@snail.stack.nl>
In-Reply-To: <20020219102539.J93925-100000@snail.stack.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > What lacks is a fingerprint detector, and iirc -long time ago- FAT has
> > > a very easy to detect fingerprint.
> > >
> > > I'll dig into FAT documentation tonight.
> >
> > I read the document repeatedly and did much tests. If you read the
> > document, you may use BS_OEMName or BS_FilSysType, however, these
> > don't have a meaning.
>
> Hmmm. You seem to be right there. In my OS (IBM PC only) I checked the
> partition table (see below).
>
> The first question I want answered: Should I just call myself stupid for
> trying to mount NTFS as VFAT, or should we consider this a real issue that
> needs fixing ? (I see the problem as a generic problem. There must be
> other combinations of filesystems and partition types that pass the
> test, but are wrong). IMHO the latter, for every lost partition makes an
> angry linux user.
>
> Anyway. I have already been thinking further. Maybe I'm talking nonsense,
> but I'll give it a try.
>
> The type of a partition is written in the partition table, or something
> similar. Maybe we should check that ?

Partition type isn't available to fs driver. Think about mounting 
floppy/loopback/etc.

Seems you guys are discussing non-problem here. What really needs to be done 
is to add more sanity checks to FAT superblock detection/validation code:
* signatures like 55AA at end of 1st sector
* sane values for various superblock data (if you see "FAT copies: 146"
  it is more than enough to tell it's not a FAT, right?)

If anyone feels so inclined, please go to fs/fat/inode.c:fat_read_super()
and hack on it. Send your patches to Alexander Viro <viro@math.psu.edu>
and tighten your seatbelt ;-)

> While mounting a partition, the vfs layer tries to determine the partition
> type, and passes that info to the filesystem driver, which checks whether
> that partition type can be mounted by the driver. If no partition type is
> provided by the vfs layer (for the partition type is not available in the
> used partition table, or whatever), the fs driver must try to find out
> itself.
--
vda
