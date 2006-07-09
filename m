Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbWGIT0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWGIT0W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWGIT0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:26:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:41297 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161063AbWGIT0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:26:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cnZWlnTZx2q7vPu5VdgWqm7IdJh76Pr6L3Aa0JQV0FakMf6Vo2FHrv4NFMQyBQBBi1ZstyJgA1qVvJD9yG7e1GDrlHXWV88tucAcTYf2L6f1sFZfdeDA+6VLQWJ3VeMwaZOroCTWjnGXZZrJUWBC6grhWOrdrYniRy2IHWsFaCw=
Message-ID: <787b0d920607091226sb1db56dg9c0267f6ae8e2dc7@mail.gmail.com>
Date: Sun, 9 Jul 2006 15:26:19 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: ray-gmail@madrabbit.org
Subject: Re: Opinions on removing /proc/tty?
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Greg KH" <greg@kroah.com>,
       rmk+lkml@arm.linux.org.uk, alan@lxorguk.ukuu.org.uk, efault@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>
	 <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com>
	 <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com>
	 <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Ray Lee <madrabbit@gmail.com> wrote:
> On 7/9/06, Albert Cahalan <acahalan@gmail.com> wrote:
> > In any case, I'm NOT running a udevinfo program or linking
> > to a screwball library. Random failures are not OK.
>
> Complete agreement, but it seems like there's a third option here.
> We're talking about nothing more complicated than a table lookup here.
> Having a `udevinfo` invocation would indeed be overkill (and slower
> than just stating the entire /dev hierarchy, I'm sure), but
> Greg's/Jon's point that udev is the original authoritative source of
> the data remains.
>
> A simple solution would be for udev to just maintain a list in a flat
> file (e.g., /dev/.mappings) that could be read (very quickly) by ps
> upon startup. This could be yet another strategy somewhere in your
> list of heroic efforts to derive a /dev/ node :-).
>
> Having anyone other than udev try to maintain that mappings cache file
> is doomed to failure, as you already noted.

BSD just uses devname(3) in libc, which asks the kernel via
the kern.devname sysctl. So, /proc/sys/kern/devname for us.
This is essentially what /proc/tty/drivers is today, except
that FreeBSD standardized on a fully functional devfs.

Solaris uses _ttyname_dev(dev_t,buf,bufsize), also in libc.
This is horribly slow, involving a recursive search of
directories listed in the /etc/ttysrch file. The interface
is nice though. You get: ttyname, ttyname_r, _ttyname_dev.

Note that our glibc is often defective, not always upgraded,
and not even the only C library. I won't be relying on it
even if _ttyname_dev() or devname() gets implemented.

If you insist on bringing back the dead though...

I already have code, probably written in 1996 by Charles Blake.
Use /etc/psdevtab for the filename.

File format:

There are 16 tty major numbers (as of the Linux 1.1 kernel,
or thereabouts) with 256 minors each, and the names are 8
characters long. That makes for a 32 KiB file; procps will
verify the length. Major numbers are to be stored in the
following order:

2,3,4,5,19,20,22,23,24,25,32,33,46,47,48,49

The structure is thus like this:

char psdevtab[16][256][8]

Names should be zero-padded, not zero-terminated.

(seriously, a binary file with a tree structure is best)
