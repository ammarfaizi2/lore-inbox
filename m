Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRDFJVg>; Fri, 6 Apr 2001 05:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRDFJV0>; Fri, 6 Apr 2001 05:21:26 -0400
Received: from [202.54.26.202] ([202.54.26.202]:53740 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S131382AbRDFJVM>;
	Fri, 6 Apr 2001 05:21:12 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Message-ID: <65256A26.0031F455.00@sandesh.hss.hns.com>
Date: Fri, 6 Apr 2001 14:42:48 +0530
Subject: Re: __switch_to macro
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org








Jamie Lokier <lk@tantalophile.demon.co.uk> on 04/06/2001 03:18:13 PM

To:   Amol Lad/HSS@HSS
cc:   linux-kernel@vger.kernel.org

Subject:  Re: __switch_to macro




alad@hss.hns.com wrote:
> 1) What exactly is meant by ' stale segment register values' in the note.
> 2) In the above macro, I think we recover gracefully from error
>    condition while recovering fs and gs segment registers . The
>    loadsegment(fs,next->tss.fs) and loadsegment(gs,next->tss.gs) does
>    it.  I am not able to understand loadsegment macro. The macro is as under
>
> /** Load a segment. Fall back on loading a zero segment if something goes
wrong
> **/
> #define loadsegment(seg,value)           \
>      asm volatile("\n"             \
>           "1:\t"                   \
>           "movl %0,%%" #seg "\n"   \
>           "2:\n"                   \
>           "3:\t"                   \
>           "pushl $0\n\t"           \
>           "jmp 2b\n"               \
>           ".previous\n"            \
>           ".section __ex_table,\"a\"\n\t  \
>           "/align 4\n\t"           \
>           ".long 1b,3b\n"          \
>           ".previous"              \
>           : :"m" (*(unsigned int *)&(value)))
>
> I also want to know what is 'something' in the comment above the macro

The answers to 1. and 'something' are the same: stale segment values.
You can't load any value into %ss, %ds, %es, %fs or %gs.  They must be
valid references into the GDT or LDT, with the appropriote protection
level, or 0.

Usually the values stored in tss are ok, as they were valid values when
they were stored.  However for programs that use modify_ldt, it's
possible for a valid LDT entry to be made invalid while some tss still
refers to that segment.

>>> Thanks a lot.. good explanation..

At the next attempt to load the segment value into a segment register,
you get a fault.  The code in loadsegment traps this fault and loads
zero into the segment register instead when this happens.  Zero is
always allowed.  If the user program then tries to access data
referenced by that segment register, user space will get a
general_protection fault.  As it's only user space that calls modify_ldt
to invalidate an LDT entry, that's reasonable.

There's one thing that confuses me: don't you get a segment_not_present
fault?  If so, traps.c's do_segment_not_present doesn't appear to search
the exception table, and the code in loadsegment would not work.

>>> well.. I peeked into traps.c.. I do seem a call to die_if_no_fixup
in this function. And I think loadsegment is already making an entry in
exception table.

Amol


-- Jamie




