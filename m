Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266159AbTGDUX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbTGDUX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:23:57 -0400
Received: from franka.aracnet.com ([216.99.193.44]:53208 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S266159AbTGDUXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:23:55 -0400
Date: Fri, 04 Jul 2003 13:37:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <19140000.1057351073@[10.10.2.4]>
In-Reply-To: <20030704200746.GB1715@holomorphy.com>
References: <20030703023714.55d13934.akpm@osdl.org> <3F054109.2050100@aitel.hist.no> <20030704093531.GA26348@holomorphy.com> <20030704095004.GB26348@holomorphy.com> <7910000.1057333295@[10.10.2.4]> <20030704182617.GA955@holomorphy.com> <15480000.1057347497@[10.10.2.4]> <20030704200746.GB1715@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Maybe not, but it looks like one. Maybe if you actually explain
>> what you're trying to fix, and why?
>> I think this kind of change deserves a better explanation that 
>> "I'm right" ... that's my main objection.
> 
> I'll try to be more verbose, then.

Thanks ... will help a lot ;-)

> On Fri, Jul 04, 2003 at 12:38:19PM -0700, Martin J. Bligh wrote:
>> Explain. Not obvious to the casual observer.
> 
> The function assigns physical APIC ID's to IO-APIC's. The loop is
> intended to iterate over the physical APIC ID space. 0xf is an
> inaccurate description of the upper bound on the physical APIC ID space.
> APIC_BROADCAST_ID is a more accurate upper bound.

OK, you're right. Is just confusing because it works as it is right 
now ... even on a 32x system - however, that's only because Summit
doesn't actually run that region of code, and NUMA-Q ignores it.

> On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>>> APIC_BROADCAST_ID is an upper bound on valid physical APIC ID's as it
>>> is used in the code. That actually was commented in the patch.
> 
> On Fri, Jul 04, 2003 at 12:38:19PM -0700, Martin J. Bligh wrote:
>> I find it odd that this worked before then. Also seems to be a separate
>> issue from the rest of the patch. Is quite probably correct, is just
>> non-obvious in the context of the rest of the patch.
> 
> I audited not only for usage of limited-width bitmaps for APIC ID
> spaces, but also improper bounds on iterations over APIC ID spaces.
> Things ran out of APIC ID's when phys_cpu_present_map was NR_CPUS
> wide. This patch makes the limits accurate to the hardware with
> the brute-force application of bitmaps. The semantic impact of
> dropping in a bitmap is very low. The issue that arose was that it
> wasn't wide enough, which was obvious enough to spot as a thinko
> without even testing.
>
>> Why is Summit 0xF, and bigsmp 0xFF then?
> 
> Summit (and all other xAPIC-based subarches) should be 0xFF; I missed
> it in the sweep.

OK. Makes more sense now if both are that way.

> On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>>> Look at where it's used.
> 
> On Fri, Jul 04, 2003 at 12:38:19PM -0700, Martin J. Bligh wrote:
>> I did. Still unclear why you think this is correct, or what physical
>> apicids have to do with a function that maps from apicids to  the
>> phys_cpu_present_map, which is a compact mapping of logical apicids
>> for NUMA-Q.
>> Sorry, but this needs more explanation.
> 
> The bitmap width is sufficient. NUMA-Q abuses what everything else
> uses for physical APIC ID's (partly because of the BIOS). It so happens
> that the array is MAX_APICS wide, which suffices for NUMA-Q (and
> anything else that cares to use it).
> 
> No. This was not written for or around NUMA-Q; it's meant for the
> io_apic.c loops and sparse physid wakeup on non-NUMA-Q machines.

OK, maybe this is just an extension of my earlier abuse - in which 
case, let's just remove it. Was bad enough before, but now even I 
can't understand it, and I wrote the damned thing.

So yes, it looks correct. I'll see if I can see a neat way to bury this
under the existing abstractions like Summit does ... I'm not sure it's
a good idea to have two different methods for this; that whole area of
code is getting horribly complicated ...

Thanks very much for the explanations,

M.

