Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWCYNtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWCYNtI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 08:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWCYNtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 08:49:07 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:5761 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751407AbWCYNtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 08:49:06 -0500
Date: Sat, 25 Mar 2006 11:51:39 -0300
From: cascardo@minaslivre.org
To: "Theodore Ts'o" <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org,
       cascardo@minaslivre.org
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060325145139.GA5606@cascardo.localdomain>
References: <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com> <20060320234829.GJ6199@schatzie.adilger.int> <1142960722.3443.24.camel@orbit.scot.redhat.com> <20060321183822.GC11447@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20060321183822.GC11447@thunk.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2006 at 01:38:22PM -0500, Theodore Ts'o wrote:
> On Tue, Mar 21, 2006 at 12:05:22PM -0500, Stephen C. Tweedie wrote:
> > > It would also be good to understand what HURD is actually doing with
> > > those other fields (if anything, does it even exist anymore?), since
> > > it is literally holding TB of space unusable on Linux ext3 filesystems
> > > that could better be put to use.  There are i_translator, i_mode_high,
> > > and i_author held hostage by HURD, and I certainly have never seen or
> > > heard of any good description of what they do or if Linux would/could
> > > ever use them, or if HURD could live without them.
>=20
> Hurd is definitely using the translator field, and I only recently
> discovered they are using it to point at a disk block where the name
> of the translator program (I'm not 100% sure, but I think it's a
> generic, out-of-band, #! sort of functionality).  I don't know about
> the other fields, but I can find out.
>=20
> > If they really are 100% necessary for hurd, it might be that we could
> > relegate them to an xattr.  There's the slight problem of testing,
> > though; does anyone on ext2-devel actually run hurd, ever?
>=20
> Relegating them to an xatter would break compatibility with existing
> hurd filesystems.  We could take the arrogant "Linux is the only thing
> that matters", and just screw them, and the net result will probably
> be that Hurd will never implement some of the advanced features we've
> been talking about.  They might not anyways, though.  A real problem
> is that as far as I know, the hurd ext2 developers aren't on the
> ext2-devel mailing list.
>=20
> I've cc'ed two people that sent me a request to add some additional
> debugfs functionality to support hurd; maybe they can help by telling
> us whether or not hurd is using i_mode_high and i_author, and whether
> or not hurd has any likelihood of tracking new ext3 features that we
> might add in the future or not.
>=20

As AMS has pointed out, the filesystem creator must be set to Hurd for
these inode fields to be used. Since ext2 seems to be the most
supported filesystem on Hurd, most of the ext2 fs used have the fs
creator set to Hurd.

Regarding compatibility, there are plans to support xattr in Hurd and
use them for these fields, translator and author. (I can't recall what
i_mode_high is used for.) With respect to that, I'd appreciate if
there is a recommendation to every ext2 implementation (not only
Linux) that supports xattr, to support gnu.translator and gnu.author
(I'll check about the i_mode_high and post about it asap.). There is a
patch by Roland McGrath for Linux that supports those besides the
reserved fields in case the fs creator is Hurd.

> > > I'm fully in the "the chance of any real problem is vanishingly small"
> > > camp, even though Lustre is one of the few users of large inodes.  The
> > > presence of the COMPAT field would not really be any different than j=
ust
> > > changing ext3_new_inode() to make i_extra_isize 16 by default, except=
 to
> > > cause breakage against the older e2fsprogs.
> >=20
> > Setting i_extra_isize will break older e2fsprogs anyway, won't it?
> > e2fsck needs to have full knowledge of all fs fields in order to
> > maintain consistency; if it doesn't know about some of the fields whose
> > presence is implied by i_extra_isize, then doesn't it have to abort?
>=20
> E2fsprogs previous to e2fsprogs 1.37 ignored i_extra_isize and didn't
> check whether or not the EA's in the inode were valid.  Starting in
> e2fsprogs 1.37, e2fsck understands i_extra_size and in fact does
> validate the EA's in the inode.  If we add new i_extra fields, then
> currently e2fsprogs will ignore them, and that's OK for things like
> the high precision time fields.  But if they are fields where e2fsck
> does need to know about them, then obviously we would need a COMPAT
> feature flag to signal that fact (since e2fsck will refuse to operate
> on a filesystem if ther is a COMPAT feature that it doesn't
> understand.)

Regarding userland tools, it would be wise if they would still support
old format filesystems, including those with fs creator set to
Hurd. That would include supporting the oob block for translator when
counting used/free blocks and other operations like copying a file
using debugfs, for example.

>=20
[...]
>=20
> 						- Ted

Regards,
Thadeu Cascardo.
--

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFEJVj7ViHte+iggsgRAr9tAJ9Pz8Y3rNKuC6bjRYe3ZrPhKI2BUACgkdYz
o5532U2ds7cHfZWY+eZEU4o=
=288a
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

	

	
		
_______________________________________________________ 
Yahoo! doce lar. Faga do Yahoo! sua homepage. 
http://br.yahoo.com/homepageset.html 

