Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274997AbTHLDbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 23:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275000AbTHLDbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 23:31:06 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:37126 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S274997AbTHLDbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 23:31:01 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
Date: Tue, 12 Aug 2003 03:30:22 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bh9n0e$nbf$1@abraham.cs.berkeley.edu>
References: <20030810023606.GA15356@ghanima.endorphin.org> <1060525667.14835.4.camel@chtephan.cs.pocnet.net> <20030810210306.GA2235@ghanima.endorphin.org> <1060553236.25524.49.camel@chtephan.cs.pocnet.net>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1060659022 23919 128.32.153.211 (12 Aug 2003 03:30:22 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Tue, 12 Aug 2003 03:30:22 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout  wrote:
>Before encryption the data to be encrypted gets xor'ed with the result
>from the previous encrypted block. The idea in cryptoloop is that not
>the result from the previous run gets used but a specially constructed
>dummy block that has the sector number (little-endian encoded) in the
>first four bytes and is null every where else. So you simply get some
>additional perturbation based on the sector number, so that zero-filled
>sectors always looked differently after encoding.
>
>When decoding this means that the sector number is xor'ed over the
>encrypted block. If, when decoding, the sector number doesn't match that
>one that was put in the iv while encoding that sector, you will get
>errors in the first four bytes, mostly one or few bits flipped.

Unrelated to the corruption issues:

Is this how cryptoloop works?  The sector number is used directly as the
IV (not the encrypted sector number)?  In other words, if X denotes the
first block of plaintext and S the sector number, then the first block
of ciphertext is C = E_K(X ^ S)?

If yes, I noticed a small security weakness.  This usage of CBC mode can
leak a few bits of information about the plaintext data, in some cases.
For instance, consider the following example.  Let X denote the first block
of plaintext at sector S, and X' the first block of plaintext at sector S'.
Suppose X' = X^1 and S' = S^1 (here "^" denotes xor, as usual).  Then
C = E_K(X^S), and C' = E_K(X'^S') = E_K((X^1)^(S^1)) = E_K(X^S) = C.
This condition can be recognized in the encrypted data.

In other words, here's the attack.  The attacker looks at two sectors,
number S and S', and looks at the first block of ciphertext in each sector,
call them C and C'.  If C = C', then the attacker knows that
X = X' ^ S ^ S', where X and X' denote the first block of plaintext in
each sector.  If plaintext were totally random, this would almost never
happen (with probability 2^-64 for a 64-bit block cipher).  However,
plaintext data often isn't exactly random.  There are some plausible
ways that the condition X = X' ^ S ^ S' could arise with non-negligible
probability, and if this happens, information leaks to the attacker.

Is this a problem worth fixing?  You'll have to decide.  Fortunately,
there is a simple fix: use the encrypted sector number as IV, not the
plaintext sector number.  In other words, the IV would be E_K(S), and
thus the first block of ciphertext would be C = E_K(X ^ E_K(S)).  This
fix makes the above attack go away.
