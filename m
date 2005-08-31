Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVHaPJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVHaPJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVHaPJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:09:17 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:10403 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S964829AbVHaPJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:09:16 -0400
Subject: Re: jack, PREEMPT_DESKTOP, delayed interrupts?
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: jackit-devel@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, cc@ccrma.Stanford.EDU,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20050831073518.GA7582@elte.hu>
References: <1125453795.25823.121.camel@cmn37.stanford.edu>
	 <20050831073518.GA7582@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1125500915.17851.10.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Aug 2005 08:08:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-31 at 00:35, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > Do a "tar cvf usr.tar /usr" just to read/write a lot to disk (this 
> > within the same SATA disk). Watch memory being used in a system 
> > monitor applet up to 100%. After a while, hard to say how long (maybe 
> > 10/15 minutes?) the system eventually can get into a state where Jack 
> > starts printing messages of the type "delay of 3856.000 usecs exceeds 
> > estimated spare time of 2653.000; restart ..." (if I understand 
> > correctly this means interrupts are being delayed on their way to 
> > Jack, or at least Jack thinks they are arriving too late), along with 
> > some less frequent xun notices.
> > 
> > Now the strange thing is that this condition seems to be persistent.  
> > Nothing I do after it starts to happen seems to halt those messages.  
> > Including stopping Jack and starting it again, and even (tried it 
> > once) stopping the alsa sound driver and loading it again. Nothing out 
> > of the ordinary in dmesg or /var/log/messages. I would guess that 
> > something "breaks" inside the kernel with regards to interrupt 
> > handling and/or whatever Jack uses to measure time inside the kernel?  
> > Interrupts are prioritized correctly (rtc, then audio and jack runs at 
> > lower realtime priority than the audio interrupts), everything else 
> > looks fine.
> 
> are the messages unstoppable, even if the system is completely idle? And 
> you get this only with the SMP kernel, correct?

That's correct. I have to try harder with a UP kernel but I'm short on
time. I should see how idle I can get the system (ie: logout, start
stopping processes), but quitting jack and all related apps and/or
restarting alsa does not fix the problem. Top does not show anything
strange in terms of cpu usage.

> i dont know what's going on, but here are a couple of ideas to debug 
> this further:
> 
> - could you check whether there are any SCHED_FIFO tasks that shouldnt 
>   be there:
> 
>     ps -meo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm | grep FF

Seems to be fine (I'm doing this remotely so I can't look at the screen
to see if jack is still spewing messages):

    -     2 FF      99   - 139   0  0.0 S    migration_thre -
    -     3 FF       1   -  41   0  0.0 S    ksoftirqd      -
    -     4 FF       1   -  41   0  0.0 S    ksoftirqd      -
    -     5 FF       1   -  41   0  0.0 S    ksoftirqd      -
    -     6 FF       1   -  41   0  0.0 S    ksoftirqd      -
    -     7 FF       1   -  41   0  0.0 S    ksoftirqd      -
    -     8 FF       1   -  41   0  0.0 S    ksoftirqd      -
    -    10 FF      99   - 139   0  0.0 S    watchdog       -
    -    11 FF      99   - 139   1  0.0 S    migration_thre -
    -    12 FF       1   -  41   1  0.0 S    ksoftirqd      -
    -    13 FF       1   -  41   1  0.0 S    ksoftirqd      -
    -    14 FF       1   -  41   1  0.0 S    ksoftirqd      -
    -    15 FF       1   -  41   1  0.0 S    ksoftirqd      -
    -    16 FF       1   -  41   1  0.0 S    ksoftirqd      -
    -    17 FF       1   -  41   1  0.0 S    ksoftirqd      -
    -    19 FF      99   - 139   1  0.0 S    watchdog       -
    -    20 FF       1   -  41   0  0.0 S<   worker_thread  -
    -    21 FF       1   -  41   1  0.0 S<   worker_thread  -
    -    27 FF      49   -  89   0  0.0 S<   irqd           -
    -   295 FF      80   - 120   0  0.0 S<   irqd           -
    -   313 FF      49   -  89   0  0.0 S<   irqd           -
    -   346 FF      46   -  86   0  0.0 S<   irqd           -
    -   378 FF      50   -  90   0  0.0 S<   irqd           -
    -   408 FF      44   -  84   0  0.0 S<   irqd           -
    -   421 FF      60   - 100   0  0.0 S<   irqd           -
    -   923 FF      42   -  82   0  0.0 S<   irqd           -
    -   947 FF      41   -  81   0  0.0 S<   irqd           -
the next line is the soundcard interrupt:
    -  1033 FF      70   - 110   0  0.0 S<   irqd           -
    -  1046 FF      69   - 109   0  0.0 S<   irqd           -
    -  1205 FF      59   -  99   0  0.0 S<   irqd           -
    -  3946 FF      37   -  77   0  0.0 S<   irqd           -
    -  3947 FF      36   -  76   0  0.0 S<   irqd           -
    -  3972 FF      35   -  75   0  0.0 S<   irqd           -
    -  4434 FF      34   -  74   0  0.0 S<   irqd           -
These guys should be jackd (no clients are running):
    -  4674 FF      61   - 101   1  0.2 SLl  -              -
    -  4671 FF      72   - 112   1  0.0 SLsl -              -
    -  4672 FF      62   - 102   1  0.6 SLsl -              -

Interrupt lines:
# cat /proc/interrupts
           CPU0       CPU1
  0:     112487   51273672  IO-APIC-edge   [.........N/  0]  timer
  1:          1        638  IO-APIC-edge   [........../  0]  i8042
  7:          2          1  IO-APIC-edge   [..P......./  0]  parport0
  8:          0          1  IO-APIC-edge   [.........N/  0]  rtc
  9:          0          0  IO-APIC-level  [........../  0]  acpi
 12:        128      25211  IO-APIC-edge   [........../  0]  i8042
 14:       1271     459434  IO-APIC-edge   [........../  0]  ide0
177:          0          0  IO-APIC-level  [........../  0]  libata
185:       2613     701940  IO-APIC-level  [........../  0]  libata,
ehci_hcd:usb1
193:        609     174347  IO-APIC-level  [........../  0]  SysKonnect
SK-98xx
201:      25124   38426783  IO-APIC-level  [.........N/  0]  ICE1712,
ohci1394
209:          0          0  IO-APIC-level  [.........N/  0]  NVidia
CK8S, ohci_hcd:usb2
217:          0          0  IO-APIC-level  [........../  0] 
ohci_hcd:usb3
225:      11191    3327675  IO-APIC-level  [........../  0] 
radeon@pci:0000:01:00.0
NMI:          0          0
LOC:   51386600   51386544
ERR:          1
MIS:          0

Thanks for all the debugging tips!!
I'll see what I can do today. 
-- Fernando


