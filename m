Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290884AbSASATM>; Fri, 18 Jan 2002 19:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290885AbSASAS7>; Fri, 18 Jan 2002 19:18:59 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:30200 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290884AbSASASn>; Fri, 18 Jan 2002 19:18:43 -0500
Message-Id: <200201190018.g0J0Idq11657@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Summit interrupt routing patches
Date: Fri, 18 Jan 2002 16:18:37 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16RiEX-0008Bi-00@the-village.bc.nu>
In-Reply-To: <E16RiEX-0008Bi-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 January 2002 03:15 pm, Alan Cox wrote:
> > alternative is much more invasive:  adding interrupt code to adjust
> > XTPRs, hacks to the scheduler to somehow encapsulate task priority in 4
> > bits, etc.
>
> Is it necessary to try something complex. We already keep per cpu/per irq
> data and if you have a lot of interrupts it feels like you can handwave
> them to be roughly the same amount of cpu load.
>
> Given that is it enough to once a second shuffle the irqs around to try and
> get a rough balance based on a simple decaying history. Then all it needs
> is a regular timer event to do what the hardware hasnt

Thanks for the reply.

What I'd like to see is a scheme where we route interrupts preferentially to 
idle CPUs.  If none are idle, then aim them at the CPUs running the "least 
important" tasks.  Also, since each CPU's local APIC only has two interrupt 
latches per `level' (the upper nibble of the IRQ's vector), it would be a 
good idea to avoid sending IRQs to those CPUs that are already processing one.

Since we only have 4 bits in each XPTR, suppose we used the high bit to 
indicate IRQ-in-progress and the bottom three for some kind of compressed 
task goodness measure.  Idle equals zero.  The XTPR would be updated on every 
interrupt entry/exit and on every task switch.

What's the catch?  The cost of doing the above.  Plus, we still only have two 
CPUs in each cluster, four if hyperthreading is turned on.  (Of course, the 
hyperthreaded "sibling processors" don't have the power of a full CPU -- 
maybe 20% to 40% of one.)  All interrupts have to be targeted at a particular 
cluster.  So, lowest priority interrupt delivery may not buy us very much.

To make matters even more interesting, the economy version (non-NUMA) of this 
hardware started shipping last month and the full version will be shipping 
soon.  I wonder if Marcelo is going to allow this kind of futzing around with 
interrupt and scheduler code in 2.4....

-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com

