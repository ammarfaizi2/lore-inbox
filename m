Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVADXGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVADXGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVADXGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:06:42 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:56720 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262399AbVADXEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:04:46 -0500
Date: Tue, 4 Jan 2005 23:04:23 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Nicholas Miell <nmiell@comcast.net>
cc: "H. Peter Anvin" <hpa@zytor.com>, sfrench@samba.org,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       samba-technical@lists.samba.org, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <1104877121.3815.36.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0501042251420.15144@hermes-1.csi.cam.ac.uk>
References: <41D9C635.1090703@zytor.com>  <1104834865.26349.32.camel@imp.csi.cam.ac.uk>
 <1104877121.3815.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Nicholas Miell wrote:
> On Tue, 2005-01-04 at 10:34 +0000, Anton Altaparmakov wrote:
> > On Mon, 2005-01-03 at 14:24 -0800, H. Peter Anvin wrote:
> > > I recently posted to LKML a patch to get or set DOS attribute flags for 
> > > fatfs.  That patch used ioctl().  It was suggested that a better way 
> > > would be using xattrs, although the xattr mechanism seems clumsy to me, 
> > > and has namespace issues.
> > > 
> > > I also think it would be good to have a unified interface for FAT, NTFS 
> > > and CIFS for these attributes.
> > > 
> > > I noticed that CIFS has a placeholder "user.DosAttrib" in cifs/xattr.c, 
> > > although it doesn't seem to be implemented.
> > > 
> > > Questions:
> > > 
> > > a) is xattr the right thing?  It seems to be a fairly complex and 
> > > ill-thought-out mechanism all along, especially the whole namespace 
> > > business (what is a system attribute to one filesystem is a user 
> > > attribute to another, for example.)
> > > 
> > > b) if xattr is the right thing, shouldn't this be in the system 
> > > namespace rather than the user namespace?
> > > 
> > > c) What should the representation be?  Binary byte?  String containing a 
> > > subset of "rhsvda67" (barf)?
> > 
> > Definitely not [a string]!
> 
> Why not? It makes special setfatattr and getfatattr (or setntfsattr and
> getnetfsattr) tools completely unnecessary. All you need is setfattr and
> getfattr, which already exist.

For one because seeing things like "rhsvda67" makes me want to throw up.  
(-;  Also strings are no use for internationalisation.  Binary is much 
shorter and already well defined.  If you want text, just have a library 
or even do it in the application.  The lib or app can decode the binary to 
text and output it in any language it desires and in any shape it desires.  
Also, binary bit testing is a hell of a lot faster than strncmp() on each 
and every string...

> > In NTFS, the "dos attribute flags" are part of the system information
> > attribute which is an entity in its own right, totally separate from
> > extended attributes (and named streams for that matter).  So if I were
> > to be thinking in an NTFS-only world I would be inclined to use an
> > ioctl() to access/modify them (i.e. not b either).  So if you implement
> > an ioctl() for vfat I will probably be able to provide the same in NTFS
> > with almost zero effort (we already have the code to read and write the
> > attribute flags in the kernel ntfs driver, we just do not provide an
> > interface for it).
> 
> An ioctl would be wrong. Remember, the point of this exercise is to
> expose these attributes in such a way that tools don't have to have any
> special knowledge to correctly preserve them.

Certainly not for me.  I don't care about backup programs.  We have 
ntfsclone for that.  You can never use xattrs to do full backups of ntfs 
anyway so no point in trying.  How do you deal with compression or 
encryption for example?  Do you just allow everyone to read the crypto 
keys so they can back them up?  What about ACLs?  And quotas?  And reparse 
points (sym links and mount points and more complex stuff like DFS/HFS).  
The only way you can really backup ntfs IMO is using ntfsclone or if the 
ntfs driver and/or libntfs were to provide it, the MS BackupAPI or 
something equivalent.  Perhaps the "Linux Backup API"?  That could be 
defined and then exported by the VFS with appropriate hooks for each fs 
that does the nitty gritty work.  (-;

> If I want to be able to copy files from one NTFS volume to another
> (preserving all their NTFS attributes), I don't want to have to teach cp
> to run a Linux-specific and NTFS-specific ioctl on each file on the
> source and destination for it to work, it should be able to see the
> xattrs and just do the right thing.
> 
> The fact that the NTFS "dos attribute flags" are seperate from real
> extended attributes isn't a problem, either. Real extended attributes
> can be exported in the user namespace, just like ext2/3 does. (Or are
> the real extended attributes something other than inert blobs of data --
> does Windows care about their contents at all, or does it just store
> them for users who do?)

I do not believe windows cares about the EAs at all.

> > But please note that it would be best if you could use 32-bits for the
> > flags.  At the very least 16-bits though as on NTFS there are currently
> > in use 16-bits in the standard information but the field is u32 sized on
> > disk (little endian) and two of the higher bits are in use in the file
> > name attribute as well and I would not be surprised if more bits get
> > used in future NTFS releases.  Tridge already gave you a list of all the
> > Samba dos attributes so here is the full list for NTFS (note they are
> > 100% compatible to the Samba ones and also note in NTFS we always keep
> > the flags in little endian and just define all the constants to be
> > little endian as well - makes life much easier):
> 
> Using anything other than 8-bits to represent the FAT attributes would
> be wrong, too. It's better to separate the xattr holding NTFS DOS
> attributes (what genius at Microsoft named this...) from the xattr
> holding FAT attributes so that, again, cp can do the right thing without
> any special knowledge about filesystems.
> 
> If the attributes aren't separated into different xattrs, what would
> happen when I copy files from an NTFS volume to a VFAT volume?

Simply loose the bits that cannot be preserved.  It makes no sense to try 
to preserve them on VFAT as they have no meaning there.  It is just 
pointless.

> cp will attempt to copy xattrs containing NTFS-specific bits that VFAT
> can't store, now what? VFAT could either silently discard the bits that
> it doesn't support, or it could fail the entire operation. Either way,
> it has to do the wrong thing.

So according to your arguments all FS now need to support NTFS based 
compression and encryption as well then?  So no information gets lots when 
copying from one to the other?  Unlikely...  Far more likely is that you 
just loose this information and you copy the file uncompressed / 
unencrypted.  You then also want to loose the compressed/encrypted bits on 
the file attributes anyway as the file is no longer compressed/encrypted.  
That would certainly be the element of least surprise.  You simply loose 
unsupported bits since you also loose all the features that go with their 
meaning.  Makes perfect sense to me anyway.  YMMV  (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
