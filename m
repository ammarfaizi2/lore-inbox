Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVENBHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVENBHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 21:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVENBHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 21:07:19 -0400
Received: from remus.commandcorp.com ([130.205.32.4]:11653 "EHLO
	remus.wittsend.com") by vger.kernel.org with ESMTP id S262653AbVENBG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 21:06:58 -0400
Subject: Re: Sync option destroys flash!
From: "Michael H. Warfield" <mhw@wittsend.com>
Reply-To: mhw@wittsend.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mhw@wittsend.com
In-Reply-To: <1116009619.9371.494.camel@localhost.localdomain>
References: <1116001207.5239.38.camel@localhost.localdomain>
	 <1116009619.9371.494.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YmBEAw8+6x0rzl7rkcXJ"
Organization: Thaumaturgy & Speculms Technology
Date: Fri, 13 May 2005 21:05:34 -0400
Message-Id: <1116032735.5461.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-WittsEnd-MailScanner: Found to be clean
X-MailScanner-From: mhw@wittsend.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YmBEAw8+6x0rzl7rkcXJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey Alan...

On Fri, 2005-05-13 at 19:40 +0100, Alan Cox wrote:
> > 	What happens, with the sync option on a VFAT file system, is that the
> > FAT tables are getting pounded and over-written over and over and over
> > again as each and every block/cluster is allocated while a new file is
> > written out.  This constant overwriting eventually wears out the first
> > block or two of the flash drive.

> All non-shite quality flash keys have an on media log structured file
> system and will take 100,000+ writes per sector or so. They decent ones
> also map out bad blocks and have spares. The "wear out the same sector"
> stuff is a myth except on ultra-crap devices.

	Yah know...  I've been thinking about this...  In a former life, we use
to do something very similar with a virtual memory system on some real
early (80's vintage) networked VM workstations (back when memory was
actually valuable and scarce).

	So...  This would have to work with a list or pool of "spares" that are
not allocated to the "visible" file system.  We used a "least used"
algorithm for that VM system.  This would seem to be a "replace as
rewritten" algorithm.  Each time you write to the file system, it grabs
a block off the head of the spares list, writes your data to it, and
then adds the old block to the tail of the list.  Pretty basic stuff and
it doesn't have to track what kind of high level file system you are
using or know anything about its structure.  Cool...

	That makes sense.  But...  How big might this "list" be?  Maybe an
additional 10% of the entire drive capacity?  That's quite a bit...  But
now you're beating on that FAT table pretty heavy.  For each block
allocated and written to, we're rewriting the FAT table (actually TWO
FAT tables if you count the back up FAT).  Ok...  One data block, two
FAT table rewrites.  So a FAT table block gets added back to the list
and a block is grabbed off the list.  Seems like there would be a pretty
high percentage of old FAT table blocks sitting there circulating on the
spares list.  That would make the probability of grabbing an old FAT
table block and rewriting it again pretty high.  Then it would get added
back to the list again, in turn.

	Because of this systematic thumping of the FAT tables, these old FAT
blocks are going to be circulating in that spares list at a pretty high
density.  The wear leveling is not going to be nearly as effective
BECAUSE of the thumping.  I'm not certain if that will be better or
worse if there are more blocks in the spares list.  Seems like you are
going to end up with 50% - 60% (WAG) of the blocks in the spares list
being old FAT table blocks and end up with a number that just keep
recirculating until they burn out.  I would think that they'll burn out
faster if that spares list is small and they get reused more frequently
(note to follow).

	The up side is that, once an beat up old FAT table block does get
allocated to a file data block, it gets to retire in comfort and not get
rewritten until the file gets rewritten.  But...  That's reducing the
pool of circulating blocks in the allocated file system...  So, a file
system that's full is going to rotate through it's spare and free blocks
faster as well...  Some pluses...  Some minuses...

	It would seem like this would work well for something like a camera (or
a Mars Rover) where you are periodically removing almost everything from
the flash memory and all the blocks have a chance to return to the
spares list.  But I see lots of possibilities for degrading the wear
leveling in other cases...

	Now...  Flaw recovery could be a big help there.  Write the block but
notice that the old one is now bad and don't add it back or the new one
failed and you grab another.  But then your spares list shrinks.
Failure occurs on the first failure where the spares list hits zero.
Probability (in the FAT thumping case with the sync option) is that it's
going to be a FAT block that takes the hit and takes then entire drive
out.

	Am I seeing this correctly?  Seems to me that the wear leveling is not
going to be nearly as effective as it should in the case where we are
beating up on the FAT simply because of this systematic bias the sync
option introduces into the write patterns on a FAT file system.  And
that will be aggravated by significant load of static data.  If
anything, the "sync" option almost appears to be defeating the wear
leveling logic on FAT and VFAT file systems.

> > 	I'm also going to file a couple of bug reports in bugzilla at RedHat
> > but this seems to be a more fundamental problem than a RedHat specific
> > problem.  But, IMHO, they should never be setting that damn sync flag
> > arbitrarily.
>=20
> It sounds like your need to find a vendor who makes decent keys. For
> that matter several vendors now offer life time guarantees with their
> USB flash media.
>=20
> Sync gets set by RH because it seemed the right thing to do to handle
> random user device pulls. Now O_SYNC works so excessively well on
> fat/vfat that needs looking at - and as you say likewise perhaps the
> nature of the FAT rewriting.
>=20
> However its not a media issue, its primarily a performance issue.
>=20
> Alan

	Mike
--=20
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com =20
  /\/\|=3Dmhw=3D|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/=
mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

--=-YmBEAw8+6x0rzl7rkcXJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQCVAwUAQoVO3uHJS0bfHdRxAQLcTwQAhKhGxKmx9Ka8WchTwVbuUvb6eWbKHgUR
ohVQb0NGATeJ9enTp3HEma8EG8I4co4IR/G8W4TlLtqeULtRrfMI05gON6D4X9Zz
Fl26Yy3puC5yqGU5j7nBLjp1gGo4ATjE/G4lao8I2g0EYnTtyyOctiku3y6WZwlf
Ai8HkUIrU/4=
=46c6
-----END PGP SIGNATURE-----

--=-YmBEAw8+6x0rzl7rkcXJ--

