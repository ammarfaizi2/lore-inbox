Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271942AbRHVGKH>; Wed, 22 Aug 2001 02:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271941AbRHVGJ5>; Wed, 22 Aug 2001 02:09:57 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:62479 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S271940AbRHVGJv>; Wed, 22 Aug 2001 02:09:51 -0400
Date: Tue, 21 Aug 2001 23:10:02 -0700
To: Robert Love <rml@tech9.net>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <20010821231002.C27313@bluemug.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
	riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org> <998193404.653.12.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998193404.653.12.camel@phantasy>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2001 at 11:56:41PM -0400, Robert Love wrote:
> 
> Again, /dev/urandom is just as "secure" as /dev/random.  Its the same
> pool.  The same stuff.  Except that /dev/random blocks when the entropy
> count hits 0.

You have been repeating that there is no difference in security
between /dev/random and /dev/urandom, but consider this: you install
a kernel/hardware combination without any registered SA_SAMPLE_RANDOM
IRQs (i.e. headless, no IDE, no NICs with SA_SAMPLE_RANDOM IRQs).
This configuration is not hard to imagine for, say, a dedicated
server appliance or embedded device.

The entropy pool for such a system starts at 0s, unless I'm
misreading the source; from create_entropy_store():

        memset(r->pool, 0, poolwords*4);

As long as no interrupt ever adds randomness to this pool, I might be
able to predict every bit ever read from /dev/random on this machine.
I don't need to break SHA-1, I just run the algorithm forward from
its starting point.  I guess I would probably have to know the size
of each read, so in practice an active network (TCP initial sequence
numbers) in combination with other reads would make my job harder.
But it's still a scary scenario.  And it comes from the fact that
although /dev/urandom is a strong PRNG, it is still deterministic,
and if I know its complete state at any point and can simulate
subsequent events, I can predict its behavior.

/dev/random is very good for making sure you never generate a GPG
key on a machine like this.  I agree with most people on this thread
that session keys are usually safe coming from /dev/urandom.  But you
should still make sure you have at least one device feeding into
the entropy pool, something I'm sure many admins have no clue about
and don't verify.

miket
