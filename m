Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268553AbTANDfG>; Mon, 13 Jan 2003 22:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268555AbTANDfG>; Mon, 13 Jan 2003 22:35:06 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:8124 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S268553AbTANDe7>; Mon, 13 Jan 2003 22:34:59 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8F0@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: James Cleverdon <jamesclv@us.ibm.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: RE: Question about xAPIC lowest priority delivery
Date: Mon, 13 Jan 2003 21:43:36 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Anyway, is this a known erratum for xAPICs in parallel mode? (Namely, a bug

>in the XTPR arbitration logic in host bridges.)
>For that matter, does this happen on non-Summit xAPIC boxes? Anyone out
there 
>with a >= 2 CPU P4 box that uses parallel interrupts care to comment

I am not sure if we fall in the parallel mode category, but I will comment
since I was also concerned about xTPR mechanism.

We use lowest priority delivery for xAPIC-APIC case the following way: set
the destination to the logical id of boot CPU, set the LPDM bit on the
destination (0x01XXXX). This way, if something is wrong with xTPR mechanism,
the interrupt goes to boot CPU. (I presume it is about IA32 case, because it
is different for Itanium). Then, I have to increase priority entering an
interrupt by writing to the TPRI register, and lower it on the exit from it
to make it available for the next one... Besides this, due to some erratum
(I wish I had my specs here) I have to read from LDR and write back to it
after changing TPRI value:
 
apic_write_around(APIC_TASKPRI, pri); 
apic_write_around(APIC_LDR, apic_read(APIC_LDR)); 

Unfortunately, there is no single spot in the code identifying start and end
of an interrupt, so I had to fish for all places where they were happening.
I got it to work, and the balance is so fragile, that if I only touch any of
those places it immediately breaks or hangs... I wish there were macros in
place: irq_enter(), irq_exit() for IO-APIC irq's like in UnixWare, say.

I am sure there are people (especially from Intel, with red books newer than
mine) who are looking into this or could shed more light on how this can be
properly implemented.

--Natalie
