Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274641AbRITUxH>; Thu, 20 Sep 2001 16:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274648AbRITUw5>; Thu, 20 Sep 2001 16:52:57 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:35126 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274641AbRITUwh>; Thu, 20 Sep 2001 16:52:37 -0400
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Chris Mason <mason@suse.com>,
        Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <3BAA29C2.A9718F49@zip.com.au>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com>,
	<20010920170812.CCCACE641B@ns1.suse.com> <773660000.1001006393@tiny> 
	<3BAA29C2.A9718F49@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 16:52:46 -0400
Message-Id: <1001019170.6090.134.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 13:39, Andrew Morton wrote:
> > Andrew, are these still maintained or should I pull out the reiserfs bits?
> 
> This is the reiserfs part - it applies to 2.4.10-pre12 OK.
> 
> For the purposes of Robert's patch, conditional_schedule()
> should be defined as 
> 
> 	if (current->need_resched && current->lock_depth == 0) {
> 		unlock_kernel();
> 		lock_kernel();
> 	}
> 
> which is somewhat crufty, because the implementation of lock_kernel()
> is arch-specific.  But all architectures seem to implement it the same way.

Note that we only support preemption on i386 thus far, so this is not an
issue (yet).

One other note, in not all cases is it OK to just drop the one lock
(above it is).  Say we hold a spinlock, but another lock (most notably
the BKL) is also held.  Since the preemption counter is recursive, we
still won't allow preemption until all locks are dropped.  In this case,
we need to see what else needs to be dropped, or just call schedule()
explicitly.

> <patch snipped>

Looks nice, Andrew.

Anyone try this? (I don't use ReiserFS).

I am putting together a conditional scheduling patch to fix some of the
worst cases, for use in conjunction with the preemption patch, and this
might be useful.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

