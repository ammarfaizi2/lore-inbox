Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUHZN7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUHZN7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUHZN7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:59:01 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:30102 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S268886AbUHZN6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:58:19 -0400
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
In-Reply-To: <20040826134034.GA1470@lst.de>
References: <20040825152805.45a1ce64.akpm@osdl.org>
	 <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org>
	 <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de>
	 <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de>
	 <1093526273.11694.8.camel@leto.cs.pocnet.net>
	 <20040826132439.GA1188@lst.de>
	 <1093527307.11694.23.camel@leto.cs.pocnet.net>
	 <20040826134034.GA1470@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a/fC3Z+Swf0SIdPlS6iD"
Date: Thu, 26 Aug 2004 15:58:03 +0200
Message-Id: <1093528683.11694.36.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a/fC3Z+Swf0SIdPlS6iD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 15:40 +0200 schrieb Christoph Hellwig:

> > That's your opinion. reiser4 seems to work very well.
>=20
> So how many OSes is it ported to currently?  The problem is not that it
> doesn't work but that it's really hard to maintain.  And remember that
> this maintaince overhead is not just for Hans but for everyone that does
> VFS-level work.

Where does it add overhead? It's just the interface between the reiser4
storage layer and the rest abstracted out.

Ok, there's the code that dispatches the VFS method calls to the plugin
call but I would say that's about it. I didn't develop reiser4 so I
don't know.

/* ->mkdir() VFS method in reiser4 inode_operations */
static int
reiser4_mkdir(struct inode *parent      /* inode of parent
                                         * directory */ ,
              struct dentry *dentry     /* dentry of new object to
                                         * create */ ,
              int mode /* new object's mode */ )
{
        reiser4_object_create_data data;

        reiser4_stat_inc_at(parent->i_sb, vfs_calls.mkdir);

        data.mode =3D S_IFDIR | mode;
        data.id =3D DIRECTORY_FILE_PLUGIN_ID;
        return invoke_create_method(parent, dentry, &data);
}

The invoke_create_method then just calls the create method of the plugin
after setting up a context and lookup up the plugin.

xfs_iops.c seems to do something similar.

>   Unless of course we get a blanko permission to break it
> as soon as fixing the mess becomes non-trivial.

Well, I think so. It's done relatively often.

> > What I understood is that you can select exactly one plugin that e.g.
> > handles the file data. The default plugin is optimized for normal files=
,
> > another one could implement transparent compression or encryption. Some
> > of these plugins also give the storage layer hints how to group files
> > together to optimized performance. Neither of these things mess with th=
e
> > VFS.
>=20
> compression or encryption must sit below the pagecache to work nicely,
> and this hint things that usually sit at the pagecache level.  But let's
> assume you have a valid use for different file_operations, why don't you
> simply add in different file_operations instead of adding another
> internal dispatch layer? =20

I don't know, ask Hans. How could the VFS know it a filesystem wants to
do something specific with a file that is completely transparent to the
VFS?


--=-a/fC3Z+Swf0SIdPlS6iD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQBBLexrZCYBcts5dM0RArcSAJjJm994nX4K3nJpbGuMAzxv6PecAKCaJ5OL
iE8Tkw3UEPiRyJFTgOxoZQ==
=s9Bq
-----END PGP SIGNATURE-----

--=-a/fC3Z+Swf0SIdPlS6iD--

