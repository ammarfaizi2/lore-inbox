Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbTF2Urq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265731AbTF2UrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:47:25 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:63046 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265097AbTF2Uqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:46:49 -0400
Date: Sun, 29 Jun 2003 17:00:34 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <20030629205003.GA4298@carfax.org.uk>
To: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org
Message-id: <200306291700340120.0257F7AF@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk>
 <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
 <200306291545410600.02136814@smtp.comcast.net>
 <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
 <200306291629450990.023BC35E@smtp.comcast.net>
 <20030629205003.GA4298@carfax.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 9:50 PM Hugo Mills wrote:

>On Sun, Jun 29, 2003 at 04:29:45PM -0400, rmoser wrote:
>> *********** REPLY SEPARATOR  ***********
>>
>> NO!  You're not getting the point at all!
>>
>> You don't need a pair!  If you have 10 filesystems, you need 10 sets of
>> code in each direction, not 90.  You convert from the data/metadata set
>> in the first filesystem to a self-contained atom, and then back from the
>> atom to the data/metadata set in the new filesystem.  The atom is object
>> oriented, so anything that can't be moved over--like ACLs or Reiser4's
>> extended attributes that nobody else has, or permissions if converting to
>> vfat--is just lost.
>
>   You will, of course, ensure that your atoms contain the superset of
>all filesystem metadata semantics.
>

Yes, that's the point of object orientation.  Objects I don't understand I ignore.
Objects I do understand I keep.  Objects I don't understand don't confuse
me because I can see the difference between two objects.

>> Note that if the data has an attribute like "Compressed"
>> or "encrypted", it is expanded/decrypted and thus brought back to its
>> natural form before being stuffed into an atom.
>[snip]
>
>> So with 10 filesystem types, N*(N-1) or 90 pairs to go directly from one
>> filesystem's datastructures to any other's; N*2 or 20 pairs to go from
>> Metadata/Data pair -> Self-contained object oriented possibly
>> compressed atom -> Metadata/Data pair.  That's N sets of code to go
>> FS_OBJECT -> atom and N sets to go from atom ->  FS_OBJECT, in
>> this case 10 and 10.
>>
>> When we get to 20 filesystems, direct conversion needs 380 pieces of
>> code, whereas my method needs only 20 + 20 == 40.  I obviously put
>> more thought into this than you, but that's okay; it's an obscure idea
>and
>> I don't expect everyone to think before answering.
>
>   Actually:
>
>1) I think Viro did mention exactly this method in one of his mails.
>
>2) It's not an obscure idea at all -- it's one of the standard
>   techniques if you've ever had to consider (let alone write!) a
>   set of data-conversion routines.
>
wow, I re-invented another wheel.

>> >If you want your idea to be considered seriously - take reiserfs code,
>> >take ext3 code, copy both to userland and put together a conversion
>> >between them.  Both ways.  That, by definition, is easier than doing
>> >it in kernel - you have the same code available and none of the
>> >limitations/
>> >interaction with other stuff.  When you have it working, well, time to
>> >see what extra PITA will come from making it coexist with other parts
>> >of kernel (and with much more poor runtime environment).
>> >
>>
>> That would be much harder to maintain as well.  It would have to be
>altered
>> every time the filesystem code in the kernel is changed.
>
>   Yes, but the point is it's a much easier thing to implement and
>test the concept than diving straight into kernel code. You don't have
>to maintain it for very long (if at all) -- just long enough to prove
>to everyone that this kind of conversion is possible, and that they
>should help you roll it into the kernel.
>

I can't code it.  I want to, it'd be FUN, but I can't.

>> >AFAICS, it is _very_ hard to implement.  Even outside of the kernel.
>> >If you can get it done - well, that might do a lot for having the
>> >idea considered seriously.  "Might" since you need to do it in a way
>> >that would survive transplantation into the kernel _and_ would scale
>> >better that O((number of filesystem types)^2).
>>
>> I've beaten the O((FS_COUNT)^2) already.  And by the way, it's
>> O((FS_COUNT)*(FS_COUNT - 1_).  There's exactly O(2*FS_COUNT)
>> and o(2*FS_COUNT) sets of code needed total to be able to convert
>> between any two filesystems.
>
>   There's no such thing as O(x*(x-1)). This is precisely O(x^2).
>Similarly, O(2*x) is precisely the same as O(x). If you're going to
>try to use mathematics to demonstrate your point, please at least make
>sure that you're using it _right_.
>

Big O notation is inappropriate here because it measures time complexity;
however, I was following Viro's lead.  We're using it to measure code
complexity, sorry.

>> Now, what's impractical is maintaining two sets of code that do exactly
>> the same thing.  Why maintain code here to read the filesystems, and
>> also in the kernel?
>
>   It's not a maintenance thing at all -- it's a matter of
>demonstrating that you can walk before you try running.
>

Erm, if you're going to do it at all, do it right first.  Actually demonstrating
it is not the only way to prove it's possible.

>> Just do it in the kernel.  Don't lose sight of the fact
>> that the final goal (after all else is done) is to modify VFS to actually
>> run this thing as a filesystem.  THAT is what's going to be a bitch.  The
>> conversions are simple enough.
>
>   Hugo.
>
>--
>=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
>  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
>     --- For months now, we have been making triumphant retreats ---
>               before a demoralised enemy who is advancing
>                           in utter disorder.
>
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.2 (GNU/Linux)
>
>iD8DBQE+/1D7ssJ7whwzWGARArdCAJ4pBlRI5wUCQuto8a/UJS89VgVGqACglV2k
>yZmfIJpKxN2qEjONnx5FicA=
>=iJlv
>-----END PGP SIGNATURE-----

Calmest input I've seen yet.

--Bluefox Icy

