Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLGVnW>; Thu, 7 Dec 2000 16:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLGVnM>; Thu, 7 Dec 2000 16:43:12 -0500
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:54420 "EHLO
	d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S129340AbQLGVnB>; Thu, 7 Dec 2000 16:43:01 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Andi Kleen <ak@suse.de>, root@chaos.analogic.com,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-kernel@vger.kernel.org
Message-ID: <802569AE.00747B7E.00@d06mta06.portsmouth.uk.ibm.com>
Date: Thu, 7 Dec 2000 21:09:47 +0000
Subject: Re: Why is double_fault serviced by a trap gate?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Which surely we can on today's x86 systems. Even back in the days of OS/2
2.0 running on a 386 with 4Mb RAM we used a taskgate for both NMI and
Double Fault. You need only a minimal stack - 1K, sufficient to save state
and restore ESP to a known point before switching back to the main TSS to
allow normal exception handling to occur.

There no architectural restriction that some folks have hinted at - as long
as the DPL for the task gates is 3.

There's no problem under MP since the double fault exception will be only
presented on the processor that instigated the problem.

As for NMIs I didn't think they  were presented to all processors
simultaneously. If they are then the way to handle that is to map a page of
the GDT,  to a  unique physical address per-processor - i.e. processor
local storage. The virtual address will be the same on each. This is what
we did under OS/2 SMP.
We also alisaed these pages to unique virtual addresses so that they could
be seen by the kernel from any processor context.

The only time you want the NMI handler to be fast is when it's being used
for hand-shaking, which some disk devices do. And perhaps for APIC NMI
class interprocessor interrupts. But I honestly don't think that's really a
good enough reason not to have a task gate for NMI.

The unpredictablility of the abort (NMI or Double-fault) refers to fact
that in general it is indeterminate as to whether it is  a fault or trap.
And that's a matter of whether the EIP point at ot after the instruction
related to the exception. The abort nature  of theses exceptions is not
really a problem for the exception handler.

In summary I'd say the lack of a task gate is at the very least an
oversight, if not a bug.

If no one else wants to do it I'll see if I can code up the task gates for
the double-fault and NMI.

Richard


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
