Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264532AbUDUKoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264532AbUDUKoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 06:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbUDUKoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 06:44:03 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:65041 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264532AbUDUKnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 06:43:55 -0400
Date: Wed, 21 Apr 2004 12:42:31 +0200
From: Willy Tarreau <w@w.ods.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.26 released
Message-ID: <20040421104231.GA2558@alpha.home.local>
References: <200404141314.i3EDEbxv023592@hera.kernel.org> <20040420232312.GQ743@holomorphy.com> <20040421045344.GJ596@alpha.home.local> <20040421101244.GX743@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421101244.GX743@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

sorry for the noise, you're right. I didn't notice the '/4' before '*16',
so I thought 2 bits were missing.

Thanks for your explanation.
Willy

On Wed, Apr 21, 2004 at 03:12:44AM -0700, William Lee Irwin III wrote:
> On Tue, Apr 20, 2004 at 04:23:12PM -0700, William Lee Irwin III wrote:
> >> -		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
> >> +		return (mps_cpu & ~0x3) << 2 | 1 << (mps_cpu & 0x3);
> 
> On Wed, Apr 21, 2004 at 06:53:44AM +0200, Willy Tarreau wrote:
> > I think you wanted to put '<< 4' here instead of '<< 2'. Also, could you
> > put (useless for some) parenthesis to group the left side and the right
> > side of the bit-wise OR ? I'm always scared that someone changes it to
> > an addition with good intentions and changes the operators precedence
> > without noticing.
> 
> The important thing here is the bit movement.
> 
> apicid[7]:	mps_cpu[5]
> apicid[6]:	mps_cpu[4]
> apicid[5]:	mps_cpu[3]
> apicid[4]:	mps_cpu[2]
> apicid[3]:	mps_cpu[1] && mps_cpu[0]	|
> apicid[2]:	mps_cpu[1] && !mps_cpu[0]	|  == 1 << mps_cpu[0:1]
> apicid[1]:	!mps_cpu[1] && mps_cpu[0]	|
> apicid[0]:	!mps_cpu[1] && !mps_cpu[0]	|
> 
> apicid[4:7] and mps_cpu[2:5] encode the cluster ID for use by the
> clustered hierarchical DFR local APIC ID settings (which in this case
> are done by the BIOS, not the OS). apicid[0:3] is an architecturally
> defined cluster-local cpumask, which as it's 4 bits, only needs 2 bits
> to densely encode within mps_cpu[0:1]. The mps_cpu values are basically
> BIOS-defined and the mps_cpu values are computed from auxiliary tables
> provided by the BIOS in combination with the serial APIC's physical
> APIC ID's (which are provided as 0, 1, 2, 4; the computation in mpparse.c
>                 logical_apicid = (quad << 4) + 
>                         (m->mpc_apicid ? m->mpc_apicid << 1 : 1);
> is easily tabulated as (quad << 4) | one of 1 2 4 8. The way that the
> various information is compacted into a NR_CPUS-sized array indexed by
> the logical APIC ID is with the computation carrying the clustered
> hierarchical logical APIC ID to the | of the cluster ID shifted right
> by 2, and the __ffs() of the lower 4 bits of the logical APIC ID (the
> "local" logical APIC ID) so as to match later-used mps_cpu values. It
> appears, though, that the majority of the arrays indexed in this way,
> e.g. bios_cpu[], have been removed (excepting raw_phys_apicid[] etc.).
> 
> So the proof of all this is:
> 
> (a) mps_cpu % 4 == mps_cpu & 0x3
> 	The right side of the | is equal to the right side of the +
> (b) (mps_cpu & ~0x3) << 2
> 		== mps_cpu[3:7] << 4
> 		== (mps_cpu/4) << 4
> 		== 16*(mps_cpu/4)
> 	The left side of the | is equal to the left side of the +
> (c) ((mps_cpu & ~0x3) << 2) & (1 << (mps_cpu & 0x3))
> 		== (mps_cpu[3:7] << 4) & (1 << (mps_cpu & 0x3))
> 		== 0
> 	Because shifting 1 by mps_cpu & 0x3 on the left can set no bit
> 	higher than 3, but the right side is shifted left by 4, which
> 	is out of its reach.
> 	So there are no carries, and the | is equivalent to the +.
> 
> The ~, <<, &, and | version clarifies the bit movement. The definitions
> are in terms of bit extraction, which matches the patch more closely
> than the in-tree arithmetic definition.
> 
> 
> -- wli
