Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269098AbUIHKsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269098AbUIHKsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269099AbUIHKsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:48:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29623 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269098AbUIHKsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:48:08 -0400
Date: Wed, 8 Sep 2004 12:49:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] max-sectors-2.6.9-rc1-bk14-A0
Message-ID: <20040908104931.GA5523@elte.hu>
References: <20040908100448.GA4994@elte.hu> <20040908030944.4cd0e3a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908030944.4cd0e3a0.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> > the attached patch introduces two new /sys/block values:
> > 
> >    /sys/block/*/queue/max_hw_sectors_kb
> >    /sys/block/*/queue/max_sectors_kb
> > 
> >  max_hw_sectors_kb is the maximum that the driver can handle and is
> >  readonly. max_sectors_kb is the current max_sectors value and can be
> >  tuned by root. PAGE_SIZE granularity is enforced.
> > 
> >  It's all locking-safe and all affected layered drivers have been updated
> >  as well. The patch has been in testing for a couple of weeks already as
> >  part of the voluntary-preempt patches and it works just fine - people
> >  use it to reduce IDE IRQ handling latencies.
> 
> Could you remind us what the cause of the latency is, and its
> duration?
>
> (Am vaguely surprised that it's an issue at, what, 32 pages?  Is
> something sucky happening?)

yes, we are touching and completing 32 (or 64?) completely cache-cold
structures: the page and the bio which are on two separate cachelines a
pop. We also call into the mempool code for every bio completed. With
the default max_sectors people reported hardirq latencies up to 1msec or
more. You can see a trace of a 600+usec latency at:

  http://krustophenia.net/testresults.php?dataset=2.6.8-rc4-bk3-O7#/var/www/2.6.8-rc4-bk3-O7/ide_irq_latency_trace.txt

here it's ~8 usecs per page completion - with 64 pages this completion
activity alone is 512 usecs. So people want to have a way to tune down
the maximum overhead in hardirq handlers. Users of the VP patches have
reported good results (== no significant performance impact) with
max_sectors at 32KB (8 pages) or even 16KB (4 pages).

	Ingo
