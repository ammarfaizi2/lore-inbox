Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTAOTWY>; Wed, 15 Jan 2003 14:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267110AbTAOTWY>; Wed, 15 Jan 2003 14:22:24 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:15791 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S267104AbTAOTWW>; Wed, 15 Jan 2003 14:22:22 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD907@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
Date: Wed, 15 Jan 2003 13:30:37 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Actually, I've also been feeling pain about MAX_IRQ_SOURCES, NR_IRQS,
>and HARDIRQ_BITS in addition to MAX_IO_APICS and MAX_APICS. I'll bet
>some ppl will have trouble with MAX_MP_BUSSES also, though I don't
>have any heavily-populated systems to stress that with.

... and one more from me: isn't it time to let IO-APIC id be 8 bit in the
asm/io_apic.h (make it a union fot both?..)?
Look what I have to do in io_apic.h to get around it and ... "mister, have a
heart":
=========================================
struct IO_APIC_reg_00 {
	__u32	__reserved_2	: 24,
		ID		:  4,
		__reserved_1	:  4;
} __attribute__ ((packed));
#ifdef CONFIG_ES7000
struct IO_APIC_reg_00_1 {
        __u32   __reserved_2    : 24,
                ID              :  8;
} __attribute__ ((packed));
#endif /* CONFIG_ES7000 */
=========================================

and then in io_apic.c:

=========================================
#ifdef CONFIG_ES7000
	struct IO_APIC_reg_00_1 reg_00_1;
	unsigned long *reg_00_p;
	
	if (es7000_plat)
		reg_00_p = (unsigned long *)&reg_00_1;
	else
		reg_00_p = (unsigned long *)&reg_00;
#endif /*CONFIG_ES7000*/
.......
#ifndef CONFIG_ES7000
		*(int *)&reg_00 = io_apic_read(apic, 0);
#else
		*(int *)reg_00_p = io_apic_read(apic, 0);
#endif /*CONFIG_ES7000*/
.....
====================================================

>There are also somewhat deeper issues with vector assignments to
>interrupt sources that prevent elevating any of the above to useful
>levels and utilizing them. The assumptions based on the vector assignment
>algorithm appear to be widely distributed enough to discourage me after
>an initial attempt or two to get any kind of useful interrupt routing
>for a number of IRQ sources larger than the number of vectors.

I strongly suggest to take a look in IA64 implementation. 
They have 1:1 correspondence between IRQ and vector and don't seem to be
able to run out of vectors or IRQs.

>I pretty much reprogrammed the IDT to push only the vector and then still
>got interrupts on the wrong node(s) despite the physical broadcast RTE's
>plus (node, vector) <-> irq accounting and irq number lookup in do_IRQ().

