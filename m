Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUFUKq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUFUKq3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 06:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUFUKq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 06:46:29 -0400
Received: from golobica.uni-mb.si ([164.8.100.4]:21150 "EHLO
	golobica.uni-mb.si") by vger.kernel.org with ESMTP id S266187AbUFUKqW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 06:46:22 -0400
Message-ID: <40D6BC5F.4070200@utrip.net>
Date: Mon, 21 Jun 2004 12:45:51 +0200
From: Milan Gabor <milan.gabor@utrip.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Cordes <peter@cordes.ca>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] x86-64: double timer interrupts in recent 2.4.x
References: <20040616192826.GD14043@cordes.ca>
In-Reply-To: <20040616192826.GD14043@cordes.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have Suse 9.0 and dual Opteron on MSI K8T Master 2 motherboard.
I also get  interrupts only on one cpu and my clock is ticking strange, 
so I have to synchronize it with NTP server frequently.

This is from my system:
            CPU0       CPU1
   0:      30434   16139843    IO-APIC-edge  timer
   1:        944          0    IO-APIC-edge  keyboard
   2:          0          0          XT-PIC  cascade
  14:         30          1    IO-APIC-edge  ide0
  16:     657371          0   IO-APIC-level  eth0
  20:     261267          0   IO-APIC-level  libata
NMI:     694146     873271
LOC:   16167676   16167576
ERR:          1
MIS:          0

Linux www 2.4.21-226-smp #1 SMP Tue Jun 15 09:14:10 UTC 2004 x86_64 
x86_64 x86_64 GNU/Linux


I am also running irq_balance and acpi=off set from grub boot menu.
Without acpi=off system never boots.

Is there any solution, so clock will work OK and interrupts will be on 
both CPUs?

MIlan


Peter Cordes wrote:

>  Nobody replied to this message on debian-amd64@lists.d.o, or
> discuss@x86-64.org.  Hopefully I've found the right places to send this this
> time around.  Actually, Roland Fehrenbacher saw my message in a list archive
> and mailed me to confirm that he saw the same double-speed clock problem on
> two different machines, so it's not just Tyan S2880 boards.  He suggested I
> mail Andi and lkml, so here goes.  (I haven't tested again with anything more
> recent than 2.4.27-pre2, so if this is fixed, sorry.)
> 
> -----
> 
>  I just noticed that on my Opteron cluster, the nodes that are running 64bit
> kernels have their clocks ticking at double speed.  This happens with
> Linux 2.4.26, and 2.4.27-pre2, compiled with gcc 3.3.3 (Debian 20040401) in a
> Debian pure64 chroot. Linux 2.4.25, compiled on Debian Woody + bi-arch gcc
> 3.3.2 20030908, does _not_ have the problem.  The config options were pretty
> much the same for all kernels, and all the kernels are plain vanilla flavour
> from www.ca.kernel.org.
> 
>  If I run ntpdate to set the clock, then 10 seconds later it will be 10
> seconds fast.  Running date(1), the system time advances 20 seconds in 10
> seconds of real time.  (I haven't done anything weird with adjtimex(8).)
> time sleep 10 takes 5 seconds, but bash reports its real time as 10 seconds.
> The timer interrupt counter is increasing at a rate of 200/real second, so
> it seems like the system is getting timer interrupts twice as fast as it
> should.  (With 2.4.25, it is 100/sec, same as HZ).
> 
>  Linux says it is using the PIT and TSC timers.  I have HPET enabled in my
> Linux config, but I guess Tyan's S2880 mobo doesn't have one.  This is a
> dual-Opteron 240 machine, BTW.
> 
>  i386 Linux on the same machines has no problems with timekeeping.  (But I
> haven't tested versions later than 2.4.25 in legacy mode.)
> 
>  I spent some time poking around the timer code that increments xtime, but I
> guess the fact that the timer irqs are coming at double speed indicates that
> the problem lies elsewhere.  Maybe the code that sets up the timer?
> 
> $ uname -a
> Linux node6.cs.dal.ca 2.4.26 #2 SMP Fri May 14 14:46:42 ADT 2004 x86_64 x86_64 x86_64 GNU/Linux
> $ cat /proc/interrupts
>            CPU0       CPU1
>   0:    4415908          0    IO-APIC-edge  timer
>   1:          2          0    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   9:          0          0   IO-APIC-level  acpi
>  14:      17861          1    IO-APIC-edge  ide0
>  19:          0          0   IO-APIC-level  usb-ohci, usb-ohci
>  24:     563942          0   IO-APIC-level  eth0
>  25:     564331          0   IO-APIC-level  eth1
> NMI:      19097      19097
> LOC:    2211090    2211095
> ERR:          0
> MIS:          0
> 
>  Only CPU0 is getting the timer interrupt, but at least we know it's not
> that both CPUs are getting the timer interrupt.  (Both CPUs get 100 LOC:
> (local APIC) interrupts/sec, but that happens on the non-buggy 2.4.25, too.)
> 
>  Thanks for any help,
>  
>  I'm not subscribed to the lkml, so please CC me on any followups.
> 
