Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269122AbUIHLp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269122AbUIHLp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269131AbUIHLp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:45:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:52114 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269122AbUIHLp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:45:28 -0400
Date: Wed, 8 Sep 2004 04:43:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] max-sectors-2.6.9-rc1-bk14-A0
Message-Id: <20040908044328.46eec88b.akpm@osdl.org>
In-Reply-To: <20040908104931.GA5523@elte.hu>
References: <20040908100448.GA4994@elte.hu>
	<20040908030944.4cd0e3a0.akpm@osdl.org>
	<20040908104931.GA5523@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> * Andrew Morton <akpm@osdl.org> wrote:
> 
>  > > the attached patch introduces two new /sys/block values:
>  > > 
>  > >    /sys/block/*/queue/max_hw_sectors_kb
>  > >    /sys/block/*/queue/max_sectors_kb
>  > > 
>  > >  max_hw_sectors_kb is the maximum that the driver can handle and is
>  > >  readonly. max_sectors_kb is the current max_sectors value and can be
>  > >  tuned by root. PAGE_SIZE granularity is enforced.
>  > > 
>  > >  It's all locking-safe and all affected layered drivers have been updated
>  > >  as well. The patch has been in testing for a couple of weeks already as
>  > >  part of the voluntary-preempt patches and it works just fine - people
>  > >  use it to reduce IDE IRQ handling latencies.
>  > 
>  > Could you remind us what the cause of the latency is, and its
>  > duration?
>  >
>  > (Am vaguely surprised that it's an issue at, what, 32 pages?  Is
>  > something sucky happening?)
> 
>  yes, we are touching and completing 32 (or 64?) completely cache-cold
>  structures: the page and the bio which are on two separate cachelines a
>  pop. We also call into the mempool code for every bio completed. With
>  the default max_sectors people reported hardirq latencies up to 1msec or
>  more. You can see a trace of a 600+usec latency at:
> 
>    http://krustophenia.net/testresults.php?dataset=2.6.8-rc4-bk3-O7#/var/www/2.6.8-rc4-bk3-O7/ide_irq_latency_trace.txt
> 
>  here it's ~8 usecs per page completion - with 64 pages this completion
>  activity alone is 512 usecs. So people want to have a way to tune down
>  the maximum overhead in hardirq handlers. Users of the VP patches have
>  reported good results (== no significant performance impact) with
>  max_sectors at 32KB (8 pages) or even 16KB (4 pages).

Still sounds a bit odd.  How many cachelines can that CPU fetch in 8 usecs?
Several tens at least?
