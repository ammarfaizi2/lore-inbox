Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVC2ThG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVC2ThG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVC2ThF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:37:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1965 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261345AbVC2Te7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:34:59 -0500
Subject: Re: [ubuntu-hardened] Re: Collecting NX information
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Brandon Hale <brandon@smarterits.com>, ubuntu-hardened@lists.ubuntu.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <4249A78A.1040407@comcast.net>
References: <42484B13.4060408@comcast.net>
	 <1112035059.6003.44.camel@laptopd505.fenrus.org>
	 <4248520E.1070602@comcast.net>
	 <1112036121.6003.46.camel@laptopd505.fenrus.org>
	 <424857B0.4030302@comcast.net>
	 <1112043246.10117.5.camel@localhost.localdomain>
	 <4248828B.20708@comcast.net>
	 <1112080581.6282.1.camel@laptopd505.fenrus.org>
	 <4249096B.7020802@comcast.net>
	 <1112083762.6282.23.camel@laptopd505.fenrus.org>
	 <424911FF.1080702@comcast.net>
	 <1112086016.6282.36.camel@laptopd505.fenrus.org>
	 <42499C40.5030202@comcast.net>
	 <1112121756.6282.88.camel@laptopd505.fenrus.org>
	 <4249A78A.1040407@comcast.net>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 21:34:49 +0200
Message-Id: <1112124890.6282.99.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 14:07 -0500, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Arjan van de Ven wrote:
> >>>Hmmmm you either need an executable stack or you don't. Can you explain
> >>>why you think there is a strong advantage for a "neutral" setting on
> >>>this one?
> >>>
> >>
> >>As I said, compatibility mode.  The toolchain should not emit
> >>*everything* PT_GNU_STACK and leave it up to you to de-mark it; instead,
> >>everything should be emitted without PT_GNU_STACK set, in which case
> >>violating code would die.
> > 
> > 
> > actually right now the toolchain marks things automatically correct.
> > If gcc emits a stack trampoline, it gets marked needing executable
> > stack, if gcc can prove it doesn't need executable stack, it gets marked
> > as such as well. 
> > 
> 
> And the toolchain emits a -E library with PT_PAX_FLAGS if there's a
> stack trampoline :)  But it's defficient right now, doesn't inherit when
> you link to a library with -E. . . you can fix that right?  :)

it's inherited for PT_GNU_STACK though.
Not sure how you implemented PT_PAX_FLAGS, but for PT_GNU_STACK it's
inherited.

> > I *really* don't understand why you want to get away from automatic
> > marking to something manual, which *has* to be more fragile.
> > 
> 
> /me shrugs.  It's a security blanket for him mostly; he fears automagic
> security maintainence.

who is "him" ?

> 
> > 
> >>Remember also I'm very much against "let the compiler guess if you need
> >>an executable stack"
> > 
> > 
> > it's not guessing. the *compiler* emits the stack trampoline. So the
> > *compiler* knows that it needs that stack.
> > 
> 
> With a trampoline, things like Grub and a few libs need PT_GNU_STACK.

sure they do. There's about a handful in an entire distro.

> 
> Of course you can't just suddenly say "OH!  Well PT_GNU_STACK should do
> this instead!" because you'll break everything.

I'm not a fan of any kind of emutrampoline. At all. But I am open to
others making a different tradeoff; for me the option to have a
trampoline at all is just a bypass of the non-exec stack... legit bypass
one hopes but a bypass regardless. Some time ago we did an eval of how
much stuff would need the emutramp (well or something equivalent) and
the list was so small that I decided that the added risk and complexity
were not worth it and that I rather had those 5 or so apps run with exec
stack.

> > again what does tristate mean.. "I don't know" ? But gcc does know, with
> > very very very few exceptions. Eg old mono is the exception because it
> > didn't do a proper mprotect. Saying "I don't know" doesn't solve you
> > anything, since in the end there needs to be a policy enforced anyway,
> > it's just postponing the inevitable to a point with less knowledge.
> > 
> 
> Remember I'm also thinking of restricted mprotect() situations as well,
> because I'm trying to get it to the point where one set of markings has
> a predictable effect on any kernel, be it vanilla, pax, or ES.

well that is an entirely independent thing again. Really.
I think mixing all these into one big flag is a mistake. 
(And thats a lesson I learned the hard way, but Linus was right; don't
mix independent things into one flag artificially. Extra flags are
cheap. Don't complicate the world for a dozen bytes.)




