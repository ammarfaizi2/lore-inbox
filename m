Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUCNXW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 18:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbUCNXW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 18:22:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:62353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262040AbUCNXWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 18:22:55 -0500
Date: Sun, 14 Mar 2004 15:22:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: marcelo.tosatti@cyclades.com, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-Id: <20040314152253.05c58ecc.akpm@osdl.org>
In-Reply-To: <20040314230138.GV30940@dualathlon.random>
References: <20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp>
	<Pine.LNX.4.44.0403141638390.1554-100000@dmt.cyclades>
	<20040314121503.13247112.akpm@osdl.org>
	<20040314230138.GV30940@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > 
> > Having a magic knob is a weak solution: the majority of people who are
> > affected by this problem won't know to turn it on.
> 
> that's why I turned it _on_ by default in my tree ;)

So maybe Marcelo should apply this patch, and also turn it on by default.

> There are workloads where adding anonymous pages to the lru is
> suboptimal for both the vm (cache shrinking) and the fast path too
> (lru_cache_add), not sure how 2.6 optimizes those bits, since with 2.6
> you're forced to add those pages to the lru somehow and that implies
> some form of locking.

Basically a bunch of tweeaks:

- Per-zone lru locks (which implicitly made them per-node)

- Adding/removing sixteen pages for one taking of the lock.

- Making the lock irq-safe (it had to be done for other reasons, but
  reduced contention by 30% on 4-way due to not having a CPU wander off to
  service an interrupt while holding a critical lock).

- In page reclaim, snip 32 pages off the lru completely and drop the
  lock while we go off and process them.

