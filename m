Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVCLEjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVCLEjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 23:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVCLEgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 23:36:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:50855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261852AbVCLEfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 23:35:03 -0500
Date: Fri, 11 Mar 2005 20:34:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break_lock forever broken
Message-Id: <20050311203427.052f2b1b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> lock->break_lock is set when a lock is contended, but cleared only in
>  cond_resched_lock.  Users of need_lockbreak (journal_commit_transaction,
>  copy_pte_range, unmap_vmas) don't necessarily use cond_resched_lock on it.
> 
>  So, if the lock has been contended at some time in the past, break_lock
>  remains set thereafter, and the fastpath keeps dropping lock unnecessarily.
>  Hanging the system if you make a change like I did, forever restarting a
>  loop before making any progress.
> 
>  Should it be cleared when contending to lock, just the other side of the
>  cpu_relax loop?  No, that loop is preemptible, we don't want break_lock
>  set all the while the contender has been preempted.  It should be cleared
>  when we unlock - any remaining contenders will quickly set it again.
> 
>  So cond_resched_lock's spin_unlock will clear it, no need for it to do
>  that; and use need_lockbreak there too, preferring optimizer to #ifdefs.
> 
>  Or would you prefer the few need_lockbreak users to clear it in advance?
>  Less overhead, more errorprone.

This patch causes a CONFIG_PREEMPT=y, CONFIG_PREEMPT_BKL=y,
CONFIG_DEBUG_PREEMPT=y kernel on a ppc64 G5 to hang immediately after
displaying the penguins, but apparently not before having set the hardware
clock backwards 101 years.

After having carefully reviewed the above description and having decided
that these effects were not a part of the patch's design intent I have
temporarily set it aside, thanks.

