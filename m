Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUA0Vas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUA0Var
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:30:47 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:32182 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265698AbUA0Vao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:30:44 -0500
Date: Tue, 27 Jan 2004 15:25:46 -0600
From: Michael Halcrow <mike@halcrow.us>
To: LKML <linux-kernel@vger.kernel.org>, Hans Reiser <reiser@namesys.com>
Subject: Re: Encrypted Filesystem
Message-ID: <20040127212546.GA10831@halcrow.us>
Reply-To: Michael Halcrow <mike@halcrow.us>
References: <16405.24299.945548.174085@laputa.namesys.com> <40156449.8010805@namesys.com> <4016B444.A816C980@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <4016B444.A816C980@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2004 at 09:56:04PM +0300, Edward Shishkin wrote:
> > >   - Unencrypted pass-through mode with minimal overhead
> Would you comment this?=20

Allow me to clarify.  A transparent encryption layer like CFS will
encrypt anything written out to a CFS mount and decrypt anything read
from a CFS mount, using the metadata associated with the source
directory.  One potential modification to something like CFS would be
to make the encryption optional; a file behind a CFS mount may or may
not be encrypted, depending on an EA set in the file in the source
directory.  If this were to apply to an entire root filesystem, then
one would want to minimize the overhead imposed by the CFS layer when
dealing with files that are not flagged as encrypted.

I have had a discussion with Steve French[1] on this topic, who has
given me some interesting insights.  In general, one of my design
goals in an encrypted filesystem is to minimize overhead for the
default (unencrypted) case.  In fs/jfs/file.c:106, the fileop read
pointer is set to generic_file_read.  This is passed the file struct,
which can contain the encrypted status of file.  If the file is marked
as encrypted, then the block can be assumed to be encrypted.  The
pages in the blocks that are read can then be placed in a scatterlist
and decrypted with the crypto code in the kernel, according to further
metadata pointed to by the file struct (cipher id, key, etc.) and
according to the credentials in the task structure.  Perhaps this
logic can be placed in a new jfs_file_read and the fileop read pointer
can point there instead; the jfs_file_read will check
filp->f_encryption->encrypted, and if it is set (unlikely()), then it
will continue with a read-and-decrypt, else it will just call
generic_file_read.  This pointer will need to get set for each
relevant function in each filesystem that supports file encryption in
this manner.

> Also cryptcompress file has the following extended attributes (I think
> it will be useful to resolve some listed issues):
> - digest plugin id (which represents digest algorithm supported by
> reiser4: md5, sha1, etc..)
> - key id (fingerprint of special randomly generated string, this string
> is a part of a secret key, and this 'public' fingerprint is created
> by appropriate digest plugin. 'Public' means that all EA should be
> stored in disk stat-data. This key id allows to check authorization
> every time when file is opened. Authorization is granted only by a
> secret key (not by root password)
> ...
> Reiser4 allows to support any compression algorithm of Ziv-Lempel
> family, and any (symmetric or asymmetric) crypto algorithm (of course,
> asymmetric ones are very slowly and may inflate data, but enabling of
> short files encrypted by public/private keys can be useful for various
> management purposes.

Hans has been doing some very interesting work in this area.  I am
aware of reiser4; Hans may remember having lunch with me at the
DISCEX-III conference in Washington, D.C. last year.  My booth (the
BYU Internet Security Research Lab; Trust Negotiation) was right
across from his:

http://csdl.computer.org/comp/proceedings/discex/2003/1897/02/1897toc.htm

He had a lengthy discussion with Jason Holt[2] on the implementation
of crypto in reiser4.

While I appreciate the security features that are part of reiser4, my
efforts toward filesystem encryption are aimed at a more general
level, to provide an encryption layer that will work across several
filesystems.  Perhaps we can look into unifying and abstracting the
key management, authentication, and other aspects involved in a
comprehensive filesystem encryption system, extending and using kernel
structures (struct file, kobject/sysfs, etc.) to maintain that data,
so whether someone is using reiser4, Security Enhanced ext3 (SEext3),
or Security Enhanced jfs (SEjfs)[3], the interface to userland will be
the same.

Mike

[1] Steve works on the Samba team down the hall from me; he's working
on CFIS at the moment

[2] Hans: Jason was a co-worker of mine in the ISRL, skinny and tall
with curly red hair (he's hard to forget once you've met him:
<http://isrl.cs.byu.edu/images/Dcp02290.jpg>)

[3] That was meant to be funny...
=2E___________________________________________________________________.
                         Michael A. Halcrow                         =20
       Security Software Engineer, IBM Linux Technology Center      =20
GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQFAFtdaLTz92j62YB0RAsqhAJ9fF+KF/OoFCdXPv7uQooGtTpGazgCeK2jG
+bcT3kHdkra/iw2V2LMLYrE=
=zaKw
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
