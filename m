Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272432AbTHIROo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272932AbTHIROk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:14:40 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:41348 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272432AbTHIRNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:13:44 -0400
Date: Sat, 9 Aug 2003 18:13:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       jmorris@intercode.com.au, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030809171318.GD29647@mail.jlokier.co.uk>
References: <20030809074459.GQ31810@waste.org> <20030809143314.GT31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809143314.GT31810@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> This code is already at about 125% of baseline throughput, and can
> probably reach 250% with some tweaking of cryptoapi's redundant
> padding (in case anyone else cares about being able to get 120Mb/s
> of cryptographically strong random data).

Why would the cryptoapi version be faster, I wondered?  So I had a look.
No conclusions, just observations.

  - random.c defines a constant, SHA_CODE_SIZE.  This selects between
    4 implementations, from smaller to (presumably) faster by
    progressively unrolling more and more.

    This is set to SHA_CODE_SIZE == 0, for smallest code.

    In crypto/sha1.c, the code is roughly equivalent to SHA_CODE_SIZE == 3,
    random.c's _largest_ implementation.

    So you seem to be replacing a small version with a large version,
    albeit faster.

  - One of the optimisations in crypto/sha1.c is:

      /* blk0() and blk() perform the initial expand. */
      /* I got the idea of expanding during the round function from SSLeay */

    Yet, random.c has the opposite:

      /*
       * Do the preliminary expansion of 16 to 80 words.  Doing it
       * out-of-line line this is faster than doing it in-line on
       * register-starved machines like the x86, and not really any
       * slower on real processors.
       */

    I wonder if the random.c method is faster on x86?

  - sha1_transform() in crypto/sha1.c ends with this misleading
    comment.  Was the author trying to prevent data leakage?  If so,
    he failed:

	/* Wipe variables */
	a = b = c = d = e = 0;
	memset (block32, 0x00, sizeof block32);

    The second line will definitely be optimised away.  The third
    could be, although GCC doesn't.

Enjoy,
-- Jamie
