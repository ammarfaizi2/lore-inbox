Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131352AbRDFIta>; Fri, 6 Apr 2001 04:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131362AbRDFItU>; Fri, 6 Apr 2001 04:49:20 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:8719 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131352AbRDFItD>;
	Fri, 6 Apr 2001 04:49:03 -0400
Date: Fri, 6 Apr 2001 10:48:13 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: alad@hss.hns.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: __switch_to macro
Message-ID: <20010406104813.A5334@pcep-jamie.cern.ch>
In-Reply-To: <65256A26.0027EA80.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <65256A26.0027EA80.00@sandesh.hss.hns.com>; from alad@hss.hns.com on Fri, Apr 06, 2001 at 12:53:10PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alad@hss.hns.com wrote:
> 1) What exactly is meant by ' stale segment register values' in the note.
> 2) In the above macro, I think we recover gracefully from error
>    condition while recovering fs and gs segment registers . The
>    loadsegment(fs,next->tss.fs) and loadsegment(gs,next->tss.gs) does
>    it.  I am not able to understand loadsegment macro. The macro is as under
> 
> /** Load a segment. Fall back on loading a zero segment if something goes wrong
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

-- Jamie
