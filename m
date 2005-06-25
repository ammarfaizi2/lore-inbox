Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVFYUcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVFYUcv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 16:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFYUcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 16:32:51 -0400
Received: from h80ad255c.async.vt.edu ([128.173.37.92]:26273 "EHLO
	h80ad255c.async.vt.edu") by vger.kernel.org with ESMTP
	id S261275AbVFYUco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 16:32:44 -0400
Message-Id: <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Sat, 25 Jun 2005 13:33:27 CDT."
             <42BDA377.6070303@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>
            <42BDA377.6070303@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119731497_3890P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Jun 2005 16:31:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119731497_3890P
Content-Type: text/plain; charset=us-ascii

On Sat, 25 Jun 2005 13:33:27 CDT, David Masover said:
> > Now *think* for a moment - how does a hypothetical Reiser4 using ext3 format
> > gain any speed advantage with small files, when the speed advantage is based
> > on using a format other than ext3?

> happen in RAM.  If you do a ton of work with a dataset that stays in
> RAM, Reiser probably performs as well or better than a ramdisk, because
> changes that get overwritten while still in RAM never actually touch the
> disk.

At that point, since the actual buffer management is being done at the VFS
level (see fs/buffer.c and friends) what you're really comparing is the speed
of journalling metadata - at which point you need to be *very* careful to
specify exactly what configuration you're talking about.  If you don't believe
me, investigate why mounting a filesystem with 'noatime,nodiratime' can make a
dramatic difference totally independent of the underlying filesystem, but the
actual amount of gain is dependent on format (hint - how far do the heads have
to move to record 3 atime updates against 3 random inodes on an ext2, an ext3,
and a VFAT filesystem, assuming no other disk activity), and why
ext3 has 3 different modes data=ordered/writeback/journal.

>        Reiser also doesn't fragment as quickly as ext3, and I don't
> think that has anything to do with its format.

Care to explain why it's not format-dependent? 

> > b) Tell reiser4 to get its grubby little paws off the VFS if it ever intends
> > to have a chance of being merged in mainline.
> 
> You are saying Reiser isn't in because it shouldn't touch VFS.  Every
> single other person in this thread says Reiser isn't in because it
> *should* touch VFS.

Hmm.. let's see.. I said Reiser isn't in because it shouldn't be screwing with
the VFS, and said stuff should be done separate from the Reiser4 filesystem.

Everybody else said that to achieve all the goals that Hans wants will require
changes to the VFS, and the way reiser4 gets there isn't acceptable.

Seems like myself and everybody else are saying this needs to be factored into
2 pieces, a FS piece and a VFS piece, and moved forward separately.

> > c) Have a *separate* project to improve the speed/reliability/function of
> > the VFS layer, which is the only way that your vision of having the ext3 and
> > reiser developers cooperating will ever happen.
> 
> Why does it have to be a separate project if it is already *done* as
> part of Reiser4?  Or is the name Reiser just cursed that way?

Because it's done *as a part of reiser4*, and not as a separately reviewed
change to the VFS.

> The FS that gets merged ahead of time without plugins would no longer be
> Reiser4.  Go read the whitepaper, or tell me why I'm wrong, but even
> symlinks are implemented as plugins.

Which is another way of saying Reiser4 can't be merged in its present form.

> I'm not arguing that at all.  But if you've got an entirely new driver,
> why not do:
> 
> Patch 1/2:  Add white_whale driver, which also adds moby_foo_init to
> nautical core.

You don't do this because the rule is "one patch, one logical change", and
"which also" implies more than one change.

> Actually, plugins are just as easy or easier than crypto-loop or
> dm-crypt.  And why shouldn't my crypto be easy?  Most users are insecure
> in all kinds of ways because of that attitude -- security is HARD, so I

There's a vast distinction between "easy for implementors" and "easy for
users".  Jaari Russo's loop-aes stuff does a wonderful job of being "easy for
users" - just say "mount", answer the passphrase, and you're good to go.  The
underlying arguing about the crypto involved is complicated enough keep
professional crypto jocks busy for years (is the watermark attack Jaari is
concerned about a real threat?  You tell me. ;)

Meanwhile, PGP was designed to be used in an environment where you could do
this:  "Today's secret plans are AES256 encrypted.  The key is the next key in
your one-time-pad book, XOR'ed with your 128-bit secret key - do it in your head".
(And yes, you can easily memorize a 16-digit hex number and learn to do an XOR
with another 16-digit number, if failing to do so means you could end up dead).

This is inconvenient for the user, but intractable for an attacker to create a
scenario where they can just 'vi /each/decrypted/file' ;)

> won't do it.  If security is transparent, just enter a password and go,
> then more people would do it.

"Just enter a password and go, then more people would do it".

Two words: "phishing e-mail".

Why does phishing work at all?  Because it's simple for the user, and the
user isn't aware of the totally busticated underlying security model of
SMTP (namely, there isn't one) and the mostly busticated security model of
most browsers (the misleading concept that if an SSL site is identified
by the SSL cert, that this implies the site can be trusted, and other similar
misfeatures).


--==_Exmh_1119731497_3890P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCvb8pcC3lWbTT17ARAi1IAKDv5RBSZZ4nLTD/65ZkP8ePwshbhQCgtnfL
TDUHwikc+uAEA5WxjlT27+k=
=21Cx
-----END PGP SIGNATURE-----

--==_Exmh_1119731497_3890P--
