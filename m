Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272067AbTHRPrC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272070AbTHRPrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:47:01 -0400
Received: from waste.org ([209.173.204.2]:463 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272067AbTHRPqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:46:47 -0400
Date: Mon, 18 Aug 2003 10:46:25 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@intercode.com.au>,
       Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030818154625.GB16387@waste.org>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030815221211.GA4306@think> <20030815235501.GB325@waste.org> <20030818032348.GA9456@think>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818032348.GA9456@think>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 11:23:48PM -0400, Theodore Ts'o wrote:
> On Fri, Aug 15, 2003 at 06:55:01PM -0500, Matt Mackall wrote:
> > I posted a proof of concept patch for discussion on $SUBJECT. In that
> > patch, I removed the folding for the purposes of having a reasonable
> > comparison between cryptoapi and native. Cryptoapi does FIPS-180-1 and
> > thus does twice as much hashing on 512 bits. 
> 
> It would be nice if there was a Crypto API algorithm variant which
> didn't do the FIPS-180-1 padding, for those applications (like
> /dev/random) that don't need it.

I'm looking at one, but the two layers of indirection in cryptoapi make
this tricky. 
 
> > As for "screwing with /dev/random", it's got rather more serious and
> > longstanding problems than speed that I've been addressing. For
> > instance, I'm pretty sure there was never a time when entropy
> > accounting wasn't racy let alone wrong, SMP or no (fixed in -mm, thank
> > you). Nor has there ever been a time when change_poolsize() wasn't an
> > oops waiting to happen (patch queued for resend).
> 
> Agreed, fixing the locking is much more important than CryptoAPI
> changes.  Can you send me a pointer to your latest locking patches?
> I'd like to look them over.  Thanks!!

Locking fixes:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm4/broken-out/random-locking-fixes.patch

Ignore the changelog, it doesn't match the patch. Instead read what I
wrote to Andrew.

Accounting stuff at:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm4/broken-out/random-accounting-and-sleeping-fixes.patch

The above involved a lot of carefully going over logs with entropy
debugging turned on as most of it wasn't obvious from reading the
code. There are still a couple corner cases in the above but they fall
on the undercounting side. For the separated output pool patch, the xfer
code ends up looking like this, which is much easier to follow:

+static void reseed_pool(struct entropy_store *r, int margin, int wanted)
+{
+       __u32 tmp[TMP_BUF_SIZE];
+       int bytes;
+
+       DEBUG_ENT("reseed %s wants %d bits (margin %d)\n",
+                 r->name, wanted*8, margin);
+
+       /* Never more than can fit in buffer */
+       bytes = min_t(int, wanted, sizeof(tmp));
+       /* Nor more than destination has room for */
+       bytes = min_t(int, bytes, (r->poolinfo->POOLBITS-r->entropy_count)/8);
+       /* Nor too much to starve other pools */
+       bytes = min_t(int, bytes, (input_pool->entropy_count - margin)/8);
+       /* And never less than catastrophic reseed threshold */
+       if(bytes < read_thresh/8)
+               return;
+
+       DEBUG_ENT("trying to reseed %s with %d bits\n", r->name, bytes*8);
+
+       bytes=extract_entropy(input_pool, tmp, bytes, EXTRACT_ENTROPY_LIMIT);
+       add_entropy_words(r, tmp, bytes+3/4);
+       credit_entropy_store(r, bytes*8);

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
