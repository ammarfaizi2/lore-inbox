Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTF2VXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTF2VXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 17:23:12 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:61656 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S263752AbTF2VXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 17:23:05 -0400
Date: Sun, 29 Jun 2003 22:37:23 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org
Cc: mlmoser@comcast.net
Subject: Re: File System conversion -- ideas
Message-ID: <20030629213723.GD4298@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org, mlmoser@comcast.net
References: <20030629205003.GA4298@carfax.org.uk> <200306291700340120.0257F7AF@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <200306291700340120.0257F7AF@smtp.comcast.net>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[Damn, forgot to cc the list]

On Sun, Jun 29, 2003 at 05:00:34PM -0400, rmoser wrote:
> 
> 
> *********** REPLY SEPARATOR  ***********
> 
> On 6/29/2003 at 9:50 PM Hugo Mills wrote:
> 
> >On Sun, Jun 29, 2003 at 04:29:45PM -0400, rmoser wrote:
> >> That would be much harder to maintain as well.  It would have to be
> >altered
> >> every time the filesystem code in the kernel is changed.
> >
> >   Yes, but the point is it's a much easier thing to implement and
> >test the concept than diving straight into kernel code. You don't have
> >to maintain it for very long (if at all) -- just long enough to prove
> >to everyone that this kind of conversion is possible, and that they
> >should help you roll it into the kernel.
> >
> 
> I can't code it.  I want to, it'd be FUN, but I can't.

   This, I think, is your problem. IIRC, you had the same problem last
time you posted an idea to LKML. It's like novelists -- come up with a
good idea for a story, and approach a novelist with it: "Hey! I've got
this great idea for a story!". They will tell you exactly where to
stick your great idea. Their problem is not a lack of ideas, it's a
lack of time in which to implement all of their ideas. For example,
I've got enough ideas right now for bits of code and research that I
want to write that I could probably work full-time for at least 10
years to implement just the ones I have _now_. Effectively, what
you're asking these people to do is to do all of the work, and give
you some of the credit for having the idea.

   Start with the easy bits: make a list of _every_ piece of metadata
that can be stored by an ext2 filesystem. Do the same for ReiserFS.
Work out how one maps to the other. Write a C/C++ struct to contain
that metadata. Work out how you're going to store your metadata nodes
on-disk. Those are the easy bits.

   Then it gets harder: see if you can get the documentation for the
on-disk format of ext2. I don't believe that it's _stunningly_
complicated, at least in its basics. If ext2 turns out to be too
complicated, try FAT32 (or even FAT16!). Write a piece of (userspace)
code which can read that format (or take it from either the kernel or
e2fsck) and which converts to your own format. Write another piece of
code which converts back (to ext2). Try it on a small ext2 loopback
device -- copy all the data on the "device" to a file somewhere else,
and then try to create another ext2 FS from your metadata.

   Fix bugs, and repeat for ReiserFS.

   By this point, you will know how ext2 and Reiser really work. Then
you can start considering how to manage your metadata objects inside a
partly-converted filesystem. Work out how to do that, and implement it
(still in user-space). At that point, you can take it back to LKML,
and say: "here's some code which I think will work". They will
probably tear it to bits, and find loads of holes. This is good -- it
probably means that someone's found it worthwhile enough to help you
with it. At this point, if it works, things may snowball, although
you'll still end up doing most of the work.

   Personally, I think you're doomed, and I think you're probably
terminally doomed at the managing-the-atoms-in-the-filesystem bit,
just because by its very nature an atom is going to take up much more
space than the equivalent metadata in any given filesystem.

> >> I've beaten the O((FS_COUNT)^2) already.  And by the way, it's
> >> O((FS_COUNT)*(FS_COUNT - 1_).  There's exactly O(2*FS_COUNT)
> >> and o(2*FS_COUNT) sets of code needed total to be able to convert
> >> between any two filesystems.
> >
> >   There's no such thing as O(x*(x-1)). This is precisely O(x^2).
> >Similarly, O(2*x) is precisely the same as O(x). If you're going to
> >try to use mathematics to demonstrate your point, please at least make
> >sure that you're using it _right_.
> >
> 
> Big O notation is inappropriate here because it measures time complexity;
> however, I was following Viro's lead.  We're using it to measure code
> complexity, sorry.

   Just to put the record straight, computer scientists normally use
O-notation to describe time complexity. However, it's a general
notation for describing functions qualitatively, and could be used in
any context (growth of time, growth of code, growth of data, w.r.t.
some input parameter(s)). I've used O-notation for talking both about
data size and simply about arbitrary functions (when you expand a
polynomial series, you tend to write "... + O(e^3)", or whatever, at
the end of the useful expansion of the series, to indicate that it
keeps going).

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
     --- For months now, we have been making triumphant retreats ---     
               before a demoralised enemy who is advancing               
                           in utter disorder.                            

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/1wTssJ7whwzWGARArWTAJ4vHR2U/lrV74CSWqBe4B0jLMotUQCfal6b
kd8BMIpmvhi4Szc2GOfSL5c=
=WGqO
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
