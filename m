Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967172AbWKYVSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967172AbWKYVSg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967185AbWKYVSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:18:36 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:25307 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S967172AbWKYVSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:18:36 -0500
Date: Sun, 26 Nov 2006 00:18:18 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "David S. Miller" <davem@davemloft.net>,
       David Howells <dhowells@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: atomic_add_unless() and mb()
Message-ID: <20061125211818.GA167@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both Documentation/memory-barriers.txt and Documentation/atomic_ops.txt state
that atomic_add_unless() implies smp_mb() on each side of the operation.

Is it true?

include/asm-most_of/atomic.h:

	#define atomic_add_unless(v, a, u)				\
	({								\
		int c, old;						\
		c = atomic_read(v);					\
		for (;;) {						\
			if (unlikely(c == (u)))				\
				break;					\
			old = atomic_cmpxchg((v), c, c + (a));		\
			if (likely(old == c))				\
				break;					\
			c = old;					\
		}							\
		c != (u);						\
	})

This looks like atomic_add_unless() implies mb() only if it returns 1.
Otherwise it could fail (return 0) before the first atomic_cmpxchg(),
but atomic_read() provides a compiler barrier only.

Could you clarify?

Oleg.

