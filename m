Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbULRAzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbULRAzh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbULRAzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:55:37 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:32184 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262793AbULRAz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:55:28 -0500
Date: Sat, 18 Dec 2004 01:52:08 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
In-Reply-To: <1103320106.7864.6.camel@localhost>
Message-ID: <Pine.LNX.4.61.0412180020220.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com> 
 <Pine.LNX.4.61.0412170133560.793@scrub.home>  <1103244171.13614.2525.camel@localhost>
  <Pine.LNX.4.61.0412170150080.793@scrub.home>  <1103246050.13614.2571.camel@localhost>
  <Pine.LNX.4.61.0412170256500.793@scrub.home>  <1103257482.13614.2817.camel@localhost>
  <Pine.LNX.4.61.0412171132560.793@scrub.home>  <1103299179.13614.3551.camel@localhost>
  <Pine.LNX.4.61.0412171818090.793@scrub.home> <1103320106.7864.6.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 17 Dec 2004, Dave Hansen wrote:

> > > No.  But, I do think that most of the very basic VM structures do, as it
> > > stands.  That's limited to struct page, zone, and pgdat as I see it
> > > now.  
> > 
> > Why do you want to put these into separate headers?
> 
> It enables you do do static inlines accessing struct page members
> anywhere you want, such as in asm/mmzone.h, like in my example. 

And by that you add more header dependencies.
We have basically this situation:

	foo.h (struct foo; inline foo();) <-> bar.h (struct bar; inline bar();)

Almost every time we had such recursive dependencies, we simply rip one 
element out and put it into a separate header:

	foo.h (inline foo();)
		-> bar.h (struct bar; inline bar();)
			-> foo_struct.h (struct foo;)

Repeat this often enough and we end up with millions of small header 
files. Instead we can reorder everything a little and can do this:

	foo.h (inline foo(); inline bar();)
		-> foo_types.h (struct foo; struct bar;)

In your case don't put the inline functions into asm/mmzone.h and we 
should merge the various definition into fewer header files.

> > > The dependencies aren't very twisted at all.  In fact, I don't think any
> > > of those are deeper than two.  More importantly, I never have to cope
> > > with 'struct page;' keeping me from doing arithmetic. 
> > 
> > You may be surprised. :)
> > Play around with "mkdir test; echo 'obj-y = test.o' > test/Makefile; echo 
> > '#include <linux/foo.h>' > test/test.c; make test/test.i 
> > CFLAGS_test.o=--trace-includes".
> 
> I'm not sure what you're getting at.
> 
> 	make: *** No rule to make target `test/test.i'.  Stop.

Sorry, I forgot to mention that you have to do this inside a kernel tree.

bye, Roman
