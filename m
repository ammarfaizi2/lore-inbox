Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVHXSXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVHXSXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVHXSXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:23:19 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:32268 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751351AbVHXSXS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:23:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com>
References: <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com>
X-OriginalArrivalTime: 24 Aug 2005 18:23:08.0714 (UTC) FILETIME=[E0C200A0:01C5A8D8]
Content-class: urn:content-classes:message
Subject: Re: question on memory barrier
Date: Wed, 24 Aug 2005 14:22:32 -0400
Message-ID: <Pine.LNX.4.61.0508241347020.30497@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question on memory barrier
Thread-Index: AcWo2ODL1Kc2KAm0Sb+Mx4184gn3Qg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "moreau francis" <francis_moreau2000@yahoo.fr>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Aug 2005, moreau francis wrote:

>
> --- "linux-os (Dick Johnson)" <linux-os@analogic.com> a écrit :
>
>>
>> On Wed, 24 Aug 2005, moreau francis wrote:
>>
>>> Hi,
>>>
>>> I'm currently trying to write a USB driver for Linux. The device must be
>>> configured by writing some values into the same register but I want to be
>>> sure that the writing order is respected by either the compiler and the
>> cpu.
>>>
>>> For example, here is a bit of driver's code:
>>>
>>> """
>>> #include <asm/io.h>
>>>
>>> static inline void dev_out(u32 *reg, u32 value)
>>> {
>>>        writel(value, regs);
>>> }
>>>
>>> void config_dev(void)
>>> {
>>>        dev_out(reg_a, 0x0); /* first io */
>>>        dev_out(reg_a, 0xA); /* second io */
>>> }
>>>
>>
>> This should be fine. The effect of the first bit of code
>> plus all side-effects (if any) should be complete at the
>> first effective sequence-point (;) but you need to
>
> sorry but I'm not sure to understand you...Do you mean that the first write
> into reg_a pointer will be completed before the second write because they're
> separated by a (;) ?

Yes. The compiler must make sure that every effect of all previous
code and all side-effects are complete at a "sequence-point". There
are several sequence-points and the most obvious is a ";".

The compiler is free to reorder anything in a compound statement
as long as it complies with presidence rules, but it can't re-order
the statements themselves.

In other words:

volatile unsigned int *hardware = virtual(MY_DEVICE);

    *hardware = 1;
    *hardware = 2;
    *hardware = 4;
    *hardware = 8;

.. happens exactly as shown above. If it didn't, you couldn't
write device drivers. An example of the code above:

 	.file	"xxx.c"
 	.text
.globl foo
 	.type	foo, @function
foo:
 	pushl	%ebp
 	movl	%esp, %ebp
 	subl	$4, %esp
 	movl	$305419896, -4(%ebp)	// init the pointer
 	movl	-4(%ebp), %eax		// Get pointer
 	movl	$1, (%eax)		// *hardware = 1;
 	movl	-4(%ebp), %eax		// Get pointer
 	movl	$2, (%eax)		// *hardware = 2;
 	movl	-4(%ebp), %eax		// Get pointer
 	movl	$4, (%eax)		// *hardware = 4;
 	movl	-4(%ebp), %eax		// Get pointer
 	movl	$8, (%eax)		// *hardware = 8;
 	movl	$0, %eax
 	leave
 	ret
 	.size	foo, .-foo
 	.section	.note.GNU-stack,"",@progbits
 	.ident	"GCC: (GNU) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)"

Because of the necessary 'volatile' keyword, even the pointer is
obtained over again each time. This wastes CPU cycles. One
could do:

 	movl	$1, (%eax)
 	movl	$2, (%eax)
 	movl	$4, (%eax)
 	movl	$8, (%eax)

.. after the pointer is loaded. Unfortunately, 'C' doesn't have
a keyword that would accommodate that.

When communicating across a PCI/Bus, the writes are cached.
They don't necessarily occur __now__. It will take a (perhaps
dummy) read of the PCI/Bus to make them get to the hardware
now. Even then, they will still get there in order, all 4 writes,
because the interface is a FIFO. A read on the PCI/Bus will force
all pending writes to be written).

Some arcitectures do write-combining which means that, for instance
on an Intel Pentium P6, it's possible for all writes of adjacent
words may be condensed into a single quadword write. This may not be
what you want. If you have such a situation, one would execute
WBINVD after the critical writes. No not do this just to "make sure".
It wastes a lot of bandwidth.

See http://developer.intel.com/design/PentiumII/applnots/24442201.pdf



> Or because writes are encapsulated inside an inline function, therefore
> compiler
> must execute every single writes before returning from the inline function ?
>

In-line doesn't care. It's not as complicated as many expect.

> Thanks.
>
>            Francis
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
