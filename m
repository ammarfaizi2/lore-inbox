Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTLDTY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTLDTY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:24:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7916 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263466AbTLDTYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:24:53 -0500
Date: Thu, 4 Dec 2003 19:24:52 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031204192452.GC10421@parcelfarce.linux.theplanet.co.uk>
References: <3FCDE5CA.2543.3E4EE6AA@localhost> <Pine.LNX.4.58.0312031533530.2055@home.osdl.org> <Pine.LNX.4.58.0312031614000.2055@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312031614000.2055@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 04:23:33PM -0800, Linus Torvalds wrote:

> Side note: historically, the Linux kernel module interfaces were really
> quite weak, and only exported a few tens of entry-points, and really
> mostly effectively only allowed character and block device drivers with
> standard interfaces, and loadable filesystems.
> 
> So historically, the fact that you could load a module using nothing but
> these standard interfaces tended to be a much stronger argument for not
> being very tightly coupled with the kernel.
> 
> That has changed, and the kernel module interfaces we have today are MUCH
> more extensive than they were back in '95 or so. These days modules are
> used for pretty much everything, including stuff that is very much
> "internal kernel" stuff and as a result the kind of historic "implied
> barrier" part of modules really has weakened, and as a result there is not
> avery strong argument for being an independent work from just the fact
> that you're a module.
 
	FWIW, it would be very nice if somebody did hard and messy work and
produced lists of in-tree modules using given symbols.  Ideally - automated
that, but that won't be easy to do (quite a few are used only via inlined
wrappers and in some cases - under an ifdef; many arch-specific exports
are of that sort).

	Aside of "hey, nothing uses that at all" and "only core uses it"
we'd get a bunch of "hmm, we really should've exported higher-level function
instead" and "WTF does that lone driver use this function?".  I'd played
with that for fs/* exports and so far results look interesting.  I'm using
grep, but that's pretty much hopeless - we have literally thousands of
exported symbols and any manual approach will break on that.

	Some approximation might be obtained by building all modules and
doing nm on them, with manual work for non-obvious cases.  I've done that
on x86 (allmodconf + enabling whatever could be enabled, even if broken).
Statistics is interesting, to put it mildly.

	First of all, there are ~3600 symbols used by some in-tree drivers.
~600 of them are have 10 users or more.  ~2000 have only one or two users.
And we have ~7500 EXPORT_... in the tree.  Now, that number is inflated by
duplicates between architectures (and other stats are deflated by incomplete
coverage).  And yes, there are things that have every reason to be exported,
but only a few modules care to use them.

	However, it certainly looks like a large fraction of export list
should go away.  Moreover, we probably should introduce
EXPORT_FOR(symbol, module list)
and use it for stuff like jbd poking very deep in buffer.c guts - deeper
than anybody else.  Ditto for ipv6 / ipv4 interaction - they really have
a special relationship and it makes no sense whatsoever to treat everything
in TCPv4 guts that happens to be shared with TCPv6 as public export.  There's
a lot of cases like that and I suspect that they cover ~50-60% of the in-tree
imports.

	Real interface is somewhere around 400-500 symbols and it can be
split into several more or less compact parts.  Having more than an order
of magnitude more than that, and having it as a big pile...  Not a good
thing(tm), IMO.
