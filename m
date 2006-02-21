Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbWBUEtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWBUEtI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 23:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWBUEtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 23:49:08 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:22165 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932705AbWBUEtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 23:49:06 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Andy Lutomirski <luto@myrealbox.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 21 Feb 2006 14:45:59 +1000
User-Agent: KMail/1.9.1
Cc: Matthias Hensler <matthias@wspse.de>,
       kernel list <linux-kernel@vger.kernel.org>,
       Sebastian Kgler <sebas@kde.org>, rjw@sisk.pl, pavel@ucw.cz
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220094728.GD19293@kobayashi-maru.wspse.de> <43FA97D9.4070902@myrealbox.com>
In-Reply-To: <43FA97D9.4070902@myrealbox.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1238552.qOFPz56le9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602211446.04123.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1238552.qOFPz56le9
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andy.

On Tuesday 21 February 2006 14:32, Andy Lutomirski wrote:
> Matthias Hensler wrote:
> > Hi.
> >
> > On Mon, Feb 20, 2006 at 01:53:33AM +0100, Pavel Machek wrote:
> >>Only feature I can't do is "save whole pagecache"... and 14000 lines
> >>of code for _that_ is a bit too much. I could probably patch my kernel
> >>to dump pagecache to userspace, but I do not think it is worth the
> >>effort.
> >
> > I do not think that Suspend 2 needs 14000 lines for that, the core is
> > much smaller. But besides, _not_ saving the pagecache is a really _bad_
> > idea. I expect to have my system back after resume, in the same state I
> > had left it prior to suspend. I really do not like it how it is done by
> > Windows, it is just ugly to have a slowly responding system after
> > resume, because all caches and buffers are gone.
> >
> > I can only speak for myself, but I want to work with my system from the
> > moment my desktop is back.
>
> I Am Not A VM Hacker, but:
>
> What's the point of saving pagecache during suspend?  This seems like a
> total waste.  Why don't we save a list of pages in pagecache to disk,
> then, after resume, prefetch them all back in.  This will slow down
> resume (extra seeks, minimized if we sort the list, and inability
> to compress these pages), but it will speed up suspend, and it sounds
> a lot simpler.  There's already a patch to add swap prefetching, and
> this can't be much more complicated.

The page cache contains the process pages, among other things, so it can't =
all=20
be discarded with impunity. You're right in suggesting that discarding them=
=20
and then prefetching them would be a potential alternative, but it would=20
actually be more complicated: you'd still have to remember which pages you=
=20
wanted to fault back in, and some how store that info in the image. You'd=20
also have to add code to do the faulting.  Right now, we don't (for the mos=
t=20
part) care what a page is used for - we just save and reload it. I believe=
=20
both implementations give you the option to set a soft upper limit on the=20
size of the image, so you can still throw away cache if you want to.

> While I'm at it, here's another pie-in-the-sky idea.  If we had the
> ability to unmount an in-use filesystem (that lack is my single biggest
> pet peeve about Linux right now -- Windows has been able to do this for
> ages), then the process could be:
> 1. Atomic snapshot of userspace.  Snapshot all struct file's as well.
> 2. Unmount local filesystems.  Network filesystems probably can't be
> trashed by buggy suspend anyway.
> 3. Snapshot kernelspace.
> 4. Suspend happily without worrying about hosing filesystems, since
> they're all unmounted.
> 5. For extra safety, unmount anything that the suspend process mounted.
>
> -- Shutdown and restart --
>
> 6. Mount stuff and load the image, then unmount it (again using the
> in-use FS unmounting).
> 7. Restore the image and resume kernelspace.
> 8. Remount local filesystems and reattach all the struct files.
> 9. Resume userspace.  Start prefetching everything.
>
> This would seem to allow an ordinary program to handle image writing
> with no particular worries about disk access, except that unlinking
> files might confuse userspace (but not the FS) on resume.
>
> Feel free to tell me why this is impossible.  If no one tells me it's
> impossible, I may work on unmounting in-use filesystems and revoking
> fd's in a month when I have more free time.

It's not quite unmounting, but Suspend2 already freezes bdevs as part of th=
e=20
process of quiescing the system. This was the only way I could find to make=
=20
XFS really complete pending I/O (and stop further submissions).

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1238552.qOFPz56le9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+psMN0y+n1M3mo0RAt8jAKDBF9Ccrk9O6KVhmvBnXCVemAmwFACggsA1
q4gG1f6L6NlOy2IVoIGaeaw=
=2/o8
-----END PGP SIGNATURE-----

--nextPart1238552.qOFPz56le9--
