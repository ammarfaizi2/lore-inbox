Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268961AbUHZPC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268961AbUHZPC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbUHZPC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:02:27 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:40064 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S268961AbUHZPCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:02:07 -0400
Date: Thu, 26 Aug 2004 08:53:19 -0500
From: Michael Halcrow <lkml@halcrow.us>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826135319.GA28811@halcrow.us>
Reply-To: Michael Halcrow <mahalcro@us.ibm.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If I may chime in here...

On Wed, Aug 25, 2004 at 01:22:55PM -0700, Linus Torvalds wrote:
> On Wed, 25 Aug 2004, Christoph Hellwig wrote:
> >=20
> > For one thing _I_ didn't decide about xattrs anyway.  And I still
> > haven't seen a design from you on -fsdevel how you try to solve
> > the problems with files as directories.
>=20
> Hey, files-as-directories are one of my pet things, so I have to
> side with Hans on this one. I think it just makes sense. A hell of a
> lot more sense than xattrs, anyway, since it allows scripts etc
> standard tools to touch the attributes.
>=20
> It's the UNIX way.

This is an issue that directly affects work I am doing in extended
cryptfs:

http://www.linuxsymposium.org/2004/view_abstract.php?content_key=3D55
http://halcrow.us/~mhalcrow/ols2004.pdf
http://halcrow.us/~mhalcrow/ols_cryptfs.sxi

The basic idea is that the cryptographic context for every file is
correlated with the individual file via xattr's.  A file is a unit of
data that should, as it stands, contain all the information requisite
for the encrypting filesystem layer to transparently decrypt (and
encrypt, when the file is written to).  This allows for a key->file
granularity, as opposed to a key->block device (dm-crypt) or a
key->mount point (CFS) granularity.

My grand vision is to have a policy that determines whether or not the
encrypted version of the file or the decrypted version of the file is
read, dependent on whether or not the file is leaving the security
domain (the storage device under the control of the currently running
kernel).  For example, if the ``cp'' command is copying a file from a
filesystem mounted from /dev/hda1 to a filesystem mounted from
/dev/fd0, then the policy would indicate that (unless otherwise noted
in the .cryptfsrc file in the root of the filesystem mounted from
/dev/fd0, which might also contain the default security context for
that filesystem or directory - like whose public keys should be used
to encrypt the symmetric key for data) the file is leaving the
security domain, and the encrypted contents of the file should be
given to cp.  Same with mutt reading an email attachment (as opposed
to, say, .muttrc, where, more likely than not, the unencrypted version
is wanted).

The goal is to enable an ``encrypted by default'' policy, in which
files on the storage devices are independent encrypted units that
remain encrypted until an application that actually needs to see the
decrypted contents opens them.  Then the encryption and decryption is
done transparently by the fs layer, as long as the user has the right
keys.  Extended attributes seem like a natural way to store this
context.

Once you consider that you can have a crypto context for each file,
you can start doing other neat tricks, like keyed hashes over extents
within the file, to allow for dynamic integrity verification during
the read.  If an offset of 1.5 gigabytes into a 2-gigabyte has been
tampered with, then that tampering will be caught when that portion of
the file is read; you don't have to verify the hash of the entire
2-gigabyte file at the time of the open.  Of course, this would very
rapidly overrun the available xattr storage size.  And so to
realistically implement something like this, some new underlying file
format is in order.

In any case, the issue of userspace applications supporting extended
attributes is key to the viability of this approach.  If cp, uuencode,
tar, or what not do not preserve the extended attributes, then the
crypto context is lost, and the file is unreadable.  So the $64,000
question is, just how committed is the community to this whole concept
of extended attributes?  From this point, should I assume that good
xattr support is forthcoming, or should I abandon the idea of using
xattr's for this altogether?

One solution I've been kicking around is to make cryptfs
GnuPG-compatible.  Not only would this eliminate the need to store
some of the crypto context in the xattr set, but it would also
preserve the crypto context with apps that don't know about xattr's,
and it would be possible for users who are not running cryptfs to read
the files with gpg.  Keyed hashes over extents would be doable if
GnuPG allowed for opaque data blobs in the file that gpg would just
ignore when decrypting the file (gnupg-dev list had technical issues
last time I tried to post these ideas to it - any gpg guys around that
can comment on this?).

> I never liked the xattr stuff. It makes little sense, and is totally=20
> useless for 99.9999% of everything. I still don't see the point of it,=20
> except for samba. Ugly.

If xattr's wind up getting supported by a certain critical mass of
applications, then they are somewhat useful for me, although, as
currently implemented, are insufficient for what I really need (keyed
hashes over extents require too much space).

BTW, early this week I migrated cryptfs over to use David Howell's new
keyring, which is working out nicely.

Mike
=2E___________________________________________________________________.
                         Michael A. Halcrow                         =20
       Security Software Engineer, IBM Linux Technology Center      =20
GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D
--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLetPLTz92j62YB0RApJWAJ9fIDHyq+uIGxgaILDVX3PLyAqwuACbBceQ
jjtQHPpi0eqQfqPqiOGlKD8=
=lbro
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
