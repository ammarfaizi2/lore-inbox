Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268961AbUIXVfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268961AbUIXVfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 17:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbUIXVfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 17:35:38 -0400
Received: from [69.25.196.29] ([69.25.196.29]:48304 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S268961AbUIXVfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 17:35:34 -0400
Date: Fri, 24 Sep 2004 17:34:52 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040924213452.GA22399@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>,
	linux-kernel@vger.kernel.org
References: <20040923234340.GF28317@certainkey.com> <20040924043851.GA3611@thunk.org> <20040924125457.GO28317@certainkey.com> <20040924174301.GB20320@thunk.org> <20040924175929.GU28317@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924175929.GU28317@certainkey.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 01:59:29PM -0400, Jean-Luc Cooke wrote:
> > If they only want crypto-secure random numbers, they can do it in
> > userspace.  Information secure random numbers is something the kernel
> > can provide, because it has low-level access to entrpoy sources.  So
> > why not try to do the best possible job? 
> 
> Sure.  I hate Brittney Spears, but I will not deny people the choice.

The principle of avoiding kernel bloat means that if it doesn't have
to be done in the kernel, it should be done in userspace.  If all
you're providing is an CRNG, the question then is why should it be
done in kernel, when it could be done just as easily in userspace, and
using /dev/random as its input?

> > This is another red herring.  First of all, we're not using the hash
> > as a MAC, or in any way where we would care about collisions.
> > Secondly, all of the places where we take a hash, we are always doing
> > it 16 bytes at a time, which is SHA's block size, so that there's no
> > need for any padding.  And although you didn't complain about it,
> > that's also why we don't need to mix in the length in the padding;
> > extension attacks just simply aren't an issue, since the way we are
> > using the hash, that just simply an issue as far as the strength of
> > /dev/random.
> 
> Woh there.  Didn't you just say "see, these hashes are weakened.  That's
> bad".  Now I just demonstrated the same thing with your SHA1 implementation
> and you throw that "red-herring" phrase out again?

No, what I'm saying is that crypto primitives can get weakened; this
is a fact of life.  SHA-0, MD4, MD5, etc. are now useless as general
purpose cryptographic hashes.  Fortuna makes the assumptions that
crypto primitives will never break, as it relies on them so heavily.
I have a problem with this, since I remember ten years ago when people
were as confident in MD5 as you appear to be in SHA-256 today.

Crypto academics are fond of talking about how you can "prove" that
Fortuna is secure.  But that proof handwaves around the fact that we
have no capability of proving whether SHA-1, or SHA-256, is truly
secure.

In contrast, /dev/random doesn't have this dependence, which (a) is a
good thing, and (b) why it doesn't bother with the SHA finalization
step.  It's simply not necessary.

						- Ted
