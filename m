Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265164AbTLKRQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbTLKRQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:16:56 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:4253 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265164AbTLKRQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:16:52 -0500
Date: Thu, 11 Dec 2003 09:16:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ken <ken@nova.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4][PATCH] Xeon HT - SMT+SMP interrupt balancing
Message-ID: <1316550000.1071163004@[10.10.2.4]>
In-Reply-To: <3FD89EF5.30101@nova.org>
References: <3FD89EF5.30101@nova.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am a long time Linux user who has observed a behavior in recent 2.4.x kernels that I consider undesirable.  I have read the FAQ, 'googled'/searched the LKML archives, "lurked" on the list via archives, and contacted the Maintainer directly prior to posting.  Since Marcelo has announced the freezing of 2.4, I believe this is the appropriate time/forum to raise this issue.  This issue may be related to other recent threads with similar subjects, but has not been addressed IMHO.
> 
> 
> I have found that each kernel in 2.4.[19|20|21|22|23] detects my Dual (2) Xeon HT CPUs and maps hardware IRQs, but does not distribute interrupts from the IRQs across the 4 logical CPUs.  All interrupts seem to be handled by CPU0 except for LOC, which is per CPU.  In each case, I have corrected the behavior by applying Ingo's "linux-2.4.18-irqbalance.patch" which I found in an archive.  Thank you, Ingo, for posting it -- it has been a lifesaver. ;-)  I've found that it now exists by other names in various places.
> 
> For example, I have an Intel SR2300 based on an Intel SE7501-WV2 MB with   two Xeon 2.4G (HT) CPUs and E7500 (Plumas) chip set.  Booting the vanilla kernel results in this:
> 
># `cat /proc/interrupts` from 2.4.23 (essentially vanilla)
> 
>             CPU0       CPU1       CPU2       CPU3
>    0:      23147          0          0          0    IO-APIC-edge  timer
>    1:         49          0          0          0    IO-APIC-edge  keyboard
>    2:          0          0          0          0          XT-PIC  cascade
>    8:          1          0          0          0    IO-APIC-edge  rtc
>   15:          4          1          0          0    IO-APIC-edge  ide1
>   16:          0          0          0          0   IO-APIC-level  usb-uhci
>   19:          0          0          0          0   IO-APIC-level  usb-uhci
>   24:     247647          0          0          0   IO-APIC-level  eth3
>   27:          6          0          0          0   IO-APIC-level  eth2
>   31:       1509          0          0          0   IO-APIC-level  eth0
>   48:       2663          0          0          0   IO-APIC-level  dpti0
> NMI:          0          0          0          0
> LOC:      22996      22929      22995      22994
> ERR:          0
> MIS:          0
> 
> 
> 
> However, if I use Ingo's irq_balance patch, I get this:
> 
># `cat /proc/interrupts` on 2.4.23 w/ irq-balancing patch
> 
>             CPU0       CPU1       CPU2       CPU3
>    0:      67879      87331      67921      86498    IO-APIC-edge  timer
>    1:          1          0          0          1    IO-APIC-edge  keyboard
>    2:          0          0          0          0          XT-PIC  cascade
>    8:          1          0          0          0    IO-APIC-edge  rtc
>   15:          4          0          0          1    IO-APIC-edge  ide1
>   16:          0          0          0          0   IO-APIC-level  usb-uhci
>   19:          0          0          0          0   IO-APIC-level  usb-uhci
>   24:   14524668   17990352   14614712   17901660   IO-APIC-level  eth3
>   27:        341        431        341        421   IO-APIC-level  eth2
>   31:      10656      13555      10724      14244   IO-APIC-level  eth0
>   48:       2483       2997       2603       2874   IO-APIC-level  dpti0
> NMI:          0          0          0          0
> LOC:     309474     309472     309472     309405
> ERR:          0
> MIS:          0
> 
> 
> It is my understanding that Ingo's patch implements a "Brownian motion" of the interrupts.  While I'm unqualified to comment on the mathematical theory, I will confirm that I perceive a real improvement in performance.  The CPU activity reported by 'top' definitely shows better balance across logical CPUs.  The dmesg output for both scenarios is also attached.
> 
> I get similar results on all my Dell 2650 servers which have the Server Works chip set (specs at support.dell.com).  Also, there doesn't seem to   be any difference in behavior by selecting/deselecting full/ht/off ACPI support, if that is relevant.  I know that ACPI is used to scan the tables regardless -- you'll note proper detection and sibling mapping in both.  Furthermore, I note that if I disable HT in BIOS, I can get the two CPU balancing of interrupts seen on any non-HT SMP box, e.g., dual PIII on i440GX chip set.
> 
> But, as of 2.4.23 Ingo's patch doesn't apply cleanly, so I modified it. It is attached for your review -- NOTA BENE:  it works and I'm running it in production with moderate to heavy loads, but I don't know if I've introduced a bug somewhere else.  I've only tested it on the hardware mentioned above.
> 
> I have attempted user space alternatives -- irq_balance-0.06 and smp_affinity via sysctrl.  The former seems to "blindly" affine an IRQ to a single logical CPU, which in my case, puts the timer and eth3 on CPU0 and it gets "overloaded" while the others are mostly idle.  Using a mask with the latter results in the low number sibling handling the interrupts and the other sibling doing nothing/little.  Specifically, I use a mask of 0x03 on, say, IRQ 24 in an effort to use logical CPUs 0-1 and only CPU0 shows activity via /proc/interrupts.  Likewise, a mask of 0x0C on, say, IRQ 48 in an effort to use logical CPUs 2-3 and only CPU2 shows activity.  The perceived performance in both cases is much less than using the patch.
> 
> Also, I noticed that Nitin Kamble had submitted a possible alternative patch to 2.5.  In offline discussion with him, he preferred a discussion here prior to doing a back port.

Nitin's patch is in 2.6 - does that work OK for you?

M.

