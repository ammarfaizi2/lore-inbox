Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271967AbRHVIzA>; Wed, 22 Aug 2001 04:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271966AbRHVIyk>; Wed, 22 Aug 2001 04:54:40 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:3563 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271963AbRHVIyf>;
	Wed, 22 Aug 2001 04:54:35 -0400
Date: Wed, 22 Aug 2001 09:54:47 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mike Touloumtzis <miket@bluemug.com>, Robert Love <rml@tech9.net>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <46395243.998474087@[169.254.198.40]>
In-Reply-To: <20010821231002.C27313@bluemug.com>
In-Reply-To: <20010821231002.C27313@bluemug.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

>> Again, /dev/urandom is just as "secure" as /dev/random.  Its the same
>> pool.  The same stuff.  Except that /dev/random blocks when the entropy
>> count hits 0.
>
> You have been repeating that there is no difference in security
> between /dev/random and /dev/urandom, but consider this: you install
> a kernel/hardware combination without any registered SA_SAMPLE_RANDOM
> IRQs (i.e. headless, no IDE, no NICs with SA_SAMPLE_RANDOM IRQs).

(& no access to any block devices - but leave that for the time
being)

> The entropy pool for such a system starts at 0s, unless I'm
> misreading the source; from create_entropy_store():
>
>         memset(r->pool, 0, poolwords*4);
>
> As long as no interrupt ever adds randomness to this pool, I might be
> able to predict every bit ever read from /dev/random on this machine.

You would read precisely 0 bits from /dev/random, as it would
sit there blocking, with no entropy in the system.
You would be able to predict the bits from /dev/urandom.
Both pretty useless for generating useful random numbers,
but the blocking behaviour is probably safer.

This is the 'seeding' problem we refer to. After you've seeded
the random number generator (perhaps provide some entropy from
a file from the last boot), you wouldn't have this problem. And
/dev/urandom and /dev/random stay the same.

The suggestion of counting various events which are 'reasonably
unpredictable' but potentially observable, but not count them
as entropy, helps the seeding problem. Noone has argued that
using network IRQs to add randomness to the pool, but NOT count
as entropy, would be bad.

> /dev/random is very good for making sure you never generate a GPG
> key on a machine like this.  I agree with most people on this thread
> that session keys are usually safe coming from /dev/urandom.  But you
> should still make sure you have at least one device feeding into
> the entropy pool, something I'm sure many admins have no clue about
> and don't verify.

If they have none, they will know it very soon, as /dev/random will
block. It is currently hard to boot without accessing block devices,
however (and yes, on a duplicated machine, with embedded hardware
with predictable timing and no moving parts, this isn't much of
an entropy source either).

--
Alex Bligh
