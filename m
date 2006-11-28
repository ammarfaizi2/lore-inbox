Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935132AbWK1EXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935132AbWK1EXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 23:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935141AbWK1EXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 23:23:49 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:54742 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S935132AbWK1EXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 23:23:49 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Entropy Pool Contents
Date: Tue, 28 Nov 2006 04:17:02 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ekgd7u$6gp$1@taverner.cs.berkeley.edu>
References: <ek2nva$vgk$1@sea.gmane.org> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu> <EB3E5F09-6529-4AB9-B7EF-DFCACC6D445E@mac.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1164687422 6681 128.32.168.222 (28 Nov 2006 04:17:02 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Tue, 28 Nov 2006 04:17:02 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warning: tangent with little practical relevance follows:

Kyle Moffett  wrote:
>Actually, our current /dev/random implementation is secure even if  
>the cryptographic algorithms can be broken under traditional  
>circumstances.

Maybe.  But, I've never seen any careful analysis to support this or
characterize exactly what assumptions are needed for this to be true.
Some weakened version of your claim might be accurate, but at a minimum
you probably need to make some heuristic assumptions about the sources
of randomness and the distribution of values they generate, and you may
also need some assumptions that the SHA hash function isn't *totally*
broken.  If you make worst-case assumptions, I doubt that this claim
can be justified in any rigorous way.

(For instance, compressing random samples with the CRC process is a
heuristic that presumably works fine for most randomness sources, but
it cannot be theoretically justified: there exist sources for which it
is problematic.  Also, the entropy estimator is heuristic and will
overestimate the true amount of entropy available, for some sources.
Likewise, if you assume that the cryptographic hash function is totally
insecure, then it is plausible that carefully chosen malicious writes to
/dev/random might be able to reduce the total amount of entropy in the
pool -- at least, I don't see how to prove that this is impossible.)

Anyway, I suspect this is all pretty thoroughly irrelevant in practice.
It is very unlikely that the crypto schemes are the weakest link in the
security of a typical Linux system, so I'm just not terribly worried
about the scenario where the cryptography is completely broken.  It's
like talking about whether, hypothetically, /dev/random would still be
secure if pigs had wings.

>When generating long-term cryptographic private keys, however, you  
>*should* use /dev/random as it provides better guarantees about  
>theoretical randomness security than does /dev/urandom.  Such  
>guarantees are useful when the random data will be used as a  
>fundamental cornerstone of data security for a server or network  
>(think your root CA certificate or HTTPS certificate for your million- 
>dollar-per-year web store).

Well, if you want to talk about really high-value keys like the scenarios
you mention, you probably shouldn't be using /dev/random, either; you
should be using a hardware security module with a built-in FIPS certified
hardware random number source.  The risk of your server getting hacked
probably exceeds the risk of a PRNG failure.

I agree that there is a plausible argument that it's safer to use
/dev/random when generating, say, your long-term PGP private key.
I think that's a reasonable view.  Still, the difference in risk
level in practice is probably fairly minor.  The algorithms that use
that private key are probably going to rely upon the security of hash
functions and other crypto primitives, anyway.  So if you assume that
all modern crypto algorithms are secure, then /dev/urandom may be just
as good as /dev/random; whereas if you assume that all modern crypto
algorithms are broken, then it may not matter much what you do.  I can
see a reasonable argument for using /dev/random for those kinds of keys,
on general paranoia and defense-in-depth grounds, but you're shooting
at a somewhat narrow target.  You only benefit if the crypto algorithms
are broken just enough to make a difference between /dev/random and
/dev/urandom, but not broken enough to make PGP insecure no matter how
you pick your random numbers.  That's the narrow target.  There are
better things to spend your time worrying about.

Nothing you say is unreasonable; I'm just sharing a slightly different
perspective on it all.
