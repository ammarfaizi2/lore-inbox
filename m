Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131145AbQLGRqa>; Thu, 7 Dec 2000 12:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbQLGRqU>; Thu, 7 Dec 2000 12:46:20 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:44299 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S131145AbQLGRqD>;
	Thu, 7 Dec 2000 12:46:03 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Thu, 7 Dec 2000 18:13:22 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Why is double_fault serviced by a trap gate?
CC: richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <F00C8C3408E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Dec 00 at 11:31, Richard B. Johnson wrote:
> On Thu, 7 Dec 2000, Andi Kleen wrote:
> > On Thu, Dec 07, 2000 at 04:04:21PM +0000, richardj_moore@uk.ibm.com wrote:
> > > 
> > > 
> > > Why is double_fault serviced by a trap gate? The problem with this is that
> > > any double-fault caused by a stack-fault, which is the usual reason,
> > > becomes a triple-fault. And a triple-fault results in a processor reset or
> > > shutdown making the fault damn near impossible to get any information on.
> > > 
> > > Oughtn't the double-fault exception handler be serviced by a task gate? And
> > > similarly the NMI handler in case the NMI is on the current stack page
> > > frame?
> > 
> > Sounds like a good idea, when you can afford a few K for a special
> > NMI/double fault stack. On x86-64 it is planned to do that.
> > 
> > 
> 
> Well, at least on current ix86 processors it can't. Attempting to
> use a task gate appears to be a trick to cause the exception to
> be handled on the current stack. The hardware protection hierarchy
> won't let this happen. You need to have a stack that is not accessible

No. If interrupt uses task gate, task switch happens. Nothing is stored
in context of old process except registers into TSS. There is only one
(bad) problem. If you want to get it 100% proof (it is not needed for double
fault, but it is definitely needed for NMI, as NMI is very often on SMP
ia32), each CPU's IRQ vector must point to different task, otherwise you
can get TSS in use during doublefault, leading to triplefault again...

> from the mode that will be trapped. Otherwise, a user could crash
> the machine by setting ESP to 0 and waiting for the next context-
> switch or timer-tick.

Yes. Currently if any ESP related problem happens in kernel, machine silently
reboots without any message. With task gate (as Jeff Merkey proposed
some months ago, btw), you can even suspend offending task and recover
from it... I think that also bluesmoke should use task gate, but I
did not read documentation on this yet.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
