Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267701AbTASWJ7>; Sun, 19 Jan 2003 17:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267708AbTASWJ7>; Sun, 19 Jan 2003 17:09:59 -0500
Received: from holomorphy.com ([66.224.33.161]:8584 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267701AbTASWJ5>;
	Sun, 19 Jan 2003 17:09:57 -0500
Date: Sun, 19 Jan 2003 14:18:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask_t
Message-ID: <20030119221852.GC789@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20020808.073630.37512884.davem@redhat.com> <20020809080517.E4BE5443C@lists.samba.org> <20030119213524.GH780@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119213524.GH780@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 01:35:24PM -0800, William Lee Irwin III wrote:
> -static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
> +#if NR_CPUS <= 32
> +static void set_ioapic_affinity (unsigned int irq, cpumask_t mask)

This is just broken anyway. And fixing it isn't as obvious as just
using some mask -> APIC destination converter, as it's not possible
to form all masks in all APIC modes. Even better, we set up our RTE's
with physical DESTMOD, which not only finds these "masks" to be garbage,
but can only address things parked on the same APIC bus as the IO-APIC;
its implicit "any IO-APIC can interrupt any cpu" assumption is broken.

There are various very good reasons to keep it that way, too, for one,
interrupting cpus on remote nodes would be dog slow, and the software
interrupt number resolution techniques seem to require locality
restrictions, as I don't believe the box has anything resembling MSI
or whatever allows IA64 boxen to get away with 1:1 vector <-> irq maps.

I should probably find some way to make it play fair with xAPIC-based
stuff and find something better to #ifdef on (or some other way out of
actually being forced to deal with this) if I push this any further.


On Sun, Jan 19, 2003 at 01:35:24PM -0800, William Lee Irwin III wrote:
> @@ -1478,8 +1497,9 @@ static void __init setup_ioapic_ids_from
> -		if (check_apicid_used(phys_id_present_map,
> -					mp_ioapics[apic].mpc_apicid)) {
> +
> +		/* MAJOR BRAINDAMAGE */
> +		if (phys_id_present_map & (1UL << mp_ioapics[apic].mpc_apicid)) {
>  			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",

It's currently broken on multi-APIC-bus boxen anyway, and there is a
replacement (not included here), at least for NUMA-Q. NFI about others;
multi-APIC bus configs predating xAPIC's etc. with 8-bit physid's are
probably rare outside of Sequent's boxen.


On Sun, Jan 19, 2003 at 01:35:24PM -0800, William Lee Irwin III wrote:
> -	if (!(new_value & cpu_online_map))
> +	cpus_and(tmp, new_value, cpu_online_map);
> +	if (!any_online_cpu(tmp))
>  		return -EINVAL;

Woops; I better fix that.

Hmm, there are probably other stupidities about. It could probably
be cleaner/tested/etc. too. The IO-APIC and irq balancing stuff is
a disaster area with or without the patch; I'm not sure how much I
can really be expected to clean up down there. The TLB flushing stuff
wanting various tidbits of atomicity is a wee bit worrying as well.
I think I can get away with just shoving a barrier or two in there.
And the shift operations on bitmaps could probably made faster, but
AFAICT they aren't on any performance-critical paths.


-- wli
