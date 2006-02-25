Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWBYFQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWBYFQj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 00:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWBYFQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 00:16:39 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:59100 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030183AbWBYFQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 00:16:38 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 25 Feb 2006 15:13:36 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602251026.21441.ncunningham@cyclades.com> <200602250156.49228.rjw@sisk.pl>
In-Reply-To: <200602250156.49228.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6919104.U6oMLIceWs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602251513.41697.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6919104.U6oMLIceWs
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 25 February 2006 10:56, Rafael J. Wysocki wrote:
> On Saturday 25 February 2006 01:26, Nigel Cunningham wrote:
> > On Saturday 25 February 2006 10:20, Rafael J. Wysocki wrote:
> > > On Saturday 25 February 2006 00:11, Nigel Cunningham wrote:
> > > > On Saturday 25 February 2006 06:22, Rafael J. Wysocki wrote:
> > > > > On Friday 24 February 2006 14:12, Pavel Machek wrote:
> > > > > > On P=C3=A1 24-02-06 11:58:07, Rafael J. Wysocki wrote:
> > >
> > > }-- snip --{
> > >
> > > > > > > Well, if all of the pages that Nigel saves before snapshot are
> > > > > > > freeable in theory, there evidently is something wrong with
> > > > > > > freeing in swsusp, as we have a testcase in which the user was
> > > > > > > unable to suspend with swsusp due to the lack of memory and
> > > > > > > could suspend with suspend2.
> > > > > > >
> > > > > > > However, the only thing in swsusp_shrink_memory() that may be
> > > > > > > wrong is we return -ENOMEM as soon as shrink_all_memory()
> > > > > > > returns 0. Namely, if shrink_all_memory() can return 0
> > > > > > > prematurely (ie. "there still are some freeable pages, but th=
ey
> > > > > > > could not be freed in _this_ call"), we should continue until
> > > > > > > it returns 0 twice in a row (or something like that).  If this
> > > > > > > doesn't help, we'll have to fix shrink_all_memory() I'm afrai=
d.
> > > > > >
> > > > > > I did try shrink_all_memory() five times, with .5 second delay
> > > > > > between them, and it freed more memory at later tries.
> > > > >
> > > > > I wonder if the delays are essential or if so, whether they may be
> > > > > shorter than .5 sec.
> > > > >
> > > > > > Sometimes it even freed 0 pages at the first try.
> > > > > >
> > > > > > I did not push the patch because
> > > > > >
> > > > > > 1) it was way too ugly
> > > > >
> > > > > I think I can do something like that in swsusp_shrink_memory() and
> > > > > it won't be very ugly.
> > > > >
> > > > > > 2) shrink_all_memory() should be fixed. It should not really
> > > > > > return if there are more pages freeable.
> > > > >
> > > > > Well, that would be a long-run solution.  However, until it's fix=
ed
> > > > > we can use a workaround IMHO. ;-)
> > > >
> > > > Isn't trying to free as much memory as you can the wrong solution
> > > > anyway?
> > >
> > > No, it isn't.  There are situations in which we would like to suspend
> > > "whatever it takes" and then we should be able to free as much memory
> > > as _really_ possible.
> > >
> > > Besides, it is supposed to work, and it doesn't, so it needs fixing.
> > >
> > > > I mean, that only means that the poor system has more pages to fault
> > > > back in at resume time, before the user can even begin to think abo=
ut
> > > > doing anything useful.
> > >
> > > Well, that's not the only possibility.  After we fix the memory freei=
ng
> > > issue we can use the observation that page cache pages need not be
> > > saved to disk during suspend, because they already are in a storage.=
=20
> > > We only need to create a map of these pages during suspend with the
> > > information on where to get them from and prefetch them into memory
> > > during resume independently of the page fault mechanism.
> > >
> > > This way we won't have to actually save anything before we snapshot t=
he
> > > system and the system should be reasonably responsive after resume.
> >
> > But this is going to be much more complicated than simply saving the
> > pages in the first place. You'll need some mechanism for figuring out
> > what pages to get, how to fault them in, etc.
>
> Yes, this is going to be quite difficult indeed.  Still there's a price f=
or
> saving the pages and I'd like to avoid paying it. ;-)
>
> > In addition, it will be much slower than simply reading them back from
> > (ideally) contiguous storage.
>
> Not necessarily.  These pages may come from contiguous storage areas as
> well.

Oh well, I suppose we can compare once you've spent the time implementing i=
t.

Regards,

Nigel

--nextPart6919104.U6oMLIceWs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/+eFN0y+n1M3mo0RAoZKAKDmhszwWaUmJIOcgdv/BvY8Ec2CjgCfUjlK
piy019AfRNp7AGYDVDMdT94=
=/TIs
-----END PGP SIGNATURE-----

--nextPart6919104.U6oMLIceWs--
