Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbTGDTwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbTGDTwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:52:13 -0400
Received: from holomorphy.com ([66.224.33.161]:18561 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266153AbTGDTwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:52:05 -0400
Date: Fri, 4 Jul 2003 13:07:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <20030704200746.GB1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <3F054109.2050100@aitel.hist.no> <20030704093531.GA26348@holomorphy.com> <20030704095004.GB26348@holomorphy.com> <7910000.1057333295@[10.10.2.4]> <20030704182617.GA955@holomorphy.com> <15480000.1057347497@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15480000.1057347497@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>> It's not a cleanup, and it doesn't touch trailing whitespace etc.

On Fri, Jul 04, 2003 at 12:38:19PM -0700, Martin J. Bligh wrote:
> Maybe not, but it looks like one. Maybe if you actually explain
> what you're trying to fix, and why?
> I think this kind of change deserves a better explanation that 
> "I'm right" ... that's my main objection.

I'll try to be more verbose, then.


On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>> It is.

On Fri, Jul 04, 2003 at 12:38:19PM -0700, Martin J. Bligh wrote:
> Explain. Not obvious to the casual observer.

The function assigns physical APIC ID's to IO-APIC's. The loop is
intended to iterate over the physical APIC ID space. 0xf is an
inaccurate description of the upper bound on the physical APIC ID space.
APIC_BROADCAST_ID is a more accurate upper bound.


On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>> APIC_BROADCAST_ID is an upper bound on valid physical APIC ID's as it
>> is used in the code. That actually was commented in the patch.

On Fri, Jul 04, 2003 at 12:38:19PM -0700, Martin J. Bligh wrote:
> I find it odd that this worked before then. Also seems to be a separate
> issue from the rest of the patch. Is quite probably correct, is just
> non-obvious in the context of the rest of the patch.

I audited not only for usage of limited-width bitmaps for APIC ID
spaces, but also improper bounds on iterations over APIC ID spaces.
Things ran out of APIC ID's when phys_cpu_present_map was NR_CPUS
wide. This patch makes the limits accurate to the hardware with
the brute-force application of bitmaps. The semantic impact of
dropping in a bitmap is very low. The issue that arose was that it
wasn't wide enough, which was obvious enough to spot as a thinko
without even testing.


On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>> The change is correct, and I am not thinking of any such thing.
>> APIC_BROADCAST_ID's sole usage is for terminating loops over physical
>> APIC ID's while setting the physical APIC ID's of IO-APIC's.

On Fri, Jul 04, 2003 at 12:38:19PM -0700, Martin J. Bligh wrote:
> Why is Summit 0xF, and bigsmp 0xFF then?

Summit (and all other xAPIC-based subarches) should be 0xFF; I missed
it in the sweep.


On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>> Look at where it's used.

On Fri, Jul 04, 2003 at 12:38:19PM -0700, Martin J. Bligh wrote:
> I did. Still unclear why you think this is correct, or what physical
> apicids have to do with a function that maps from apicids to  the
> phys_cpu_present_map, which is a compact mapping of logical apicids
> for NUMA-Q.
> Sorry, but this needs more explanation.

The bitmap width is sufficient. NUMA-Q abuses what everything else
uses for physical APIC ID's (partly because of the BIOS). It so happens
that the array is MAX_APICS wide, which suffices for NUMA-Q (and
anything else that cares to use it).

No. This was not written for or around NUMA-Q; it's meant for the
io_apic.c loops and sparse physid wakeup on non-NUMA-Q machines.


-- wli
