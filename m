Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269487AbUICBXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269487AbUICBXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269474AbUICBRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:17:31 -0400
Received: from ozlabs.org ([203.10.76.45]:16802 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269490AbUICBOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:14:11 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>,
       netfilter-devel@lists.netfilter.org
In-Reply-To: <20040902074604.GA21144@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <1094108653.11364.26.camel@krustophenia.net>
	 <20040902071525.GA19925@elte.hu>
	 <1094110289.11364.32.camel@krustophenia.net>
	 <20040902074604.GA21144@elte.hu>
Content-Type: text/plain
Message-Id: <1094126377.16999.49.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 11:10:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 17:46, Ingo Molnar wrote:
> Rusty, what's going on in this code?

Good question!  Not my code, fortunately...

> #1: we kmalloc(GFP_KERNEL) with a spinlock held and softirqs off - ouch!
> 
> #2: why does it do the kmalloc() anyway? It could store the position in
>     the seq pointer just fine. No need to alloc an integer pointer to
>     store the value in ...
> 
> #3: to fix the latency, ct_seq_show() could take the ip_conntrack_lock 
>     and could check the current index against ip_conntrack_htable_size. 
>     There's not much point in making this non-preemptible, there's 
>     a 4K granularity anyway.

The code tries to put an entire hash bucket into a single seq_read(). 
That's not going to work if the hash is really deep.  On the other hand,
not much will, and it's simple.

The lock is only needed on traversing: htable_size can't change after
init anyway, so it should be done in ct_seq_show.

Fix should be fairly simple...
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

