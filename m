Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQJ0Ff4>; Fri, 27 Oct 2000 01:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129030AbQJ0Ffq>; Fri, 27 Oct 2000 01:35:46 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:26885 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129026AbQJ0Ffj>; Fri, 27 Oct 2000 01:35:39 -0400
Date: Thu, 26 Oct 2000 22:35:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, Doug Ledford <dledford@redhat.com>,
        Gabriel Paubert <paubert@iram.es>, mingo@redhat.com,
        gareth@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: missing mxcsr initialization
In-Reply-To: <E13oxYQ-00041U-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10010262229330.864-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Oct 2000, Alan Cox wrote:
> > bitmap is all about, and should be forced to go back to the bad old times
> > when you had to check the stepping levels etc to figure out what the CPU's
> > could do.
> 
> You still do. In fact your example SEP specifically requires this due to 
> Intel specification changes in the undocumented=->documented versions

NO.

Go back. Read ym email. Realize that you do this ONCE. At setup time.

You can even split SEP into SEPOLD and SEPNEW, and _always_ just test one
bit. You should not have to test stepping levels in normal use: that
invariably causes problems when there are more than one CPU that has some
feature.

It is insidious. It starts out as something simple like

	if (stepping < 5) {
		...
	}

and everybody thinks it is cool. Until somebody notices that it should be

	if (vendor == intel && stepping < 5) {
		...
	}

and it appears to work again, until it turns out that Cyrix has the same
issue, and then it ends up being the test from hell, where different
vendor tests all clash, and it gets increasingly difficult to add a new
thing later on sanely. 

In contrast, having the test be

	if (feature & SEPNEW) {
		...
	}

your test is simplified, easier to read and understand, AND it is much
easier to account for different vendors who have different stepping levels
etc. Especially as some vendors need setup code for the thing to work at
all, so it's not even stepping levels, it's stepping levels PLUS some
certain magic sequence that must have been done to initialize the thing.

No thank you. We'll just require fixed feature flags. Which can be turned
on as the features are enabled.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
