Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSLQKqH>; Tue, 17 Dec 2002 05:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSLQKqH>; Tue, 17 Dec 2002 05:46:07 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:54194
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S264885AbSLQKqC>; Tue, 17 Dec 2002 05:46:02 -0500
Message-ID: <3DFF023E.6030401@redhat.com>
Date: Tue, 17 Dec 2002 02:53:50 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Ok, I did the vsyscall page too, and tried to make it do the right thing
> (but I didn't bother to test it on a non-SEP machine).
> 
> But it might be interesting to verify that a
> recompiled glibc (or even just a preload) really works with this on a
> "whole system" testbed rather than just testing one system call (and not
> even caring about the return value) a million times.


I've created a modified glibc which uses the syscall code for almost
everything.  There are a few int $0x80 left here and there but mostly it
is a centralized change.

The result: all works as expected.  Nice.

On my test machine your little test program performs the syscalls on
roughly twice as fast (HT P4, pretty new).  Your numbers are perhaps for
the P4 Xeons.  Anyway, when measuring some more involved code (I ran my
thread benchmark) I got only about 3% performance increase.  It's doing
a fair amount of system calls.  But again, the good news is your code
survived even this stress test.


The problem with the current solution is the instruction set of the x86.
 In your test code you simply use call 0xfffff000 and it magically work.
 But this is only the case because your program is linked statically.

For the libc DSO I had to play some dirty tricks.  The x86 CPU has no
absolute call.  The variant with an immediate parameter is a relative
jump.  Only when jumping through a register or memory location is it
possible to jump to an absolute address.  To be clear, if I have

    call 0xfffff000

in a DSO which is loaded at address 0x80000000 the jumps ends at
0x7fffffff.  The problem is that the static linker doesn't know the load
address.  We could of course have the dynamic linker fix up the
addresses but this is plain stupid.  It would mean fixing up a lot of
places and making of those pages covered non-sharable.

Instead I've changed the syscall handling to effectve do

   pushl %ebp
   movl $0xfffff000, %ebp
   call *%ebp
   popl %ebp

An alternative is to store the address in a memory location.  But since
%ebx is used for a syscall parameter it is necessary to address the
memory relative to the stack pointer which would mean loading the stack
address with 0xfffff000 before making the syscall.  Not much better than
the code sequence above.

Anyway, it's still an improvement.  But now the question comes up: how
the ld.so detect that the kernel supports these syscalls and can use an
appropriate DSO?  This brings up again the idea of the read-only page(s)
mapped into all processes (you remember).


Anyway, it works nicely.  If you need more testing let me know.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

