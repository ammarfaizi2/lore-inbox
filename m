Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUIHM5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUIHM5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUIHM4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:56:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:5251 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267568AbUIHMwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:52:07 -0400
Date: Wed, 8 Sep 2004 14:53:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-smp.patch, 2.6.9-rc1-bk14
Message-ID: <20040908125339.GA20132@elte.hu>
References: <20040908111751.GA11507@elte.hu> <Pine.LNX.4.53.0409080814570.15087@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409080814570.15087@montezuma.fsmlabs.com>
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


* Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> > to solve this problem i've introduced a new spinlock field,
> > lock->break_lock, which signals towards the holding CPU that a
> > spinlock-break is requested by another CPU. This field is only set if a
> > CPU is spinning in a spinlock function [at any locking depth], so the
> > default overhead is zero. I've extended cond_resched_lock() to check for
> > this flag - in this case we can also save a reschedule. I've added the
> > lock_need_resched(lock) and need_lockbreak(lock) methods to check for
> > the need to break out of a critical section.
> 
> Doesn't having break_lock within the same cacheline as lock bounce the
> line around more?

in fact this way it bounces less than if it were on a separate
cacheline. Contention causes bouncing anyway. This way we already have
the cacheline dirty and on the local CPU when we set break_lock, which
the lockholder CPU bounces back when it breaks the lock and/or releases
the lock.

	Ingo
