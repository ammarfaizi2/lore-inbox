Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUI0O3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUI0O3P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 10:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUI0O3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 10:29:15 -0400
Received: from [69.25.196.29] ([69.25.196.29]:6338 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264991AbUI0O3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 10:29:13 -0400
Date: Mon, 27 Sep 2004 10:23:52 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux@horizon.com
Cc: jlcooke@certainkey.com, cryptoapi@lists.logix.cz, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040927142352.GA15589@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, linux@horizon.com,
	jlcooke@certainkey.com, cryptoapi@lists.logix.cz,
	jmorris@redhat.com, linux-kernel@vger.kernel.org
References: <20040926052308.GB8314@thunk.org> <20040927005033.14622.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927005033.14622.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 12:50:33AM -0000, linux@horizon.com wrote:
> > And the ring-buffer system which delays the expensive mixing stages untill a
> > a sort interrupt does a great job (current and my fortuna-patch).  Difference
> > being, fortuna-patch appears to be 2x faster.
> 
> Ooh, cool!  Must play with to steal the speed benefits.  Thank you!

The speed benefits come from the fact that /dev/random is currently
using a large pool to store entropy, and so we end up taking cache
line misses as we access the memory.  Worse yet, the cache lines are
scattered across the memory (due to the how the LFSR works), and we're
using/updating information from the pool 32 bits at a time.  In
contrast, in JLC's patch, each pool only has enough space for 256 bits
of entropy (assuming the use of SHA-256), and said 256 bits are stored
packed next to each other, so it can fetch the entire pool in one or
two cache lines.

This is somewhat fundamental to the philosophical question of whether
you store a large amount of entropy, taking advantage of the fact that
the kernel has easy access to hardware-generated entropy, or use tiny
pools and put a greater faith in crypto primitives.

So the bottom line is that while Fortuna's input mixing uses more CPU
(ALU) resources, /dev/random is slower because of memory latency
issue.  On processors with Hyperthreading / SMT enabled (which seems
to be the trend across all architectures --- PowerPC, AMD64, Intel,
etc.), the memory latency usage may be less important, since other
tasks will be able to use the other (virtual) half of the CPU while
the entropy mixing is waiting on the memory access to complete.  On
the other hand, it does mean that we're chewing up a slightly greater
amount of memory bandwidth during the entropy mixing process.  Whether
or not any of this is actually measurable during real-life mixing is
an interesting and non-obvious question.

						- Ted
