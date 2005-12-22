Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVLVMAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVLVMAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVLVMAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:00:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18060 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964819AbVLVMAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:00:53 -0500
Date: Thu, 22 Dec 2005 12:00:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 9/9] mutex subsystem, XFS namespace collision fixes
Message-ID: <20051222120052.GC30964@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20051222114308.GJ18878@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222114308.GJ18878@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -#define mutex_init(lock, type, name)		sema_init(lock, 1)
> -#define mutex_destroy(lock)			sema_init(lock, -99)
> -#define mutex_lock(lock, num)			down(lock)
> -#define mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
> -#define mutex_unlock(lock)			up(lock)
> +#define xfs_mutex_init(lock, type, name)	sema_init(lock, 1)
> +#define xfs_mutex_destroy(lock)			sema_init(lock, -99)
> +#define xfs_mutex_lock(lock, num)		down(lock)
> +#define xfs_mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
> +#define xfs_mutex_unlock(lock)			up(lock)

Again, this should really be using the mutex primitives (obviously ;-)).

The patch should become (pseudo-patch):

-typedef struct semaphore	mutex_t
-
-#define mutex_init(lock, type, name)		sema_init(lock, 1)
-#define mutex_destroy(lock)			sema_init(lock, -99)
-#define mutex_lock(lock, num)			down(lock)
-#define mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
-#define mutex_unlock(lock)			up(lock)
+#define mutex_init(lock, type, name)		mutex_init(lock)
+#define mutex_destroy(lock)			do { } while (0)

While we're at it, maybe we should a mutex_destroy aswell?  it would
be non-mandatory and allow that a lock is gone for the debugging variant.
