Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbTI3Vhw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbTI3Vhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:37:52 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:56641 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S261728AbTI3Vhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:37:45 -0400
Date: Tue, 30 Sep 2003 21:53:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jamie Lokier <jamie@shareable.org>
cc: Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, "Hu, Boris" <boris.hu@intel.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.0-test6 oops futex"
In-Reply-To: <20030930084853.GD26649@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309302141220.4388-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003, Jamie Lokier wrote:
> Klaus Dittrich wrote:
> > With linux-2.6.0-test6 I got several times this oops.
> > I had no problems with linux-2.6.0-test5 before. (absolute stable for me)
> 
> This oops is in the first store in the __list_del() of
> list_del_init(), inside the loop of futex_wake.
> 
> The "next" link of the current futex in the loop is corrupt.  More
> precisely, the iterator list node contains { LIST_POISON1, LIST_POISON2 }
> which means it must have been earlier deleted using list_del().
> 
> The only call to list_del() in the futex code is in unqueue_me(),
> where it is protected against the same spinlock as all the other
> queuing and dequeuing operations.
> 
> The one possibility I can think of is that the hash function isn't
> consistent, either because of a hashing bug or because the hash
> function argument is being changed.  Then different locks would be
> used between one place and another, permitting the lists to become
> corrupt.  That would explain the oops appearing only in test6, which
> is when the new hashing scheme and split locks appeared.
> 
> I don't see any obvious flaw.  Rusty, Hugh, anyone else see it?

Excellent (hah, not again! what a cosy club we share) analysis.

I can't quite make the flaw I do see, fit the facts Klaus sees.

Consider unqueue_me on one cpu racing against this->key = key2 in
futex_requeue on another.  unqueue_me finds the right bh to lock
from q->key, but futex_requeue is shifting q->key beneath it.
Although futex_requeue holds both the relevant spinlocks, during
reassignment of key an irrelevant hashqueue may get calculated
and locked instead.

Whether or not this is relevant to Klaus' oops, it does need to be
fixed, doesn't it?  And your new key_refs version even more exposed?
I'm giving up on it, but expect you or Rusty will be ingenious enough
to rescue the split locks somehow.

(Oh, while you're there, be nice to fix nr_requeue 0.)

Hugh

