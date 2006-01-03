Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWACPVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWACPVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWACPVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:21:33 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:24712 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932400AbWACPVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:21:32 -0500
Date: Tue, 3 Jan 2006 16:21:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 04/19] mutex subsystem, add include/asm-i386/mutex.h
Message-ID: <20060103152117.GA2445@elte.hu>
References: <20060103100737.GD23289@elte.hu> <43BA7B2E.4070101@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BA7B2E.4070101@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >+#ifdef __HAVE_ARCH_CMPXCHG
> >+	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
> >+		return 1;
> >+	return 0;
> >+#else
> >+	return fail_fn(count);
> >+#endif
> >+}
> 
> asm-i386 version I think really should just use atomic_cmpxchg 
> unconditionally, because otherwise an i386 compatible kernel will not 
> use cmpxchg even when running on 486+ (not sure how important that is 
> these days, but still...).

yeah. This code predates the generic-atomic-cmpxchg code. (Feel free to 
review all __HAVE_ARCH_CMPXCHG users after this goes in, and remove 
__HAVE_ARCH_CMPXCHG altogether with a CONFIG_ flag.)

but ... the spinlock based variant is quite likely faster (on i386) than 
generic-cmpxchg. Couldnt we introduce a new API, something along the 
lines of:

	atomic_cmpxchg_lock(&count, &lock->wait_lock);

and if the cmpxchg fails, it would hold the spinlock? The cmpxchg 
semantics could be guaranteed by the spinlock. (because it is 'global' 
for that particular critical section)

	Ingo
