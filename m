Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbUKBWNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUKBWNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbUKBWI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:08:27 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:55188 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261807AbUKBWGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:06:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Daniel Egger <degger@fhm.edu>
Subject: Re: 2.6.8 and 2.6.9 Dual Opteron glitches
Date: Tue, 2 Nov 2004 22:53:50 +0100
User-Agent: KMail/1.6.2
Cc: Linux Mailing List Kernel <linux-kernel@vger.kernel.org>
References: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu>
In-Reply-To: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411022253.51040.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 02 of November 2004 14:59, Daniel Egger wrote:
> Hija,
> 
> I've a few glitches with my brandnew dual Opteron System which I'd
> like to share with you. First of all, all those problems seem to
> be there with 2.6.8.1 and 2.6.9 but since this seemed to be the
> case I moved on with 2.6.9 and hadn't investigated any further
> on 2.6.8.1 so some of the issues might only apply to 2.6.9.

I'm using 2.6.10-rc1-mm2 currently, on a dual Opteron w/ Tyan Thunder K8W.

> 1) 32 bit kernel HPET calibration hang: If the kernel is compiled
>     with HPET support, the kernel will hang on boot while
>     calibrating the timer. The problem goes away if HPET support is
>     not compiled in. I've no idea what information to provide to help
>     debug this.

I can't confirm this.  I've just set CONFIG_HPET and friends (except for 
CONFIG_HPET_RTC_IRQ) and nothing wrong happens.

> 2) 64 bit kernel vgettimeofday panic: The kernel panics in
>     arch/x64_64/vsyscall.c:169 on boot.

This does not happen on my system.

> 
>    static int __init vsyscall_init(void)
>    {
>            if ((unsigned long) &vgettimeofday != 
> VSYSCALL_ADDR(__NR_vgettimeofday))
>                    panic("vgettimeofday link addr broken");
> 
>    Replacing those panic(s) by printk make the machine boot just fine
>    and also work (seemingly) without any problems under load.
> 
> 3) Interrupt distribution 32 bit vs. 64 bit. Below is a copy of the
>     current interrupt distribution for the 64 bit kernel which shows
>     a huge shift towards CPU1. In a 32 bit kernel the distribution is
>     reversed and even more visible than here since in total <100
>     interupts will be handled by CPU1 after days of operation. The 64
>     bit kernel has all relevant options for K8 (irq balancing,
>     NUMA support, etc.) enabled.
> 
>             CPU0       CPU1
>    0:      15260    4196668   IO-APIC-edge  timer
>    9:          0          0   IO-APIC-level  acpi
> 169:          0          5   IO-APIC-level  ehci_hcd
> 177:          0          3   IO-APIC-level  uhci_hcd, ohci1394
> 185:       1999     934839   IO-APIC-level  uhci_hcd, eth0
> NMI:       2698       2817
> LOC:    4211263    4211263
> ERR:          0
> MIS:          0

I see this effect too, but I'd attribute it to the fact that on my board the 
whole I/O is attached to one of the processors (then it's CPU1, I'd bet).

> 4) ACPI powermanagement (32bit and 64bit): No matter which ACPI options
>     I choose in the BIOS, ACPI will only handle the first CPU somewhat
>     and leave the second CPU alone. I'd love to have some simple
>     powermanagement because the system will get quite warm, even when
>     idle, and warm == loud because the fans (which are barely noticeable
>     when the system is cold) kick into gear quite fast.
> 
> processor id:            0
> acpi id:                 1
> bus mastering control:   no
> power management:        no
> throttling control:      yes
> limit interface:         yes
> active limit:            P0:T0
> user limit:              P0:T0
> thermal limit:           P0:T0
> active state:            C1
> default state:           C1
> bus master activity:     00000000
> states:
>     *C1:                  promotion[--] demotion[--] latency[000] 
> usage[00000000]
>      C2:                  <not supported>
>      C3:                  <not supported>
> state count:             8
> active state:            T0
> states:
>     *T0:                  00%
>      T1:                  12%
>      T2:                  25%
>      T3:                  37%
>      T4:                  50%
>      T5:                  62%
>      T6:                  75%
>      T7:                  87%
> 
> processor id:            1
> acpi id:                 2
> bus mastering control:   no
> power management:        no
> throttling control:      no
> limit interface:         no
> <not supported>
> active state:            C1
> default state:           C1
> bus master activity:     00000000
> states:
>     *C1:                  promotion[--] demotion[--] latency[000] 
> usage[00000000]
>      C2:                  <not supported>
>      C3:                  <not supported>
> <not supported>

This happens on my system too.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
