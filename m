Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbTFCClU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 22:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTFCClU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 22:41:20 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:55425
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264900AbTFCClS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 22:41:18 -0400
Date: Mon, 2 Jun 2003 22:44:08 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][2.5] provisional 32-way x445 patches
In-Reply-To: <200306021836.14227.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.50.0306022232220.14455-100000@montezuma.mastecende.com>
References: <200305232036.39297.jamesclv@us.ibm.com>
 <Pine.LNX.4.50.0305241433270.2267-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0305241659530.16144-100000@montezuma.mastecende.com>
 <200306021836.14227.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, James Cleverdon wrote:

> Back from holiday.
> 
> This kludge doesn't change any IDT behavior, so it is vulnerable to vector 
> exhaustion too.  It just deals with large systems that have large I/O APICs.  
> Since we are indexing irq_vectors by the sum of all available I/O APIC RTEs 
> and not checking for overflow, we can get into trouble.

Yeah i get the same with 2.5.70 on a 32way NUMAQ, basically we just keep 
going regardless of what NR_IRQS is and then try and write garbage all 
over the IDT. There appears to be something wrong with my patch as it gets 
ignored each time i send it.

> Some numbers:
> 
> * A 32-way x445 is made up of four 8-way chassis hooked together by 
> scalability cables.
> 
> * Each Summit chassis has 2 I/O APICs with 50 RTEs per.  The BIOS guys are 
> trying to help out by using some hardware to only use one I/O APIC for all 
> but the boot chassis.
> 
> * Each RXE100 PCI expansion box contains one or two I/O APICs with 50 RTEs 
> each.  Every chassis can have one RXE100.
> 
> Even without PCI expansion boxes, 5 * 50 == 250 which is > 224.  The kernel 
> overflows irq_vectors and dies.
> 
> Since the value stuffed into irq_vectors is 0x31 to 0xF8, it easily fits into 
> a byte.  As a quick kludge, I changed the type of irq_vectors and quadrupled 
> the number.  With 896 elements in the array, the system survived and ran.

Are you implying that the large array stopped your box from booting?

> For a real fix, irq_vectors should be dynamically allocated.  But then, I 
> should port the dynamic MAX_MP_BUSSES patch from 2.4 to 2.5 anyway....

Hmm dynamic irq_vectors sounds good, we could start off with a static 
amount and then dynamically allocate once we start reaching the silly 
numbers. Dynamic allocation for all might get interesting at early boot.

This is the patch i use right now to boot 2.5.70 on 32way NUMAQ without 
disabling IOAPICs, however i do drop the overflow interrupts.

http://function.linuxpower.ca/patches/misc/patch-fix-8quad-mainline3

I also have another patch to just increase NR_IRQS, this was used on the 
same 8quad and allowed full functionality of all the devices upto and 
including node7

http://www.osdl.org/projects/numaqhwspprt/results/patch-numaq-highirq7

http://www.osdl.org/projects/numaqhwspprt/results/data/dmesg-32way-8quad-2.5.70-640irqs

But the static arrays aren't all that nice, do you plan on starting on the 
dynamic allocation of NR_IRQS sized arrays sometime soon?

Thanks,
	Zwane
-- 
function.linuxpower.ca
