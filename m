Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbSLWSqS>; Mon, 23 Dec 2002 13:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbSLWSqR>; Mon, 23 Dec 2002 13:46:17 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:23389 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S266936AbSLWSqQ> convert rfc822-to-8bit; Mon, 23 Dec 2002 13:46:16 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4]  generic support for systems with more than 8 CP Us (2/2)
Date: Mon, 23 Dec 2002 10:54:18 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E1BB@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-MS-Has-Attach: 
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic support for systems with more than 8 CP Us (2/2)
Thread-Index: AcKqpc4+3+Hi9RaXEdes/wBQi+Bv6wADQzwA
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Dec 2002 18:54:19.0145 (UTC) FILETIME=[B2DCDF90:01C2AAB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Protasevich, Natalie [mailto:Natalie.Protasevich@UNISYS.com]
> +	/*
> +	 * Switch to Physical destination mode in case of generic
> +	 * more than 8 CPU system, which has xAPIC support
> +	 */
> +#define FLAT_APIC_CPU_MAX	8
> +	if ((clustered_apic_mode == CLUSTERED_APIC_NONE) &&
> +	    (xapic_support) &&
> +	    (num_processors > FLAT_APIC_CPU_MAX)) {
> +		clustered_apic_mode = CLUSTERED_APIC_XAPIC;
> +		apic_broadcast_id = APIC_BROADCAST_ID_XAPIC;
> +		int_dest_addr_mode = APIC_DEST_PHYSICAL;
> +		int_delivery_mode = dest_Fixed;
> +		esr_disable = 1;
> +	}
> +#endif
> +
> 
> Venkatesh,
> I could not find the definition for CLUSTERED_APIC_NONE. Is 
> this an attempt
> to set up the clustered mode right in case if it was not compiled with
> CLUSTERED_..._XAPIC on the system with > 8 cpu?

CLUSTERED_APIC_NONE is the normal default mode of flat logical (defined in asm/smpboot.h)
NUMAQ, Summit has a OEM field check and they change it to Cluster or Physical mode
before this point. What I am trying here is to check whether we are still in the default
flat (with max 8 cpu) mode, and we have more than 8 xAPIC supporting CPUs, then
we switch to physical mode rather than flat mode.

> >There is already some code in base that does this. For NUMAQ 
> specifically
> >this check happens and clustered mode is selected for APIC. 
> My patch has
> this 
> >additinal check (after the initial IBM OEM check), for 
> non-NUMAQ systems
> with 
> >more than 8 CPUs and xAPIC support. These systems can not 
> work with the 
> >default flat addressing mode. So, this patch sets up such systems in
> physical 
> >mode.
> 
> In the systems like ES7000, all CPU (up to 32) and IO-APICs have 8-bit
> hard-wired ID's according to their topological position. 
> Therefore, the
> apic_broadcast_id be has to be 0xFF (like summit's, I guess), 
> and modes
> should be clustered logical for Cascades, clustered physical 
> for xAPIC. The
> IO-APIC lines are programmed with the broadcast ID/lowest priority for
> Cascades, and boot CPU ID/XTPR flag/Lowest priority for 
> Fosters/Gallatins.
> This is pretty much the only choices we have. If this is not 
> what the patch
> allows to do, we need a last chance architectural hook to be able to
> accommodate our stuff.

Unfortunately, this patch doesn't do that. My initial attempt (first version of
the patch that I had sent) was trying to set up clustered physical mode for all non-NUMAQ
systems, with more than 8 CPUs with xAPIC support. But due to the amount of code changes
that it involved, we had to fall back to setting up such systems in physical mode, 
with IO-APIC programmed for fixed Priority interrupt.

Thanks,
-Venkatesh
