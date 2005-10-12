Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVJLNDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVJLNDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 09:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVJLNDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 09:03:41 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:10251 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751301AbVJLNDk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 09:03:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <434C1D60.2090901@cmu.edu>
References: <434C1D60.2090901@cmu.edu>
X-OriginalArrivalTime: 12 Oct 2005 13:03:38.0313 (UTC) FILETIME=[5C8CB390:01C5CF2D]
Content-class: urn:content-classes:message
Subject: Re: using segmentation in the kernel
Date: Wed, 12 Oct 2005 09:03:37 -0400
Message-ID: <Pine.LNX.4.61.0510120837370.8832@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: using segmentation in the kernel
Thread-Index: AcXPLVyWq6vlztBDR3Os459ifqYXng==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jonathan M. McCune" <jonmccune@cmu.edu>
Cc: <linux-kernel@vger.kernel.org>, "Arvind Seshadri" <arvinds@cs.cmu.edu>,
       "Bryan Parno" <parno@cmu.edu>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Oct 2005, Jonathan M. McCune wrote:

> Hello,
>
> We're starting work on a project for the 32-bit x86 Linux kernel that
> involves using segmentation in the kernel. As a first effort, we'd
> like to adjust the kernel code and data segment descriptors so that
> the kernel code, and data segment, bss, heap and stack exist in linear
> address range between 3GB and 4 GB. How could we implment this so that
> it breaks the memory management subsystem the least (or not at all if
> we are lucky ;-))?
>
> Our current thinking is to modify only the base address and the limit
> of the the kernel code and data segment descriptors (_KERNEL_CS and
> _KERNEL_DS). We set the base address to 3GB and the limit to 1GB. We
> would also change the kernel linker script (vmlinux.lds.S) by removing
> the relocation caused by PAGE_OFFSET. This would mean that the kernel
> would be linked to start at address 0 + 1MB in logical address
> space. Since we would set the base address of the kernel code and data
> segment descriptors to 3GB, the processor would translate all
> addresses emitted by the kernel so that the kernel would use addresses
> of 3GB + 1MB and above in the linear address space. Hopefully, this
> would mean that the all the paging code in the kernel would continue
> to work correctly.
>
> We do not understand the mm subsystem well enough to figure out if our
> method would work at all or if it works what things in the mm
> subsystem would be likely to break. Can someone who understands the mm
> subsystem please help us here?
>
>
> Thanks!
> -Jon
>

On the ix86 you have a problem. Let's say that you write some
code from scratch, that runs the CPU in 32-bit linear address-mode
without paging. Then you want to activate paging. To activate
paging, you MUST have provided some code and some data-space for
your descriptors, where there is a 1:1 mapping between virtual
and bus addresses. If you don't do this, at the instant you
change to paging mode, you crash. The CPU fetches garbage.

This is why the first few megabytes of Linux are unity-mapped.
You will always need to run the kernel out of an area where
a portion of that "segment" is unity-mapped. That segment
is where the descriptors for addressing, paging, and interrupts
must reside.

If you truly wanted to run the kernel from 3-4 GB as you state,
you must have RAM there, i.e., some physical stuff so that
a 1:1 mapping could be implemented. The 3-4 GB region is
where a lot of PCI addressing occurs on 32-bit machines and,
in fact, there are some "do-not-touch" addresses in that
region as well.

Remember that the kernel runs in virtual address mode, but
the descriptors that specify that mode need to be in physical
memory, addressed at the same offset. You can experiment
by making a module that attempts to turn off paging and
then turn it back on. The kernel will crash instantly.
However, if you write some code somewhere in low address-
space where the startup code already exists, that turns
off paging, then turns it back on; and your module code
calls this other code, the machine will work fine. You
need the interrupts off when you play.

So, basically you can't do what you want with any OS that
uses ix86 type CPUs. The question is; "What was it that
you really wanted to do?". What you gave us was the
"implementation details". What I want to know is what
you intend to accomplish. The ix86 architecture lends itself
to a lot of interesting things so if I knew your intentions
I might be able to help.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.48 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
