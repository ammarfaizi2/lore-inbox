Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTF2Ugm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTF2Ugg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:36:36 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:29400 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S264085AbTF2Ufz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:35:55 -0400
Date: Sun, 29 Jun 2003 21:50:03 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: rmoser <mlmoser@comcast.net>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030629205003.GA4298@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	rmoser <mlmoser@comcast.net>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk> <200306291545410600.02136814@smtp.comcast.net> <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk> <200306291629450990.023BC35E@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <200306291629450990.023BC35E@smtp.comcast.net>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 29, 2003 at 04:29:45PM -0400, rmoser wrote:
> *********** REPLY SEPARATOR  ***********
> 
> NO!  You're not getting the point at all!
> 
> You don't need a pair!  If you have 10 filesystems, you need 10 sets of
> code in each direction, not 90.  You convert from the data/metadata set
> in the first filesystem to a self-contained atom, and then back from the
> atom to the data/metadata set in the new filesystem.  The atom is object
> oriented, so anything that can't be moved over--like ACLs or Reiser4's
> extended attributes that nobody else has, or permissions if converting to
> vfat--is just lost.  

   You will, of course, ensure that your atoms contain the superset of
all filesystem metadata semantics.

> Note that if the data has an attribute like "Compressed"
> or "encrypted", it is expanded/decrypted and thus brought back to its
> natural form before being stuffed into an atom.
[snip]

> So with 10 filesystem types, N*(N-1) or 90 pairs to go directly from one
> filesystem's datastructures to any other's; N*2 or 20 pairs to go from
> Metadata/Data pair -> Self-contained object oriented possibly
> compressed atom -> Metadata/Data pair.  That's N sets of code to go
> FS_OBJECT -> atom and N sets to go from atom ->  FS_OBJECT, in
> this case 10 and 10.
> 
> When we get to 20 filesystems, direct conversion needs 380 pieces of
> code, whereas my method needs only 20 + 20 == 40.  I obviously put
> more thought into this than you, but that's okay; it's an obscure idea and
> I don't expect everyone to think before answering.

   Actually:

1) I think Viro did mention exactly this method in one of his mails.

2) It's not an obscure idea at all -- it's one of the standard
   techniques if you've ever had to consider (let alone write!) a
   set of data-conversion routines.

> >If you want your idea to be considered seriously - take reiserfs code,
> >take ext3 code, copy both to userland and put together a conversion
> >between them.  Both ways.  That, by definition, is easier than doing
> >it in kernel - you have the same code available and none of the
> >limitations/
> >interaction with other stuff.  When you have it working, well, time to
> >see what extra PITA will come from making it coexist with other parts
> >of kernel (and with much more poor runtime environment).
> >
> 
> That would be much harder to maintain as well.  It would have to be altered
> every time the filesystem code in the kernel is changed.

   Yes, but the point is it's a much easier thing to implement and
test the concept than diving straight into kernel code. You don't have
to maintain it for very long (if at all) -- just long enough to prove
to everyone that this kind of conversion is possible, and that they
should help you roll it into the kernel.

> >AFAICS, it is _very_ hard to implement.  Even outside of the kernel.
> >If you can get it done - well, that might do a lot for having the
> >idea considered seriously.  "Might" since you need to do it in a way
> >that would survive transplantation into the kernel _and_ would scale
> >better that O((number of filesystem types)^2).
> 
> I've beaten the O((FS_COUNT)^2) already.  And by the way, it's
> O((FS_COUNT)*(FS_COUNT - 1_).  There's exactly O(2*FS_COUNT)
> and o(2*FS_COUNT) sets of code needed total to be able to convert
> between any two filesystems.

   There's no such thing as O(x*(x-1)). This is precisely O(x^2).
Similarly, O(2*x) is precisely the same as O(x). If you're going to
try to use mathematics to demonstrate your point, please at least make
sure that you're using it _right_.

> Now, what's impractical is maintaining two sets of code that do exactly
> the same thing.  Why maintain code here to read the filesystems, and
> also in the kernel?  

   It's not a maintenance thing at all -- it's a matter of
demonstrating that you can walk before you try running.

> Just do it in the kernel.  Don't lose sight of the fact
> that the final goal (after all else is done) is to modify VFS to actually
> run this thing as a filesystem.  THAT is what's going to be a bitch.  The
> conversions are simple enough.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
     --- For months now, we have been making triumphant retreats ---     
               before a demoralised enemy who is advancing               
                           in utter disorder.                            

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/1D7ssJ7whwzWGARArdCAJ4pBlRI5wUCQuto8a/UJS89VgVGqACglV2k
yZmfIJpKxN2qEjONnx5FicA=
=iJlv
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
