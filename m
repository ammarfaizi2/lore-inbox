Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWCHBtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWCHBtj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWCHBtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:49:39 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:18063 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751344AbWCHBtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:49:39 -0500
Date: Tue, 7 Mar 2006 20:45:53 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386 spinlocks: disable interrupts only if we
  enabled them
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Message-ID: <200603072049_MC3-1-BA0B-ED8F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060307161550.27941df5.akpm@osdl.org>

On Tue, 7 Mar 2006 16:15:50, Andrew Morton wrote:

> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > Fastpath before patch:
> >         jle <keep looping>      not-taken conditional jump
> >         cli                     disable interrupts
> >         jmp <try for lock>      unconditional jump
> > 
> > Fastpath after patch, if interrupts were not enabled:
> >         jg <try for lock>       taken conditional branch
> > 
> 
> Well no.  The fastpath is:
> 
>       jns     4f              we got the lock.

 That's debatable.  Once the spinlock is available, jumping back to
try and get it becomes fastpath code, even though the spinloop itself
is not.  Any delay seen here means lost cycles that could be doing work.

 My only real question is how long 'cli' takes if interrupts are already
disabled.

> And it's increasing text size.  Which wouldn't be a big problem if the
> spinning code was still in an out-of-line section, but it isn't any more.

 __raw_spin_lock_flags is inlined, but only one place, in
_spin_lock_irqsave(), which is no longer an inline.  So there's no real
need to out-of-line the spin code anymore.  This adds nine bytes, which
should be acceptable in an out-of-line function. (Only the unlock functions
are inlined, and even then only if !CONFIG_PREEMPT).


-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

