Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268515AbUILHpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268515AbUILHpB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268520AbUILHpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:45:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:11433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268515AbUILHo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:44:58 -0400
Date: Sun, 12 Sep 2004 00:42:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: nickpiggin@yahoo.com.au, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-Id: <20040912004256.59a74c28.akpm@osdl.org>
In-Reply-To: <20040912071948.GH2660@holomorphy.com>
References: <20040909155226.714dc704.akpm@osdl.org>
	<20040909230905.GO3106@holomorphy.com>
	<20040909162245.606403d3.akpm@osdl.org>
	<20040910000717.GR3106@holomorphy.com>
	<414133EB.8020802@yahoo.com.au>
	<20040910174915.GA4750@logos.cnet>
	<20040912045636.GA2660@holomorphy.com>
	<4143D07E.3030408@yahoo.com.au>
	<20040912062703.GF2660@holomorphy.com>
	<4143E6C6.40908@yahoo.com.au>
	<20040912071948.GH2660@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> A large stream of faults to map in a file will blow L1 caches of the
>  sizes you've mentioned at every kernel/user context switch. 256 distinct
>  cachelines will very easily be referenced between faults. MAP_POPULATE
>  and mlock() don't implement batching for either ->page_table_lock or
>  ->tree_lock, so the pagevec point is moot in pagetable instantiation
>  codepaths (though it probably shouldn't be).

Instantiation via normal fault-in becomes lock-intensive once you have
enough CPUs.  At low CPU count the page zeroing probably preponderates.

>  O_DIRECT writes and msync(..., ..., MS_SYNC) will use pagevecs on
>  ->tree_lock in a rapid-fire process-triggerable manner. Almost all
>  uses of pagevecs for ->lru_lock outside the scanner that I'm aware
>  of are not rapid-fire in nature (though there probably should be some).

pagetable teardown (munmap, mremap, exit) is the place where pagevecs help
->lru_lock.  And truncate.

>  IMHO pagevecs are somewhat underutilized.
> 

Possibly.  I wouldn't bother converting anything unless a profiler tells
you to though.

>  Sorry, 4*lg(NR_CPUS) is 64 when lg(NR_CPUS) = 16, or 65536 cpus. 512x
>  Altixen would have 4*lg(512) = 4*9 = 36. The 4*lg(NR_CPUS) sizing was
>  rather conservative on behalf of users of stack-allocated pagevecs.

It's pretty simple to diddle PAGEVEC_SIZE, run a few benchmarks.  If that
makes no difference then the discussion is moot.  If it makes a significant
difference then more investigation is warranted.

