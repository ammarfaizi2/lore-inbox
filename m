Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTE1Hah (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTE1Hah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:30:37 -0400
Received: from holomorphy.com ([66.224.33.161]:46573 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264593AbTE1Ha0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:30:26 -0400
Date: Wed, 28 May 2003 00:43:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       John Stoffel <stoffel@lucent.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <20030528074317.GE19818@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Roman Zippel <zippel@linux-m68k.org>,
	John Stoffel <stoffel@lucent.com>,
	DevilKin-LKML <devilkin-lkml@blindguardian.org>,
	linux-kernel@vger.kernel.org
References: <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL> <Pine.LNX.4.44.0305272010550.12110-100000@serv> <20030527184016.GA5847@suse.de> <4060000.1054072761@[10.10.2.4]> <20030528033459.GR8978@holomorphy.com> <13590000.1054102279@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13590000.1054102279@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, my attribution was stripped from:
>> Or better yet, remove all the #ifdefs, finish generalizing the APIC
>> code, and have nothing to configure at all. For 2.7 ...

On Tue, May 27, 2003 at 11:11:20PM -0700, Martin J. Bligh wrote:
> For the "commerical" options like Summit and bigsmp, I think this is an
> option for 2.5 even, given some more testing. And then the wierdo arches
> can be better hidden ;-)

The delimiter between weirdo and non-weirdo arches is wrong IMHO; so
long as the only differences are APIC handling (and that in fact holds
for NUMA-Q and a couple of others that were left out of the generic
bits) a "proper" APIC abstraction should handle it just fine.

One might argue that NUMA-Q is a corner case not worth handling by a
generic APIC layer; it is a corner case, however it far more clearly
shows where generality is needed, in particular because it mixes
clustered hierarchical DFR and logical IPI's with physical DESTMOD in
IO-APIC RTE's. At the moment the general confusions, mis-declarations,
and what appear to be either latent or actual bugs going around
include/asm-i386/mach-*/mach_apic.h point to a need for a consolidated
library of APIC macros and functions accurately conforming to the Intel
specifications. AFAICT there are four and only four or five parameters
that really make a difference:

(1) APIC vs. xAPIC
(2) clustered hierarchical DFR vs. flat DFR
(3) physical DESTMOD vs. logical DESTMOD in IO-APIC RTE's
(4) wakeup via INIT or via NMI
(5) physical IPI's or logical IPI's

So one could easily form destinations by:

physical_destination_t cpumask_to_physical_destination(cpumask_t cpumask)
{
	int cpu, ncpus = cpus_weight(cpumask);

	if (!ncpus) {
		WARN_ON(1);
		if (xapic)
			return XAPIC_PHYSICAL_BROADCAST;
		else
			return SAPIC_PHYSICAL_BROADCAST;
	}

	WARN_ON(ncpus > 1);
	cpu = first_cpu(cpumask);
	if (!xapic && cpu >= 16) {
		WARN_ON(1);
		return SAPIC_PHYSICAL_BROADCAST;
	}

	return (physical_destination_t) { 1UL << cpu };
}

logical_destination_t cpumask_to_logical_destination(cpumask_t cpumask)
{
	unsigned long k, raw_dest = 0UL;

	if (apic_dfr_flat) {
		cpumask_t invalid_mask = cpus_promote(0xFFUL);
		cpus_complement(invalid_mask);
		cpus_and(invalid_mask, invalid_mask, cpumask);
		WARN_ON(!cpus_empty(invalid_mask));
		return (logical_destination_t){ cpus_coerce(cpumask) & 0xFFUL };
	}

	for (k = 0; k < NR_CPUS; ++k) {
		if (!cpu_isset(k, cpumask))
			continue;
		if (raw_dest) {
			unsigned long old_cluster, new_cluster;
			old_cluster = raw_dest >> 4;
			new_cluster = k >> 4;
			if (old_cluster != new_cluster) {
				WARN_ON(1);
				continue;
			}
		}
		raw_dest |= (k & ~0xFUL) | (1UL << (k & 0xf));
	}
	if (!raw_dest) {
		WARN_ON(1);
		return APIC_LOGICAL_BROADCAST;
	}
	return (logical_destination_t) { raw_dest };
}

Destination formation is done in two contexts:
(1) IPI's
(2) IO-APIC RTE's

The higher level of abstraction could easily insulate subarches with:

ipi_destination_t cpumask_to_ipi_destination(cpumask_t cpumask)
{
	switch (APIC_IPI_MODE) {
		case APIC_IPI_MODE_PHYSICAL:
			return cpumask_to_physical_destination(cpumask);
			break;
		case APIC_IPI_MODE_LOGICAL:
			return cpumask_to_logical_destination(cpumask);
			break;
		default:
			BUG();
			return (ipi_destination_t) { 0 };
	}
}

and

rte_destination_t cpumask_to_ipi_destination(cpumask_t cpumask)
{
	switch (IOAPIC_RTE_DESTMOD) {
		case IOAPIC_RTE_DESTMOD_PHYSICAL:
			return cpumask_to_physical_destination(cpumask);
			break;
		case IOAPIC_RTE_DESTMOD_LOGICAL:
			return cpumask_to_logical_destination(cpumask);
			break;
		default:
			BUG();
			return (rte_destination_t) { 0 };
	}
}

with ipi_destination_t typedef'd to physical_destination_t or
logical_destination_t according to the subarch.

CPU wakeup would proceed similarly; just check an operational variable
and either NMI with a logical destination or INIT with a physical
destination, with tabulated BIOS IDT addresses to edit.

And the infamous setup_ioapic_ids_from_mpc() needs a notion of APIC
buses to which IO-APIC's and cpus are connected. It should be look like:

static void __init setup_ioapic_ids_from_mpc(void)
{
	int apic_bus;

	for (apic_bus = 0; apic_bus < MAX_APIC_BUSES; ++apic_bus) {
		unsigned long local_physid_map[BITS_TO_LONGS(XAPIC_PHYSICAL_BROADCAST+1)] = { [0...XAPIC_PHYSICAL_BROADCAST] = 0UL };
		int ioapic, cpu;

		if (!apic_bus_present(apic_bus))
			continue;

		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
			if (!cpu_present(cpu))
				continue;
			if (apic_bus_of_cpu(cpu) != apic_bus)
				continue;

			set_bit(cpu, local_physid_map);
		}

		for (ioapic = 0; ioapic < nr_ioapics; ++ioapic) {
			int ioapic_physid, entry;

			if (apic_bus_of_ioapic(ioapic) != apic_bus)
				continue;

			if (MP_APICID_PHYSICAL)
				ioapic_physid = mp_ioapics[ioapic].mpc_apicid;
			else {
				for (entry = 0; entry < MAX_MPC_ENTRY; ++entry)
					if (!translation_table[entry])
						continue;
					if (translation_table[entry]->mpc_apicid != mp_ioapics[ioapic].mpc_apicid)
						continue;
					if (translation_table[entry]->trans_type == MP_IOAPIC)
						break;

				if (entry >= MAX_MPC_ENTRY)
					panic("IO-APIC %d not listed in"
						" translation table\n", ioapic);
				ioapic_physid = translation_table[entry]->trans_local;
			}

			if (test_bit(ioapic_physid, local_physid_map)) {
				unsigned long free_physids[BITS_TO_LONGS(XAPIC_PHYSICAL_BROADCAST+1)];
				int j, new_physid;
				unsigned long flags;
				struct IO_APIC_reg_00 reg_00;

				for (j = 0; j < ARRAY_SIZE(free_physids); ++j)
					free_physids[j] = ~local_physid_map[j];

				new_physid = find_first_bit(free_physids,
						XAPIC_PHYSICAL_BROADCAST + 1);
				if (!xapic && new_physid >= SAPIC_PHYSICAL_BROADCAST)
					panic("physical APIC ID clash not "
						"resolvable due to physical "
						"APIC ID space exhaustion on "
						"APIC bus %d\n", apic_bus);
				printk("renumbering IO-APIC %d to physical"
					"APIC ID %d from %d\n",
					ioapic, new_physid, ioapic_physid);
				spin_lock_irqsave(&ioapic_lock, flags);
				*(int *)&reg_00 = io_apic_read(ioapic, 0);
				reg_00.ID = new_physid;
				io_apic_write(ioapic, 0, *(int *)&reg_00);
				spin_unlock_irqsave(&ioapic_lock, flags);
				set_bit(new_physid, local_physid_map);
				if (MP_APICID_PHYSICAL)
					mp_ioapics[ioapic].mpc_apicid =
								new_physid;
				else
					translation_table[entry]->trans_local =
								new_physid;
			}
			set_bit(ioapic_physid, local_physid_map);
		}
	}
}

Afterward, APIC-based subarches would just declare their preferences
and the APIC library would dispatch on the operational variables they
declare in mach_apic.h. Shoving the entire thing in a header with
inlines kills off so-called runtime overhead, and the generic subarch
bits would be largely unaltered, and provide a machine vector largely
identical to what it does today. Then, since APIC support is complete,
the detection phases would retarget the APIC driver to the proper
machine vector for the detected machine configuration and work across
a broader variety of systems than it does today.

This is not a pointless exercise: the bogosities I pointed out in the
userspace irqbalancing thread are very real. In particular the APIC vs.
xAPIC oddities for mach-default, though they're not exercised in any
obvious way, are very troubling, and it's unclear whether bigsmp is
peroperly functional as it stands in 2.5.70, since target_cpus()
disallows RTE's targeting clusters > 0 and NO_BALANCE_IRQ is 1. It
vaguely looks like bigsmp cut and paste NUMA-Q APIC code and did the
wrong thing for xAPIC as a result.

Following the spec with respect to destination formation is just not
that far out, people. The above code is just "example code" or whatever
and the BUG() checks are probably overly strict, but the general
notions are basically the rest of what's needed for true APIC genericity.


-- wli
