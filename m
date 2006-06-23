Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933059AbWFWLoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbWFWLoW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933058AbWFWLoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:44:22 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:19206 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751527AbWFWLoT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:44:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 23 Jun 2006 11:44:10.0726 (UTC) FILETIME=[57C52860:01C696BA]
Content-class: urn:content-classes:message
Subject: Re: [patch] i386: cpu_relax() in crash.c and doublefault.c
Date: Fri, 23 Jun 2006 07:44:04 -0400
Message-ID: <Pine.LNX.4.61.0606230708020.15888@chaos.analogic.com>
In-Reply-To: <20060623083018.GA12273@rhlx01.fht-esslingen.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] i386: cpu_relax() in crash.c and doublefault.c
thread-index: AcaWulfOYMgyY06NQ2iuakVD00nVAQ==
References: <200606230343_MC3-1-C33B-67CA@compuserve.com> <20060623083018.GA12273@rhlx01.fht-esslingen.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Dave Jones" <davej@redhat.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2006, Andreas Mohr wrote:

> Hi,
>
> On Fri, Jun 23, 2006 at 03:40:25AM -0400, Chuck Ebbert wrote:
>> Add cpu_relax() to infinite loops in crash.c and
>> doublefault.c.  This is the safest change.
>
> Thanks for your continued work on this!
>
> What's the reasoning for not running halt() in doublefault_fn()?
>
>
> In order to consolidate those places to safely halt a CPU,
> I could think of (possibly in a header file):
>
> /* very, very safely halt CPU:
>   - do minimal checking in case CPU might already be overheated (unreliable!)
>     (also use inlining to avoid call overhead on an unreliable CPU)
>   - try to use halt() and cpu_relax() very liberally to keep the crashed
>     CPU as cool as possible (crash might have happened due to CPU fan failure!)
>     While ACPI specifies CPU shutdown on over-temperature, we really don't
>     want to rely on this since it might be broken or we simply don't use ACPI
>     mode at all...
> */
> inline void safely_halt_cpu(int do_minimal_checking)
> {
> 	/* inlining will optimize the branching away */
> 	if (!do_minimal_checking) {
> 		if (cpu_data[smp_processor_id()].hlt_works_ok)
> 			for (;;) {
> 				halt();
> 				/* halt failed? still make sure to cpu_relax()! */
> 				cpu_relax();
> 			}
> 		else
> 			for (;;) {
> 				cpu_relax();
> 				cpu_relax();
> 				cpu_relax();
> 			}
> 	} else {
> 		halt();
> 		/* halt didn't work, so still keep as cool as possible: */
> 		for (;;) {
> 			cpu_relax();
> 			cpu_relax();
> 			cpu_relax();
> 		}
> 	}
> }
>
> Does my preliminary code even make any sense at all? ;)
> Might want to cleverly rearrange it to try to get rid of the cpu_relax()
> duplication while not abandoning any advantage of those different
> conditions.
>
> Andreas Mohr

The code follows the theory that if a little is good, more must
be better. Even the basic concept that a little is good is
seriously flawed.

The local CPU, i.e., the one that is executing the current instructions,
can be halted forever by clearing the interrupts and issuing a halt
(ix86 HLT) instruction. No loop is necessary. However, to make the
code seem sensible to those who don't know this, it has been customary
to put:
 	"for(;;) ; // hardstop"

...after such a sequence. That code will usually never be executed.
However, a non-maskable interrupt can still occur.

Such an interrupt would normally be trapped in its handler. However,
if that handler actually executes a return (ix86, IRET), then the
code that used to be halted will now be spinning. As previously
stated, spinning does NOT create friction. There is no problem
with spinning, in fact any internal power-sense like the Celleron
CPUs have, will know that the instruction cache is not being
refilled so it might lower the clock speed.

Nevertheless, it might be appropriate for the CPU to he halted
again. Such code would be, simply:

void hardstop(){
     __asm__ __volatile__(
 	"1:	cli\n"\
 	"	hlt\n"\
 	"jmp	1b\n");
}

The 'cpu_relax()' macro is really just two instructions that
tell the CPU that it is waiting for something to change in
memory (ix86 REP NOP).

This means that it can forgo recalculating memory operands and
fetching the memory variable it has been spinning on, until
some other memory accesses occur (perhaps from another CPU).
It's only legitimate purpose is in spin-locks and semaphores.

The code:
 	for(;;) ;
...contains no memory operands and the code is already in the
instruction cache, so memory accesses are already shut off.

Using the cpu_relax() macro anywhere in the hardstop code
is simply wrong.

If you want to fix something that is not broken, then fix it
with the hardstop() code above.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
