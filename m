Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266166AbUHNHOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUHNHOS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 03:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUHNHOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 03:14:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47042 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266166AbUHNHOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 03:14:16 -0400
Date: Sat, 14 Aug 2004 09:15:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040814071546.GB4355@elte.hu>
References: <2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it> <2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it> <2sHu9-2EW-31@gated-at.bofh.it> <m31xibtf4e.fsf@averell.firstfloor.org> <20040813121502.GA18860@elte.hu> <20040813121800.GA68967@muc.de> <20040813135109.GA20638@elte.hu> <411D9A2A.1000202@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411D9A2A.1000202@grupopie.com>
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


* Paulo Marques <pmarques@grupopie.com> wrote:

> >yeah. Maybe someone will find the time to improve the algorithm. But
> >it's not a highprio thing.
> 
> Well, I found some time and decided to give it a go :)

great, your patch is looking really good!

> The original algorithm took, on average, 1340us per lookup on my P4
> 2.8GHz. The compile settings for the test are not the same on the
> kernel, so this can be only compared against other results from the
> same setup.

ouch. I consider fixing this a quality of implementation issue.

> With the attached patch it takes 14us per lookup. This is almost a
> 100x improvement.

wow! I have tried your patch and /proc/latency_trace now produces
instantaneous output.

> There are still a few issues with this approach. The biggest issue is
> that this is clearly a speed/space trade-off, and maybe we don't want
> to waste the space on a code path that is not supposed to be "hot". If
> this is the case, I can make a smaller patch, that fixes just the name
> "decompression" strcpy's.

your patch doesnt add all that much of code. It adds 288 bytes to .text
and 64 bytes to .data. A typical .config generates 180K of compressed
kallsyms data (with !KALLSYMS_ALL), so your patch increases the kallsyms
overhead by a mere 0.2%. So it's really not an issue - especially since
kallsyms can be disabled in .config. 

i've put your patch into the -O8 patch:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O8

i'd strongly recommend merging this patch upstream as well.

> Just one side note: gcc gives a warning about 2 variables that might
> be used before initialization. I know they are not, and it didn't seem
> a good idea to put extra code just to shut up gcc. What is the
> standard way to convince gcc that those vars are ok?

the standard way is to add the extra initializers. The gcc folks feel
that those rare cases where gcc gets it wrong justify the benefit of
catching lots of real bugs. I've added the extra initialization to -O8.

	Ingo
