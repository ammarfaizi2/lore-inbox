Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVLTRDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVLTRDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVLTRDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:03:23 -0500
Received: from spirit.analogic.com ([204.178.40.4]:19722 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750931AbVLTRDX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:03:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <46578.10.10.10.28.1135094132.squirrel@linux1>
X-OriginalArrivalTime: 20 Dec 2005 17:03:06.0487 (UTC) FILETIME=[3F26D070:01C60587]
Content-class: urn:content-classes:message
Subject: Re: About 4k kernel stack size....
Date: Tue, 20 Dec 2005 12:02:59 -0500
Message-ID: <Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: About 4k kernel stack size....
Thread-Index: AcYFhz8y8owawm0ZQV2Q37V+juGg3Q==
References: <20051218231401.6ded8de2@werewolf.auna.net>     <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de>    <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com> <46578.10.10.10.28.1135094132.squirrel@linux1>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Sean" <seanlkml@sympatico.ca>
Cc: "Mike Snitzer" <snitzer@gmail.com>, "Adrian Bunk" <bunk@stusta.de>,
       "Mark Lord" <lkml@rtr.ca>, "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>, <nel@vger.kernel.org>,
       <mpm@selenic.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2005, Sean wrote:

> On Tue, December 20, 2005 9:37 am, Mike Snitzer said:
>
>> Given this last statement, why is it that Matt Mackall's suggestion in
>> the "Light-weight dynamically extended stacks" thread didn't get any
>> _real_ discussion from the big 4K stack advocates?  For all intents
>> and purposes, Matt was dismissed with the same Bunk: "Ever since
>> neilb's patch there are 0 bugs.. blah blah".  4K, 8K (aka "6 kB")
>> aside; having more stack safety in the Linux kernel is a "good thing"
>> no?  Aren't dynamic stacks a viable means to imposing 4K (but doing so
>> with real safety)?
>
> The so called 4K stack patch does add more stack safety.  Avoiding the
> possibility of allocation failures due to memory fragmentation.  Besides,
> the patch is really misnamed; it should have been called the split-stack
> (ie. 4K + 4K).   Since nobody can show any area in the mainline code where
> the split stack scheme introduces a problem the old setup should be
> removed as it is no longer needed by the mainline code.
>
> I for one hope those silly bastards using ndiswrapper fix up that code to
> work with the new kernel so that we can stop hearing all these wannabe
> complaints against this progress.
>
> Sean


Since it's been determined that the kernel will
use 4k stacks, solely because "smaller is better",
I decided to look through kernel code and
find out what the minimum stack-size required
is. First I looked at the number of arguments
passed to various procedures. The maximum I
could find by looking in kernel headers was
7 parameters. There are probably some well-
hidden procedures that use more. However, let's
make a rule that nobody can use more than 8
parameters. This rule will be justified by
the loudest shouter of "should have been a
pointer to a struct".

Anyway, that's 8 parameters plus the return
address or 9 of size_t elements on the stack.
For ix86, that's 9 * sizeof(size_t) = 36
bytes of stack-space required for the procedure
call. Now, that's make a rule that there can't
be more that 32 size_t sized things in local
space on the stack. This rule can be justified
by shouting the loudest that anybody who
codes buffers or structures on the stack is
an idiot.

Anyway, that's 32 * sizeof(size_t) =  128 bytes
required. We add this to the first 36 and we
have 164 bytes of stack-space required. So,
the maximum stack-space allowed will be defined
to be 164 bytes since we have proved that this
is all that's required (interrupts happen on
another stack). You can also make a rule that
recursion isn't allowed since a simple state-
machine can be proved to work as a substitute.

Since the ix86 processor won't allow us to make
pages less than 4k, we need to poison the rest
of the stack-page and if a kernel monitor, operating
off a timer-tick, detects that anybody is violating
this rule, an automatic daemon, kernel thread, shall
be awakened to spam the violator to death.

To enforce this new-world-order, we need to
require that all procedures contain the email
address of the writer. This shall be handled
with a macro, EXPORT_WRITER(torvalds@microsoft.com).
Or, alternatively you can send your email address,
Linux-kernel version, and procedure name to:
 	president@whitehouse.gov
Maybe you won't need to because the NSA already
has that information.

See, isn't rule-making fun? This whole 4k stack-
thing is really dumb. Other operating systems
use paged virtual memory for stacks, except
for the interrupt stack. If Linux used paged
virtual memory for stacks, the pages would not
have to be contiguous so dynamic stack allocation
would practically never fail. But Linux doesn't
use paged virtual memory for stacks. So, there
needs to be some rule to control the amount
of kernel stack allocated to each task when it
executes a system call.

This means, in the limit, that there are two
possibilities:

(1)	Implement paged virtual memory for stack.
(2)	Use a single page.

The NDIS driver problem can be fixed by switching
stacks. The NDIS compatibility device is single-
threaded, no need for a dynamic allocation of a stack.
The stack can be switched using simple assembly and
a buffer/stack that was allocated when the device-driver
was installed. It is a driver problem, not a kernel
problem.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
