Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281838AbRKRBKR>; Sat, 17 Nov 2001 20:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281840AbRKRBKG>; Sat, 17 Nov 2001 20:10:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58384 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281838AbRKRBJ6>; Sat, 17 Nov 2001 20:09:58 -0500
Date: Sun, 18 Nov 2001 02:09:57 +0100
From: Jan Hubicka <jh@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jan Hubicka <jh@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: i386 flags register clober in inline assembly
Message-ID: <20011118020957.A10674@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011117214041.D3789@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0111171238150.1731-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111171238150.1731-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, 17 Nov 2001, Jan Hubicka wrote:
> >
> > Actually the main dificulty I see is storing cc0 to variable.  CC0 is hard
> > register and pretty strange one - you can't move it, you can't spill.
> 
> Well, you _can_ spill it, but you need to use "pushfl/popfl" to
> spill/restore.
I know, I can, but we are speaking about sollution how to get programs faster,
not slow down them to scrawl.
Sadly gcc's reload pass is one (or the) most tricky part of gcc and adding any
new feature to that beast is extreme problem, especially with later maitenance.

Actually what can be feasible is to make asm statement set flags and follow
it by store flag instruction that will be used in the conditional. Later
the combine pass should be able to get it connected.

Problem with this sollution I see is that it would need to redesign way
the conditionals are output. Currently gcc believes there is single flags
register and emits comparison and user of flags separately.

Backends plays around this and remembers the comparisons instead of emitting
and do use it later once asked for emitting the flags user.  If the asm
statement is emit, backend would not be notified and whole machinery needs
to be tweaked.

Also I am not quite sure how to nicely design the syntax representing the
asm and flag store together.

The 3.1 feature freeze is in few weeks, not enought to implement something
so drastic, but I will try to keep it in the mind and discuss later for 3.2.

The design of asm statements should be IMO re-tought.  I think it has been
mistake to make them so low level and allow user to write constraints directly,
so perhaps we can think about big change for future gcc...

Honza
> 
> Also, if you're clever you don't spill cc0 itself, but the _comparison_,
> ie if you need to spill in
> 
> 	asm(.. "=cc" (cc0))
> 	if (cc0 > 0)
> 
> a sufficiently clever spill-engine would spill not eflags,  but instead
> spill "cc0 > 0", which it can do with the "seq" expansions..
> 
> gcc already does know about "store-flag" instructions, although I
> certainly agree that the _patterns_ of usage may end up being very
> different than existing conditional comparisons..
> 
> 		Linus
