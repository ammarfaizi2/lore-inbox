Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267696AbTACWYF>; Fri, 3 Jan 2003 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267697AbTACWYF>; Fri, 3 Jan 2003 17:24:05 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:60624 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267696AbTACWYD> convert rfc822-to-8bit; Fri, 3 Jan 2003 17:24:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Avery Fay <avery_fay@symantec.com>
Subject: Re: Gigabit/SMP performance problem
Date: Fri, 3 Jan 2003 16:31:47 -0600
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <OF256CD297.9F92C038-ON85256CA3.006A4034-85256CA3.00705DEA@symantec.com> <23880000.1041629786@flay>
In-Reply-To: <23880000.1041629786@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301031631.47381.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 January 2003 15:36, Martin J. Bligh wrote:
> > Dual Pentium 4 Xeon at 2.4 Ghz. I believe I am using irq load balancing
> > as shown below (seems to be applied to Red Hat's kernel). Here's
> > /proc/interrupts:
>
> Is in 2.4.20-ac2 at least. See if arch/i386/kernel/io_apic.c
> has a function called balance_irq.
>
> >            CPU0       CPU1
> >   0:     179670     182501    IO-APIC-edge  timer
> >   1:        386        388    IO-APIC-edge  keyboard
> >   2:          0          0          XT-PIC  cascade
> >   8:          1          0    IO-APIC-edge  rtc
> >  12:          9          9    IO-APIC-edge  PS/2 Mouse
> >  14:       1698       1511    IO-APIC-edge  ide0
> >  24:    1300174    1298071   IO-APIC-level  eth2
> >  25:    1935085    1935625   IO-APIC-level  eth3
> >  28:    1162013    1162734   IO-APIC-level  eth4
> >  29:    1971246    1967758   IO-APIC-level  eth5
> >  48:    2753990    2753821   IO-APIC-level  eth0
> >  49:    2047386    2043894   IO-APIC-level  eth1
> >  72:     838987     841143   IO-APIC-level  eth6
> >  73:    2767885    2768307   IO-APIC-level  eth7
> > NMI:          0          0
> > LOC:     362009     362008
> > ERR:          0
> > MIS:          0
> >
> > I started traffic at different times on the various interfaces so the
> > number of interrupts per interface aren't uniform.
> >
> > I modified RxIntDelay, TxIntDelay, RxAbsIntDelay, TxAbsIntDelay,
> > FlowControl, RxDescriptors, TxDescriptors. Increasing the various
> > IntDelays seemed to improve performance slightly.

Monitor for dropped packets when increasing int delay.  At least on the older 
e1000 adapters, you would get dropped packets, etc, making the problem worse 
in other areas. 
>
> Makes sense, increasing the delays should reduce the interrupt load.
>
> > I'm using 3 Intel PRO/1000 MT Dual Port Server adapters as well as 2
> > onboard Intel PRO/1000 ports. The adapters use the 82546EB chips. I
> > believe that the onboard ports use the same although I'm not sure.
> >
> > Should I get rid of IRQ load balancing? And what do you mean
> > "Intel broke the P4's interrupt routing"?
>
> P3's distributed interrupts round-robin amongst cpus. P4's send
> everything to CPU 0. If you put irq_balance on, it'll spread
> them around, but any given interrupt is still only handled by
> one CPU (as far as I understand the code). If you hammer one
> adaptor, does that generate more interrupts than 1 cpu can handle?
> (turn irq balance off by sticking a return at the top of balance_irq,
> and hammer one link, see how much CPU power that burns).

Another problem you may have is that irq_balance is random, and sometimes more 
than one interrupt is serviced by the same cpu at the same.  Actually, let me 
clarify.  In your case if your netowrk load was "even" across the adapters, 
ideally you would want cpu0 handling the first 4 adapters and cpu1 handling 
the last 4 adapters.  With irq_balance, this is usually not the case.  There 
will be times where one cpu is doing more work than the other, possibly 
becomming a bottleneck.  

Now, there was some code in SuSE's kernel (SuSE 8.0, 2.4.18) which did a round 
robin static assingment of interrupt to cpu.  In your case, all even 
interrupt numbers would go to cpu0 and all odd interrupt numbers would go to 
cpu1.  Since you have exactly 4 adapters in even interrupts and 4 on odd 
interrupts, that would work perfectly.  Now, that doesn't mean there is some 
other problem, like PCI bandwidth, but it's a start.  Also, you might be able 
to emulate this with irq affinity (/proc/irq/<num>/smp_affnity) but last time 
I tried it on P4, it didn't work at all -No interrupts!

-Andrew
