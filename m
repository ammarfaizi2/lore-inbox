Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVIRXHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVIRXHp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 19:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVIRXHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 19:07:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:16079 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932243AbVIRXHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 19:07:44 -0400
Date: Mon, 19 Sep 2005 00:07:33 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Willy Tarreau <willy@w.ods.org>,
       Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918230733.GA29869@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local> <20050918171845.GL19626@ftp.linux.org.uk> <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org> <20050918174549.GN19626@ftp.linux.org.uk> <Pine.LNX.4.61.0509182222030.3743@scrub.home> <20050918211225.GP19626@ftp.linux.org.uk> <20050918215257.GA29417@ftp.linux.org.uk> <Pine.LNX.4.58.0509181513440.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509181513440.9106@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 03:25:39PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 18 Sep 2005, Al Viro wrote:
> > 
> > BTW, for some idea of how hard does it actually blow
> 
> Well, to be slightly more positive: it's not a very easy feature to do 
> properly.
> 
> The thing about "(cast) { .. }" initializers is that they aren't just 
> initializers: they really are local objects that can be used any way you 
> want to. So in the _generic_ case, gcc does exactly the right thing: it 
> introduces a local object that is filled in with the initializer.

Of course.  It's not a question of local object being semantically correct.

Forget for a minute about compound literals; consider

{
	some_type foo = expression; /* doesn't use bar */
	bar = foo;
}

That's exactly what happens here.  What does _not_ happen is elimination
of foo.  Note that all tricky cases happen when we take an address of
our object or of some part of it.  E.g. (struct foo){...}.scalar_field is
happily optimized to <evaluate all members of initializer, memorizing the
result for initializer if our field><use the memorized result>.

What's happening might be (and no, I haven't looked into the gcc codegenerator
yet) as simple as too early conversion of assignment to memcpy() call, losing
the "we don't really use the address of this sucker after initialization"
in process.
