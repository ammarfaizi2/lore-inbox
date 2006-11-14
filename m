Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966359AbWKNVND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966359AbWKNVND (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966361AbWKNVND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:13:03 -0500
Received: from mx27.mail.ru ([194.67.23.64]:54820 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S966359AbWKNVNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:13:00 -0500
X-Nat-Received: from [10.10.231.1]:2526 [ident-empty]
	by rt-fiord1.z-net.ru with TPROXY id 1163535220.2644
	abuse-to abuse@ss-lan.ru
Date: Wed, 15 Nov 2006 01:15:51 +0300
From: Anton Vorontsov <cbou@mail.ru>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       rpurdie@rpsys.net
Subject: Re: [ARM] Corrupted .got section with 2.6.18 and JFFS2 (solved)
Message-ID: <20061114221551.GA17042@localhost>
Reply-To: cbou@mail.ru
References: <ly1wozcr1d.fsf@ensc-pc.intern.sigma-chemnitz.de> <ly64dyt7de.fsf@ensc-pc.intern.sigma-chemnitz.de> <1162497112.12781.51.camel@localhost.localdomain> <lywt6cc04g.fsf_-_@ensc-pc.intern.sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <lywt6cc04g.fsf_-_@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Nov 03, 2006 at 11:09:35AM +0100, Enrico Scholz wrote:
> [CC lkml; original issue at
>  http://article.gmane.org/gmane.linux.ports.arm.kernel/28068]
> 
> rpurdie@rpsys.net (Richard Purdie) writes:
> 
> >> > I have a problem with JFFS2 filesystem and kernel 2.6.18. When
> >> > starting a program which uses a certain library (libutil.so.1 in
> >> > my case), the .got section of the library can be initialized
> >> > wrongly when the used memory is uninitialized.
> >> 
> >> Problem seems to be caused by
> >> 
> >> | [PATCH] zlib_inflate: Upgrade library code to a recent version
> >> 
> >> (4f3865fb57a04db7cca068fed1c15badc064a302)
> >> 
> >> After reverting this (and related patches), things seem to work.
> >> 
> >> I don't have an idea yet, which changes in this complex patch are
> >> really responsible....
> >
> > I'm the author of the above change. I just ran your test program
> > on a device (ARM PXA255 with 2.6.19-rc4 kernel, 2.3.5ish glibc,
> > gcc 3.4.4, libraries on jffs2) and I can't reproduce the
> > problem.
> 
> I can reproduce it 100% with:

As I told before (but it's not delivered to the arm-linux-kernel), I
can reproduce it too, using glibc-2.4 or glibc-2.5. I can't reproduce
it using glibc-2.3.5.

My further investigations shows that reading libutil.so.1
(cat /lib/libutil.so.1 > /dev/null) prior using it eliminates
segfault. That, I suppose, means that glibc can easily operate on 
cached file, but refuses to initially ""read"" it from disk properly.

Quoting Richard Purdie:

"The file is read ok from the disk when copying and when read with
md5sum. I therefore wonder if the dynamic linker is doing something it
shouldn't."

Though, it may be either glibc or JFFS2 issue. As for glibc, it's not
using read() call as do cat, cp or md5sum, glibc using readonly
mmap call (which is supported by JFFS2 if I understood code correctly)
on libraries ld-linux wants to load.


I hope these itinerary of mine will bring some light on that issue, and
someone will guess where real bug is. ;-)

> 
> Enrico

-- Anton (irc: bd2)
