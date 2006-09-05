Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWIES6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWIES6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWIES6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:58:18 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:34802 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030226AbWIES6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:58:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=pTFZqkgkFY+ii7RGmVpPvmAck6xHBPfKpfJ19hgKYb1pTfpScUtChcxKU/S7dqrSyKufJeCZ3BzsgDi2Nx8OOnBlK4AVOI3zzw9oa3tex1MaS9c4iQ1NBHr0Cu5eCjP/k+l5YqaS24VylUMbF0/yZkqCi4vHLH0dhULRqk3IQ2U=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Ingo Molnar'" <mingo@elte.hu>,
       "'Heiko Carstens'" <heiko.carstens@de.ibm.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Daniel Walker'" <dwalker@mvista.com>
Subject: RE: lockdep oddity
Date: Tue, 5 Sep 2006 11:57:58 -0700
Message-ID: <000b01c6d11d$3f528ff0$6721100a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060905181241.GC16207@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AcbRF/KGDiq6eKjfREGjGRWig5kFkQABPTbw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe we should define raw __likely/__unlikely which behave the same way as the vanilla and use them in places like spinlocks to
avoid these weird problems.

> * Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > The lock validator gives me this (latest -mm and 2.6.18-rc6):
> > 
> > =====================================
> > [ BUG: bad unlock balance detected! ]
> > -------------------------------------
> > swapper/0 is trying to release lock (resource_lock) at:
> > [<0000000000042842>] request_resource+0x52/0x88 but there 
> are no more 
> > locks to release!
> > 
> > The reason is that the BUILD_LOCK_OPS macros in 
> kernel/lockdep.c don't 
> > contain any of the *_acquire calls, while all of the 
> _unlock functions 
> > contain a *_release call. Hence I get immediately unbalanced locks.
> 
> hmmm ... that sounds like a bug. Weird - i recently ran 
> PREEMPT+SMP+LOCKDEP kernels and didnt notice this.
> 
> > Found this will debugging some random memory corruptions 
> that happen 
> > when CONFIG_PROVE_LOCKING and CONFIG_PROFILE_LIKELY are both on.
> > Switching both off or having only one of them on seems to work.
> 
> previously i had some weirdnesses with PROFILE_LIKELY too, 
> they were caused by it generating cross-calls from within 
> lockdep. Do the corruptions go away if you remove all 
> likely() and unlikely() markings from kernel/lockdep.c?
> 
> 	Ingo

