Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbTDURIU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTDURIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:08:20 -0400
Received: from [66.212.224.118] ([66.212.224.118]:36615 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S261747AbTDURIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:08:18 -0400
Date: Mon, 21 Apr 2003 13:12:26 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB56401A45722@fmsmsx407.fm.intel.com>
Message-ID: <Pine.LNX.4.50.0304211306400.2085-100000@montezuma.mastecende.com>
References: <3014AAAC8E0930438FD38EBF6DCEB56401A45722@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, Nakajima, Jun wrote:

> BTW, I think a better way is to switch from IRQ-base to vector-base. 
> We are working on PCI MSI (Messaged Signaled Support) support, and MSI 
> does not require IRQ (or the platform does not provide IRQ at all), and 
> found a vector-based solution was simpler. 
> 
> Even if MSI is not required, I think vector-based is a clearer solution 
> (IA-64 is using vector-based). IRQs are given by the platform, and the 
> kernel cannot do anything with those. Vector assignment/allocation are 
> fully controlled by the kernel, and the kernel can return the vector 
> number instead of IRQ (except legacy drivers where IRQs < 16). 
> 
> We made a prototype that simply returns the vector numbers for IRQ to 
> device drivers (dev.irq). The function do_IRQ(), for example, gets the 
> vector number, instead of IRQ. No changes to arch/i386/kernel/irq.c were 
> required.

I know there are more people who want to get rid of NR_IRQS e.g. due to 
very sparse irq distribution. For one of the platforms i'm interested in, 
we have to make a clear distinction between irqs and vectors so that we 
can have seperate vector allocations per interrupt handling domain. I 
believe IA-64 does the same but instead per cpu (our domain/node consists 
of 4 cpus) NR_IRQS gets in the way due to it being set at 224 when we actually 
can service NR_IRQ_VECTORS * NUM_MAXNODES I/O vectors. Can you post your 
patch?

Also what MSI devices are you using?

> Before (IRQ-based)
> # cat /proc/interrupts 
>            CPU0       CPU1       
>   0:      10921     671640    IO-APIC-edge  timer
>   2:          0          0          XT-PIC  cascade
>   9:          0          0   IO-APIC-level  acpi
>  14:       5102          1    IO-APIC-edge  ide0
>  15:         10          1    IO-APIC-edge  ide1
>  16:          0          0   IO-APIC-level  uhci-hcd, uhci-hcd
>  18:        449          0   IO-APIC-level  uhci-hcd
>  19:         61          0   IO-APIC-level  uhci-hcd
>  20:        345          0   IO-APIC-level  eth0
>  23:          0          0   IO-APIC-level  ehci-hcd
> NMI:          0          0 
> LOC:     680526     680437 
> ERR:          0
> MIS:          0
> 
> After (vector-based)
>            CPU0       CPU1       
>   0:     709682          0    IO-APIC-edge  timer
>   2:          0          0          XT-PIC  cascade
>   9:          0          0   IO-APIC-level  acpi
>  14:       4988          1    IO-APIC-edge  ide0
>  15:         10          1    IO-APIC-edge  ide1
> 177:         78          0   IO-APIC-level  uhci-hcd
> 185:          0          0   IO-APIC-level  uhci-hcd, uhci-hcd
> 193:         58          0   IO-APIC-level  uhci-hcd
> 201:          0          0   IO-APIC-level  ehci-hcd
> 209:        356          0   IO-APIC-level  eth0
> NMI:          0          0 
> LOC:     707613     707524 
> ERR:          0
> MIS:          0

-- 
function.linuxpower.ca
