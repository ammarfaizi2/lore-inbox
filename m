Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVADW0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVADW0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVADWYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:24:15 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:64140 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262386AbVADWSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:18:54 -0500
Subject: Re: FAT, NTFS, CIFS and DOS attributes
From: Nicholas Miell <nmiell@comcast.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, sfrench@samba.org,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       samba-technical@lists.samba.org, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1104834865.26349.32.camel@imp.csi.cam.ac.uk>
References: <41D9C635.1090703@zytor.com>
	 <1104834865.26349.32.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 14:18:41 -0800
Message-Id: <1104877121.3815.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 10:34 +0000, Anton Altaparmakov wrote:
> On Mon, 2005-01-03 at 14:24 -0800, H. Peter Anvin wrote:
> > I recently posted to LKML a patch to get or set DOS attribute flags for 
> > fatfs.  That patch used ioctl().  It was suggested that a better way 
> > would be using xattrs, although the xattr mechanism seems clumsy to me, 
> > and has namespace issues.
> > 
> > I also think it would be good to have a unified interface for FAT, NTFS 
> > and CIFS for these attributes.
> > 
> > I noticed that CIFS has a placeholder "user.DosAttrib" in cifs/xattr.c, 
> > although it doesn't seem to be implemented.
> > 
> > Questions:
> > 
> > a) is xattr the right thing?  It seems to be a fairly complex and 
> > ill-thought-out mechanism all along, especially the whole namespace 
> > business (what is a system attribute to one filesystem is a user 
> > attribute to another, for example.)
> > 
> > b) if xattr is the right thing, shouldn't this be in the system 
> > namespace rather than the user namespace?
> > 
> > c) What should the representation be?  Binary byte?  String containing a 
> > subset of "rhsvda67" (barf)?
> 
> Definitely not [a string]!

Why not? It makes special setfatattr and getfatattr (or setntfsattr and
getnetfsattr) tools completely unnecessary. All you need is setfattr and
getfattr, which already exist.

> 
> In NTFS, the "dos attribute flags" are part of the system information
> attribute which is an entity in its own right, totally separate from
> extended attributes (and named streams for that matter).  So if I were
> to be thinking in an NTFS-only world I would be inclined to use an
> ioctl() to access/modify them (i.e. not b either).  So if you implement
> an ioctl() for vfat I will probably be able to provide the same in NTFS
> with almost zero effort (we already have the code to read and write the
> attribute flags in the kernel ntfs driver, we just do not provide an
> interface for it).
> 

An ioctl would be wrong. Remember, the point of this exercise is to
expose these attributes in such a way that tools don't have to have any
special knowledge to correctly preserve them.

If I want to be able to copy files from one NTFS volume to another
(preserving all their NTFS attributes), I don't want to have to teach cp
to run a Linux-specific and NTFS-specific ioctl on each file on the
source and destination for it to work, it should be able to see the
xattrs and just do the right thing.

The fact that the NTFS "dos attribute flags" are seperate from real
extended attributes isn't a problem, either. Real extended attributes
can be exported in the user namespace, just like ext2/3 does. (Or are
the real extended attributes something other than inert blobs of data --
does Windows care about their contents at all, or does it just store
them for users who do?)

> But please note that it would be best if you could use 32-bits for the
> flags.  At the very least 16-bits though as on NTFS there are currently
> in use 16-bits in the standard information but the field is u32 sized on
> disk (little endian) and two of the higher bits are in use in the file
> name attribute as well and I would not be surprised if more bits get
> used in future NTFS releases.  Tridge already gave you a list of all the
> Samba dos attributes so here is the full list for NTFS (note they are
> 100% compatible to the Samba ones and also note in NTFS we always keep
> the flags in little endian and just define all the constants to be
> little endian as well - makes life much easier):
> 

Using anything other than 8-bits to represent the FAT attributes would
be wrong, too. It's better to separate the xattr holding NTFS DOS
attributes (what genius at Microsoft named this...) from the xattr
holding FAT attributes so that, again, cp can do the right thing without
any special knowledge about filesystems.

If the attributes aren't separated into different xattrs, what would
happen when I copy files from an NTFS volume to a VFAT volume?

cp will attempt to copy xattrs containing NTFS-specific bits that VFAT
can't store, now what? VFAT could either silently discard the bits that
it doesn't support, or it could fail the entire operation. Either way,
it has to do the wrong thing.

Now, if the attributes have been seperated into system.fatattrs and
system.ntfsattrs, cp will be able to completely preserve system.fatattrs
with no trouble at all and inform the user that it could not create
system.ntfsattrs (similar to what it does now when it cannot preserve
ownership or permissions when copying from ext3 to VFAT).

>
> Best regards,
> 
>         Anton
-- 
Nicholas Miell <nmiell@comcast.net>

