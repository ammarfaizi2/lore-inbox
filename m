Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130901AbQLHMOX>; Fri, 8 Dec 2000 07:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132079AbQLHMON>; Fri, 8 Dec 2000 07:14:13 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:5617 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130901AbQLHMOC>; Fri, 8 Dec 2000 07:14:02 -0500
Date: Fri, 8 Dec 2000 12:30:54 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: richardj_moore@uk.ibm.com
cc: Andi Kleen <ak@suse.de>, root@chaos.analogic.com,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <802569AE.00747B7E.00@d06mta06.portsmouth.uk.ibm.com>
Message-ID: <Pine.GSO.3.96.1001208121406.6796B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000 richardj_moore@uk.ibm.com wrote:

> Which surely we can on today's x86 systems. Even back in the days of OS/2
> 2.0 running on a 386 with 4Mb RAM we used a taskgate for both NMI and
> Double Fault. You need only a minimal stack - 1K, sufficient to save state
> and restore ESP to a known point before switching back to the main TSS to
> allow normal exception handling to occur.

 The memory hit is surely not a problem.

> There's no problem under MP since the double fault exception will be only
> presented on the processor that instigated the problem.

 But what if another double fault happens on another CPU at roughly the
same time (unlikely, but still...)?

> As for NMIs I didn't think they  were presented to all processors
> simultaneously. If they are then the way to handle that is to map a page of
> the GDT,  to a  unique physical address per-processor - i.e. processor
> local storage. The virtual address will be the same on each. This is what
> we did under OS/2 SMP.

 Good idea.

> The only time you want the NMI handler to be fast is when it's being used
> for hand-shaking, which some disk devices do. And perhaps for APIC NMI
> class interprocessor interrupts. But I honestly don't think that's really a
> good enough reason not to have a task gate for NMI.

 Do we really want to waste 60000+ CPU cycles every second just to handle
a TSS switch? 

> The unpredictablility of the abort (NMI or Double-fault) refers to fact
> that in general it is indeterminate as to whether it is  a fault or trap.

 NMI is a normal interrupt (fault-like) and not an abort.  It's fully
predictable.

> And that's a matter of whether the EIP point at ot after the instruction
> related to the exception. The abort nature  of theses exceptions is not
> really a problem for the exception handler.

 If you get a double fault during retrieving a CPU state from a TSS, you
may end with an inconsistent state -- you may be unable to iretd or use
the stack.  For NMIs it doesn't happen -- an NMI event, if happens during
a TSS switch, will not be handled until the switch completes.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
