Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271941AbRHVG0x>; Wed, 22 Aug 2001 02:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271940AbRHVG0o>; Wed, 22 Aug 2001 02:26:44 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:35860 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S271943AbRHVG02>; Wed, 22 Aug 2001 02:26:28 -0400
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
From: Robert Love <rml@tech9.net>
To: Mike Touloumtzis <miket@bluemug.com>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
In-Reply-To: <20010821231002.C27313@bluemug.com>
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org>
	<998193404.653.12.camel@phantasy>  <20010821231002.C27313@bluemug.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.20.07.08 (Preview Release)
Date: 22 Aug 2001 02:26:36 -0400
Message-Id: <998461609.5166.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-08-22 at 02:10, Mike Touloumtzis wrote:
> You have been repeating that there is no difference in security
> between /dev/random and /dev/urandom, but consider this: you install
> a kernel/hardware combination without any registered SA_SAMPLE_RANDOM
> IRQs (i.e. headless, no IDE, no NICs with SA_SAMPLE_RANDOM IRQs).
> This configuration is not hard to imagine for, say, a dedicated
> server appliance or embedded device.
> 
> The entropy pool for such a system starts at 0s, unless I'm
> misreading the source; from create_entropy_store():
> 
>         memset(r->pool, 0, poolwords*4);

You are correct, it starts at zero.  Although, you are _supposed_ to
seed the pool with entropy from the previous session (save/restore
entropy on shutdown/boot).  All distributions I know do this correctly.
Obviously, however, this is not possible in your scenerio (no disks and
no entropy anyhow to save).

> As long as no interrupt ever adds randomness to this pool, I might be
> able to predict every bit ever read from /dev/random on this machine.
> I don't need to break SHA-1, I just run the algorithm forward from
> its starting point.  I guess I would probably have to know the size
> of each read, so in practice an active network (TCP initial sequence
> numbers) in combination with other reads would make my job harder.
> But it's still a scary scenario.  And it comes from the fact that
> although /dev/urandom is a strong PRNG, it is still deterministic,
> and if I know its complete state at any point and can simulate
> subsequent events, I can predict its behavior.

In this case, you are right.  Maybe I am unclear, I like /dev/random and
I like the entropy estimating algorithm.  There is just a lot of
confusion about how the entropy pool works and the differences between
/dev/random and /dev/urandom, and it is true that given that SHA-1 is
unbreakable /dev/random and /dev/urandom are alike in most respects.

In your situation, though, it is not ever safe to use the entropy pool
period, since no entropy is generated.  I am not sure if /dev/urandom
would even return.

The solution to this is easy: get something to generate entropy (like my
netdev patch! :) and save/restore the entropy seed.

> /dev/random is very good for making sure you never generate a GPG
> key on a machine like this.  I agree with most people on this thread
> that session keys are usually safe coming from /dev/urandom.  But you
> should still make sure you have at least one device feeding into
> the entropy pool, something I'm sure many admins have no clue about
> and don't verify.

Agreed.  Personally, I always just use /dev/random for stuff I feel
needs true security.  It is important that sysadmins know that something
is generating entropy.  Ideally, it comes from numerous places.  One of
those places can certainly be your network devices if you trust them.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

