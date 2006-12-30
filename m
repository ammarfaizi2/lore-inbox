Return-Path: <linux-kernel-owner+w=401wt.eu-S1030199AbWL3BSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWL3BSr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 20:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWL3BSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 20:18:47 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:42150 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030199AbWL3BSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 20:18:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=oM5vB5mNB8q4I4gtyLKt7Isaj8tMUldbKA99mKFhAt3ko5jdMCJq100j4WZAnPHCf/HniuhUlG4+0hcO7FlPDqmpF8uc7ltogPVGs+LLb1e9Nb80oMyDZX2eCDm/raRhzQKu49hk9C/mLLknU+3NpKEa5h0Zpjda9YXvhRLIJnA=  ;
X-YMail-OSG: epcTISAVM1kBrpyxeC5W8WHE7Z_GonmFSzRjHLBETMUWvp.QJiFz8GkFNXqncOO4Q06HZ.K6VBzLMeWLyMqRISVub116rVvNk5HrvlW5e.jMtD50SwmWAWhE3T_vKoMJhAtWD_5NVzzDsMSZ.Ad.792YsOyR7QTi1NPwGUGHHWizp7J.9MDmo8pPLOOk
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.20-rc1 1/6] GPIO core
Date: Fri, 29 Dec 2006 17:18:33 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612281405.37143.david-b@pacbell.net> <20061229002752.GA3543@elf.ucw.cz>
In-Reply-To: <20061229002752.GA3543@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612291718.34494.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 4:27 pm, Pavel Machek wrote:
> 
> > > > +GPIOs are identified by unsigned integers in the range 0..MAX_INT....
> > > 
> > > Perhaps these should not be integers, then?
> > 
> > Thing is, the platforms **DO** identify them as integers.
> > ...
> 
> Well. when you see (something) = gpio_number + 5 ... you most likely
> have an error.

One could surely apply that argument to hundreds of places throughout
the kernel ... that doesn't make it a good one.  One of the downfalls
of many "object oriented programming" efforts was this same desire to
encapsulate things that don't need it; it's lose, not a don't-care.

Think of it as "cookies represented by integers" if you like.


> No, that's a wrong way. I want you to admit that gpio numbers are
> opaque cookies noone should look at, and use (something like)
> gpio_t... so that we can teach sparse to check them.

You're welcome to dream on.  :)

The goal here is not to create new complexity, it's to wrap the
current widely used abstraction (gpios are integers, with get/set
primitives and a direction) in a neutral programming interface
that's very easy to map to/from the current arch-specific ones.

So that various drivers can get on with the business of being
generally useful, rather than arch-specific; or at least being
easier to read.  See the example PXA patch I recently posted;
it's a code shrink, and *direct* translation from the current
GPIO interface (which uses integers).


> > > > +The get/set calls have no error returns because "invalid GPIO" should have
> > > > +been reported earlier in gpio_set_direction().  However, note that not all
> > > > +platforms can read the value of output pins; those that can't should always
> > > > +return zero.  Also, these calls will be ignored for GPIOs that can't safely
> > > > +be accessed without sleeping (see below).
> > > 
> > > 'Silently ignored' is ugly. BUG() would be okay there.
> > 
> > The reason for "silently ignored" is that we really don't want to be
> > cluttering up the code (source or object) with logic to test for this
> > kind of "can't happen" failure, especially since there's not going to
> > be any way to _resolve_ such failures cleanly.
> 
> You may not want to clutter up code for one arch, but for some of them
> maybe it is okay and welcome. Please do not document "silently
> ignored" into API.

Those words were yours; so you can consider that already done.
Should it instead say that's an (obviously unchecked) error?

The "no error returns" was an explicit request from several folk
during earlier API discussions.  People actually _using_ GPIOs have
no use for faults on those known-valid get/set calls.  Seriously,
exactly how could you ever recover from register access no longer
working correctly?  The chip is in the process of exploding, or
being crushed; what could software possibly do to recover?


> > And per Linus' rule about BUG(), "silently ignored" is clearly better
> > than needlessly stopping the whole system.
> 
> You are perverting what Linus said. "Do not bother detecting errors"
> is not what he had in mind.. but perhaps it should be WARN() not
> BUG().

You are perverting what _I_ said.  (As you've done before; stop that.)

It's very clear that I was talking about a tradeoff ("better than"), and
pointing out how Linus' rule made it clear that your proposal was on the
wrong end of things.  (His rule being that BUG should not be used unless
the system really can't continue operating.)

In terms of API specs, emitting any warning is traditionally out-of-scope.
Because "of course" it's legit for debug modes to do all kinds of things,
including emitting warnings; and likewise it's legit for non-debug modes
to do nothing not absolutely required.  And programming interface specs
have no business in "quality of implementation" issues like whether any
implementation even _has_ a debug mode, much less what it covers.


> > > > +... It is an unchecked error to use a GPIO
> > > > +number that hasn't been marked as an input using gpio_set_direction(), or
> > > 
> > > It should be valid to do irqs on outputs,
> > 
> > Good point -- it _might_ be valid to do that, on some platforms.
> > Such things have been used as a software IRQ trigger, which can
> > make bootstrapping some things easier.
> > 
> > That's not incompatible with it being an error for portable code to
> > try that, or with refusing to check it so that those platforms don't
> > needlessly cause trouble!
> 
> I believe your text suggests it _is_ incompatible. Plus that seems to
> mean that  architecture must not check for that error...

Which -- that portable code mustn't try such things?  That seems clearly
wrong; that's what the "is an error" phrase means.  Or that code should
not need an obscure API for nonportable tricks like that?  That seems
wrong too; that's one of the reasons to specify things as "unchecked".
Or that implementations shouldn't be required to guard against that
behavior in layers above?  Same comment about "unchecked".

I think you must have missed the class in "how to write API specs" which
discussed how to accomodate nonportable behaviors; it's a given that if
there are more than two implementations of the interface, such things are
going to exist.  One of the options is to just declare such things as
clearly out-of-scope for the API, and just wash your hands of what some
implementaiton will be doing (regardless of what you write down).  In
this case, that's what happened.

And again, remember that if your implementation (not architecture!) wants
to have a (debug) mode that warns about marginal might-be-trouble cases,
that's always legit.

- Dave

