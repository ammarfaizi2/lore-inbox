Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbUBUDB2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 22:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbUBUDB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 22:01:28 -0500
Received: from mail.shareable.org ([81.29.64.88]:20609 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261487AbUBUDBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 22:01:24 -0500
Date: Sat, 21 Feb 2004 03:01:18 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040221030118.GE10928@mail.shareable.org>
References: <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220173307.GF8994@mail.shareable.org> <Pine.LNX.4.58.0402201017370.2533@ppc970.osdl.org> <20040221003831.GB10928@mail.shareable.org> <Pine.LNX.4.58.0402201708100.3301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402201708100.3301@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> That's what Ingo's O_CLEAN thing did. An di fyou do Ingo's O_CLEAN, then 
> there's no point to notifiers in the first place - Ingo's algorithm works 
> regardless of them (it had other problems, but that's another issue and 
> just requires a bit of extending on the basic concept).
> 
> So why do you care about dnotify? It doesn't help at all once you have 
> O_CLEAN (or equivalent).

Please look at my pseudo-code carefully.  It uses dnotify to
test-and-set the bit; there isn't a "notify" event.

In other words, I'm making dnotify simpler by getting rid of the
signal, so it becomes exactly the same as Ingo's syscall:

        while (sys_mark_dir_clean(dirfd) == 0) {
            do_readdir(dirfd);
        }
        /* use results */

becomes:

        while (fcntl(dirfd, F_NOTIFY,
               DN_CREATE|DN_RENAME|DN_DELETE|DN_NOSIGNAL) != 0) {
            do_readdir(dirfd);
        }
        /* use results */

In my scheme, we still have O_CLEAN.  (Have I said that's a great idea
enough times yet?)

The reason I prefer to add DN_NOSIGNAL to dnotify instead of a new
syscall should be obvious: it's a simple change, equally fast, and
dnotify is a _lot_ more versatile.

For Samba, dnotify lets you be more selective for various cache types,
and poll() can do multiple tests in a single syscall - good for path
walk algorithms (although I've shown in another email how the tests
can be elided completely).

The combination of O_CLEAN with dnotify is useful for many other
applications.  I don't want to complicate this explanation by
describing them.  The dnotify change by itself is also good.

In short, it's a good thing, with no bad sides.

-- Jamie
