Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbTACVev>; Fri, 3 Jan 2003 16:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTACVev>; Fri, 3 Jan 2003 16:34:51 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:47005 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267672AbTACVet>; Fri, 3 Jan 2003 16:34:49 -0500
Date: Fri, 03 Jan 2003 13:36:26 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Avery Fay <avery_fay@symantec.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
Message-ID: <23880000.1041629786@flay>
In-Reply-To: <OF256CD297.9F92C038-ON85256CA3.006A4034-85256CA3.00705DEA@symantec.com>
References: <OF256CD297.9F92C038-ON85256CA3.006A4034-85256CA3.00705DEA@symantec.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dual Pentium 4 Xeon at 2.4 Ghz. I believe I am using irq load balancing as 
> shown below (seems to be applied to Red Hat's kernel). Here's 
> /proc/interrupts:

Is in 2.4.20-ac2 at least. See if arch/i386/kernel/io_apic.c
has a function called balance_irq.

>            CPU0       CPU1 
>   0:     179670     182501    IO-APIC-edge  timer
>   1:        386        388    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   8:          1          0    IO-APIC-edge  rtc
>  12:          9          9    IO-APIC-edge  PS/2 Mouse
>  14:       1698       1511    IO-APIC-edge  ide0
>  24:    1300174    1298071   IO-APIC-level  eth2
>  25:    1935085    1935625   IO-APIC-level  eth3
>  28:    1162013    1162734   IO-APIC-level  eth4
>  29:    1971246    1967758   IO-APIC-level  eth5
>  48:    2753990    2753821   IO-APIC-level  eth0
>  49:    2047386    2043894   IO-APIC-level  eth1
>  72:     838987     841143   IO-APIC-level  eth6
>  73:    2767885    2768307   IO-APIC-level  eth7
> NMI:          0          0 
> LOC:     362009     362008 
> ERR:          0
> MIS:          0
> 
> I started traffic at different times on the various interfaces so the 
> number of interrupts per interface aren't uniform.
> 
> I modified RxIntDelay, TxIntDelay, RxAbsIntDelay, TxAbsIntDelay, 
> FlowControl, RxDescriptors, TxDescriptors. Increasing the various 
> IntDelays seemed to improve performance slightly.

Makes sense, increasing the delays should reduce the interrupt load.

> I'm using 3 Intel PRO/1000 MT Dual Port Server adapters as well as 2 
> onboard Intel PRO/1000 ports. The adapters use the 82546EB chips. I 
> believe that the onboard ports use the same although I'm not sure.
>
> Should I get rid of IRQ load balancing? And what do you mean 
> "Intel broke the P4's interrupt routing"?

P3's distributed interrupts round-robin amongst cpus. P4's send 
everything to CPU 0. If you put irq_balance on, it'll spread
them around, but any given interrupt is still only handled by
one CPU (as far as I understand the code). If you hammer one
adaptor, does that generate more interrupts than 1 cpu can handle?
(turn irq balance off by sticking a return at the top of balance_irq,
and hammer one link, see how much CPU power that burns).

M.
