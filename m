Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVADLJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVADLJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVADLJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:09:14 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:20122 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261154AbVADLIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:08:54 -0500
Subject: Re: FAT, NTFS, CIFS and DOS attributes
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: sfrench@samba.org, ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       samba-technical@lists.samba.org, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1104834865.26349.32.camel@imp.csi.cam.ac.uk>
References: <41D9C635.1090703@zytor.com>
	 <1104834865.26349.32.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Tue, 04 Jan 2005 11:08:31 +0000
Message-Id: <1104836911.26349.49.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
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
> Definitely not c!

I meant definitely not the second suggestion of c (i.e. the string
subset).  That is just horrible...

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

Another reason to want 32-bits is that this could be used to add more
Linux specific bits like "FILE_ATTR_CHAR_DEV" for character device
special files and use the existing "FILE_ATTR_DEVICE" for block devices.
Windows unfortunately does not distinguish between the two in the
flags.  )-:

> /*
>  * File attribute flags (32-bit).
>  */
> enum {
>         /*
>          * The following flags are only present in the
> STANDARD_INFORMATION
>          * attribute (in the field file_attributes).
>          */
>         FILE_ATTR_READONLY              = const_cpu_to_le32(0x00000001),
>         FILE_ATTR_HIDDEN                = const_cpu_to_le32(0x00000002),
>         FILE_ATTR_SYSTEM                = const_cpu_to_le32(0x00000004),
>         /* Old DOS volid. Unused in NT. = const_cpu_to_le32(0x00000008),
> */
>                                                                                 
>         FILE_ATTR_DIRECTORY             = const_cpu_to_le32(0x00000010),
>         /* Note, FILE_ATTR_DIRECTORY is not considered valid in NT.  It
> is
>            reserved for the DOS SUBDIRECTORY flag. */
>         FILE_ATTR_ARCHIVE               = const_cpu_to_le32(0x00000020),
>         FILE_ATTR_DEVICE                = const_cpu_to_le32(0x00000040),
>         FILE_ATTR_NORMAL                = const_cpu_to_le32(0x00000080),
>                                                                                 
>         FILE_ATTR_TEMPORARY             = const_cpu_to_le32(0x00000100),
>         FILE_ATTR_SPARSE_FILE           = const_cpu_to_le32(0x00000200),
>         FILE_ATTR_REPARSE_POINT         = const_cpu_to_le32(0x00000400),
>         FILE_ATTR_COMPRESSED            = const_cpu_to_le32(0x00000800),
>                                                                                 
>         FILE_ATTR_OFFLINE               = const_cpu_to_le32(0x00001000),
>         FILE_ATTR_NOT_CONTENT_INDEXED   = const_cpu_to_le32(0x00002000),
>         FILE_ATTR_ENCRYPTED             = const_cpu_to_le32(0x00004000),
>                                                                                 
>         FILE_ATTR_VALID_FLAGS           = const_cpu_to_le32(0x00007fb7),
>         /* Note, FILE_ATTR_VALID_FLAGS masks out the old DOS VolId and
> the
>            FILE_ATTR_DEVICE and preserves everything else.  This mask is
> used
>            to obtain all flags that are valid for reading. */
>         FILE_ATTR_VALID_SET_FLAGS       = const_cpu_to_le32(0x000031a7),
>         /* Note, FILE_ATTR_VALID_SET_FLAGS masks out the old DOS VolId,
> the
>            F_A_DEVICE, F_A_DIRECTORY, F_A_SPARSE_FILE,
> F_A_REPARSE_POINT,
>            F_A_COMPRESSED, and F_A_ENCRYPTED and preserves the rest.
> This mask
>            is used to to obtain all flags that are valid for setting. */
>                                                                                 
>         /*
>          * The following flags are only present in the FILE_NAME
> attribute (in
>          * the field file_attributes).
>          */
>         FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT   =
> const_cpu_to_le32(0x10000000),        /* Note, this is a copy of the
> corresponding bit from the mft record,
>            telling us whether this is a directory or not, i.e. whether
> it has
>            an index root attribute or not. */
>         FILE_ATTR_DUP_VIEW_INDEX_PRESENT        =
> const_cpu_to_le32(0x20000000),        /* Note, this is a copy of the
> corresponding bit from the mft record,
>            telling us whether this file has a view index present (eg.
> object id
>            index, quota index, one of the security indexes or the
> encrypting
>            file system related indexes). */
> };
>                                                                                 
> typedef le32 FILE_ATTR_FLAGS;

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

