Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269576AbUIZQeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269576AbUIZQeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 12:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269578AbUIZQen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 12:34:43 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:25793 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S269576AbUIZQeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 12:34:12 -0400
Date: Sun, 26 Sep 2004 12:32:29 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux@horizon.com
Cc: jmorris@redhat.com, cryptoapi@lists.logix.cz, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040926163229.GB28317@certainkey.com>
References: <20040926014218.GZ28317@certainkey.com> <20040926064617.7537.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040926064617.7537.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 06:46:17AM -0000, linux@horizon.com wrote:
> > And I showed that the SHA-1 in random.c now can produce collisions.
> 
> This, I do not recall.  I must have missed it.  Will you please show me
> two inputs that, when fed to the SHA-1 in random.c, will produce
> identical output?

SHA-1 without padding, sure.

hash("a") = hash("a\0") = hash("a\0\0") = ...
hash("b") = hash("b\0") = hash("b\0\0") = ...
hash("c") = hash("c\0") = hash("c\0\0") = ...

I've failed in my attempt to present a good argument for Fortuna.  Guess I'll
just sit on this patch.  Is this above a big issue?  No because as you two
pointed out the hash() uses full block sizes.

This is a trying thread for me to continue, by no fault of yours.  I thought
I made it very clear when I started that I saw *no* vulnerability in the
current /dev/random.  This did not prevent Ted and yourself to ignore this
statement as immediately assume when I say "you could have done this better"
to mean "ha!  I've hax0rd your silly code, I'm l33t." - an infuriating blow
to my professionalism.  Then I simply follow that up with insult to injury
by trying to clear up the whole mess and only making things worse.

> > Or did I misunderstand you?  Were you just mentioning the weakened algorithms
> > as a "what if they were more serious discoveries?  Wouldn't be be nice if we
> > didn't rely on them?" ?
> 
> Yes.  And Fortuna's *only* layer of armor is the block cipher.  Yes,
> it's a damn good layer of armor, but defense in depth sure helps.
> 
> That is NOT to say that lots of half-assed algorithms piled on top of
> each other makes good crypto, but if you can have a good primitive and
> *then* use it safely as well, that's better.
> 
> For example, AES is supposed to be resistant to adaptive chosen
> plaintext/ciphertext attacks.  Suppose you are given two ciphertexts
> and two corresponding plaintexts, but not which corresponds to which.
> And then you are given access to an oracle which will, using the same
> key as was used on the plaintext/ciphertext pairs, give you the plaintext
> for any ciphertet that's not one of the two, and the ciphertext for any
> plaintext that's not one of the two.  The orace can answer basically an
> infinite number of questions (well, 2^128-2) and you can look at one set
> of answers before posing the next.
> 
> AES is supposed to prevent you from figuring out, with all that help,
> which plaintext of the two goes with which ciphertext, with more than 50%
> certainty.  I.e. you are given an infinite series of such challenges and
> offered even-odds bets on your answer.  In the long run, you shouldn't
> be able to make money.
> 
> Yes, AES *should* be able to hold up even to that, but that's really
> placing all your eggs in one basket.  If you can give it more help
> without weakening other parts, that's Good Design.
> 
> If I'm designing a protocol, I'll try to design it so that an attacker
> *doesn't* have access to such an oracle, or the responses are too slow
> to make billions of them, or asking more than a few dozen questions will
> raise alarms, or some such.  I'll change keys so the time in which an
> attacker has to mount their attack is limited.  I'll do any of a number
> of things which let the German navy keep half of their U-boat traffic
> out of the hands of Bletchley park even through they didn't know there
> were vast gaping holes in the underlying cipher.

If say, the key for the AES256-CTR layer changed after every block-read from
/dev/random?

> > The decision to place trust in a entropy estimation scheme vs. a crypto
> > algorithm we have different views on.  I can live with that.
> 
> Better crypto is fine.  But why *throw out* the entropy estimation and
> rely *entirely* on the crypto?  Feel free to argue that the crypto in
> Fortuna is better (although Ted is making some strong points that it
> *isn't*), but is it necessary to throw the baby out with the bathwater?
> Can't you get the best of both worlds?

My past arguments for removing entropy estimation were hand-waving at best
(rate of /dev/random output ~= rate of event sources' activity like
keyboards, disks, etc).  This could (not likely) lead to information about
what the system is doing.  If an attacker could open and close tcp ports, or
ping an ethernet card to generate IRQs which are fed into the PRNG and
increasing the entropy count - would this be usable in an attack?  Not likely.
Would you want to close-off this avenue of attack?  Majority seems to say
"no", but I personally would like to.  And that is where my argument falls
apart.

> > I "completly and totally" agree.  I'm pointing out that no added padding
> > makes me, the new guy reading your code, work harder to decide if it's a
> > weakness.  You shouldn't do that to people if you can avoid it.
> 
> Sorry, but if you know enough to know why the padding is necessary, you
> should know when it isn't.  Feel free to say "isn't this a weakness?
> I read in $BOOK that that padding was important to prevent some attacks"
> and propose a comment patch.  But to say "this is crap because I don't
> understand one little detail and you should replace it with my shiny
> new 2005 model" when it's your ignorance and not a real problem is
> unbelievably arrogant.

Sigh.  Perhaps I need to be excruciatingly clear:
  - SHA1-nopadding() is less secure than SHA1-withpadding()
  - It doesn't apply to random.c

I though it was clear ... clearly I was delusional.

> > Just like you shouldn't obfuscate code, even if it doesn't "weaken"
> > its implementation.  It's just rude.  Take the performance penalty to
> > avoid scaring people away from a very important peice of the kernel.
> 
> Tell it to the marines.  I'd say "tell it to Linus", because he'll laugh
> louder, but his time is valuable to me.
> 
> Part of the Linux developer's credo, learned at Linus' knee, is that
> Performance Matters.  If you don't worry about 5% all the time, after 15
> revisions you've running at half speed and it's a lot of work to catch up.

I see.  And in the -mm examples, is the code easily readable for other
os-MemMgt types?  If no, then I guess random.c is not the exception and I
apologize.

> What *is* critical is the input mixing stage, because that happens at
> interrupt time, and many many people care passionately about interrupt
> latency.  And /dev/random wants to be non-optional, always there for
> people to use so they don't have to invent their own half-assed
> equivalent.

And the ring-buffer system which delays the expensive mixing stages untill a
a sort interrupt does a great job (current and my fortuna-patch).  Different
being, fortuna-patch appears to be 2x faster.

> > The quantitaive aspects of the two RNGs in question are not being discussed.
> > It's the qualitative aspects we do not see eye to eye on.  So I will no
> > longer suggest replacing the status-quo.  I'd like to submit a patch to let
> > users chose at compile-time under Cryptographic options weither to drop in
> > Fortuna.
> > 
> > Ted, can we leave it at this?
> 
> You're welcome to write the patch.  But I have to warn you, if you
> hope to get it into the standard kernel rather than just have a
> separately maintained patch, you'll need to persuade Linus or someone
> he trusts (who in theis case is probably Ted) that your patch is
> a) better in some way or another than the existing code, and
> b) important enough to warrant the maintenance burden that having
>    two sets of equivalent code imposes.
> 
> You're being offered a lot of clues.  Please, take some.

I appreciate the feedback for what it's worth.  Thanks.

JLC
