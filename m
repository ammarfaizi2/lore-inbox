Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRCEJtl>; Mon, 5 Mar 2001 04:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbRCEJtb>; Mon, 5 Mar 2001 04:49:31 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:53978 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S129131AbRCEJtN>; Mon, 5 Mar 2001 04:49:13 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
Date: Mon, 5 Mar 2001 10:48:01 +0100
Message-Id: <19350128031945.8136@mailhost.mipsys.com>
In-Reply-To: <20010304230707.L2565@ftsoj.fsmlabs.com>
In-Reply-To: <20010304230707.L2565@ftsoj.fsmlabs.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>More generic in terms of using irq_desc[] and some similar structures I can
>see.  Making do_IRQ() and enable/disable use the same names and structures
>as x86 isn't sensible.  They're different ports, with different design
>philosophies.
>
>I don't believe that the plan is a common irq.c - lets stay away from that.

Why ? Except for a few things like irq probing, our irq.c is already very
similar
to i386 (well, mostly because I merged most of it some time ago) and I
don't see
why it would be a bad thing. The design of irq.c makes it perfectly
adapted to our
needs, there's nothing really x86-specific in it, it handles things we
need to be
handled correctly, does nothing more than what we need (well it does, but
those parts,
mostly the irq locking, got already removed), etc...

I did that merge in the first place because I wanted the depth support in
enable/disable_irq, and more fine-grained spinlocking. I really see
nothing wrong
in the way irq.c works, I really think that except the small added bit we have
in our do_IRQ() to call ppc_md.get_irq(), it's perfectly adapted to our needs.

Remember that it allowed to remove the (mostly useless) post_irq() thing
we had ?
It also allow proper implement of irq distribution even with controllers
that could
trigger the same IRQ on several CPUs, re-entrancy in the handler if we do
early-eoi
without masking an edge interrupt is also handled properly, enable/
disable from
within the handler too, all sorts of things our previous code didn't do right.

The only thing I added to the core irq.c code is that IRQ_PERCPU flag
that prevents
IRQ_INPROGRESS to be set. It's a bit hackish but allows our IPIs to use a
single
desc for all CPUs without beeing mutually exclusive. 

Ben.

