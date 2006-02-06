Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWBFMQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWBFMQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 07:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWBFMQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 07:16:56 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:61854 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751042AbWBFMQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 07:16:55 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 6 Feb 2006 22:13:20 +1000
User-Agent: KMail/1.9.1
Cc: Rafael Wysocki <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602061402.54486.nigel@suspend2.net> <20060206105954.GD3967@elf.ucw.cz>
In-Reply-To: <20060206105954.GD3967@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12665027.0LF5A1vz2c";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602062213.24735.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12665027.0LF5A1vz2c
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 06 February 2006 20:59, Pavel Machek wrote:
> Hi!
>
> [Head straight down for j. if you hate long mails.]
>
> > > Complexity in userspace: ungood.
> > >
> > > Complexity in kernel: doubleplusungood.
> > >
> > > It is not that hard to understand :-).
> >
> > Heh. you'll soon be submitting patches to move interrupt handling and
> > scheduling to userspace then?
>
> If I figure out how to do that with equivalent performance and without
> excessive uglyness... yes.
>
> [This has hidden assumption that we want to include *all* the features
> suspend2 has. We could do it... but we probably do not want to.]

Not hidden - I said I didn't expect you'd do most of the Suspend2 stuff,=20
but was trying to compare apples with apples to make the comparison fair.

> > a. Freezing processes, freeing memory and preparing the image.
>
> ...
>
> > Freeing memory and preparing the image is significantly simpler for
> > swsusp at the moment because it doesn't support swap files, and
> > doesn't
>
> I do not see why I'd have to modify freezer for supporting swap
> files. It is really unrelated part. If I want to support swap files,
> I'll just bmap() them from userspace, then write to blockdevice
> directly, like lilo or grub does.

It would be needed because they're on filesystems. Freezing the=20
filesystems, then trying to eat memory to the degree that the system tries=
=20
to swap would lead to a deadlock if that swap was on a frozen filesystem.=20
Conversely, trying to freeze the memory before freezing processes would be=
=20
unreliable because it relies on not racing against other processes trying=20
to work.

> b. missing?

Sorry.

> > c. Compression and encryption.
>
> ...
>
> > libraries or using cryptoapi functions via ioctls or such like. Making
> > such support optional and configurable would require further
> > modification. Using userspace libraries for compression and encryption
> > would increase the complexity of configuring uswsusp for a developer
> > (extra packages to download/configure/install), and create greater
> > potential for support issues for developers and distributions (uswusp
> > gets blamed for any problems in those libraries but can't do anything
> > to fix them!).
>
> Yes, that is how libraries work. Any userland application has these
> "problems". uswsusp is clearly better here.

How so? For Suspend2, we just use existing cryptoapi modules without any=20
requirement for particular libraries or such like.

> > d. Storage of the image.
> >
> > As it currently stands, the interface between userspace and the kernel
> > for uswsusp looks clean and simple. This is mainly, however, because
> > it only supports writing to swap, and strictly synchronously.
>
> ...and it is going to stay that way.

No plans for writing to anywhere else but swap?

> > If you were going to match the functionality in suspend2, you would be
> > looking at adding support for (a) asynchronous I/O, (b) for ordinary
> > files, (c) for multiple swap devices (d) for swapfiles and (e) for the
> > varying blocksizes of filesystems. I assume uswsusp won't currently
> > work with swapfiles (as opposed to swap partitions) as it stands
> > because I see a check for !S_ISBLK(resume_device) in suspend.c::main.
>
> (a) Reading image from kernel is memory-to-memory transfer --
> i.e. extremely fast. There's nothing to be gained by asynchronous
> I/O. (Write to disk can still be done asynchronous, kernel has
> interfaces to do that). (b) is going to be solved by bmap. Maybe I'll
> need some small changes for (c) and (d); don't see why (e) applies to
> me.

By I/O, I didn't mean the transfers between userspace and the kernel, but=20
I/O - ie writing pages to disk (or whatever).

> > userspace for getting the sector numbers of storage. Finally, you'd
> > want to use bio functions to submit the I/O, and a kernel routine to
> > handle the completion. Then you'd need some mechanism to wait for or
> > check for completion of I/O on a particular page or all pages. Of
> > course you might decide not to do async I/O because it's too complex,
> > but then you'd take the performance hit you currently have, and we
> > wouldn't have an apples with apples comparison.
>
> Submit bios from userspace? Eeek? We have perfectly working async io

Yes. But then how do you submit I/O to files on filesystems you can't=20
mount? You're stuck with swap partitions only forever?

> interface for userland, and BTW going async will not give you too much
> of performance advantage here...

How do you know that? Suspend2 has async I/O, and can write the image as=20
fast as the drive can take it. Some testing I did a while ago showed a max=
=20
throughput of 16MB/s for swsusp vs 35 (what the drive is capable of) for=20
Suspend2. Add LZF compression and it's 70MB/s vs 16MB/s.

> > e. Atomic copy/restore.
> >
> > This is currently achieved in kernelspace, as it is for Suspend2. It
> > would seem to be extremely unlikely that this could be implemented in
> > userspace.
>
> No, this stays in kernel.
>
> > f. User tuning and configuration.
>
> ...
>
> > Suspend2 offers far more support for tuning and configuration via a
> > proc interface. Suspend2 implements an additional layer on top of the
> > base proc routines, which might be useful elsewhere in the kernel.
> > This layer allows additional entries to be created at very little
> > cost, and avoid duplicating code for each entry. This is an area of
> > additional complexity that Suspend2 has at the moment, but similar
> > additions would be helpful in the userspace program for the same
> > reasons.
>
> uswsusp wins here -- at least it does the config stuff in userspace.

The difference is really only in how the support is exported (ioctl vs=20
proc).

> > g. Writing a full image of memory.
> >
> > Not possible in uswsusp right now. If the algorithm of Suspend2 was
> > used (wherein LRU pages are saved separately), support would need to
> > be added for marking which LRU pages should be in the atomic copy
> > (because they belong to the freezing process), and for reading and
> > writing the sets of pages separately.
>
> I'm not sure if we want to save full image of memory. Saving most-used
> caches only seems to work fairly well.

You're certainly doing a lot better than when you were eating everything=20
you could. But whether 1/2 is adequate depends on the mix of applications=20
and ultimately the user's requirements.

> > h. Powering down.
> >
> > uswsusp currently supports using the sys_reboot restart and power off
> > functions. There is no support for entering the ACPI S4 state, or for
> > suspending-to-ram instead of powering off. Adding these would require
> > additional ioctls and kernelspace functions, and the capability of
> > configuring which powerdown method to use.
>
> Yes, we'll need ioctls to enter S3 and S4.

Shouldn't be hard at all, either, of course.

> Do you actually support suspend-to-ram at end of suspend2? That is one
> feature I'd like to play with.

Yes (provided that S3 works on your machine normally).

> > i. Status display.
>
> ...
>
> > is required when updating the kernel). It has also created additional
> > complexity in that the code for doing the userui in the kernel didn't
> > really go away - it was just replaced by code to communicate with
> > userspace and get it to do the work. On the positive side, though,
>
> As we do image writing in userspace, anyway, it does not mean
> aditional interface to userspace for us.

But you don't. Doing image writing in userspace would involve having IDE=20
drivers etc in userspace. You're copying the snapshot to userspace, then=20
sending it straight back to the kernel one page at a time. I haven't=20
looked again while writing this, but I wonder if userspace even knows=20
exactly where the image is being stored.

> > j. Summary.
> >
> > At their cores, Suspend2 and uswsusp work in basically the same
>
> Yes, basically. They'll be similar complexity in the end, differing
> very much where the complexity is.
>
> Currently suspend2 is 14K lines of code in kernel. Not sure how much
> in userspace.

I just did wc -l on the userui svn repository *.[ch] files. I think=20
(Bernard's the expert) that this includes source for the text mode,=20
fbsplash and experimental animation uis. It looks like the text and=20
fbsplash onces are about 1k each and the animation one is larger, but I'm=20
not sure.

> Current uswsusp is 3K lines of code in kernel, 1K lines of code in
> userspace.
>
> When we are done, we'll have perhaps 2.5K lines of code in kernel
> (in-kernel swap writing support goes away), and maybe 20K lines in
> userspace.

Without adding which out of async I/O, compression, encryption, swap file=20
support, and ordinary file support?

> That may not seem like a big difference to you, but it really is. It
> keeps complexity out-of-kernel.
>
> > It seems most likely that uswsusp would never match the current
> > Suspend2 in terms of functionality, or would take a very long time to
> > get there. Support for implementing a full image of memory will likely
> > never happen, and asynchronous I/O would be unlikely too. If the
> > flexibility in how to compress/encrypt and write the image that
> > Suspend2 currently has were to be implemented in uswsusp, it would
> > require a modular architecture along the lines of the one that has
> > been rejected in the Modules support thread.
>
> It was rejected *for kernel*. Putting it in userspace is okay.

:)

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart12665027.0LF5A1vz2c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5z1kN0y+n1M3mo0RAkC8AKD0fQo8IhrSmaM1KlXI/Gsf41YyFACg6Xqy
uyEhkWctSnewVj1T/awMfMc=
=bvi2
-----END PGP SIGNATURE-----

--nextPart12665027.0LF5A1vz2c--
