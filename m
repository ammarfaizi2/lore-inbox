Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUBTNX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbUBTNUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 08:20:24 -0500
Received: from mail.shareable.org ([81.29.64.88]:50304 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261235AbUBTNTk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 08:19:40 -0500
Date: Fri, 20 Feb 2004 13:19:32 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220131932.GB8994@mail.shareable.org>
References: <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220120417.GA4010@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>  - it's a synchronous solution that avoids signals, and is thus
>    usable/robust in libraries too.

I do like the robustness, due to the way the flag is associated with
dirfd.

>  - dnotify _forces_ action. mark_dir_clean() you can use if there's use 
>    and there's no overhead if the Samba workload is completely silent
>    and there are only POSIX users. I.e. it should scale better than 
>    dnotify.

Firstly, it doesn't scale better than dnotify in this scenario if
you're using signals and one-shot mode.  With one-shot mode, there's
also no overhead if there are only POSIX users.

Secondly, dnotify is synchronous if you _block_ the dnotify signal and
use sigtimedwait() to collect events.

I'd personally like to see the robustness problem solved with epoll
or something similar extended to queue more general events to
userspace, more reliably.

Hey!  That's an idea: Use select/poll on the dirfd to read this bit.
That gives you the flexibility to wait, or collect events from
multiple directories.  (Philosophicaly, every event should be
accessible through select/poll/epoll, right?).

> We can export the 'directory clean bit' to userspace, via the same page
> pinning and mapping techniques used by futexes. User-space could
> register a 'clean bit' address via a new syscall, which the dcache then
> uses from that point on. Thus there would be only a single syscall when
> Samba sets up a directory cache in user-space [which needs those
> readdir() calls so performance is down the drain anyway], which syscall
> lets userspace register a machine-word address to serve as the
> 'directory is clean' flag. Userspace and kernelspace will set this flag
> possibly in parallel which is not a problem as long as userspace uses
> atomic ops. This approach introduces some page pinning allocation
> overhead but that's easy to solve.  User-space would of course condense
> the pinned range. Kernel-space would see very minimal overhead from
> having the bit in an indirect pointer - at least on 64-bit systems where
> all kernel RAM is mapped.

That is _far_ too overcomplicated to do just for this one obscure bit
of information.

If you're going to do kernel-triggers-futex event transmission (like
CLONE_CLEARTID already does), it would be nice to have a framework for
more general event types, like pending-but-blocked signals, dnotify
events (individual ones, not all funnelled through one signal number
as they are now), fd-ready-to-read events and such.  The sort of
things that select/poll/epoll ought to be able to wait for, and in
most cases can.

-- Jamie
