Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318721AbSHWIqk>; Fri, 23 Aug 2002 04:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318722AbSHWIqk>; Fri, 23 Aug 2002 04:46:40 -0400
Received: from holomorphy.com ([66.224.33.161]:5522 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318721AbSHWIqi>;
	Fri, 23 Aug 2002 04:46:38 -0400
Date: Fri, 23 Aug 2002 01:48:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: James Cleverdon <jamesclv@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 Summit NUMA patch with dynamic IRQ balancing
Message-ID: <20020823084804.GE8898@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@suse.de>, James Cleverdon <jamesclv@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0208131421190.3110-100000@penguin.transmeta.com.suse.lists.linux.kernel> <200208131729.50127.habanero@us.ibm.com.suse.lists.linux.kernel> <20020813233007.GV14394@dualathlon.random.suse.lists.linux.kernel> <200208221931.35052.jamesclv@us.ibm.com.suse.lists.linux.kernel> <p73d6saoxqd.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <p73d6saoxqd.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cleverdon <jamesclv@us.ibm.com> writes:
+#define physical_to_logical_apicid(phys_apic) ((1ul << ((phys_apic) & 0x3)) | ((phys_apic) & APIC_DEST_CLUSTER_MASK))

On Fri, Aug 23, 2002 at 09:11:54AM +0200, Andi Kleen wrote:
> which is not equivalent for more than four CPUs and not using 
> clustered mode. Are you sure this is correct? One of these must be wrong 
> then, either the old or the new code.

IIRC there are some oddities. Figures 7-2 and 7-5 in the P-IV vol3
describe 3 different layouts for MP table APIC ID specifications:

(1) APIC ID format for Xeon processors without HyperThreading
	[1:2]:	processor ID
	[3:4]:	cluster ID

(2) APIC ID format for P6 family processors
	[0:1]:	processor ID
	[2:3]:	cluster ID

(3) APIC ID format for Hyperthreaded processors
	[0:0]:	logical processor ID
	[1:2]:	package ID
	[3:4]:	cluster ID

.. where any bits not specified are reserved. These are as they appear
in the MP table. As destinations in the clustered hierarchical model,
the cluster ID always resides in the upper nybble, and the remainder of
the ID in the lower nybble as a bitmask. So the physical/logic
conversion above is valid for xAPIC's, where the physical:logical
correspondence of destination APIC ID's is such. For NUMA-Q the
physical APIC ID space was not large enough to hold all cpus at once
and so cpus do not have unique physical APIC ID's at all, nor do
IO-APIC's. The physical APIC ID spaces of different nodes are entirely
disjoint, and so the only flaw I see here is that the apic_broadcast_id
is not a suitable criterion for IO-APIC physical ID renumbering on
NUMA-Q (and AFAIK it's entirely unnecessary there also). This bug is
shared with mainline, which panics given a sufficient number of IO-APICs.

The macro above is only used in the case clustered_apic_xapic, and so
doesn't need checking for case (2). Only 4 cpus/cluster are allowable,
so the assumption is that a physical APIC ID is tagged with the cluster
using the same bits as logical APIC ID's. For clustered_apic_xapic this
is the case, for NUMA-Q it is not, and that shifts the cluster ID left
2 bits appropriately in macros conditional on clustered_apic_numaq.

Or so my analysis of it goes.


James Cleverdon <jamesclv@us.ibm.com> writes:
+	 * OEM/Product IDs.
+	 */
+	if (!strncmp(oem, "IBM ENSW", 8) &&
+	    (!strncmp(prod, "NF 6000R", 8) || !strncmp(prod, "VIGIL SMP", 9)) )
+		clustered_hint |= CLUSTERED_APIC_XAPIC;
+	else if (!strncmp(oem, "IBM NUMA", 8))
+		clustered_hint |= CLUSTERED_APIC_NUMAQ;

On Fri, Aug 23, 2002 at 09:11:54AM +0200, Andi Kleen wrote:
> [I'm surprised you are not using ACPI for this on your boxes]

IBM NUMA == NUMA-Q. AFAIK they were released well prior to any remotely
usable ACPI specifications. The QCT table, which encoded information
similar to various proposed NUMA-ish ACPI tables, was kept as an MP OEM
table by the NUMA-Q BIOS.


Cheers,
Bill
