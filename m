Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWIXHtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWIXHtD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 03:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWIXHtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 03:49:02 -0400
Received: from opersys.com ([64.40.108.71]:46342 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751362AbWIXHs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 03:48:59 -0400
Message-ID: <45163D3D.4010108@opersys.com>
Date: Sun, 24 Sep 2006 04:09:33 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Richard J Moore <richardj_moore@uk.ibm.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Ingo Molnar <mingo@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>,
       Satoshi Oshima <soshima@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       William Cohen <wcohen@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Does this work? "dcprobes" an x86-hack simple djprobes-equivalent?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Richard, Hiramatsu-san,

First, I _don't know if the following works_, I just got a
hunch, and I thought I'd run this by you since you've both
done extensive work on binary patching on x86. If this works,
though, I think this would provide much of the same advantages
as djprobes without any of its disadvantages. Note: this is
very much an x86 hack, but my understanding is that djrobes'
difficulties specifically stem from the variable-length
instruction set found on the x86, so other archs should be
easier to adapt.

The problem I'm trying to solve:

Since its inception, djprobes has run into quite a few problems
in trying to replace arbitrary instruction spans because of
the inherent problem of squashing an instruction to which
someone/somewhere may sometime in the future directly jump
(say insert 5 byte jump over a sequence of bytes having multiple
instructions.) Solving this requires making quite a few
assumptions about the program. Let's just say that, as I said
elsewhere, I'm not too comfortable with the idea of letting
djprobes replace any instruction that is less than 5 bytes --
but as I explained elsewhere, it can be very useful in cases
where the replaced instruction stream is tailored for being
replaced by djprobes; see my earlier "bprobes" proposal.

So here's what I got in mind:

There is, though, one single case that I can think of where
replacing a multi-byte span will just work (in as far as my
current analysis allows me to see) without caring if anything
anywhere will ever jump back into the span -- regardless of
whether preemption is active or not. If fact, there would be
no need to freeze any process or try to look up any process'
stack while doing this.

As you mentioned earlier Richard, we can just go ahead and
stick an int3 almost anywhere. Now, the opcode for that is
CC. So what if we tried this:
- For address starting at A and spanning S bytes (where S cannot
  be smaller than 7), create entry in hash table for that
  replacement target, which includes a copy of the bytes found
  in that span.
- Starting at A, insert S int3s. That is if these are 7 bytes,
  we now have:
  CC CC CC CC CC CC CC
- Replace first byte with "far call" OP:
  9A CC CC CC CC CC CC

Hence the name, dcprobes: dynamic call probes.

So now, we've got a far call to 0xCCCC,0xCCCCCCCC at every probe point.
And since this is a call, the caller's EIP is on the stack, and
we can then mux based on that EIP to direct to the appropriate
callback, possibly using the hash table. And because every
component of the address is actually int3, we don't really care
if anybody has a reference to any byte within A+1, A+2, A+3, etc.
because as soon as that thing runs, it'll trigger an int3 where
we'll be able to detect that using the hash table, fix things
up and the system continue running. That fixes one of the major
problems with djprobes since we would be able to arbitrarily
insert probe points anywhere without having to make any
assumptions about the code.

Of course, this means hardwiring a multiplexing function at
0xCCCC,0xCCCCCCCC, if that makes any sense (offset 0xCCCCCCCC
of code segment entry 7,099 of the LDT with an RPL of 1).

[ If the far call thing didn't work, we could resort to a
"standard" call (E8 instead of 9A and 5 bytes instead of 7) and
then hack up the destination address based on the current
location to make sure that at offset current+0xCCCCCCCC
something meaningful is there ... with the appropriate
protection ... this may be simpler than the far call, but may
require a specially-built kernel that changes the layout of
the memory map for user-space ... ]

For removal, things are slightly more complicated. We can go
ahead and replace the old bytecode back so long as we do it
operands first and opcodes last starting by the opcode of the
last instruction in the stream. In that way, no freezing of
tasks is necessary since no instruction will actually execute
until the opcode is back. And since the addresses where valid
opcodes were expected did, at all times, have valid opcodes, then
there is no need to make any educated guesses about the system
or do anything about references tasks/threads may have -- making
this mechanism workable even for assembly and preemptable kernels.

If replacing the bytecode back as explained above is too
complicated (since it requires some disassembly), we could just
suspend all processes, force all CPUs to rendez-vous, modify the
byte span, and let everything run. Again, without needing to look
up any tasks' stack or anything like that.

Also, because this is a call, we can keep track of threads that
go in the multiplexer and therefore implement some form of
locking in order to preserve the ability to remove the probe
sanely.

If this works, djprobes should be easily modified for this,
and I'm sure the djprobes team has got ample experience to do
this.

Of course, if it works. Hence my question: does this make sense?

[ Obviously, this is not a replacement for what Mathieu is working
on right now, but it would be useful for significantly speeding up
the generic SystemTap probes, which was one of djprobes' much
anticipated goals. ]

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546

