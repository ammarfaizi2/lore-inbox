Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280996AbRKTIeS>; Tue, 20 Nov 2001 03:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280997AbRKTIeI>; Tue, 20 Nov 2001 03:34:08 -0500
Received: from are.twiddle.net ([64.81.246.98]:7367 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S280996AbRKTIdy>;
	Tue, 20 Nov 2001 03:33:54 -0500
Date: Tue, 20 Nov 2001 00:33:38 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jan Hubicka <jh@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: i386 flags register clober in inline assembly
Message-ID: <20011120003338.A24717@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jan Hubicka <jh@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20011118020957.A10674@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0111171844001.899-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111171844001.899-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 17, 2001 at 06:48:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 06:48:22PM -0800, Linus Torvalds wrote:
> That sounds pretty ideal - have some way of telling gcc to add a "seta
> %reg", while at the same time telling gcc that if it can elide the "seta"
> and use a direct jump instead, do so..

Hmm.  It appears to be easy to do with machine-dependent builtins.  E.g.

	int x;
	__asm__ __volatile__(LOCK "subl %1,%0"
			     : "=m"(v->counter) : "ir"(i) : "memory");
	x = __builtin_ia32_sete();
	if (x) {
		...
	}

Now, you'd have to be careful in where that __builtin_ia32_sete
gets placed, but I'd guess that immediately after an asm would
be relatively safe.  No 100% guarantees on that, unfortunately.

And the sete _ought_ to get merged with the if test by combine
or cse with no extra code.

It wouldn't take too much effort to try this out either...


r~
