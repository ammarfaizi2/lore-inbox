Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970937-11449>; Mon, 9 Mar 1998 00:03:24 -0500
Received: from cygnus.com ([205.180.230.20]:1525 "EHLO cygint.cygnus.com" ident: "NO-IDENT-SERVICE") by vger.rutgers.edu with ESMTP id <970961-11449>; Mon, 9 Mar 1998 00:02:03 -0500
To: Christof Petig <christof.petig@wtal.de>
cc: linux-kernel@vger.rutgers.edu, egcs@cygnus.com, torvalds@transmeta.com, paubert@iram.es
Subject: Re: egcs 1.0.1 miscompiles Linux 2.0.33 
Reply-To: law@cygnus.com
In-reply-to: Your message of Thu, 05 Mar 1998 10:17:42 MST. <34FE6DB6.4D2CCA22@wtal.de> 
Date: Sun, 08 Mar 1998 23:27:06 -0700
Message-ID: <11753.889424826@hurl.cygnus.com>
From: Jeffrey A Law <law@hurl.cygnus.com>
Sender: owner-linux-kernel@vger.rutgers.edu



  In message <34FE6DB6.4D2CCA22@wtal.de>you write:
  > Could you please explain the syntax of an earlyclobber (I never heard of it).
  > I would undergo the task of patching Linux-Kernel's asms, since I'd like to
  > stop the debate about an EGCS/Kernel mismatch. EGCS is a valuable project a nd
  > compiling a kernel should not delay using it.
It's pretty simple.

For example strstr would look something like this:

extern inline char * strstr(const char * cs,const char * ct)
{
int __dummy1;
int __dummy2;
register char * __res;
__asm__ __volatile__(
        "cld\n\t"       "movl %6,%%edi\n\t"

        "repne\n\t"
        "scasb\n\t"
        "notl %%ecx\n\t"
        "decl %%ecx\n\t"
        "movl %%ecx,%%edx\n"
        "1:\tmovl %6,%%edi\n\t"
        "movl %%esi,%%eax\n\t"
        "movl %%edx,%%ecx\n\t"
        "repe\n\t"
        "cmpsb\n\t"
        "je 2f\n\t"
        "xchgl %%eax,%%esi\n\t"
        "incl %%esi\n\t"
        "cmpb $0,-1(%%eax)\n\t"
        "jne 1b\n\t"
        "xorl %%eax,%%eax\n\t"
        "2:"
        :"=a" (__res), "=&c" (__dummy1), "=&S" (__dummy2) :"0" (0), "1" (0xfffff
fff), "2" (cs),"g" (ct)
        :"dx","di");
return __res;
}

Notice how cx and si are no longer in the clobber list.  Instead there's
a dummy output operand for each with is marked as an earlyclobber (=&)
of the register class which contains cx and si.

The inputs which must be allocated to cx and si are forced to match
the outputs via the "1" and "2" constraints respectively.


Note that even with that fix, this asm is still has the potential to
cause problems, especially when compiling with -fno-strength-reduce.

The problem is ax, cx, si, dx and di are explicitly used by the insn.
This leaves just bx for reloading.

The general operand "g" (ct) may require 2 reload regs since it might
used an indexed address.  Unfortunately only one reload register is
considered available (bx).

This is a problem with the asm, not gcc.  Basically when compiling
with -fno-strength-reduce there may not enough registers to handle
this asm, depending on address of "ct".

Changing the constraint for "ct" to be a register will not help since
the compiler would still need to reload the value of ct into the
register to satisfy the register constraint, which still may require
2 reload registers.

You must either rewrite the asm to use one less register or not
compile with -fno-strength-reduce (note -fno-strength-reduce should
not be necessary for gcc-2.8 or egcs).

In fact, its this exact situation that started this whole discussion;
right now the compiler may silently generate incorrect code if it
runs out of registers for an x86 asm that explicitly clobbers registers.

I've got a change which will cause the compiler to issue a fatal error
anytime a clobber overlaps with an input operand or the address of
any operand.  This change is likely to expose various problems in
x86 asm statements for Linux since overlapping inputs and outputs
is relatively common.

I've hesitated installing this change because it's going to cause
so many compile time failures for code which currently exists in the
Linux sources.

One possibility would be to make the behavior conditional on a switch;
the default behavior right now would be to mimic the old behavior.
Once y'all have had time to fix the problems we could make the more
strict asm checking the default behavior.

Thoughts?
jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
