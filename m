Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbTIQDZz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 23:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTIQDZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 23:25:55 -0400
Received: from ns.suse.de ([195.135.220.2]:19132 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262586AbTIQDZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 23:25:53 -0400
Date: Wed, 17 Sep 2003 05:25:51 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
Message-Id: <20030917052551.3abee289.ak@suse.de>
In-Reply-To: <20030916194446.030d8e70.akpm@osdl.org>
References: <20030917022256.GA17624@wotan.suse.de>
	<20030916194446.030d8e70.akpm@osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 19:44:46 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Andi Kleen <ak@suse.de> wrote:
> >
> > 
> > This is much more efficient than the previous workaround used in the kernel,
> > which checked for AMD CPUs in every prefetch(). This can be seen 
> > in the size of the vmlinux:
> 
> That is hardly a serious comparison: the workaround is just to stop the
> oopses while this gets sorted out.  It makes no pretense at either
> efficiency or permanence.

It was mainly to show that the patch is a better solution than what currently
is in the kernel.

> 
> > Without patch:
> >    text    data     bss     dec     hex filename
> > 4020232  665956  169092 4855280  4a15f0 vmlinux
> > With patch:
> > 4011578  665973  169092 4846643  49f433
> 
> hrm.  Why did data grow?

Probably because of the two __get_user in is_prefetch. I suspect their exception
tables get accounted to data.

> 
> > With prefetch check:    3.7268 microseconds
> > Without prefetch check: 3.65945 microseconds
> 
> We don't know how much of this difference is due to removing the branch and
> how much is due to reenabling prefetch.

None at all. The test did not measure prefetch performance, but just
how much overhead is_prefetch adds to the page fault path. 
AFAIK there is no prefetch in the  do_page_fault -> fail to find vma -> signal delivery
path.

As for measuring prefetch I'm not sure it makes sense. It depends a lot
on how fast your memory is, how thrashed your caches are, how many
CPUs you have (e.g. on Opteron memory latency varies based on the
number of CPUs) etc. So even if it isn't a win on some system
it can help on others.
 
> It would be interesting to see comparative benchmarking between prefetch
> and no prefetch at all, see whether this feature is worth its icache
> footprint.

Maybe. But that would be really a separate thing. even with prefetch completely
removed from the kernel we would still need a workaround for user space.

-Andi 
