Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262822AbRFQUFq>; Sun, 17 Jun 2001 16:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262731AbRFQUFg>; Sun, 17 Jun 2001 16:05:36 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:60174 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262728AbRFQUFb>; Sun, 17 Jun 2001 16:05:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Newbie idiotic questions.
Date: Sun, 17 Jun 2001 22:08:23 +0200
X-Mailer: KMail [version 1.2]
Cc: David Flynn <Dave@keston.u-net.com> rjd@xyzzy.clara.co.uk,
        Bill Pringlemeir <bpringle@sympatico.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10106172115110.12465-100000@callisto.of.borg>
In-Reply-To: <Pine.LNX.4.05.10106172115110.12465-100000@callisto.of.borg>
MIME-Version: 1.0
Message-Id: <0106172208230T.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 June 2001 21:18, Geert Uytterhoeven wrote:
> On Sun, 17 Jun 2001, Jeff Garzik wrote:
> > David Flynn wrote:
> > > > Daniel Phillips wrote:
> > > > > -       if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout), 
GFP_KERNEL))
> > >
> > > > > +       if ((card->mpuout = kmalloc(sizeof(*card->mpuout),
GFP_KERNEL))
> > > >
> > > > Yeah, this is fine.  The original posted omitted the '*' which was
> > > > not fine :)
> > >
> > > The only other thing left to ask, is which is easier to read when
> > > glancing through the code, and which is easier to read when maintaining
> > > the code. imho, ist the former for reading the code, i dont know about
> > > maintaing the code since i dont do that, however in my own projects i
> > > prefere the former when maintaing the code.
> >
> > It's the preference of the maintainer.  It's a tossup:  using the type
> > in the kmalloc makes the type being allocated obvious.  But using
> > sizeof(*var) is a tiny bit more resistant to change.
> >
> > Neither one sufficiently affects long term maintenance AFAICS, so it's
> > personal preference, not any sort of kernel standard one way or the
> > other...
>
> The first one can be made a bit safer against changes by creating a `knew'
>
> macro that behaves like `new' in C++:
> | #define knew(type, flags)	(type *)kmalloc(sizeof(type), (flags))
>
> If the types in the assignment don't match, gcc will tell you.

Well, since we are still beating this one to death, I'd written a "knew" 
macro as well, and put it aside.  It does the assignment for you too:

   #define knew(p) ((p) = (typeof(p)) kmalloc(sizeof(*(p)), GFP_KERNEL))

Example:

 	struct foo { int a; int b; };
	struct { struct foo *foo; } *foobar;

	if (knew(foobar))
		if (knew(foobar->foo))
			printk("foo: %p\n", foobar->foo);

Terse and clear at the same time, and type safe.  I still don't like it much. 

--
Daniel
