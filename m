Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266197AbUHAXHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbUHAXHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 19:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUHAXHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 19:07:47 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:23689 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266197AbUHAXHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 19:07:45 -0400
Date: Mon, 2 Aug 2004 01:06:47 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: chris@scary.beasts.org
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: secure computing for 2.6.7
Message-ID: <20040801230647.GH6295@dualathlon.random>
References: <20040704173903.GE7281@dualathlon.random> <40EC4E96.9090800@namesys.com> <20040801102231.GB6295@dualathlon.random> <Pine.LNX.4.58.0408011248040.1368@sphinx.mythic-beasts.com> <20040801150119.GE6295@dualathlon.random> <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 06:29:05PM +0100, chris@scary.beasts.org wrote:
> Using the above approach, we (the app writers) would never agree on the
> syscall lists required for different seccomp modes ;-)

I see the problem ;).

> How hard would it be to have a per-task bitmap of syscalls allowed? This
> way, a task could restrict to the exact subset of syscalls required for
> maximum security.
> The bitmap would
> - Be allocated on demand (for no overhead in the common case)
> - Deny all syscalls not covered by the supplied bitmap, to cater for
> syscall table expansion
> - Be inherited across fork and (probably) shared across clone

your app will have then to learn about the syscall details of every
arch (which is normally a kernel internal thing), the most obvious
example is the difference between the sigreturn and rt_sigreturn, plus
the syscall numbers vary across every arch and the bitmap will have to
differ depending on the architecture (while the seccomp mode number is a
fixed interface for all archs and it hides all internal details like
sigreturn/rt_sigreturn). The one thing I don't like is that if somebody
changes the signal frame to use a new_rt_sigreturn the app will break
and I'll have to upload an update and I'll have again to check for uname
-r to know which kernel has to enable what. I mean when the new
behaviour is introduced it won't be too bad, it'll just get a false
positive sigkill, it could happen as well if somebody forgets to update
seccomp.c after changing the signal frame.

While I only get disavantages from the bitmap, if people really want the
arch dependent bitmap I'm certainly able to put kernel architectural
internal knowledge into some python code that will build the right
bitmap depending on the arch and depending on the uname -r.

So it's up to you. Feel free to discuss and choose what you prefer. I'm
biased and I prefer seccomp, you can still implement the bitmap on top
of seccomp as seccomp mode == 2. I'm not saying you shouldn't get the
bitmap, my previous suggestion of syscalltable that would parse as well
the parameters was a lot more complicated than the bitmap, doing the
bitmap on top of seccomp will be easy (we could add some more storage
into the seccomp file too, so if you write number 2 followed by data,
the kernel will allocate such later data afte the first 32bits, as a
bitmap). And still the seccomp mode will provide you the infrastructure
and the entry point. This is actually simple enough (not comparable to
the syscalltables) that I can implement it myself if you agree on this
direction (next weekend).
