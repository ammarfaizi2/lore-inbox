Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269284AbUJKVzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269284AbUJKVzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269330AbUJKVzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:55:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3726 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269284AbUJKVwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:52:51 -0400
Date: Mon, 11 Oct 2004 23:54:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Sven Dietrich <sdietrich@mvista.com>
Cc: Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, abatyrshin@ru.mvista.com,
       amakarov@ru.mvista.com, emints@ru.mvista.com, ext-rt-dev@mvista.com,
       hzhang@ch.mvista.com, yyang@ch.mvista.com
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041011215420.GA19796@elte.hu>
References: <20041011204959.GB16366@elte.hu> <EOEGJOIIAIGENMKBPIAEAEIDDKAA.sdietrich@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EOEGJOIIAIGENMKBPIAEAEIDDKAA.sdietrich@mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sven Dietrich <sdietrich@mvista.com> wrote:

> IMO the number of raw_spinlocks should be lower, I said teens before. 
> 
> Theoretically, it should only need to be around hardware registers and
> some memory maps and cache code, plus interrupt controller and other
> SMP-contended hardware.

yeah, fully agreed. Right now the 90 locks i have means roughly 20% of
all locking still happens as raw spinlocks.

But, there is a 'correctness' _minimum_ set of spinlocks that _must_ be
raw spinlocks - this i tried to map in the -T4 patch. The patch does run
on SMP systems for example. (it was developed as an SMP kernel - in fact
i never compiled it as UP :-|.) If code has per-CPU or preemption
assumptions then there is no choice but to make it a raw spinlock, until
those assumptions are fixed.

> There are some concurrency issues in kernel threads, and I think there
> is a lot of work here.  The abstraction for LOCK_OPS is a good
> alternative, but like the spin_undefs, its difficult to tell in the
> code whether you are dealing with a mutex or a spinlock. 

what do you mean by 'it's difficult to tell'? In -T4 you do the choice
of type in the data structure and the API adapts automatically. If the
type is raw_spinlock_t then a spin_lock() is turned into a
_raw_spin_lock(). If the type is spinlock_t then the spin_lock() is
redirected to mutex_lock(). It's all transparently done and always
correct.

> There are a whole lot of caveats and race conditions that have not yet
> been unearthed by the brief LKML testing. [...]

actually, have you tried your patchset on an SMP box? As far as i can
see the locking in it ignores SMP issues _completely_, which makes the
choice of locks much less useful.

	Ingo
