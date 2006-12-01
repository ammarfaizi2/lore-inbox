Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759328AbWLASVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759328AbWLASVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759329AbWLASVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:21:06 -0500
Received: from smtp3.Stanford.EDU ([171.67.20.26]:13524 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S1759328AbWLASVD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:21:03 -0500
Subject: Re: 2.6.19-rt1: max latencies with jackd
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, Rui Nuno Capela <rncbc@rncbc.org>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20061201080826.GA17504@elte.hu>
References: <1164923245.31959.49.camel@cmn3.stanford.edu>
	 <20061201080826.GA17504@elte.hu>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 10:21:00 -0800
Message-Id: <1164997260.4385.12.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 09:08 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > Hi Ingo, I finally have a rebuilt kernel with latency tracing enabled, 
> > a jackd with the proper prctl incantations built in and I'm getting 
> > some (hopefully) meaningful data.
> 
> ok. I'm first trying to understand what is happening. For example lets 
> take the longest latency from the 'idle' collection:
> 
>  latency: 801 us, #470/470, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
> 
> tracing starts here:
> 
>     japa-27320     0D...   18us : user_trace_start (sys_prctl)
> 
> then some 400 usecs later japa-27320 is scheduled away:
> 
>     softirq--5     0D..2  445us : thread_return <japa-27320> (161 199)
> 
> it has been scheduled away because softirq--5 [softirq-timer/0] has 
> SCHED_FIFO 99, which preempts japa-27320 which has SCHED_FIFO 61.
> 
> 200 usecs later softirq--5 has finished processing and goes to 
> posix_cp-3, which too is SCHED_FIFO 99:
> 
>     posix_cp-3     0D..2  607us : thread_return <softirq--5> (199 199)
> 
> and then 60 usecs later we go back to japa-27320:
> 
>     japa-27320     0D..2  663us : thread_return <posix_cp-3> (199 161)
> 
> which, 130 usecs later, stops tracing:
> 
>     japa-27320     0....  793us : user_trace_stop (sys_prctl)
> 
> this particular latency is caused by softirq--5 and posix_cpu_thread 
> having SCHED_FIFO 99. Why do they have that high priority?

The priorities are optimized by Rui's rtirq script for sound
performance[*]. Both softirq-timer processes (one per cpu?) are set by
rtirq to 99, I forget why (Rui?) - I presume for better timing? I don't
know about the posix_cpu_thread one - rtirq seems to not touch it, this
is what I currently have in that machine (SCHED_FIFO ones):

  PID CLS RTPRIO  NI PRI %CPU STAT COMMAND
    2 FF      99   - 139  0.0 S    migration/0
    3 FF      99   - 139  0.0 S    posix_cpu_timer
    5 FF      99   - 139  0.0 S    softirq-timer/0
   12 FF      99   - 139  0.0 S    watchdog/0
   14 FF      99   - 139  0.0 S    migration/1
   15 FF      99   - 139  0.0 S    posix_cpu_timer
   17 FF      99   - 139  0.0 S    softirq-timer/1
   24 FF      99   - 139  0.0 S    watchdog/1
  348 FF      80   - 120  0.0 S<   IRQ 8
  809 FF      70   - 110  0.9 S<   IRQ 18
  436 FF      69   - 109  0.0 S<   IRQ 20
  432 FF      60   - 100  0.0 S<   IRQ 21
  431 FF      59   -  99  0.0 S<   IRQ 22
  413 FF      50   -  90  0.0 S<   IRQ 1
   73 FF      49   -  89  0.0 S<   IRQ 9
  412 FF      49   -  89  0.0 S<   IRQ 12
  383 FF      47   -  87  0.0 S<   IRQ 14
  468 FF      41   -  81  0.0 S<   IRQ 17
  784 FF      40   -  80  0.0 S<   IRQ 19
 1036 FF      38   -  78  0.0 S<   IRQ 6
 1492 FF      37   -  77  0.0 S<   IRQ 7
    4 FF       1   -  41  0.0 S    softirq-high/0
    6 FF       1   -  41  0.0 S    softirq-net-tx/
    7 FF       1   -  41  0.0 S    softirq-net-rx/
    8 FF       1   -  41  0.0 S    softirq-block/0
    9 FF       1   -  41  0.0 S    softirq-tasklet
   10 FF       1   -  41  0.0 S    softirq-hrtimer
   11 FF       1   -  41  0.0 S    softirq-rcu/0
   16 FF       1   -  41  0.0 S    softirq-high/1
   18 FF       1   -  41  0.0 S    softirq-net-tx/
   19 FF       1   -  41  0.0 S    softirq-net-rx/
   20 FF       1   -  41  0.0 S    softirq-block/1
   21 FF       1   -  41  0.0 S    softirq-tasklet
   22 FF       1   -  41  0.0 S    softirq-hrtimer
   23 FF       1   -  41  0.0 S    softirq-rcu/1
   26 FF       1   -  41  0.0 S<   events/0
   27 FF       1   -  41  0.0 S<   events/1

And these are the interrupts and what they belong to:

           CPU0       CPU1       
  0:        264       3174   IO-APIC-edge      timer
  1:       6001       3692   IO-APIC-edge      i8042
  6:          0          6   IO-APIC-edge      floppy
  7:          0          0   IO-APIC-edge      parport0
  8:          0          0   IO-APIC-edge      rtc
  9:          0          0   IO-APIC-fasteoi   acpi
 12:      77138      60243   IO-APIC-edge      i8042
 14:      45881     612036   IO-APIC-edge      ide0
 17:          0          0   IO-APIC-fasteoi   libata
 18:   55369538    2684362   IO-APIC-fasteoi   ohci1394, ICE1712
 19:       6999         17   IO-APIC-fasteoi   eth0
 20:          0          0   IO-APIC-fasteoi   ehci_hcd:usb3, NVidia
CK8S
 21:          1        591   IO-APIC-fasteoi   ohci_hcd:usb2
 22:     779065     386084   IO-APIC-fasteoi   ohci_hcd:usb1, libata
NMI:  395324246  390468239 
LOC:   44676265   44437073 
ERR:          0

Not all traces coincided with alsa xruns. And I had xruns much longer
than what the traces suggest. I'll try to get a better report by
inserting the xrun messages as best as I can in the trace timeline. 

[MUNCH]
> could you try the patch below? 

I'm building a new kernel, will report back. 
Thanks!!
-- Fernando

[*] current version of rtirq here:
  http://www.rncbc.org/jack/rtirq-20060819.tar.gz


