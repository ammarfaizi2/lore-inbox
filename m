Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272052AbTHOWNT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272064AbTHOWNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:13:19 -0400
Received: from thunk.org ([140.239.227.29]:38303 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S272052AbTHOWNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:13:08 -0400
Date: Fri, 15 Aug 2003 18:12:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: James Morris <jmorris@intercode.com.au>,
       Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815221211.GA4306@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Matt Mackall <mpm@selenic.com>,
	James Morris <jmorris@intercode.com.au>,
	Jamie Lokier <jamie@shareable.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, davem@redhat.com
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813040614.GP31810@waste.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:06:14PM -0500, Matt Mackall wrote:
> 
> The argument applies to any and all structure. If X and Y are n-bit
> words and some pairs (X,Y) are more likely than others even though X
> and Y are perfectly distributed when looked at normally, the
> distribution (and hence the entropy) of X^Y will be less ideal than X
> or Y taken alone. No statistical tests will catch the case of
> X=hash(a) and Y=hash(~a).

Right, but that's also easy to test.  You just simply test the
statistical randomness of folded hash.  In any case, if there was any
kind of correlation between any two bits in the SHA hash, that would
be a significant weakness in the hash, and would have detected before
now. 

> I'll buy that. However simply dropping the data would serve this
> purpose better. As would hashing less than the entire pool on each
> read. 

Dropping the data does serve this purpose, yes.  But it has the
downside of exposing half the hash directly to the attacker.  This
probably shouldn't be an issue, but if you assume no statistical
correlation between any two bits, folding will hide half of the hash.

In any case, it probably doesn't make that much difference either way,
assuming that SHA is anywhere near competently designed.

> > Speed really doesn't matter here.  /dev/random is supposed to produce
> > somethign which is close to true randomness, not crypto
> > psuedo-randomness.  So overkill is a good thing.  It should only be
> > used for generating long-term keys, so speed is really not a concern. 
> 
> Mostly agreed. But I would also like to:
> 
> a) cat /dev/urandom > /dev/hda and not have it take all day

You shouldn't be using /dev/urandom this way.  OpenBSD has a
/dev/frandom which is just a quick psuedo-random generator.  I've
resisted this, since there's no reason why this should be done in the
kernel.  User-space is perfectly capable of taking 160 bits of
randomness out of /dev/urandom, and using it to seed a SHA-based
random number generator.  However, if people insist on doing silly
things like "cat /dev/urandom > /dev/hda", and worse yet, screwing
with the /dev/random and /dev/urandom with the excuse that speed is of
importance, then perhaps following OpenBSD and implementing
/dev/frandom is a better choice.

> b) enable syncookies with less of a performance penalty

Syncookies doesn't use the mainline random number generator at all.
It uses a syncookie secret generated using the high quality random
number generator, and it uses a single crank of the SHA hash to
generate the random number.

> c) generate other short-term keys, cookies, and UUIDs rapidly

In the kernel or in user space?  In either case, the right answer is
to do something similar to what Syncookies does --- pull a seed from
/dev/urandom, and then use simple SHA-based PRNG to generate
short-term keys, cookies, or UUID's.

> d) not disable preemption for long stretches while hashing (a
>    limitation of cryptoapi)

Sounds like a bug in CryptoAPI that should be fixed in CryptoAPI.

						- Ted
