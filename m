Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265103AbTLFLfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 06:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbTLFLfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 06:35:39 -0500
Received: from holomorphy.com ([199.26.172.102]:23254 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265103AbTLFLXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 06:23:53 -0500
Date: Sat, 6 Dec 2003 03:23:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mika Penttil? <mika.penttila@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Numaq in 2.4 and 2.6
Message-ID: <20031206112348.GP8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mika Penttil? <mika.penttila@kolumbus.fi>,
	linux-kernel@vger.kernel.org
References: <3FD1A54F.101@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD1A54F.101@kolumbus.fi>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 11:45:51AM +0200, Mika Penttil? wrote:
> While comparing numaq support in 2.4.23 and 2.6.0-test11 came accross 
> following...
> In 2.4.23 mpparse.c we do :
>    phys_cpu_present_map |= apicid_to_phys_cpu_present(m->mpc_apicid);
> and then launch the cpus using NMI and logical addressing in the order 
> phys_cpu_present_map indicates.
> In 2.6.0-test11mpparse.c we do :
>    tmp = apicid_to_cpu_present(apicid);
>    physids_or(phys_cpu_present_map, phys_cpu_present_map, tmp);
> where apicid is the result of :
>    static inline int generate_logical_apicid(int quad, int phys_apicid)
>    {
>        return (quad << 4) + (phys_apicid ? phys_apicid << 1 : 1);
>    }
> and phys_apicid == m->mpc_apicid
> Again we lauch the cpus using NMI and logical addressing.

The sole purposes of this (AFAICT) are for reassigning physical ID's of
the IO-APIC's, and cpu wakeup. You're noticing the first of several
inconsistencies:

(a) The NUMA-Q BIOS stores logical (clustered hierarchical) APIC ID's
	in the MP table instead of physical APIC ID's. This confuses
	various things.
(b) NUMA-Q's are P-III -based, i.e. serial APIC. The global
	phys_cpu_present_map does not suffice to represent the things,
	though some sort of mangled physical APIC ID's are kept in it.
	To properly describe serial APIC systems of its kind, there
	needs to be one analogue of phys_cpu_present_map per-node, as
	each node has a separate APIC bus with its own domain for
	physical APIC ID's. This explains (a) as it's impossible to
	have distinct physical APIC ID's for > 15 cpus on serial APIC
	-based systems.
(c) The 2.6 code actually decodes the logical APIC ID to generate a
	fake xAPIC-like physical APIC ID and uses that as an index
	into the phys_cpu_present_map. This is used essentially for
	cpu enumeration.
(d) The rest of the setup phys_cpu_present_map is used for is already
	done by the BIOS. The code cheats by ignoring the IO-APIC
	renumbering phase entirely for NUMA_Q. Granted, it's supposed
	to be there to doublecheck the BIOS.


On Sat, Dec 06, 2003 at 11:45:51AM +0200, Mika Penttil? wrote:
> So the the set of apicids fed to do_boot_cpu() in 2.4 and 2.6 must be 
> different using the same mp table. And both use logical addressing. 
> Seems that 2.4 expects mpc_apicid to be something like (quad | cpu) and 
> 2.6 only cpu, the quad comes from the translation table.
> The conclusion is that the same mp table can't work in 2.4 and 2.6? No?

It's all okay, albeit ugly and obfuscated as the code doesn't truly
describe the hardware.


-- wli
