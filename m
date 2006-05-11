Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWEKALe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWEKALe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 20:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWEKALe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 20:11:34 -0400
Received: from CPE-60-226-94-173.qld.bigpond.net.au ([60.226.94.173]:49373
	"EHLO cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S965085AbWEKALd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 20:11:33 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Date: Thu, 11 May 2006 10:11:18 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, pavel@suse.cz
References: <200605021200.37424.rjw@sisk.pl> <200605110058.19458.rjw@sisk.pl> <20060510163833.586b93ce.akpm@osdl.org>
In-Reply-To: <20060510163833.586b93ce.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1187970.HlQLmAVcs9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605111011.23508.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1187970.HlQLmAVcs9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andrew et al.

On Thursday 11 May 2006 09:38, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > On Wednesday 10 May 2006 00:27, Andrew Morton wrote:
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > Now if the mapped pages that are not mapped by the
> > > >  current task are considered, it turns out that they would change
> > > > only if they were reclaimed by try_to_free_pages(). =A0Thus if we t=
ake
> > > > them out of reach of try_to_free_pages(), for example by
> > > > (temporarily) moving them out of their respective LRU lists after
> > > > creating the image, we will be able to include them in the image
> > > > without copying.
> > >
> > > I'm a bit curious about how this is true.  There are all sorts of way
> > > in which there could be activity against these pages - interrupt-time
> > > asynchronous network Tx completion, async interrupt-time direct-io
> > > completion, tasklets, schedule_work(), etc, etc.
> >
> > AFAIK, many of these things are waited for uninterruptibly, and
> > uninterruptible tasks cannot be frozen.
>
> There can be situations where we won't be waiting on this IO at all.
> Network zero-copy transmit, for example.
>
> Or maybe there's some async writeback going on against pagecache - we'll
> end up looking at the page's LRU state within interrupt context at IO
> completion.  (A sync would prevent this from happening).

I believe more than a sync is needed in at least some cases. I've seen XFS=
=20
continue to submit I/O (presumably on the sb or such like) after everything=
=20
else has been frozen and data has been synced. Freezing bdevs addressed thi=
s.

> One possibly problematic scenario is where task A is doing a direct-IO re=
ad
> and task B truncates the same file - here, the page will be actually
> removed from the LRU and freed in interrupt context.  The direct-IO read
> process will be waiting on the IO in D state though.  It it was a
> synchronous read - if it was an AIO read then it won't be waiting on the
> IO.  Something else might save us here, but it's fragile.

Bdev freezing helps here too, right?

> >  Theoretically we may have a problem if there's an
> > interruptible task that waits for the completion of an operation that
> > gets finished after snapshotting the system.  However that would have to
> > survive the syncing of filesystems, freezing of kernel threads, freeing
> > of memory as well as suspending and resuming all devices.  [In which ca=
se
> > it would be starving to death. :-)]

(For Rafael/Pavel): The swsusp version of the refrigerator signals these=20
processes to enter the freezer too, just in case the uninterruptible task=20
does continue, right?

Regards,

Nigel

> hm.  It's all a bit of a worry.  I don't understand what swsusp is trying
> to do here sufficiently well to be able to advise, sorry.  I was rather
> surprised to learn that it's presently taking copies of all these pages...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--nextPart1187970.HlQLmAVcs9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEYoErN0y+n1M3mo0RAr/kAJwMb6/MsSnAQR2etH64jvYsThEPDgCdGOx2
0HYgsrjDXFG0uDaMJ1R5pMc=
=V1hT
-----END PGP SIGNATURE-----

--nextPart1187970.HlQLmAVcs9--
