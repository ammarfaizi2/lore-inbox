Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286316AbSAAWQq>; Tue, 1 Jan 2002 17:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSAAWQh>; Tue, 1 Jan 2002 17:16:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40210 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285632AbSAAWQ3>; Tue, 1 Jan 2002 17:16:29 -0500
Date: Tue, 1 Jan 2002 14:15:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: NFS "dev_t" issues..
Message-ID: <Pine.LNX.4.33.0201011402560.13397-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I made a pre6, which contains a new-and-anal "kdev_t".

The format of the thing is the same as it used to be, ie 16 bits of
information, but I made it a structure so that you _couldn't_ mix up
"dev_t" and "kdev_t", or use the "kdev_t" as a number (so when kdev_t
expands to 12+20 bits later in 2.5.x you shouldn't get surprises)

I fixed up the stuff I use and which showed up in compiles (on a source
level, it's so far totally untested), but I'd really like people to check
out their own subsystems. _Especially_ NFS and NFSD, which had several
cases of mixing the two dev_t's around, and which also used them as
numbers. Trond, Neil?

Because the types aren't at all compatible any more, the macros that are
used for user-level "dev_t" are no longer working for a kdev_t. So we have

	dev_t			kdev_t

	MKDEV(major,minor)	mk_kdev(major, minor)
	MAJOR(dev)		major(dev)
	MINOR(dev)		minor(dev)
	dev == dev2		kdev_same(dev, dev2)
	!dev			kdev_none(dev)

and _most_ of the time the fixes are trivial - just translate as above. It
only gets interesting when you have code that looks at the value or starts
mixing the two and compares a "dev_t" against a "kdev_t", which can be
quite interesting.

The knfsd file handle thing is also an issue - Neil, please check out that
what I did looks sane, and would be on-the-wire-compatible with the old
behaviour, even when we expand kdev_t to 12+20 bits, ok?

(Marcelo, for easier backporting of drivers to 2.4.x, we'll probably want
to eventually add

	#define mk_kdev(a,b) MKDEV(a,b)
	#define major(d) MAJOR(d)
	...

to the 2.4.x <linux/kdev_t.h> so that you can move drivers back and
forth).

Apart from some knfsd issues, most of the kdev_t users were proper. The
strict type-checking found one bug in the SCSI layer (which I knew about,
and was one of the impetuses for doing it in the first place), and found a
lot of small "works-but-will-break-with-a-bigger-kdev_t" issues).

			Linus

