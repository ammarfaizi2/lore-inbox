Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271896AbRIIHfD>; Sun, 9 Sep 2001 03:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271897AbRIIHex>; Sun, 9 Sep 2001 03:34:53 -0400
Received: from dialup173.canberra.net.au ([203.33.188.45]:772 "EHLO
	didi.local.net") by vger.kernel.org with ESMTP id <S271896AbRIIHee>;
	Sun, 9 Sep 2001 03:34:34 -0400
Message-ID: <003301c138eb$3892cf60$0200a8c0@W2K>
From: "Nick Piggin" <s3293115@student.anu.edu.au>
To: "Linus Torvalds" <torvalds@transmeta.com>,
        "Linux-Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <200109081850.f88Io0L01074@penguin.transmeta.com>
Subject: Re: 2.4.10-pre5: Bug in alloc_pages
Date: Sun, 9 Sep 2001 14:52:23 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you have come up with the cause of this problem - pre6 seems to be
stable. Anyway if you still want this information, it _is_ repeatable under
pre5 and I have not seen it no any other kernel. pre5 oopsed everytime I
booted it (mostly when starting squid), and basically ran some chance of
oopsing everytime something memory intensive was run eg. gcc.

It didn't seem to make any difference when swap was on or off. I tested this
because I saw about 10 similar messages about bad swap pages (corrupted,
invalid, not found, I can't remember) while booting pre5 the first time,
however they ran off the console and the system Oopsed then froze before I
could record them unfortunately.

The 5 oopses I sent happened over about 15 minutes, however I think the
frequency of them would be very dependant on vm pressure.

Nick

----- Original Message -----
From: "Linus Torvalds" <torvalds@transmeta.com>
Newsgroups: linux.dev.kernel
To: <s3293115@student.anu.edu.au>; "Hugh Dickins" <hugh@veritas.com>;
"Alexander Viro" <viro@math.psu.edu>
Sent: Sunday, September 09, 2001 4:50 AM
Subject: Re: 2.4.10-pre5: Bug in alloc_pages


> [ Background for Al Viro: there's an oops in at least 2.4.10-pre5 that
>   triggers in mm/page_alloc.c, line 204 - which implies that we are
>   trying to allocate a page off the free list that is already on one of
>   the page lists. Which implies rather serious MM corruption ]
>
> In article <000701c13856$14e01fe0$0200a8c0@W2K> you write:
> >Here are a few Oopses which appeared in 2.4.10-pre5 (not in pre4). The
first
> >2 appeared during the startup scripts and the next ones appeared over the
> >next 20 minutes or so. I'd be happy to try patches. Please CC me.
>
> Nick, can you do some more debugging for me? The bug is definitely real,
> there's no question about it - I have now seen it myself, but I don't
> seem to be able to reproduce it on my machines. It seems to happen quite
> early for you..
>
> What I'd ask you to do is:
>
>  - can you verify that it is repeatable under pre5? Does it happen every
>    time, or at least easy to trigger?
>
>  - can you try to trigger it some more under pre4? In particular, pre5
>    doesn't actually have any MM changes _at_all_, which makes me suspect
>    that maybe something in pre5 just made it easier to trigger. This is
>    also why I'd like to hear whether it is really repeatable in pre5: if
>    it's not repeatable in pre5, maybe you ran pre4 for a longish time
>    and just didn't happen to hit it..
>
> I know that the above kind of testing is rather nasty and boring
> (especially as you'd end up having to reboot multiple times), but it
> would really help.. Thanks.
>
> If it really happens only under pre5, and never under pre4, then that is
> very interesting indeed.  As mentioned, the pre4->pre5 thing doesn't
> actually change any of the VM code itself, so then there's something
> else going on. The only thing I can imagine right now is:
>
>  - the initbootdata handling changed a bit. Does the problem go away if
>    you copy 'arch/i386/kernel/setup.c' from pre4 into the pre5 tree?
>
>  - Al Viro's FS-layer changes somehow trigger this bug, possibly by
>    freeing some inode early. I don't have any real reason to suspect the
>    FS changes, except for the fact that with no MM changes, the FS is
>    the only other thing that has changed and is fairly intimate with MM
>    stuff.
>
> Most of the pre4->pre5 changes are in fact things that I know cannot
> matter, simply because I don't even have them compiled into my kernels.
> Things like bluetooth, ARM, sparc, minix, telephony, framebuffer etc.
> This is why it would be so interesting to make sure that it really _is_
> pre5 only, and never happens in pre4..
>
> Hugh, if it turns out to be possible to trigger on pre4 too, I'm still
> going to blame your swap changes. So please give them a double look just
> in case..
>
> Nick, I don't have any real patches for you to test yet (except the
> suggestion to reverse i386/kernel/setup.c if you can't re-create it on
> pre4), but I'd be very grateful for as much information as you can
> possibly gather.. Things like patterns to how the oopses happen etc.
>
> Thanks,
> Linus
>

