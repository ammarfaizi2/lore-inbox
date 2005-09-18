Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVIRWZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVIRWZz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 18:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVIRWZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 18:25:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932233AbVIRWZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 18:25:55 -0400
Date: Sun, 18 Sep 2005 15:25:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Roman Zippel <zippel@linux-m68k.org>, Willy Tarreau <willy@w.ods.org>,
       Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
In-Reply-To: <20050918215257.GA29417@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509181513440.9106@g5.osdl.org>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
 <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local>
 <20050918171845.GL19626@ftp.linux.org.uk> <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org>
 <20050918174549.GN19626@ftp.linux.org.uk> <Pine.LNX.4.61.0509182222030.3743@scrub.home>
 <20050918211225.GP19626@ftp.linux.org.uk> <20050918215257.GA29417@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Sep 2005, Al Viro wrote:
> 
> BTW, for some idea of how hard does it actually blow

Well, to be slightly more positive: it's not a very easy feature to do 
properly.

The thing about "(cast) { .. }" initializers is that they aren't just 
initializers: they really are local objects that can be used any way you 
want to. So in the _generic_ case, gcc does exactly the right thing: it 
introduces a local object that is filled in with the initializer.

So in the generic case, you could have

	x = (cast) { ... }.member + 2;

instead of just a straight assignment.

The problem is just that the generic case is semantically pretty damn far 
away from the case we actually want to use, ie the special case of an 
assignment. So some generic top-level code has created the generic code, 
and now the lower levels of the compiler need to "undo" that generic code, 
and see what it actually boils down to. And that's quite hard.

The sane thing to do for good code generation would be to special-case the 
assignment of this kind of thing, and just make it very obvious that an 
assignment of a (cast) {...} is very different from the generic use of 
same. But that would introduce two totally different cases for the thing.

So considering that almost nobody does this (certainly not SpecInt), and 
it would probably require re-organizations at many levels, I'm not 
surprised it hasn't gotten a lot of attention.

		Linus
