Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272679AbRHaMhS>; Fri, 31 Aug 2001 08:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272680AbRHaMhH>; Fri, 31 Aug 2001 08:37:07 -0400
Received: from [195.89.159.99] ([195.89.159.99]:6138 "EHLO kushida.degree2.com")
	by vger.kernel.org with ESMTP id <S272679AbRHaMg6>;
	Fri, 31 Aug 2001 08:36:58 -0400
Date: Fri, 31 Aug 2001 13:37:50 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010831133750.A25128@thefinal.cern.ch>
In-Reply-To: <200108310128.f7V1SSn08071@moisil.badula.org> <Pine.LNX.4.33.0108302204350.15159-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108302204350.15159-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Aug 30, 2001 at 10:08:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > 	if (len <= (int) sizeof(short) || len > (int) sizeof(*sunaddr))
> 
> You're so full of shit that it's incredible.
> 
> I'mnot going to argue this, when people call stuff like the above the
> "natural way". This is not worth it.

While I agree with Linus that the above line is ugly, there is a problem
with the original line:

    if (len <= sizeof(short) || len > sizeof(*sunaddr))

The problem?  Thinking this is natural, suppose you decide you only need
to check len against sizeof(short), perhaps here, perhaps copying this
idea to another part of the program:

    if (len <= sizeof(short))

_This_ code has a bug.  The comparison is unsigned; i.e. len is
converted to unsigned int first, so if the user passes a negative value,
the comparison returns false and the code will break.  It only works in
the original example because the second comparison checks the bogus
results of the first one.

Now, any later use of len should not lead to a buffer overflow or
anything, because you always check against a maximum size for copying,
yes?

No.  Consider this hypothetical code to copy things up to a page at a
time.  len is a signed type s.t. sizeof(len) <= sizeof(size_t):

   if (len <= sizeof(struct thing) || len > MAX_BUFFER_SIZE) {
           printk(KERN_ERR "Sanity check failed!\n");
           goto out;
   }
   memcpy (to, from, len);

Inexperienced C programmers, and sleepy ones, may not see the fault.

cheers,
-- Jamie
