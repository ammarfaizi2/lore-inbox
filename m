Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267150AbTAFVVu>; Mon, 6 Jan 2003 16:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267154AbTAFVVt>; Mon, 6 Jan 2003 16:21:49 -0500
Received: from navgwout.symantec.com ([198.6.49.12]:3489 "EHLO
	navgwout.symantec.com") by vger.kernel.org with ESMTP
	id <S267150AbTAFVVs>; Mon, 6 Jan 2003 16:21:48 -0500
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Gigabit/SMP performance problem
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.9a  January 7, 2002
Message-ID: <OF221E391C.B10B20E0-ON85256CA6.0070ACE5-85256CA6.00711485@symantec.com>
From: "Avery Fay" <avery_fay@symantec.com>
Date: Mon, 6 Jan 2003 15:33:38 -0500
X-MIMETrack: Serialize by Router on USCU-SMTPOB01-1/GLOBE-ADMIN/SYMANTEC(Release 5.0.11
  |July 24, 2002) at 01/06/2003 12:43:39 PM,
	Serialize complete at 01/06/2003 12:43:39 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The numbers I got are taking into account packet drops. I think that the 
point where performance starts to go down is when an interface is dropping 
more than a couple hundred packets per second (at least in my testing). In 
my testing scenario, traffic is perfectly distributed across interfaces 
and I have bound the irqs using smp_affinity. Unfortunately, the 
performance gain is small if any.

Avery Fay





Andrew Theurer <habanero@us.ibm.com>
01/03/2003 05:31 PM

 
        To:     "Martin J. Bligh" <mbligh@aracnet.com>, Avery Fay <avery_fay@symantec.com>
        cc:     linux-kernel@vger.kernel.org
        Subject:        Re: Gigabit/SMP performance problem


On Friday 03 January 2003 15:36, Martin J. Bligh wrote:

...

Monitor for dropped packets when increasing int delay.  At least on the 
older 
e1000 adapters, you would get dropped packets, etc, making the problem 
worse 
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

Another problem you may have is that irq_balance is random, and sometimes 
more 
than one interrupt is serviced by the same cpu at the same.  Actually, let 
me 
clarify.  In your case if your netowrk load was "even" across the 
adapters, 
ideally you would want cpu0 handling the first 4 adapters and cpu1 
handling 
the last 4 adapters.  With irq_balance, this is usually not the case. 
There 
will be times where one cpu is doing more work than the other, possibly 
becomming a bottleneck. 

Now, there was some code in SuSE's kernel (SuSE 8.0, 2.4.18) which did a 
round 
robin static assingment of interrupt to cpu.  In your case, all even 
interrupt numbers would go to cpu0 and all odd interrupt numbers would go 
to 
cpu1.  Since you have exactly 4 adapters in even interrupts and 4 on odd 
interrupts, that would work perfectly.  Now, that doesn't mean there is 
some 
other problem, like PCI bandwidth, but it's a start.  Also, you might be 
able 
to emulate this with irq affinity (/proc/irq/<num>/smp_affnity) but last 
time 
I tried it on P4, it didn't work at all -No interrupts!

-Andrew



