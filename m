Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTKKETm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbTKKETm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:19:42 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:46794 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264245AbTKKETb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:19:31 -0500
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: linux-kernel@vger.kernel.org
Subject: Monitoring IO to ioremap'ed addresses
Date: Mon, 10 Nov 2003 23:15:54 -0500
User-Agent: KMail/1.5
Cc: Eugene Teo <eugene.teo@eugeneteo.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311102315.54562.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Does Linux have any way of monitoring all IO done over a range of ioremap'ed 
addresses?  This would be useful if someone wanted to examine exactly how a 
driver interacted with hardware, especially if the driver is binary-only.  
Some architectures have debug registers that can trigger over large areas of 
memory, but i386 is pretty limited in this regard.

If Linux doesn't yet have such a system in place, one possible way to 
implement it (for i386 anyways) would be to remove the page table entry 
created by ioremap when the device was first mapped into kernel memory.  A 
table could be created somewhere to keep track of all virtual addresses we've 
invalidated in this way.  Then, when an attempt at MMIO occurs, the page 
fault hander would be invoked.

The page fault hander would be modified to correct the fault by mapping the 
faulting address to a page of kmalloc'ed memory.  If the faulting operation 
was a read, then we would do the MMIO read operation ourselves, and put the 
result into the appropriate offset of the page we've used to correct the 
fault.  We would also log the read (ie. address, value read, and triggering 
EIP) somewhere.  Next, we would set the trace bit (TR), and return from the 
fault.  After the faulting instruction was successfully executed, we would 
clean everything up in the INT 1 handler.  That is, somewhere in do_debug, we 
would remove the page table entry we set up in the page fault handler, clear 
the trace bit, and return.

For write operations, we would just reverse the above order.  We would 
retrieve the value intended to be written to MMIO from the kmalloc'ed memory 
in the INT 1 handler, log it, and then pass it on to the device.

Additionally, if such a scheme were extended to support all of memory and 
exposed to processes, user mode debuggers could make use of it to allow for 
as many "break on memory access" type breakpoints as required, rather than 
being limited to the handful of debug registers present in the i386 
architecture.

I can think of a few potential problems with this scheme.  It blends MMIO 
operations with memory operations done on regular kmalloc'ed memory, which 
doesn't usually seem like the right thing to do.  Also, it might be difficult 
to determine the actual size of the memory operation.  I don't know how 
devices respond to having a long read done at some address when they are only 
expecting to have a byte read.

I suppose these problems and the messiness of using the TR bit and the INT 1 
handler could be avoided by actually reading the instruction at the faulting 
EIP, and doing the operation ourselves, but that would involve a partial 
emulator being in the kernel. :)

Am I missing anything important?  Any ideas on better ways to do this?  Does 
anyone see this kind of feature as being useful enough to justify the work 
required to put it in?


-- Andrew
