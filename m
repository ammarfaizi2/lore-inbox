Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161221AbVKIU0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbVKIU0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbVKIU0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:26:17 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:12297 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1161221AbVKIU0Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:26:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051109192028.GP19593@austin.ibm.com>
References: <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com> <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net> <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net> <20051109192028.GP19593@austin.ibm.com>
X-OriginalArrivalTime: 09 Nov 2005 20:26:12.0521 (UTC) FILETIME=[D3A84990:01C5E56B]
Content-class: urn:content-classes:message
Subject: Re: typedefs and structs
Date: Wed, 9 Nov 2005 15:26:10 -0500
Message-ID: <Pine.LNX.4.61.0511091459440.12760@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: typedefs and structs
Thread-Index: AcXla9Oxfe07OfPsSOSKUp1Un26tAw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "linas" <linas@austin.ibm.com>
Cc: "Vadim Lobanov" <vlobanov@speakeasy.net>,
       "J.A. Magallon" <jamagallon@able.es>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Douglas McNaught" <doug@mcnaught.org>,
       "Steven Rostedt" <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
       <bluesmoke-devel@lists.sourceforge.net>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <linuxppc64-dev@ozlabs.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Nov 2005, linas wrote:

> On Wed, Nov 09, 2005 at 08:22:15AM -0800, Vadim Lobanov was heard to remark:
>> On Wed, 9 Nov 2005, J.A. Magallon wrote:
>>
>>> void do_some_stuff(T& arg1,T&  arg2)
>>
>> A diligent C programmer would write this as follows:
>> 	void do_some_stuff (struct T * a, struct T * b);
>> So I don't see C++ winning at all here.
>
> I guess the real point that I'd wanted to make, and seems
> to have gotten lost, was that by avoiding using pointers,
> you end up designing code in a very different way, and you
> can find out that often/usually, you don't need structs
> filled with a zoo of pointers.
>

But you can't avoid pointers unless you make your entire
program have global scope. That may be great for performance,
but a killer if for have any bugs.

Procedures that get pointers to variables (including structures)
are a way of isolating faults. Without them, you can't test
the procedures in a working environment.

Also, without pointers, you are severely limited on the kinds
of libraries you can share. You certainly wouldn't want
to compile an entire C runtime library into your code so
that all the buffers have local scope.

> Minimizing pointers is good: less ref counting is needed,
> fewer mallocs are needed, fewer locks are needed
> (because of local/private scope!!), and null pointer
> deref errors are less likely.
>

No. Minimizing pointers should not be an objective. Properly
using the components of your tool-set should be. This means
that you use the correct access mode for various object
types. "Correct" depends upon the instant context, not upon
some company or personal rule.

> There are even performance implications: on modern CPU's
> there's a very long pipeline to memory (hundreds of cycles
> for a cache miss! Really! Worse if you have run out of
> TLB entries!). So walking a long linked list chasing
> pointers can really really hurt performance.
>

Linked lists are some of the necessary elements when one
doesn't know ahead of time the number of objects that must
be manipulated. They are just programming tools. You use
them when they are necessary. The fact that they use pointers
to make the links is not relevant.

> By using refs instead of pointers, it helps you focus
> on the issue of "do I really need to store this pointer
> somewhere? Will I really need it later, or can I be done
> with it now?".
>

Huh? References (at the opcode level) are pointers. There
is no difference whatsoever. For memory references, you
Get:
 	direct, direct+displacement, register_indirect,
 	register_indirect+displacement.

There isn't anything else. Some processors let you sum
displacements over several registers. Nevertheless, that's
all you have. Accessing a variable by reference is an
old artifact of FORTRAN. It can be efficient if the
architecture is flat and global so the compiler can
substitute direct access. In other words, no parameter
or pointer actually gets passed to the routine. The
compiler just remembers what the parameters actually
were and substitutes code to directly access the
parameters.

Not so in C++. With C++, "reference" is a user-shorthand
where the compiler actually accesses variables with pointers.
The rules don't prohibit C++ compilers from using FORTRAN-
like conventions for passing-by-reference. It's just that
nobody seems to do so.

> I don't know if the idea of "using fewer pointers" can
> actually be carried out in the kernel. For starters,
> the stack is way too short to be able to put much on it.
>
> --linas
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
