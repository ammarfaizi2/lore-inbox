Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWABTHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWABTHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWABTHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:07:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750967AbWABTHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:07:32 -0500
Date: Mon, 2 Jan 2006 11:03:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: mingo@elte.hu, bunk@stusta.de, arjan@infradead.org,
       tim@physik3.uni-rostock.de, torvalds@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-Id: <20060102110341.03636720.akpm@osdl.org>
In-Reply-To: <m3ek3qcvwt.fsf@defiant.localdomain>
References: <20051229224839.GA12247@elte.hu>
	<1135897092.2935.81.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
	<20051230074916.GC25637@elte.hu>
	<20051231143800.GJ3811@stusta.de>
	<20051231144534.GA5826@elte.hu>
	<20051231150831.GL3811@stusta.de>
	<20060102103721.GA8701@elte.hu>
	<1136198902.2936.20.camel@laptopd505.fenrus.org>
	<20060102134345.GD17398@stusta.de>
	<20060102140511.GA2968@elte.hu>
	<m3ek3qcvwt.fsf@defiant.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> wrote:
>
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > what is the 'deeper problem'? I believe it is a combination of two 
> > (well-known) things:
> >
> >   1) people add 'inline' too easily
> >   2) we default to 'always inline'
> 
> For example, I add "inline" for static functions which are only called
> from one place.
> 
> If I'm able to say "this is static function which is called from one
> place" I'd do so instead of saying "inline". But omitting the "inline"
> with hope that some new gcc probably will inline it anyway (on some
> platform?) doesn't seem like a best idea.
> 
> But what _is_ the best idea?

Just use `inline'.  With gcc-3 it'll be inlined.

With gcc-4 and Ingo's patch it _might_ be inlined.  And it _might_ be
uninlined by the compiler if someone adds a second callsite later on. 
Maybe.  We just don't know.  That's a problem.  Use of __always_inline will
remove this uncertainty.

So our options appear to be:

a) Go fix up stupid inlinings (again) or

b) Apply Ingo's patch, then go add __always_inline to places which we
   care about.

Either way, we need to go all over the tree.  In practice, we'll only
bother going over the bits which we most care about (core kernel, core
networking, a handful of net and block drivers).  I suspect many of the bad
inlining decisions are in poorly-maintained code - we've been pretty
careful about this for several years.
