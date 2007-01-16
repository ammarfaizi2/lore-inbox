Return-Path: <linux-kernel-owner+w=401wt.eu-S1751778AbXAPXr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbXAPXr5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 18:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbXAPXr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 18:47:57 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:30530 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbXAPXr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 18:47:56 -0500
X-IronPort-AV: i="4.13,198,1167638400"; 
   d="scan'208"; a="759500133:sNHT42708992"
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: On some configs, sparse spinlock balance checking is broken
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 16 Jan 2007 15:47:42 -0800
Message-ID: <adaejpumt41.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Jan 2007 23:47:44.0637 (UTC) FILETIME=[B7FC82D0:01C739C8]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Ingo -- you seem to be the last person to touch all this stuff, and I
can't untangle what you did, hence I'm sending this email to you)

On at least some of my configs on x86_64, when running sparse, I see
bogus 'warning: context imbalance in '<func>' - wrong count at exit'.

This seems to be because I have CONFIG_SMP=y, CONFIG_DEBUG_SPINLOCK=n
and CONFIG_PREEMPT=n.  Therefore, <linux/spinlock.h> does

	#define spin_lock(lock)			_spin_lock(lock)

which picks up

	void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);

from <linux/spinlock_api_smp.h>, but <linux/spinlock.h> also has:

	#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
		!defined(CONFIG_SMP)
	//...
	#else
	# define spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)

and <asm-x86_64/spinlock.h> has:

	static inline void __raw_spin_unlock(raw_spinlock_t *lock)
	{
		asm volatile("movl $1,%0" :"=m" (lock->slock) :: "memory");
	}

so sparse doesn't see any __releases() to match the __acquires.

This all seems to go back to commit bda98685 ("x86: inline spin_unlock
if !CONFIG_DEBUG_SPINLOCK and !CONFIG_PREEMPT") but I don't know what
motivated that change.

Anyway, Ingo or anyone else, what's the best way to fix this?  Maybe
the right way to fix this is just to define away __acquires/__releases
unless CONFIG_DEBUG_SPINLOCK is set, but that seems suboptimal.

Thanks,
  Roland
