Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVAEAuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVAEAuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVAEAun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 19:50:43 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:24012 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262105AbVAEAsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 19:48:05 -0500
Subject: Re: FAT, NTFS, CIFS and DOS attributes
From: Nicholas Miell <nmiell@comcast.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, sfrench@samba.org,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       samba-technical@lists.samba.org, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0501042251420.15144@hermes-1.csi.cam.ac.uk>
References: <41D9C635.1090703@zytor.com>
	 <1104834865.26349.32.camel@imp.csi.cam.ac.uk>
	 <1104877121.3815.36.camel@localhost.localdomain>
	 <Pine.LNX.4.60.0501042251420.15144@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 16:48:01 -0800
Message-Id: <1104886081.3815.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 23:04 +0000, Anton Altaparmakov wrote:
> On Tue, 4 Jan 2005, Nicholas Miell wrote:
> > On Tue, 2005-01-04 at 10:34 +0000, Anton Altaparmakov wrote:
> > > On Mon, 2005-01-03 at 14:24 -0800, H. Peter Anvin wrote:
> > > > c) What should the representation be?  Binary byte?  String containing a 
> > > > subset of "rhsvda67" (barf)?
> > > 
> > > Definitely not [a string]!
> > 
> > Why not? It makes special setfatattr and getfatattr (or setntfsattr and
> > getntfsattr) tools completely unnecessary. All you need is setfattr and
> > getfattr, which already exist.
> 
> For one because seeing things like "rhsvda67" makes me want to throw up.  
> (-;  Also strings are no use for internationalisation.  Binary is much 
> shorter and already well defined.  If you want text, just have a library 
> or even do it in the application.  The lib or app can decode the binary to 
> text and output it in any language it desires and in any shape it desires.  
> Also, binary bit testing is a hell of a lot faster than strncmp() on each 
> and every string...

Eh. I only suggested stringifying it in the first place to make the "use
text in /proc and /sys for shell scripts!! and people!!" faction happy,
I'm not particularly attached to the idea. (Although, I have become a
bit enamored with how the string representation needs no special tools
to use.)

> 
> > > In NTFS, the "dos attribute flags" are part of the system information
> > > attribute which is an entity in its own right, totally separate from
> > > extended attributes (and named streams for that matter).  So if I were
> > > to be thinking in an NTFS-only world I would be inclined to use an
> > > ioctl() to access/modify them (i.e. not b either).  So if you implement
> > > an ioctl() for vfat I will probably be able to provide the same in NTFS
> > > with almost zero effort (we already have the code to read and write the
> > > attribute flags in the kernel ntfs driver, we just do not provide an
> > > interface for it).
> > 
> > An ioctl would be wrong. Remember, the point of this exercise is to
> > expose these attributes in such a way that tools don't have to have any
> > special knowledge to correctly preserve them.
> 
> Certainly not for me.  I don't care about backup programs.  We have 
> ntfsclone for that.  You can never use xattrs to do full backups of ntfs 
> anyway so no point in trying.  How do you deal with compression or 
> encryption for example?  Do you just allow everyone to read the crypto 
> keys so they can back them up?  What about ACLs?  And quotas?  And reparse 
> points (sym links and mount points and more complex stuff like DFS/HFS).  
> The only way you can really backup ntfs IMO is using ntfsclone or if the 
> ntfs driver and/or libntfs were to provide it, the MS BackupAPI or 
> something equivalent.  Perhaps the "Linux Backup API"?  That could be 
> defined and then exported by the VFS with appropriate hooks for each fs 
> that does the nitty gritty work.  (-;

I'm not talking about backing up NTFS, I'm talking about preserving data
that is trivial to preserve. If it can be done, it should be done.
 
> > The fact that the NTFS "dos attribute flags" are seperate from real
> > extended attributes isn't a problem, either. Real extended attributes
> > can be exported in the user namespace, just like ext2/3 does. (Or are
> > the real extended attributes something other than inert blobs of data --
> > does Windows care about their contents at all, or does it just store
> > them for users who do?)
> 
> I do not believe windows cares about the EAs at all.

That's good, then they can just be exported in the user namespace.

> > Using anything other than 8-bits to represent the FAT attributes would
> > be wrong, too. It's better to separate the xattr holding NTFS DOS
> > attributes (what genius at Microsoft named this...) from the xattr
> > holding FAT attributes so that, again, cp can do the right thing without
> > any special knowledge about filesystems.
> > 
> > If the attributes aren't separated into different xattrs, what would
> > happen when I copy files from an NTFS volume to a VFAT volume?
> 
> Simply loose the bits that cannot be preserved.  It makes no sense to try 
> to preserve them on VFAT as they have no meaning there.  It is just 
> pointless.

Wouldn't you want the user to know that the bits are being thrown away? 
Silently discarding data is bound to piss somebody off.

> > cp will attempt to copy xattrs containing NTFS-specific bits that VFAT
> > can't store, now what? VFAT could either silently discard the bits that
> > it doesn't support, or it could fail the entire operation. Either way,
> > it has to do the wrong thing.
> 
> So according to your arguments all FS now need to support NTFS based 
> compression and encryption as well then?  So no information gets lots when 
> copying from one to the other?  Unlikely...  Far more likely is that you 
> just loose this information and you copy the file uncompressed / 
> unencrypted.  You then also want to loose the compressed/encrypted bits on 
> the file attributes anyway as the file is no longer compressed/encrypted.  
> That would certainly be the element of least surprise.  You simply loose 
> unsupported bits since you also loose all the features that go with their 
> meaning.  Makes perfect sense to me anyway.  YMMV  (-;

I never suggested that all filesystems should support every feature that
every filesystem has ever supported, and I don't know where you got such
a crazy idea.

I am advocating two things:

1) If information can be accurately preserved, it should be.
2) If information cannot be accurately preserved, the user should be
notified of this fact.

My suggestion of creating two seperate xattrs meets both of these
requirements nicely.

The system.fatattrs xattr is the interface to the bits supported by
every Microsoft filesystem, whether it be msdos, vfat, CIFS, or NTFS.

The system.ntfsattrs xattr is the interface to the bits only supported
by NTFS (and CIFS, too, I suppose).

Thus, I know for a fact that if I am able to use the system.fatattr
xattr with a file, that that filesystem accurately supports FAT
attributes. I also know that if I am able to use system.ntfsattr, that
the filesystem accurately supports NTFS DOS attributes. I can can use
neither, than I know that I will lose information, and if I can use one
and not the other, I know which information will be lost.


[ Note to audience: the following is a long (and largely irrelevant to
the subject) discussion of how NTFS could implement reparse points and
encryption on Linux. Feel free to ignore it. ]

Of course, reparse points and encrypted files make this difficult
because those are NTFS DOS attribute bits that require extra information
and cannot be explicitly set. I'm not sure how you'd want to implement
that, but here's my suggestion (although, you're the NTFS expert, so
these may be completely wrong).

Reparse points fall into two categories: those that Linux supports
(afaik, only symlinks) and those that Linux doesn't support.

Reparse points that Linux doesn't support are (conceptually) easy: just
add a system.ntfs_reparse_point xattr that exports the reparse tag,
reparse GUID, and the data buffer.

If something attempts set the reparse bit in the NTFS DOS attr on a file
without the system.ntfs_reparse_point xattr, silently clear that bit, if
something attempts to clear that bit on a file with the xattr, silently
set the bit, when something creates the xattr (i.e. when something turns
a file/directory into a reparse point), set the bit, when something
removes the xattr, clear the bit.

Reparse points that Linux does support (symlinks) are more difficult.
You could pretend that they aren't actually reparse points and just make
them look like symlinks to the Linux VFS with no bit set in the NTFS DOS
attributes and no system.ntfs_reparse_point xattr.

Or you could include the bit in the attributes and the
system.ntfs_reparse_point xattr, but silently resist any attempt to
change them via the xattr interface.

Finally, you could allow arbitrary modification of the
system.ntfs_reparse_point xattr, but then you have to deal with the
possibility that something could come along and turn a normal file into
a symlink right under the VFS's nose, which is bound to cause problems.

Encryption doesn't look to be all that hard, actually. When an app sets
the Encrypted bit, you can grab the appropriate NTFS-encrypting-key from
their keyring and use that to encrypt the file.

Arranging for copying files to use the right key is harder. If you're
happy with Win2k semantics, you can live with the fact that setting the
Encrypted bit just causes the file to be encrypted with the current key.
If you want XP semantics, where copying a file causes the copy to be
encrypted with the same key if possible (or the default key, if not),
you could add a system.ntfs_key_ids xattr that lists the ids of the keys
used and require that apps create all xattrs before writing to the file
for copying to work.

Those are just my ideas, I've no intention of implementing them and you
can probably come up with better ones.

Of course, I don't use NTFS (or, for that matter, FAT and CIFS), so I
don't care all that much what you do, beyond my general desire for Linux
to be stellar instead of merely adequate.

> Best regards,
> 
> 	Anton
-- 
Nicholas Miell <nmiell@comcast.net>

