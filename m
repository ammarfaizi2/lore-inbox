Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269499AbUIZGqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269499AbUIZGqY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 02:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269501AbUIZGqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 02:46:24 -0400
Received: from science.horizon.com ([192.35.100.1]:51519 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S269499AbUIZGqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 02:46:18 -0400
Date: 26 Sep 2004 06:46:17 -0000
Message-ID: <20040926064617.7537.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@certainkey.com
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Cc: cryptoapi@lists.logix.cz, jmorris@redhat.com, linux@horizon.com,
       linux-kernel@vger.kernel.org, tytso@mit.edu
In-Reply-To: <20040926014218.GZ28317@certainkey.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You claimed that the collision techniques found for the UFN design hashs
> (sha0, md5, md5, haval, ripemd) demonstrated the need to not rely on hash
> algorithms for a RNG.  Right?

I'm putting words into Ted's mouth, but it seemed clear to me he said it
was good not to rely *entirely* on the ahsh algorithms.

> And I showed that the SHA-1 in random.c now can produce collisions.

This, I do not recall.  I must have missed it.  Will you please show me
two inputs that, when fed to the SHA-1 in random.c, will produce
identical output?

> So, if your argument against the fallen UFN hashs above (SHA-1 is a UFN
> hash also btw.  We can probably expect more annoucments from the crypto
> community in early 2005) should it not apply to SHA-1 in random.c?

No, not at all.  The point is that the current random.c design DOES NOT
RELY on the security of the hash function.  Ted could drop MD4 in there
and it still couldn't be broken, although using a better-regarded hash
function just feels better.

> Or did I misunderstand you?  Were you just mentioning the weakened algorithms
> as a "what if they were more serious discoveries?  Wouldn't be be nice if we
> didn't rely on them?" ?

Yes.  And Fortuna's *only* layer of armor is the block cipher.  Yes,
it's a damn good layer of armor, but defense in depth sure helps.

That is NOT to say that lots of half-assed algorithms piled on top of
each other makes good crypto, but if you can have a good primitive and
*then* use it safely as well, that's better.

For example, AES is supposed to be resistant to adaptive chosen
plaintext/ciphertext attacks.  Suppose you are given two ciphertexts
and two corresponding plaintexts, but not which corresponds to which.
And then you are given access to an oracle which will, using the same
key as was used on the plaintext/ciphertext pairs, give you the plaintext
for any ciphertet that's not one of the two, and the ciphertext for any
plaintext that's not one of the two.  The orace can answer basically an
infinite number of questions (well, 2^128-2) and you can look at one set
of answers before posing the next.

AES is supposed to prevent you from figuring out, with all that help,
which plaintext of the two goes with which ciphertext, with more than 50%
certainty.  I.e. you are given an infinite series of such challenges and
offered even-odds bets on your answer.  In the long run, you shouldn't
be able to make money.

Yes, AES *should* be able to hold up even to that, but that's really
placing all your eggs in one basket.  If you can give it more help
without weakening other parts, that's Good Design.

If I'm designing a protocol, I'll try to design it so that an attacker
*doesn't* have access to such an oracle, or the responses are too slow
to make billions of them, or asking more than a few dozen questions will
raise alarms, or some such.  I'll change keys so the time in which an
attacker has to mount their attack is limited.  I'll do any of a number
of things which let the German navy keep half of their U-boat traffic
out of the hands of Bletchley park even through they didn't know there
were vast gaping holes in the underlying cipher.

> The decision to place trust in a entropy estimation scheme vs. a crypto
> algorithm we have different views on.  I can live with that.

Better crypto is fine.  But why *throw out* the entropy estimation and
rely *entirely* on the crypto?  Feel free to argue that the crypto in
Fortuna is better (although Ted is making some strong points that it
*isn't*), but is it necessary to throw the baby out with the bathwater?
Can't you get the best of both worlds?

> I "completly and totally" agree.  I'm pointing out that no added padding
> makes me, the new guy reading your code, work harder to decide if it's a
> weakness.  You shouldn't do that to people if you can avoid it.

Sorry, but if you know enough to know why the padding is necessary, you
should know when it isn't.  Feel free to say "isn't this a weakness?
I read in $BOOK that that padding was important to prevent some attacks"
and propose a comment patch.  But to say "this is crap because I don't
understand one little detail and you should replace it with my shiny
new 2005 model" when it's your ignorance and not a real problem is
unbelievably arrogant.

> Just like you shouldn't obfuscate code, even if it doesn't "weaken"
> its implementation.  It's just rude.  Take the performance penalty to
> avoid scaring people away from a very important peice of the kernel.

Tell it to the marines.  I'd say "tell it to Linus", because he'll laugh
louder, but his time is valuable to me.

Part of the Linux developer's credo, learned at Linus' knee, is that
Performance Matters.  If you don't worry about 5% all the time, after 15
revisions you've running at half speed and it's a lot of work to catch up.

The -mm guys have been doing backflips for years to try to get good
paging behaviour without high run-time overhead.  This is one of the
major reasons why the kernel refuses to promise a stable binary
interface to kernel modules.  Rearranging the order of fields in a
strucure for better cache performance is a minor revision.

In fact, large parts of /dev/random deliberately *don't* care about
performance.  The entire output mixing stage is not performance
critical, and is deliberately slow.

What *is* critical is the input mixing stage, because that happens at
interrupt time, and many many people care passionately about interrupt
latency.  And /dev/random wants to be non-optional, always there for
people to use so they don't have to invent their own half-assed
equivalent.

> The quantitaive aspects of the two RNGs in question are not being discussed.
> It's the qualitative aspects we do not see eye to eye on.  So I will no
> longer suggest replacing the status-quo.  I'd like to submit a patch to let
> users chose at compile-time under Cryptographic options weither to drop in
> Fortuna.
> 
> Ted, can we leave it at this?

You're welcome to write the patch.  But I have to warn you, if you
hope to get it into the standard kernel rather than just have a
separately maintained patch, you'll need to persuade Linus or someone
he trusts (who in theis case is probably Ted) that your patch is
a) better in some way or another than the existing code, and
b) important enough to warrant the maintenance burden that having
   two sets of equivalent code imposes.

You're being offered a lot of clues.  Please, take some.
