Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVCPK1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVCPK1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVCPK1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:27:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:12451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262335AbVCPK1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:27:08 -0500
Date: Wed, 16 Mar 2005 02:26:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rostedt@goodmis.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
Message-Id: <20050316022638.237f72cd.akpm@osdl.org>
In-Reply-To: <20050316101209.GA16893@elte.hu>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	<Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	<20050315120053.GA4686@elte.hu>
	<Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	<20050315133540.GB4686@elte.hu>
	<Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	<20050316085029.GA11414@elte.hu>
	<20050316011510.2a3bdfdb.akpm@osdl.org>
	<20050316095155.GA15080@elte.hu>
	<20050316020408.434cc620.akpm@osdl.org>
	<20050316101209.GA16893@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> > ooh, I'd rather not.  I spent an intense three days removing all the
>  > sleeping locks from ext3 (and three months debugging the result). 
>  > Ended up gaining 1000% on 16-way.
>  > 
>  > Putting them back in will really hurt the SMP performance.
> 
>  ah. Yeah. Sniff.
> 
>  if we gain 1000% on a 16-way then there's something really wrong about
>  semaphores (or scheduling) though. A semaphore is almost a spinlock, in
>  the uncontended case - and even under contention we really (should) just
>  spend the cycles that we'd spend spinning. There will be some
>  intermediate contention level where semaphores hurt, but 1000% sounds
>  truly excessive.

I forget how much of the 1000% came from that, but it was quite a lot.

Removing the BKL was the first step.  That took the context switch rate
under high load from ~10,000/sec up to ~300,000/sec.  Because the first
thing a CPU hit on entry to the fs was then a semaphore.  Performance rather
took a dive.

Of course the locks also became much finer-grained, so the contention
opportunities lessened.  But j_list_lock and j_state_lock have fs-wide
scope, so I'd expect the context switch rate to go up quite a lot again.

The hold times are short, and a context switch hurts rather ore than a quick
spin.

