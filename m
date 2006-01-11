Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWAKWTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWAKWTm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWAKWTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:19:42 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:53925 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932280AbWAKWTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:19:40 -0500
Date: Wed, 11 Jan 2006 23:19:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, linux-kernel@vger.kernel.org,
       sct@redhat.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs
Message-ID: <20060111221942.GA17231@elte.hu>
References: <200601112126.59796.ak@suse.de> <20060111124617.5e7e1eaa.akpm@osdl.org> <1137012917.2929.78.camel@laptopd505.fenrus.org> <20060111130728.579ab429.akpm@osdl.org> <1137014875.2929.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137014875.2929.81.camel@laptopd505.fenrus.org>
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


* Arjan van de Ven <arjan@infradead.org> wrote:

> > We expect the lock to be held on entry.  Hence we expect mutex_trylock()
> > to return zero.
> 
> you are correct, and the x86-64 mutex.h is buggy

ahh ... indeed! And i386 trylock was buggy too.

	Ingo

----

fix typo in asm-i386/mutex.h:__mutex_fastpath_trylock - noticed by
Arjan van de Ven.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- include/asm-i386/mutex.h.orig
+++ include/asm-i386/mutex.h
@@ -125,7 +125,7 @@ __mutex_fastpath_trylock(atomic_t *count
 	 * the mutex state would be.
 	 */
 #ifdef __HAVE_ARCH_CMPXCHG
-	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
+	if (likely(atomic_cmpxchg(count, 1, 0) == 1))
 		return 1;
 	return 0;
 #else
