Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUI0Aug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUI0Aug (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 20:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUI0Aug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 20:50:36 -0400
Received: from science.horizon.com ([192.35.100.1]:23340 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S265331AbUI0Aud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 20:50:33 -0400
Date: 27 Sep 2004 00:50:33 -0000
Message-ID: <20040927005033.14622.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@certainkey.com
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Cc: cryptoapi@lists.logix.cz, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       linux@horizon.com, tytso@mit.edu
In-Reply-To: <20040926052308.GB8314@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This, I do not recall.  I must have missed it.  Will you please show me
>> two inputs that, when fed to the SHA-1 in random.c, will produce
>> identical output?

> SHA-1 without padding, sure.

> hash("a") = hash("a\0") = hash("a\0\0") = ...
> hash("b") = hash("b\0") = hash("b\0\0") = ...
> hash("c") = hash("c\0") = hash("c\0\0") = ...

And how do I hash one byte with SHA-1 *without padding*?  The only
hashing code I can find in random.c works 64 bytes at a time.
What are the other 63 bytes?

(I agree that that *naive* padding leads to collisions, but random.c
doesn't do ANY padding.)

> I see.  And in the -mm examples, is the code easily readable for other
> os-MemMgt types?  If no, then I guess random.c is not the exception and I
> apologize.

The Linux core -mm code is a fairly legendary piece of Heavy Wizardry.
To paraphrase, "do not meddle in the affairs of /usr/src/linux/mm/, for
it is subtle and quick to anger."  There *are* people who understand it,
and it *is* designed (not a decaying pile of old hacks that *nobody*
understands how it works like some software), but it's also a remarkably
steep learning curve.  A basic overview isn't so hard to acquire, but the
locking rules have subtle details.  There are places where someone very good
noticed that a given lock doesn't have to be taken on a fast path if you
avoid doing certain things anywhere else that you'd think would be legal.

And so if someone tries to add code to do the "obvious" thing, the
lock-free fast path develops a race condition.  And we all know what
fun race conditions are to debug.

Fortunately, some people see this as a challenge and Linux is blessed with
some extremely skilled VM hackers.  And some of them even write and publish
books on the subject.  But while a working VM system can be clear, making it
go fast leads to a certain amount of tension with the clarity goal.

> And the ring-buffer system which delays the expensive mixing stages untill a
> a sort interrupt does a great job (current and my fortuna-patch).  Difference
> being, fortuna-patch appears to be 2x faster.

Ooh, cool!  Must play with to steal the speed benefits.  Thank you!
