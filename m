Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTKSJdq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 04:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTKSJdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 04:33:46 -0500
Received: from holomorphy.com ([199.26.172.102]:54696 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263914AbTKSJdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 04:33:44 -0500
Date: Wed, 19 Nov 2003 01:33:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm4
Message-ID: <20031119093340.GP22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031118225120.1d213db2.akpm@osdl.org> <20031119090223.GO22764@holomorphy.com> <20031119011951.66300f0d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119011951.66300f0d.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> I'm not sure if this is within the scope of current efforts, but I
>> gave it a shot just to see how bad untangling it from highpmd and
>> O(1) buffered_rmqueue() was. It turns out it wasn't that hard.
>> The codebase (so to speak) has been in regular use since June, though
>> the port to -mm only lightly tested (basically testbooted on a laptop).

On Wed, Nov 19, 2003 at 01:19:51AM -0800, Andrew Morton wrote:
> Any performance numbers?

I've not done rigorous benchmarking of this, no. Presumably
microbenchmarks that utilize the pte cache without thrashing it would
save themselves one page zeroing per pagetable page after the first
iteration unless there's a bug in the cache flushing logic.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> +#ifdef CONFIG_SMP
>> +#define smp_local_irq_save(x)		local_irq_save(x)
>> +#define smp_local_irq_restore(x)	local_irq_restore(x)
>> +#define smp_local_irq_disable()		local_irq_disable()
>> +#define smp_local_irq_enable()		local_irq_enable()
>> +#else
>> +#define smp_local_irq_save(x)		do { (void)(x); } while (0)
>> +#define smp_local_irq_restore(x)	do { (void)(x); } while (0)
>> +#define smp_local_irq_disable()		do { } while (0)
>> +#define smp_local_irq_enable()		do { } while (0)
>> +#endif /* CONFIG_SMP */

On Wed, Nov 19, 2003 at 01:19:51AM -0800, Andrew Morton wrote:
> Interesting.

This was a micro-optimization for UP; the SMP case needs to protect
against reentry via interrupts due to smp_call_function(). UP can
just disable preemption. In principle, the two cases could be made
uniform at the cost of disabling interrupts unnecessarily on UP.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> @@ -890,6 +894,9 @@ int try_to_free_pages(struct zone *cz,
>>  		 */
>>  		wakeup_bdflush(total_scanned);
>>  
>> +		/* shoot down some pagetable caches before napping */
>> +		shrink_pagetable_cache(gfp_mask);

On Wed, Nov 19, 2003 at 01:19:51AM -0800, Andrew Morton wrote:
> Maybe this could hook into the shrink_slab() mechanism?  There's actually
> nothing slab-specific about shrink_slab().

There are some bootstrap ordering issues, but they're tractable. One
oddity is that in the highpte case, shrink_slab() will be skipped, but
the pagetable cache highmem-allocated. I'm not sure whether that's
important or not, but I erred on the side of caution.

Maybe I should slap a copyright down on arch/i386/mm/pgtable.c; I
appear to have written a substantial chunk of the code in there, too.


-- wli
