Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130751AbQKRTJN>; Sat, 18 Nov 2000 14:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130805AbQKRTJD>; Sat, 18 Nov 2000 14:09:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64267 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130751AbQKRTI4>; Sat, 18 Nov 2000 14:08:56 -0500
Date: Sat, 18 Nov 2000 10:38:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Markus Schoder <markus_schoder@yahoo.de>
cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Alan Cox <alan@redhat.com>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <20001118182230.14470.qmail@web3407.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10011181025250.919-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, Markus Schoder wrote:
> 
> Your test program is indeed sufficient to trigger the
> freeze.  Unfortunately the patch does not make a
> difference :(

Ok.

This may in fact be an Athlon CPU bug. But before we contact anybody from
AMD, I'd really need to know what the result from the irq13 disabling and
the non-3dnow thing is.

Considering that Udo reports no lockup at all with the same test-program
even with an Athlon and 3dnow, it looks like it's either irq13 (and a
motherboard routing issue: sane modern motherboards shouldn't even route
the external FERR at _all_ any more), or something stepping-specific on
your Athlon. It doesn't sound kernel-related per se.

Let's hope it's irq13. If so, it will be easy to fix (tentative fix: any
CPU that reports a built-in FPU just doesn't get irq13 enabled at all).

Current workign theory:

 - Athlons do FERR wrong. They drive FERR externally when the
   unmasked exception happens, rather than when the next FP instruction
   actually detects the exception. This means that the external FERR irq13
   actually happens _before_ the internal exception 16, which is wrong.

 - Linux has seen exception 16 working, so it ignores irq13 and assumes
   that it's some real external device (which does happen - sometimes
   SCI is wired to irq13).

 - irq13 is not only wired on the motherboard (which was right in 1989,
   but is not right in 2000), but is marked level-triggered (which
   probably wasn't right even in 1989). So when the irq13 happens, it
   _keeps_ on happening, and we never get an exception 16 at all.

The reason 2.2.x works on your machine might be that the early bootup test
for FP exceptions will have done something to mask the fpu exception just
by luck. I forget the exact details of the test - it got removed in later
kernels because it made it really nasty to handle XMM faults correctly.

Does anybody have any better ideas? 

		Linus



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
