Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263082AbUKTEkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUKTEkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbUKTEez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:34:55 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:53087 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263077AbUKTCkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:40:52 -0500
Message-ID: <419EAEA8.2060204@yahoo.com.au>
Date: Sat, 20 Nov 2004 13:40:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Christoph Lameter <clameter@sgi.com>, torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Robin Holt <holt@sgi.com>
Subject: Re: page fault scalability patch V11 [0/7]: overview
References: <Pine.LNX.4.58.0411181126440.30385@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> <419D581F.2080302@yahoo.com.au> <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com> <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <20041120020401.GC2714@holomorphy.com> <419EA96E.9030206@yahoo.com.au> <20041120023443.GD2714@holomorphy.com>
In-Reply-To: <20041120023443.GD2714@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>Split counters easily resolve the issues with both these approaches
>>>(and apparently your co-workers are suggesting it too, and have
>>>performance results backing it).
> 
> 
> On Sat, Nov 20, 2004 at 01:18:22PM +1100, Nick Piggin wrote:
> 
>>Split counters still require atomic operations though. This is what
>>Christoph's latest effort is directed at removing. And they'll still
>>bounce cachelines around. (I assume we've reached the conclusion
>>that per-cpu split counters per-mm won't fly?).
> 
> 
> Split != per-cpu, though it may be. Counterexamples are
> as simple as atomic_inc(&mm->rss[smp_processor_id()>>RSS_IDX_SHIFT]);

Oh yes, I just meant that the only way split counters will relieve
the atomic ops and bouncing is by having them per-cpu. But you knew
that :)

> Furthermore, see Robin Holt's results regarding the performance of the
> atomic operations and their relation to cacheline sharing.
> 

Well yeah, but a. their patch isn't in 2.6 (or 2.4), and b. anon_rss
means another atomic op. While this doesn't immediately make it a
showstopper, it is gradually slowing down the single threaded page
fault path too, which is bad.

> And frankly, the argument that the space overhead of per-cpu counters
> is problematic is not compelling. Even at 1024 cpus it's smaller than
> an ia64 pagetable page, of which there are numerous instances attached
> to each mm.
> 

1024 CPUs * 64 byte cachelines == 64K, no? Well I'm sure they probably
don't even care about 64K on their large machines, but...

On i386 this would be maybe 32 * 128 byte == 4K per task for distro
kernels. Not so good.
