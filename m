Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVIRVM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVIRVM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVIRVM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:12:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39622 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932203AbVIRVM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:12:29 -0400
Date: Sun, 18 Sep 2005 22:12:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Willy Tarreau <willy@w.ods.org>,
       Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918211225.GP19626@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local> <20050918171845.GL19626@ftp.linux.org.uk> <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org> <20050918174549.GN19626@ftp.linux.org.uk> <Pine.LNX.4.61.0509182222030.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509182222030.3743@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 10:34:16PM +0200, Roman Zippel wrote:
> > Ewwwww...  I'd say that it qualifies as one hell of a bug (and yes, at least
> > 3.3 and 4.0.1 are still doing that).  What a mess...
> 
> It's not a bug, it's exactly what you're asking for, e.g. "*p1 = *p2" 
> translates to memcpy. gcc also can't simply initialize that structure in 
> place, e.g. you could do something like this (not necessarily useful but 
> still valid): "*p = (struct foo){...,  bar(p),...};".
> In the end it all depends on how good gcc can optimize away the memcpy, 
> but initially there is always a memcpy.

No.  Assignment is _not_ defined via memcpy(); it's a primitive that could
be implemented that way.  Choosing such (pretty much worst-case) implementation
in every case is a major bug in code generator.

You _can_ introduce a new local variable for each arithmetic operation in
your function and store result of operation in the corresponding variable.
As the matter of fact, this is a fairly common intermediate form.  However,
if compiler ends up leaving all these suckers intact in the final code,
it has a serious problem.

Compound literal _is_ an object, all right.  However, decision to allocate
storage for given object is up to compiler and it's hardly something unusual.
"Value of right-hand side is not needed to finish calculating left-hand side,
so its storage is fair game from that point on" is absolutely normal.
