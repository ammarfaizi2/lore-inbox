Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUBWRcw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 12:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUBWRcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 12:32:52 -0500
Received: from mail.shareable.org ([81.29.64.88]:31618 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261974AbUBWRcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 12:32:10 -0500
Date: Mon, 23 Feb 2004 17:32:04 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040223173204.GA31718@mail.shareable.org>
References: <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220170438.GA19722@elte.hu> <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org> <20040220184822.GA23460@elte.hu> <20040221075853.GA828@elte.hu> <20040223105953.GA2992@openzaurus.ucw.cz> <20040223135520.GA30321@mail.shareable.org> <20040223164529.GA5085@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223164529.GA5085@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> > Another issue is that most machines don't have nanosecond resolution
> > clocks (e.g. m68k is limited to timer interrupt resolution, and some
> > x86 machines cannot use the cycle counter), [...]
> 
> this is not an issue, with the monotonicity solution i suggested: if
> prev_time == curr_time then curr_time.tv_nsec++.

So did you read this paragraph?:

   Important: you *don't* have to delay unless someone has _read_ the
   mtime since the last time it was set, _and_ if the mtime wouldn't be
   changed by the current operation, _and_ if you cannot simply increment
   the low-order bits of mtime due to known limits on the system clock
   resolution.

According to that logic, you are correct that the delay isn't
required, and tv_nsec++ works, except on very fast machines which
don't exist yet, _or_ on highly concurrent machines (maybe the 256-way
NUMA boxes?)

When it's called a "generation counter" or "uniqueness stamp", there
is no problem just changing the number.

When it's called a "timestamp", programs will also compare the
timestamps of _different_ files to see which order they were written.
("make" is the simplest example.)  Therefore it's important to get
this order logically correct.

> > The right place to put the delay is in the kernel, when mtime is set
> > or when it is read, or both.
> 
> no need to delay anything - just do the tv_nsec++ thing!

As you yourself pointed out, that doesn't work on machines in 5 years
time:  Think 40GHz machines and dynamic translation which optimises
fast paths to a few highly concurrent cycles.  Then it's easy to
imagine tv_nsec incrementing multiple times within a nanosecond.

Natural selection isn't the problem: programs assuming it is logically
dependable and returning erroneous results is the problem.

There are _lots_ of programs that could use a reliable indicator of
whether a file has changed.  tv_nsec when it isn't stored isn't one of
them, so it would be a shame to have a half-engineered solution that
complex programs like, say, a Java generated-code-precacher must not
use because of rare logical failures.

I've offered a solution that offers correct results for _all_
filesystems and _all_ machines, and it will behave exactly like your
code if you run it with XFS or a similar filesystem, it's efficient
(the delay is minimal and only done when needed), and logically
dependable.  So please consider it.

Thanks :)
-- Jamie
