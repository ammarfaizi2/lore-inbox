Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317390AbSG1Vb5>; Sun, 28 Jul 2002 17:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSG1Vb4>; Sun, 28 Jul 2002 17:31:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19330 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317390AbSG1Vb4>; Sun, 28 Jul 2002 17:31:56 -0400
Date: Sun, 28 Jul 2002 14:33:19 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
cc: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>, riel@conectiva.com.br,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <490876873.1027866798@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0207271345320.20701-100000@linux-box.realnet.co.sz>
References: <Pine.LNX.4.44.0207271345320.20701-100000@linux-box.realnet.co.sz>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since you can only have 4 bits for your IOAPIC ID, you need to stuff them 
> all into the 4 bit address space, looking at the IDs there should be 
> plenty space for 8 IOAPICs in the 4 bit region. 

Well, there's 16 cpus and 8 ioapics to theoretically go into that 
space. The trouble is that it's not really one physical address 
space globally, it's one per node, so the whole thing's a total hack.

> Another funny, is how come 
> it tries to reassign IDs for 12 IOAPICs? unless it picked up more from the 
> proprietory vendor section of mp tables seeing as it only picked up 8 at 
> boot, i think that code might need a once over.

The strangest thing to me is that all the IDs are 0, when they
weren't to start with. Something's corrupting memory ... I'd
happily blame my own code, but allegedly this has happened without
CONFIG_MULTIQUAD too.

> if (clustered_apic_mode)
> 	/* We don't have a good way to do this yet - hack */
> 	phys_id_present_map = (u_long) 0xf;
> 
> urgh...

Yeah, OK ... that's my fault. This is the physical space, and
we should really look up the physical ID of each device and put
into into a per-quad mapping. But that works just fine as a hack
without the NR_CPUs parameter, and it's only an exclusion thing
anyway, so even if a CPU doesn't come online it's correct enough.

The real question is why does this work if NR_CPUS is 32, but not
if we take it down somewhat? Likely one of the arrays is getting
overshot, but we need to do some debug to find out where & why.

> Overrall i think arch/i386/kernel/io_apic.c needs a looking over.

No denying that, but it takes a fearless man to stare into the
eyes of Intel's IOAPIC and survive ;-) I barely survived the last
time, and am not desperately keen to do it again ... <runs away>

M.


