Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269695AbUJGG1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269695AbUJGG1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 02:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269696AbUJGG1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 02:27:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23734 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269695AbUJGG1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 02:27:39 -0400
Date: Thu, 7 Oct 2004 08:29:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Default cache_hot_time value back to 10ms
Message-ID: <20041007062908.GB32679@elte.hu>
References: <20041006134317.03a22198.akpm@osdl.org> <200410062313.i96NDo609923@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410062313.i96NDo609923@unix-os.sc.intel.com>
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


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Here is a patch that revert default cache_hot_time value back to the
> equivalence of pre-domain scheduler, which determins task's cache
> affinity via architecture defined variable cache_decay_ticks.

i could agree with this oneliner patch for 2.6.9, it only affects the
SMP balancer and there for the most common boxes it likely results in a
similar migration cutoff as the 2.5 msec we currently have. Here are the
changes that occur on a couple of x86 boxes:

 2-way celeron, 128K cache:         2.5 msec -> 1.0 msec 
 2-way/4-way P4 Xeon 1MB cache:     2.5 msec -> 2.0 msec
 8-way P3 Xeon 2MB cache:           2.5 msec -> 6.0 msec

each of these changes is sane and not too drastic.

(on ia64 there is no auto-tuning of cache_decay_ticks, there you've got
a decay=<x> boot parameter anyway, to fix things up.)

there was one particular DB test that was quite sensitive to idle time
introduced by too large migration cutoff: dbt2-pgsql. Could you try that
one too and compare -rc3 performance to -rc3+migration-patches?

> This is a mere request that we go back to what *was* before, *NOT* as
> a new scheduler tweak (Whatever tweak done for domain scheduler broke
> traditional/ industry recognized workload).
> 
> As a side note, I'd like to get involved on future scheduler tuning
> experiments, we have fair amount of benchmark environments where we
> can validate things across various kind of workload, i.e., db, java,
> cpu, etc.  Thanks.

yeah, it would be nice to test the following 3 kernels:

 2.6.9-rc3 vanilla,
 2.6.9-rc3 + cache_hot_fix + use-cache_decay_ticks
 2.6.9-rc3 + cache_hot_fixes + autotune-patch

using as many different CPU types (and # of CPUs) as possible.

The most important factor in these measurements is statistical stability
of the result - if noise is too high then it's hard to judge. (the
numbers you posted in previous mails are quite stable, but not all
benchmarks are like that.)

> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
