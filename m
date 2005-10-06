Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVJFQCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVJFQCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVJFQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:02:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751123AbVJFQCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:02:32 -0400
Date: Thu, 6 Oct 2005 09:01:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Kirill Korotaev <dev@sw.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, Andrey Savochkin <saw@sawoct.com>, st@sw.ru
Subject: Re: SMP syncronization on AMD processors (broken?)
In-Reply-To: <Pine.LNX.4.61.0510061631260.11029@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0510060846590.31407@g5.osdl.org>
References: <434520FF.8050100@sw.ru> <Pine.LNX.4.64.0510060741000.31407@g5.osdl.org>
 <Pine.LNX.4.61.0510061631260.11029@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Hugh Dickins wrote:
> 
> That reminds me: ought cond_resched_lock to be doing something more?

I suspect the "need_resched()" case is sufficient in practice: it might 
not be perfect, but let's face it, there's not a lot we can do.

It's true that the cpu_relax() basically does nothing except perhaps by 
luck (and depending on CPU and memory setup). There's no good alternative, 
though. You could make it more complex and change the cpu_relax() to 
something like

	i = random_backoff();
	for (;;) {
		cpu_relax();
		if (spin_is_locked(lock))
			break;
		if (!need_lockbreak(lock))
			break;
		if (!--i)
			break;
	}

but I'd argue vehemently that you shouldn't do this unless you can see 
real problems.

I doubt it's really a problem in practice. You have to have a really hot 
spinlock that stays hot on one CPU (and most of them you can't even _make_ 
hot from user space), and I suspect we've fixed the ones that matter.

		Linus
