Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUBTNmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbUBTNi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 08:38:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:19117 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261187AbUBTNgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 08:36:07 -0500
Date: Fri, 20 Feb 2004 14:37:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220133707.GA11773@elte.hu>
References: <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <20040220131932.GB8994@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220131932.GB8994@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jamie Lokier <jamie@shareable.org> wrote:

> >  - it's a synchronous solution that avoids signals, and is thus
> >    usable/robust in libraries too.
> 
> I do like the robustness, due to the way the flag is associated with
> dirfd.
> 
> >  - dnotify _forces_ action. mark_dir_clean() you can use if there's use 
> >    and there's no overhead if the Samba workload is completely silent
> >    and there are only POSIX users. I.e. it should scale better than 
> >    dnotify.
> 
> Firstly, it doesn't scale better than dnotify in this scenario if
> you're using signals and one-shot mode.  With one-shot mode, there's
> also no overhead if there are only POSIX users.

the overriding argument is that the bit needs to be maintained by Samba
expliticly - i.e. no way around sys_mark_dir_clean() and O_CLEAN. And if
we've done that it costs us _nothing_ to return the previous bit value
in sys_mark_dir_clean() - which Samba can use to build a 100% coherent
name cache. At which point i can see no reason at all to use any variant
of dnotify/select/poll/epoll.

Also, one-shot mode will make you lose multiple outstanding events from
multiple directories, unless you associate separate signals with each
directory watched - which will make you run out of the 64 signals very
quick.

> Secondly, dnotify is synchronous if you _block_ the dnotify signal and
> use sigtimedwait() to collect events.

it still queues up kernel structures (dnotify event structures and
signal structures) which can get lost or can overflow, etc. The 'clean
bit' has no such queueing problem.

> I'd personally like to see the robustness problem solved with epoll or
> something similar extended to queue more general events to userspace,
> more reliably.

why? A synchronous lookup is just that - a synchronous lookup. There's
no need at all for Samba to know about all namespace activities. What it
wants to have is coherency between its own cache and the VFS.

dnotify (or epoll) is useful for applications that need to know about
all events: eg. directory visualisation apps. For everything else (like
Samba) it's too much overhead i believe.

> Hey!  That's an idea: Use select/poll on the dirfd to read this bit.
> That gives you the flexibility to wait, or collect events from
> multiple directories.  (Philosophicaly, every event should be
> accessible through select/poll/epoll, right?).

Samba doesnt want to 'wait' for any event. It just wants to keep in sync
with the VFS in a minimalistic way: update the cache only when
absolutely necessary. Think of it as a CPU's cache validation protocol -
you dont want to re-read invalid cachelines all the time, only if they
are really needed.

	Ingo
