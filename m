Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129145AbQKXMnC>; Fri, 24 Nov 2000 07:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKXMmx>; Fri, 24 Nov 2000 07:42:53 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:13063 "HELO
        dfmail.f-secure.com") by vger.kernel.org with SMTP
        id <S129145AbQKXMmh>; Fri, 24 Nov 2000 07:42:37 -0500
Date: Fri, 24 Nov 2000 13:23:40 +0100 (MET)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Pavel Machek <pavel@suse.cz>
cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] Reserved root VM + OOM killer
In-Reply-To: <20001123014206.D96@toy>
Message-ID: <Pine.LNX.4.30.0011241145200.12335-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Nov 2000, Pavel Machek wrote:

> > HOW?
> > No performance loss, RAM is always fully utilized (except if no swap),
>
> Handheld machines never have any swap, and alwys have little RAM [trust me,
> velo1 I'm writing this on is so tuned that 100KB les and machine is useless].
>  Unless reservation  can be turned off, it is not acceptable. Okay, it can
> be tuned. Ok, then.
>
> [What about making default reserved space 10% of *swap* size?]

No. Many people uses no swap even if they have plenty of RAM. I wasn't
right when I wrote the "reserved" VM is on swap or in buffer/page
cache. I wanted to write the reserved VM is unused swap and/or it is
*used* as buffer/page cache until it's not needed by root. Left away
swap from the former sentence and you get no RAM is wasted at all ;)

Moreover the default value for boxes with less than 8MB is 0 pages (I
thought about "embedded" systems), it's 5 MB if the box has more then
100MB and 5% of the RAM but after considered it as part of the VM
between 8MB and 100MB. I found in my setup, at least 4 MB needed to be
useful if root wants to act sure. Of course this can be different in
other setups and application behaviours -- this is why it can be tuned
runtime. Using more "reserved" [this is really a stupid and not
accurate name] VM definitely helps :) BTW, apparently Solaris reserves
4 MB for root.

I also thought about making it a compile time option [for people using
Linux as embedded systmes] in that case you would have less than 25%
chance to save one page -- I would instead optimize the compiler ;)
.... but maybe embedded systems use non-overcomittable memory
handling, I didn't look how they handle OOM.

I'm afraid I was also wrong about performance, here is a typical case
how standard 2.2 kernel works if OOM happens: killing gpm, vmstat,
syslogd, tail, httpd, zsh, identd, httpd, klogd, httpd, httpd, httpd
[the main httpd, web is dead], bad_app. If there is more bad_app
[working on the same problem but e.g. they were feeded by wrong input,
etc], then you have the big chance you must hit the reset button. With
Rik's OOM killer, the "right" processes are killed but I found the
system trashes too long and because of the constant memory pressure
you still must hit the reset button. With my patch + fixes of Rik's
OOM killer, the "right"  processes are killed fast [it's done only in
page fault, contrary to 2.4.0-test11 that has two OOM killer: one in
page fault and Rik's one ... pretty ugly] and you can do whatever you
want as root. It would be nice to see which one of the three cases
would finish a job first where multiply processes [not threads] work
on the same job saving the partial results and constantly producing
OOM.

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
