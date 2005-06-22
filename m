Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVFVPEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVFVPEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVFVPDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:03:30 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:12265 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261366AbVFVO5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:57:02 -0400
Subject: Re: reiser4 plugins
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Hans Reiser <reiser@namesys.com>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20050621181802.11a792cc.akpm@osdl.org>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com>
	 <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com>
	 <20050621181802.11a792cc.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ie3VkdKrz8I/WCDT3hID"
Date: Wed, 22 Jun 2005 16:56:52 +0200
Message-Id: <1119452212.15527.33.camel@server.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ie3VkdKrz8I/WCDT3hID
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 21.06.2005, 18:18 -0700 schrieb Andrew Morton:

> > What is wrong with having an encryption plugin implemented in this
> >  manner?  What is wrong with being able to have some files implemented
> >  using a compression plugin, and others in the same filesystem not.
> >=20
> >  What is wrong with having one file in the FS use a write only plugin, =
in
> >  which the encrypion key is changed with every append in a forward but
> >  not backward computable manner, and in order to read a file you must
> >  either have a key that is stored on another computer or be reading wha=
t
> >  was written after the moment of cracking root?
> >=20
> >  What is wrong with having a set of critical data files use a CRC
> >  checking file plugin?
>=20
> I think the concern here is that this is implemented at the wrong level.
>=20
> In Linux, a filesystem is some dumb thing which implements
> address_space_operations, filesystem_operations, etc.
>=20
> Advanced features such as those which you describe are implemented on top
> of the filesystem, not within it.  reiser4 turns it all upside down.
>=20
> Now, some of the features which you envision are not amenable to
> above-the-fs implementations.  But some will be, and that's where we shou=
ld
> implement those.

Yes, but that would be difficult, probably worse. The name "plugins" is
perhaps a bit misleading. These plugins are most of the time some sort
client to the reiser4 on-disk database structure. The core code is does
on-disk tree handling, journalling and these things. The plugins in turn
glue this core database system to the rest of the system in order to
make a filesystem of it. The "file plugin" tells the database how to
store files.

A compression plugins is more tricky. Files should be randomly
accessible and if you write in the middle of the file the compressed
block might change in size. For reiser4 this is not a problem since it
just tells the underlying database "give me some room for 1234 bytes and
insert it in the tree instead of the other block". The reiser4 core has
totally different semantics than the VFS layer and I don't see how these
things could be handled elsewhere in this simple way.

The reiser4 core is more some sort of library that abstracts a block
device and provides some sort of database API (which is highly optimized
for filesystem purposes). The actual filesystem is then another layer on
top of this. You could actually implement lots of different filesystems
on top of that database core.

The actual layer is a bit different though. The database core itself
registers with the Linux VFS and then passes the calls down to one of
the plugins which then calls back into the reiser4 core to do the actual
database modification. I think this was the point that Christoph was
criticizing the most.

Currently it looks like this:

             ,--------------.       ,--------------.
VFS -------> |              | ----> |              |
             | /fs/reiser4/ |       | .../plugins/ |
blockdev <-- |              | <---> |              |
             `--------------'       `--------------'

So the reiser4 code is introducing another abstraction of the Linux VFS
layer instead of letting the plugins define the Linux VFS ops directly.
Which would look like this:

                                    ,--------------.
VFS ------------------------------> |              |
             ,--------------,       | .../plugins/ |
blockdev <-- | /fs/reiser4/ | <---> |              |
             `--------------'       `--------------'

Which probably would be okay for most of the time except for some
details (which could probably be solved otherwise).

Actually the flow is not always this simple, usually the path goes back
and forth multiple time between the core and the plugins.

One of the features Hans is using is that there can be different kinds
of files. The on-disk structure tells the core which of the plugins is
responsible for the "database object" found on the disk. It could be a
directory or a "stat data" (inode) or a file. The file itself could be
handled by different plugins like one that stores the data directly or
one that compresses it.

reiser4 is different than other filesystems in that it uses a lot more
abstraction levels. The database aspect and the semantic aspect of a
traditional filesystems are strongly separated.

To understand the code probably means a lot of work because it is a bit
different. Some of the layering concerns may be right, other probably
not.

The plugins that add additional VFS semantics (that are currently
disable) should most definitely not be implemented only inside the
filesystem. I think Hans did this because it would have been a lot more
work doing this at the proper layer (which means talking to people and a
lot of politics...).

The last time I looked at the code is a while ago, so if I'm wrong on
something, please don't shoot me. The only thing I can say is that
reiser4 has very stable for me (though I've gone back to reiser3 for
most of my filesystems because I wanted acl/xattr).

So here's my advice: Instead of insulting each other or doing pure
marketing talk, please try to address each detail and explain why
something has been done and if it's good or bad and if it should be
changed and how.


--=-ie3VkdKrz8I/WCDT3hID
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCuXw0ZCYBcts5dM0RAsmFAJ9Pho4cu9votkAjTh5+5p+3gGjg3ACfVrmw
JHArf0/wMgvW4W3TZdY4+dk=
=8y/P
-----END PGP SIGNATURE-----

--=-ie3VkdKrz8I/WCDT3hID--
