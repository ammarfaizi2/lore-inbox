Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUBTQcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 11:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbUBTQcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 11:32:18 -0500
Received: from mail.shareable.org ([81.29.64.88]:56960 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261295AbUBTQcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 11:32:13 -0500
Date: Fri, 20 Feb 2004 16:31:52 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220163152.GE8994@mail.shareable.org>
References: <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <20040220131932.GB8994@mail.shareable.org> <20040220133707.GA11773@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220133707.GA11773@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Also, one-shot mode will make you lose multiple outstanding events from
> multiple directories, unless you associate separate signals with each
> directory watched - which will make you run out of the 64 signals very
> quick.

Eh?  Signals are queued, and the file descriptor number is stored in
the siginfo.

> dnotify (or epoll) is useful for applications that need to know about
> all events: eg. directory visualisation apps. For everything else (like
> Samba) it's too much overhead i believe.

dnotify _should_ be quite low overhead, although not as low as your
syscall of course.  I've never measured it, nor looked much at the
kernel code, but in principle delivering a siginfo through
sigtimedwait() should be quite fast.

But I agree it's too much.  Hence:

> > Hey!  That's an idea: Use select/poll on the dirfd to read this bit.
> > That gives you the flexibility to wait, or collect events from
> > multiple directories.  (Philosophicaly, every event should be
> > accessible through select/poll/epoll, right?).
> 
> Samba doesnt want to 'wait' for any event. It just wants to keep in sync
> with the VFS in a minimalistic way: update the cache only when
> absolutely necessary. Think of it as a CPU's cache validation protocol -
> you dont want to re-read invalid cachelines all the time, only if they
> are really needed.

Yes yes, but I'm thinking of the _many_ other applications that aren't
Samba and could benefit from a similar facility.  Also, dnotify is
there already - the signalling mechanism isn't pretty, but the hooks
to catch directory changes are fine.

By the way, what is the scope of O_CLEAN?  Does it fail if _any_
operation was done to the directory, or only if operations were done
by non-Samba tasks?  If the former, it has the same scalability
problem that Linus mentioned: Samba shouldn't have to evict its cache
when it creates files itself.  If the latter, is the test
process-wide, thread-wide, or CLONE_FILES-wide?

-- Jamie
