Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVJKBAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVJKBAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 21:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVJKBAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 21:00:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55438 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751328AbVJKBAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 21:00:48 -0400
Date: Mon, 10 Oct 2005 17:59:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Savochkin <saw@sawoct.com>
Cc: torvalds@osdl.org, ak@suse.de, dev@sw.ru, linux-kernel@vger.kernel.org,
       xemul@sw.ru, st@sw.ru, discuss@x86-64.org
Subject: Re: SMP syncronization on AMD processors (broken?)
Message-Id: <20051010175920.21018fac.akpm@osdl.org>
In-Reply-To: <20051006192106.A13978@castle.nmd.msu.ru>
References: <434520FF.8050100@sw.ru>
	<p73hdbuzs7l.fsf@verdi.suse.de>
	<20051006174604.B10342@castle.nmd.msu.ru>
	<Pine.LNX.4.64.0510060750230.31407@g5.osdl.org>
	<20051006192106.A13978@castle.nmd.msu.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@sawoct.com> wrote:
>
> I start to wonder about existing mainstream code, presumably bug-free, that
>  uses spinlocks without any problematic restart.
>  If one day some piece starts to be called too often by some legitimate
>  reasons, it might fall into the same pattern and completely block others who
>  want to take the same spinlock.

There are surely places in the kernel where we do get into a corner and do
drop a lock in the expectation that another CPU will acquire it and get us
out of the mess we got ourselves into.  One is
fs/jbd/commit.c:inverted_lock(), and I've always been afraid that it might
be vulnerable to NUMA capture effects such as you describe.

Presently inverted_lock() just does a completely pointless schedule() and
remains that way because nobody has reported it locking up yet :(

>  I'm not advocating for changing spinlock implementation, it's just a
>  thought...

It would make sense in these cases if there was some primitive which we
could call which says "hey, I expect+want another CPU to grab this lock in
preference to this CPU".

Note that inverted_lock() uses bit_spin_lock() - that's just a detail but
it does illustrate that any such primitive shouldn't be specific to just
spinlocks and rwlocks.

(And yes, I once looked at fixing JBD "for real" but it was really hard. 
Fact is, the commit code and the filesystem code really do want to take
those locks in opposite order).
