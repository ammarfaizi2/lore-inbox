Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTJABBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 21:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTJABBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 21:01:51 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:20102 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261861AbTJABBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 21:01:50 -0400
Date: Wed, 1 Oct 2003 02:01:25 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, "Hu, Boris" <boris.hu@intel.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.0-test6 oops futex"
Message-ID: <20031001010125.GB32209@mail.shareable.org>
References: <20030930084853.GD26649@mail.jlokier.co.uk> <Pine.LNX.4.44.0309302141220.4388-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309302141220.4388-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> I can't quite make the flaw I do see, fit the facts Klaus sees.
> 
> Consider unqueue_me on one cpu racing against this->key = key2 in
> futex_requeue on another.  unqueue_me finds the right bh to lock
> from q->key, but futex_requeue is shifting q->key beneath it.
> Although futex_requeue holds both the relevant spinlocks, during
> reassignment of key an irrelevant hashqueue may get calculated
> and locked instead.
> 
> Whether or not this is relevant to Klaus' oops, it does need to be
> fixed, doesn't it?  And your new key_refs version even more exposed?
> I'm giving up on it, but expect you or Rusty will be ingenious enough
> to rescue the split locks somehow.

Superb analysis!

It does indeed explain Klaus' oops.  unqueue_me() and futex_poll()
hash using &q->key outside any spinlocks, so if there's a concurrent
futex_requeue() the hash can be corrupt.  Result: wrong lock taken;
list manipulation races in test6, not in test5.  (Provided Klaus has
SMP or pre-empt).

Solutions are to call hash_futex() inside the lock, or store the
hash result inside futex_q, and read it inside the lock.

You're right, the key_refs version is more exposed, but because of the
change to futux_requeue logic rather than anything to do with key_refs.

> (Oh, while you're there, be nice to fix nr_requeue 0.)

Logically, zero num in FUTEX_QUEUE shouldn't wake anything either, but
it's understood that at least one is always woken.  It's a bit of a
wart I agree, but I'll go along with Ulrich's view.

Thanks,
-- Jamie
