Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWEKXp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWEKXp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 19:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWEKXp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 19:45:59 -0400
Received: from CPE-60-226-94-173.qld.bigpond.net.au ([60.226.94.173]:53416
	"EHLO cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750830AbWEKXp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 19:45:58 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Date: Fri, 12 May 2006 09:45:48 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, pavel@suse.cz
References: <200605021200.37424.rjw@sisk.pl> <200605111011.23508.ncunningham@cyclades.com> <200605111520.30203.rjw@sisk.pl>
In-Reply-To: <200605111520.30203.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2002730.hYDo8NaVe8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605120945.52477.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2002730.hYDo8NaVe8
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello.

On Thursday 11 May 2006 23:20, Rafael J. Wysocki wrote:
> Hi,
>
> On Thursday 11 May 2006 02:11, Nigel Cunningham wrote:
> > Hi Andrew et al.
> >
> > On Thursday 11 May 2006 09:38, Andrew Morton wrote:
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > On Wednesday 10 May 2006 00:27, Andrew Morton wrote:
> > > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > > Now if the mapped pages that are not mapped by the
> > > > > >  current task are considered, it turns out that they would chan=
ge
> > > > > > only if they were reclaimed by try_to_free_pages(). =C2=A0Thus =
if we
> > > > > > take them out of reach of try_to_free_pages(), for example by
> > > > > > (temporarily) moving them out of their respective LRU lists aft=
er
> > > > > > creating the image, we will be able to include them in the image
> > > > > > without copying.
> > > > >
> > > > > I'm a bit curious about how this is true.  There are all sorts of
> > > > > way in which there could be activity against these pages -
> > > > > interrupt-time asynchronous network Tx completion, async
> > > > > interrupt-time direct-io completion, tasklets, schedule_work(),
> > > > > etc, etc.
> > > >
> > > > AFAIK, many of these things are waited for uninterruptibly, and
> > > > uninterruptible tasks cannot be frozen.
> > >
> > > There can be situations where we won't be waiting on this IO at all.
> > > Network zero-copy transmit, for example.
> > >
> > > Or maybe there's some async writeback going on against pagecache -
> > > we'll end up looking at the page's LRU state within interrupt context
> > > at IO completion.  (A sync would prevent this from happening).
> >
> > I believe more than a sync is needed in at least some cases. I've seen
> > XFS continue to submit I/O (presumably on the sb or such like) after
> > everything else has been frozen and data has been synced. Freezing bdevs
> > addressed this.
> >
> > > One possibly problematic scenario is where task A is doing a direct-IO
> > > read and task B truncates the same file - here, the page will be
> > > actually removed from the LRU and freed in interrupt context.  The
> > > direct-IO read process will be waiting on the IO in D state though.  =
It
> > > it was a synchronous read - if it was an AIO read then it won't be
> > > waiting on the IO.  Something else might save us here, but it's
> > > fragile.
> >
> > Bdev freezing helps here too, right?
>
> Well, I'm not sure.  How exactly?

I believe it will ensure that both operations will be completed and the wai=
ter=20
woken.

> > > >  Theoretically we may have a problem if there's an
> > > > interruptible task that waits for the completion of an operation th=
at
> > > > gets finished after snapshotting the system.  However that would ha=
ve
> > > > to survive the syncing of filesystems, freezing of kernel threads,
> > > > freeing of memory as well as suspending and resuming all devices.=20
> > > > [In which case it would be starving to death. :-)]
> >
> > (For Rafael/Pavel): The swsusp version of the refrigerator signals these
> > processes to enter the freezer too, just in case the uninterruptible ta=
sk
> > does continue, right?
>
> Uninterruptible tasks are not freezable with the swsusp's freezer at all.
> The other tasks are signaled to enter the refrigerator - first user space,
> then we sync filesystems and finally we freeze kernel threads.

Oooh. It would probably be good if you signalled them to enter the freezer,=
=20
just in case, and had the freezer code handle a process entering the path=20
when we no longer want to freeze.

Regards,

Nigel

--nextPart2002730.hYDo8NaVe8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEY8ywN0y+n1M3mo0RAjcZAKCN0l3TipHwxOsedziKRU/U8GvWRgCeP0Md
hT6akFcOiIyFFPfBIt5PjZs=
=IjEU
-----END PGP SIGNATURE-----

--nextPart2002730.hYDo8NaVe8--
