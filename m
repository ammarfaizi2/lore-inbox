Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUIORmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUIORmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUIORmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:42:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:7625 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267184AbUIORjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:39:12 -0400
Date: Wed, 15 Sep 2004 10:39:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <roland@topspin.com>
cc: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
In-Reply-To: <524qlzxxka.fsf@topspin.com>
Message-ID: <Pine.LNX.4.58.0409151024510.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de>
 <524qlzxxka.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Sep 2004, Roland Dreier wrote:
> 
> However, I somewhat agree -- it's ugly for drivers rely on this and do
> arithmetic on void *.  It should be OK for a driver to use 
> char __iomem * for its IO base if it needs to add in offsets, right?

"char __iomem *" will certainly work - all the normal pointer conversions 
are ok. Some people in fact use pointers to structures in MMIO space, and 
this is quite reasonable when working with a chip that uses "mailboxes" 
for commands.

However, I disagree with "void *" arithmetic being ugly. It's a very nice
feature to have a pointer that can be validly cast to any other type, and
that is the whole _point_ of "void *". The fact that C++ got that wrong is
arguably the worst failing of the language, causing tons of unnecessary
casts that can silently hide real bugs (maybe the thing you cast wasn't a
"void *" in the first place, but you'll never know - the compiler will do
the cast for you).

For example, to go back to the mailbox example, let's say that your 
hardware has an IO area that is 8kB in size, with the last 4kB being 
mailboxes.

The _sane_ way to do that is to do

	void __iomem *base_io = ioremap(...);
	struct mailbox __iomem *mbox = base_io + MAILBOX_OFFSET;

and then just work on that.

In contrast, havign to cast to a "char *" in order to do arithmetic, and 
then casting back to the resultant structure type pointer is not only 
ugly and unreadable, it's a lot more prone to errors as a result.

In other words, think of "void *" as a pointer to storage. Not "char"  
(which is the C name for a signed byte), but really, it's the pointer to 
whatever underlying memory there is. And a _fundamental_ part of such 
memory is the fact that it is addressable. Thus "pointer to storage 
arithmetic" really does make sense on a very fundamental level. It has 
nothing to do with C types, and that also explains why "void *" silently 
converts to anything else. It's a very internally consistent world-view.

Now, I disagree with gcc when it comes to actually taking the "size" of 
void. Gcc will silently accept

	void *x;
	x = malloc(sizeof(*x));

which I consider to be an abomination (and the above _can_ happen, quite
easily, as part of macros for doing allocation etc - nobody would write 
it in that form, but if you have an "MEMALLOC(x)" macro that does the 
sizeof, you could end up trying to feed the compiler bogus code).

The fact that you can do arithmetic on typeless storage does _not_ imply
that typeless storage would have a "size" in my book.

So sparse will say:

	warning: cannot size expression

and refuse to look at broken code like the above. But hey, the fact that I 
have better taste than anybody else in the universe is just something I 
have to live with. It's not easy being me.

		Linus
