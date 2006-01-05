Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWAEWVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWAEWVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWAEWVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:21:42 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6530 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751075AbWAEWVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:21:41 -0500
Date: Thu, 5 Jan 2006 23:21:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
Message-ID: <20060105222106.GA26474@elte.hu>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BD4C66.60001@austin.ibm.com>
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


* Joel Schopp <jschopp@austin.ibm.com> wrote:

> The bne- and isync together form a sufficient import barrier.  See 
> PowerPC Book2 Appendix B.2.1.1

ok. Please correct me if i'm wrong: the question is, could we on ppc64 
use atomic_dec_return() for mutex_lock(), and atomic_inc_return() for 
mutex_unlock().

atomic_dec_return() does:

        EIEIO_ON_SMP
"1:     lwarx   %0,0,%1         # atomic_dec_return\n\
        addic   %0,%0,-1\n"
        PPC405_ERR77(0,%1)
"       stwcx.  %0,0,%1\n\
        bne-    1b"
        ISYNC_ON_SMP

the EIEIO_ON_SMP is in essence smp_wmb(), correct? (it's a bit stronger 
because it also orders IO-space writes, but it doesnt impose any 
restrictions on reads)

ISYNC_ON_SMP flushes all speculative reads currently in the queue - and 
is hence a smp_rmb_backwards() primitive [per my previous mail] - but 
does not affect writes - correct?

if that's the case, what prevents a store from within the critical 
section going up to right after the EIEIO_ON_SMP, but before the 
atomic-dec instructions? Does any of those instructions imply some 
barrier perhaps? Are writes always ordered perhaps (like on x86 CPUs), 
and hence the store before the bne is an effective write-barrier?

	Ingo
