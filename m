Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266103AbRGXWl0>; Tue, 24 Jul 2001 18:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266125AbRGXWlQ>; Tue, 24 Jul 2001 18:41:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10990 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266103AbRGXWlB>; Tue, 24 Jul 2001 18:41:01 -0400
From: James Washer <washer@us.ibm.com>
Message-Id: <200107242241.PAA05423@crg8.sequent.com>
Subject: switch_mm() can fail to load ldt on SMP
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Jul 2001 15:41:04 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



We've run into a small bug in switch_mm() which results in a process
running with a 'stale' ldt.

The following timeline explains how the bug can occur

Process A begins its life on cpu 0.
Process A is context switched OFF of cpu 0 and replaced by
        the idle task (perhaps because of a slow system call).
Process A next runs on cpu 1, where it calls modify_ldt,
        to establish an ldt
Process A is context switched OFF of cpu 1
Process A is selected to run on cpu 0.

If cpu 0 has been continually running the idle task, then when
switch_mm() compares the next and prev mm_struct pointers, it will
find they are equal and NOT call load_LDT().

Process A will begin running, with the ldt pointing at default_ldt rather
than its private ldt ( mm->context.segments ).



We have two possible fixes for this problem, and welcome comments as to
which would be 'best'.

The first fix would be to patch switch_mm(), so that when the next and
prev mm pointers are equal, it checks to see if mm->context.segments
is non-null, if so, it calls load_LDT(). This will unfortunately lead
to many unnecessary calls to load_LDT(). An enhanced version of this
fix, would involve introducing a bit array into the mm_struct, one
bit per cpu. When write_ldt() first allocates the ldt for this mm_struct,
it would set all bits. Subsequently, in switch_mm(), we could
introduce  a test such as
        if(next->context.segments &&
        test_and_clear_bit(cpu,&next->ldtupdate))load_LDT(next);
so that as each engine switchs to this mm_struct, a load_LDT() is
guaranteed.

The second fix would introduce yet another IPI. When write_ldt() first
creates a new ldt, it would send an IPI to all other cpu's, passing the
mm pointer as an arg. If the other cpu's were using the mm, they would
then call load_LDT().


Which fix is better depends on the system and application. On a system
with hundreds of processes sharing the same mm_struct, the first fix
will result in quite a few calls to load_LDT(). On a system with a large
number of cpus, and short lived programs using segments, the IPI will
be wasteful.


Please respond with comments as to which patch seems best to you, or
alternative patches if you have suggestions.

thanks

 Judy Barkal and Jim Washer
	jbarkal@us.ibm.com   washer@us.ibm.com


 p.s. This problem presented itself in a small application linked to
 libpthread (for those that don't know, some versions of libpthread use
 segmentation on i386 platforms). Occasionally, the application would 
 die from a SIGSEGV.
 Investigation found that it was dying when the kernel attempted to
 restore the gs register. Further investigation showed that the ldt 
 entry in the gdt pointed to the default_ldt, leading to the 
 segmentation violation.



