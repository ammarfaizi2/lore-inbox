Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUKRPxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUKRPxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUKRPwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:52:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:16800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262505AbUKRPry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:47:54 -0500
Date: Thu, 18 Nov 2004 07:47:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] fix __flush_tlb*() preemption bug on
 CONFIG_PREEMPT
In-Reply-To: <20041118124656.GA4256@elte.hu>
Message-ID: <Pine.LNX.4.58.0411180742290.2222@ppc970.osdl.org>
References: <20041118124656.GA4256@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Nov 2004, Ingo Molnar wrote:
> 
> note that reproducing this bug was only possible under PREEMPT_RT (there
> it can be triggered in 30 seconds, with the right reproducer) - it needs
> a really unlikely scenario which PREEMPT_RT's high concurrency does
> offer but which is apparently much harder to reproduce in the vanilla
> kernel. The patch fixes x86 and x64. Other architectures are most likely
> safe, but they need review as well.

Ok, that's a pretty race.

However, I'm wondering whether this is the proper approach. After all, a
lazy-tlb process should never have any reason to flush its TLB, since "its
TLB" just aint there, and it ends up flushing somebody elses.

So I assume that this happens only with kswapd or similar? It really might 
be interesting to make the "we were a lazy tlb, and we're flushing 
somebody else" case do a stack dump, because I _suspect_ that this really 
is a special thing, and maybe the right thing to do is to make it special 
in _that_ path.

Very impressive debugging, btw. That must have been painful.

		Linus
