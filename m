Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268955AbTBZV5m>; Wed, 26 Feb 2003 16:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268971AbTBZV5m>; Wed, 26 Feb 2003 16:57:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47375 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268955AbTBZV5j>; Wed, 26 Feb 2003 16:57:39 -0500
Date: Wed, 26 Feb 2003 14:05:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ion Badulescu <ionut@badula.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <Pine.LNX.4.44.0302261637560.8828-100000@guppy.limebrokerage.com>
Message-ID: <Pine.LNX.4.44.0302261400160.3156-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Feb 2003, Ion Badulescu wrote:
> 
> Mikael's patch (included in the previous message) changes this to
> 
> 	boot_cpu_physical_apicid = -1U;
> 
> which is the same thing indeed.

Yeah, I'd rather remove it if this is it.

> It's not enough. There are two other problems, further down in 
> APIC_init_uniprocessor():
> 
> 1) apic_write_around(APIC_ID, boot_cpu_physical_apicid) places the APIC 
> value in the lower 8 bits of APIC_ID, when it should be in the upper 8. As 
> as result, it effectively forces the APIC id to always be 0 for the boot 
> CPU, which is fatal on SMP AMD boxes.

Wouldn't it be nicer to just fix the write instead? I can see the 
potential to actually want to change the APIC ID - in particular, if the 
SMP MP tables say that the APIC ID for the BP should be X, maybe we should 
actually write X to it instead of just using what is there.

In particular, Mikaels patch will BUG() if the MP tables don't match the 
APIC ID. I think that's extremely rude: we should select one of the two 
and just run with it, instead of unconditionally failing.

> 2) phys_cpu_present_map = 1 means we always set bit 0, but later on 
> in setup_local_APIC() we do
>         if (!clustered_apic_mode && 
>             !test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
>                 BUG();
> and the bug is triggered if the APIC_ID is not zero.

Yeah, there's no question something is wrong. However:

> Here's Mikael's patch again -- it's quite obviously correct, it fixes the 
> problem on my SMP AMD boxes and doesn't break anything else I've thrown at 
> it. Applies cleanly to both 2.4 and 2.5.latest.

I disagree with the "obviously correct", due to the above issue of 
mismatches between MP tables and actual APIC contents. I think it is more 
correct than what we have now, but..

		Linus

