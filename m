Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWB0PsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWB0PsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWB0PsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:48:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50706 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964794AbWB0PsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:48:03 -0500
Date: Mon, 27 Feb 2006 15:47:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Johannes Stezenbach <js@linuxtv.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060227154748.GB4094@flint.arm.linux.org.uk>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org> <20060225212247.GC15276@flint.arm.linux.org.uk> <20060225214704.GN13116@waste.org> <20060225215850.GD15276@flint.arm.linux.org.uk> <20060225223737.GO13116@waste.org> <20060225225748.GF15276@flint.arm.linux.org.uk> <20060227011844.GA7218@linuxtv.org> <20060227083232.GA21994@flint.arm.linux.org.uk> <20060227120729.GC7863@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227120729.GC7863@linuxtv.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 01:07:29PM +0100, Johannes Stezenbach wrote:
> On Mon, Feb 27, 2006, Russell King wrote:
> > On Mon, Feb 27, 2006 at 02:18:44AM +0100, Johannes Stezenbach wrote:
> > > On Sat, Feb 25, 2006 at 10:57:49PM +0000, Russell King wrote:
> > > > The email:
> > > > 
> > > >   http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/1024.html
> > > > 
> > > > contains a full and clear explaination of the situation.  The second
> > > > paragraph of that email is key to understanding the problem and makes
> > > > it absolutely clear what is trying to be decompressed as the initrd
> > > > (the corrupted compressed piggy).
> > > 
> > > FWIW, I didn't it either. "Work around broken boot firmware which passes
> > > invalid initrd to kernel" would have been a simpler description.
> > 
> > Sigh, I'm sick of this crap.  I'm not going to debate it any further.
> > 
> > > I agree that it would be nice if inflate.c would fail gracefully
> > > instead of halting,
> > 
> > IT _DOES_ FAIL GRACEFULLY TODAY.  WITH MATT'S PATCHES, IT _DOESN'T_.
> > THAT'S A REGRESSION.  WHAT IS IT ABOUT THAT WHICH PEOPLE DON'T
> > UNDERSTAND?  DO I HAVE TO SPELL IT OUT IN ONE SYLLABLE WORDS?
> 
> I got that already, no need to shout. I just wanted to point
> out that from the information you provided so far it
> looks like your problem could be fixed in a more straight
> forward fashion.
> 
> Problem:  Boot firmware passes invalid arguments.
> Solution: Ignore invalid boot firmware arguments.

Let me try to explain - but I doubt it'll do any good because folk don't
seem to understand plain English here anymore (or at least that's what
it seems like from _my_ perspective.)

In order to detect that the arguments are invalid, you'd need to validate
the initrd.

In order to validate a compressed initrd, you'd have to trial-inflate it,
just like gunzip -t.

(a) gunzip -t is able to work because it has setjmp/longjmp, so when it
    runs out of data, it can sanely exit from the data reading function
    when it encounters insufficient data.

    The kernel does not have such functionality, and it has been determined
    long ago that the kernel shall not have such functionality - it was
    discussed at the time when this problem first came up and the resounding
    answer was precisely as I state.

(b) if we have to have separate code to validate a compressed image, that is
    a complete waste of code and resources - we already have something which
    tests whether a compressed image is valid by inflating it - called
    lib/inflate.c.

So, your suggestion isn't a really a solution when the simple solution
is to keep the original _simple_ fix for a buggy integration of the gzip
inflate code.

> > > but why can't you just use CONFIG_BLK_DEV_INITRD=n?
> > 
> > Because you might want to use an initrd for real (for installation
> > purposes) and therefore distributions (eg Debian) want it turned on?
> 
> If you use a distribution kernel which contains one, you
> could simply add "noinitrd" to the kernel command line
> to ignore it, no?

Tell that to all the people who have complained in the past about it.

> > Okay, this does it - I'm ignoring further discussion on this stupid
> > idiotic topic which is soo bloody difficult for others to understand.
> 
> I don't understand your aggressiveness, there must be a dark
> secret behind all this. Or maybe it's just the season
> for flame wars.

I'm completely and utterly pissed off with this thread, having to almost
go back to kindergarten type explainations to get the point across.
_That's_ what has been soo infuriating about this whole saga.

And what's even more stupid is the attitude that required fixes can be
thrown out of the kernel, and then a massive argument is required to
re-explain wtf they're necessary.

Are we doomed to have to repeatedly explain why bug fixes are necessary?
If that's the case, let's pack up this Linux kernel thing because we're
on a route to insanity.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
