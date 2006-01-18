Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWARDWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWARDWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWARDWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:22:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964885AbWARDWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:22:35 -0500
Date: Tue, 17 Jan 2006 19:22:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] mm: Convert global dirty_exceeded flag to per-node
 node_dirty_exceeded
Message-Id: <20060117192216.5a6f1d27.akpm@osdl.org>
In-Reply-To: <20060118030959.GD5289@localhost.localdomain>
References: <20060117020352.GB5313@localhost.localdomain>
	<20060116181323.7a5f0ac7.akpm@osdl.org>
	<20060118012953.GC5289@localhost.localdomain>
	<20060117180956.7f2627a6.akpm@osdl.org>
	<20060118030959.GD5289@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> > OK.  That's a bit nasty, isn't it?  It can work well or poorly for
> > different people depending upon vagaries of .config and the linker.
> > 
> > We should find out what it was sharing _with_.  Could you please run
> > 
> > 	nm -n vmlinux| grep -C5 dirty_exceeded
> 
> ffffffff805290c0 b irq_dir
> ffffffff80529838 b root_irq_dir
> ffffffff80529880 B max_pfn
> ffffffff80529888 B min_low_pfn
> ffffffff80529890 B max_low_pfn
> ffffffff80529900 B nr_pagecache
> ffffffff80529908 B nr_swap_pages
> ffffffff80529980 b boot_pageset
> ffffffff8052a980 B laptop_mode
> ffffffff8052a984 B block_dump
> ffffffff8052a988 b dirty_exceeded
> ffffffff8052a990 b total_pages
> ffffffff8052a998 B nr_pdflush_threads
> ffffffff8052a9a0 b last_empty_jifs
> ffffffff8052a9c0 B slab_reclaim_pages
> ffffffff8052a9c4 b slab_break_gfp_order
> ffffffff8052a9c8 b g_cpucache_up
> ffffffff8052a9d0 b cache_chain
> ffffffff8052a9e0 b cache_chain_sem
> ffffffff8052aa00 b offslab_limit
> ffffffff8052aa08 B page_cluster
> 
> Maybe slab_reclaim_pages is the culprit? 
> 

I guess so - pretty much everything else there should be in __read_mostly
anwyay, apart from nr_pagecache.

slab_reclaim_pages is just a silly beancounting thing for overcommit.  We
could give it the approximate-counting treatment like pagecache_acct() I
guess.
