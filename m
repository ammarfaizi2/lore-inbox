Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUIXEmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUIXEmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUIXEko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:40:44 -0400
Received: from [69.25.196.29] ([69.25.196.29]:63913 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267740AbUIXEjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:39:37 -0400
Date: Fri, 24 Sep 2004 00:38:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040924043851.GA3611@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>,
	linux-kernel@vger.kernel.org
References: <20040923234340.GF28317@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923234340.GF28317@certainkey.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 07:43:40PM -0400, Jean-Luc Cooke wrote:
> 
> Here is a patch for the 2.6.8.1 Linux kernel which replaces the existing PRNG
> in random.c with the Fortuna PRNG designed by Ferguson and Schneier (Practical
> Cryptography).  It is regarded in crypto circles as the current state-of-the-art
> in cryptographically secure PRNGs.
>
> Warning: Ted Ts'o and I talked about this at great length in sci.crypt and
> in the end I failed on convince him that my patch was worth becoming main-line,
> and he failed to convince me that status-quo is acceptable considering a better
> solution exists.

I've taken a quick look at your patch, and here are some problems with it.


0.  Code style issues

Take a look at /usr/src/linux/Documentation/CodingStyle, and follow
it, please.  In particular, pay attention to wrapping text
(particularly comment blocks) at 80 characters, max, and lose the
C++-style comments, please.  Maintaining a good common comment
convention is good, too.

1.  Don't leave out-of-date comments behind.  

Your patch makes significant changes, but you haven't updated the
comments to reflect all of your changes.  For example, the comments
for secure TCP sequence number generation are no longer correct.  The
comments about the twisted GFSR document the original scheme, not the
Fortuna generator.  If you're going to remove the code, remove the
comments too, or the resulting mess will be confusing and not very
maintainable.

2.  The kernel will break if CONFIG_CRYPTO is false

The /dev/random driver is designed to be present in the system no
matter what.  This was a design decision that was made long ago, to
simplify user space applications that could count on /dev/random being
present.  This is a philosophical divide; your belief (as you put it
on your web site) seems to be: "If you want secure random numbers but
don't want crypto, then you don't want secure random numbers."  The
problem is that someone may not want (or need) encryption algorithms
in the *kernel*, but they may still want secure random numbers in
*userspace*.

In any case, your patch is broken, since the kernel will simply fail
to build if CONFIG_CRYPTO is turned off.  And simply making the
compilation of /dev/random conditional on CONFIG_CRYPTO isn't good
enough, since there are other portions of the kernel that assume that
random.c will be present.  (For example, irqaction for providing
entropy input, and the TCP stack depends on it for secquence numbers.)

3.  The TCP sequence numbers are broken

The requirements on secure sequence number is far more than just
"needs to be random-ish, but incresing [sic]".  Read RFC 1948:

   The choice of initial sequence numbers for a connection is not
   random.  Rather, it must be chosen so as to minimize the probability
   of old stale packets being accepted by new incarnations of the same
   connection [RFC 1185].

The increasing bit is also not guaranteed, since tmp[0] isn't masked
off.  Not that it would really matter if it did; with only 8 bits
worth of COUNT_BITS, every 256 TCP connections you will wrap, and
expose that connection to the risk that stale packets being accepted.

I'm also a bit concerned about how much time AES takes over the
cut-down MD4, as this may affect networking benchmarks.  (And we don't
need super-strength crypto here.)


As far as the Fortuna generator being "better", it really represents a
philosophical divide between what I call Crypto academics" and "Crypto
engineers".  I won't go into that whole debate here, except to note
that the current /dev/random was designed with close consultation with
Colin Plumb, who wrote the random number generator found in PGP, and
indeed /dev/random is very close to that used in PGP.  In discussions
on sci.crypt, there were those who argued on both side of this issue,
with such notables as Peter Gutmann lining up against Jean-Luc.

>   + Removed entropy estimation
>    - Fortuna doesn't need it, vanilla-/dev/random and other Yarrow-like
>      PRNGs do to survive state compromise and other attacks.

Entropy estimation is a useful concept in that it attempts to limit
possible attacks caused by weaknesses in the crypto algorithms (such
what happened at this year's Crypto's conference, where MD4, MD5,
HAVAL, and SHA-0 were all weakened).  The designed used by PGP and
/dev/random both limit the amount of reliance placed in the crypto
algorithms, where as Fortuna and Yarrow both assume that crypto
primitives are 100% strong.  This is again a philosophical divide;
given that we have access to unpredicitability based on hardware
timings, we should limit the dependence on crypto algorithsm and to
design a system that is closer to "true randomness" as possible.  

>  - Current /dev/random's input mixing function is a linear function.  This is bad in crypto-circles.
>    Why?  Linear functions are communitive, associative and sometimes distributive.
>    Outputs from Linear function based PRNGs are very weak.

This is a red herring.  /dev/random is not a linear function based
PRNG.  We use a linear function for mixing, yes, but we do use SHA-1
as part of the output stage.  And based on how we use SHA-1, even if
arbitrary collisions can be found in SHA-1 (as has been found in
SHA-0) this wouldn't cause a failure of /dev/random's security ---
this is part of the design philosophy of trying to avoid relying over
much on the security of the crypto primitives, as much as possible.

							- Ted
