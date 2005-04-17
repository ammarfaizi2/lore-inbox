Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVDQAis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVDQAis (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 20:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVDQAis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 20:38:48 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:36362 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261220AbVDQAio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 20:38:44 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fortuna
Date: Sun, 17 Apr 2005 00:36:29 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d3sb2d$sbg$1@abraham.cs.berkeley.edu>
References: <20050416111033.28308.qmail@science.horizon.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113698189 29040 128.32.168.222 (17 Apr 2005 00:36:29 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sun, 17 Apr 2005 00:36:29 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux wrote:
>Thank you for pointing out the paper; Appendix A is particularly
>interesting.  And the [BST03] reference looks *really* nice!  I haven't
>finished it yet, but based on what I've read so far, I'd like to
>*strongly* recommnd that any would-be /dev/random hackers read it
>carefully.  It can be found at
>http://www.wisdom.weizmann.ac.il/~tromer/papers/rng.pdf

Yeah, [BST03] seems worth reading.  It has a reasonable survey of some
previous work, and is well-written.

However, I'm pretty skeptical about [BST03] as a basis for a real-world
randomness generator.  It assumes that there are only 2^t possible
distributions for the source, and the set of possible distributions has
been fixed in advance (before the design of your randomness generator
is revealed).  Consequently, it fails to defend against adaptive attacks.

If the attacker can feed in maliciously chosen inputs (chosen after the
attacker learns which randomness extraction algorithm you are using),
then the BST03 scheme promises nothing.  For instance, if you feed in
timings of network packets, then even if you don't count them as providing
any entropy, the mere act of feeding them into your randomness generator
causes their theorems to be clearly inapplicable (since no matter what
value of t you pick, the adversary can arrange to get more than t bits
of freedom in the network packets he sends you).

So I'm not sure [BST03]'s theorems actually promise what you'd want.

On the other hand, if you want to take their constructions as providing
some intuition or ideas about how one might build a randomness generator,
while realizing that their theorems don't apply and there may be no
useful guarantees that can be proven about such an approach, I don't
have any objections to that view.

By the way, another example of work along these lines is
http://theory.lcs.mit.edu/~yevgen/ps/2-ext.ps
That paper is more technical and theoretically-oriented, so it might
be harder to read and less immediately useful.  It makes a strong
assumption (that you have two sources that are independent -- i.e.,
totally uncorrelated), but the construction at the heart of their paper
is pretty simple, which might be of interest.

>Happily, it *appears* to confirm the value of the LFSR-based input
>mixing function.  Although the suggested construction in section 4.1 is
>different, and I haven't seen if the proof can be extended.

Well, I don't know.  I don't think I agree with that interpretation.

Let me give a little background about 2-universal hashing.  There is a
basic result about use of 2-universal hash functions, which says that
if you choose the seed K truly at random, then you can use h_K(X) to
extract uniform random bits from a non-uniform source X.  (Indeed, you
can even reveal K without harming the randomness of h_K(X).)  The proof
of this fact is usually known as the Leftover Hashing Lemma.

One of the standard constructions of a 2-universal hash function is
as a LFSR-like scheme, where the seed K is used to select the feedback
polynomial.  But notice that it is critical that the feedback polynomial
be chosen uniformly at random, in a way that is unpredictable to the
attacker, and kept secret until you receive data from the source.

What /dev/random does is quite different from the idea of 2-universal
hashing developed in the theory literature and recounted in [BST03].
/dev/random fixes a single feedback polynomial in advance, and publishes
it for the world to see.  The theorems about 2-universal hashing promise
nothing about use of a LFSR with a fixed feedback polynomial.
