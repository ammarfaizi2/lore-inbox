Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbULKCGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbULKCGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 21:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbULKCGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 21:06:46 -0500
Received: from av2.karneval.cz ([81.27.192.108]:33076 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S261910AbULKCGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 21:06:35 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel series
Date: Sat, 11 Dec 2004 03:07:45 +0100
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz> <1102712732.3264.73.camel@localhost.localdomain> <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412110307.45547.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 December 2004 23:55, Linus Torvalds wrote:
> 
> On Fri, 10 Dec 2004, Alan Cox wrote:
> > 
> > You can't disable_irq and return to user space - the IRQ may be shared
> > by a device needed to make user space progress. 
> 
> The vm86 interrupt does not allow sharing. And it really _has_ to be 
> disabled until user mode has cleared the irq source, or you'll have a very 
> dead machine.

I have thought about all these problems before change proposal.
There is no other way to do interrupt propagation to user-space
for user-space only serviced level activated interrupt.
I would like very much ability to propagate some interrupts
serviced by real driver into userspace as well.
This is well doable, if real driver clears source and VM86
shared handler would return IRQ_NONE and not disable IRQ in this case.
There is no clean way, how to solve level activated IRQ sharing between
two devices, one serviced by real driver and the second by userspace.
Probably IRQ disable would partially work, if real driver would
not be at core path (swapping) device or device blocking userspace
"driver" thread.

There are some more IRQ related issues ad questions.

1) Actual VM86 IRQ solution works well for us, but I have
   found even before patch sending one scenario asking for check.
   IRQ appears in HW, disable_irq() is called by the handler.
   Userspace task is deleted before get_and_reset_irq()
   reenables IRQ. free_vm86_irq() is called.
   Now some real kernel module asks for same IRQ
   by request_irq() call. It succeeds, because IRQ is no longer
   reserved for VM86. But what does happen with IRQ disable counter
   in such case? 
   ... OK, I have recheck that now, "if (!shared) {" in  setup_irq()
   should correctly solve that case. It enables IRQ again and cleans counter.

2) I think, that the VM86 IRQ handling is x86 specific only by its name.
   It is shame, that it is allowed only for interrupts 3 to 15
   and implemented only for x86 architecture. This is feature, which
   in combination with some libraries, could be used for drivers
   debugging in userspace even for ARM or other targets.
   I have used this feature years ago for debugging of uLan driver
   and pre-LinCAN incarnations of my CAN experiments.
   Are there more people who think that this could be of some value?

3) What is your opinion about sharing edge triggered interrupts
   on x86 architecture?
   It was unserviceable for all kernels before irqreturn_t introduction.
   This seems to be broken up to 2.6.9 still.
   Let there are two shared edge triggered sources A and B.
   Device B asks for IRQ, ISR for A is called and returns,
   request from device A arrives, but there is no edge, line is
   held by B. B request proceeds, but no edge appears, line is held by A.
   Handlers are not called any more => stuck IRQ condition.
   It is necessary cycle calls to all handlers until one full round
   of IRQ_NONE is received. Have I overlooked something, which solves
   this situation in the current kernel? Is there willing to do something
   with that. I can prepare and test some solution if there is interrest.
   I know, that ISA is out of scope for desktop PCs now, but low count of
   available IRQs is common problem on embedded PC-104 targets.
   They would benefit from this enhancement.
   
Best wishes

                Pavel Pisa
