Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136121AbRAMMKB>; Sat, 13 Jan 2001 07:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136618AbRAMMJv>; Sat, 13 Jan 2001 07:09:51 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:5896 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136121AbRAMMJn>;
	Sat, 13 Jan 2001 07:09:43 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: Christian Zander <phoenix@minion.de>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Sat, 13 Jan 2001 10:46:44 -0000."
             <Pine.LNX.4.30.0101131011020.1540-100000@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Jan 2001 23:06:36 +1100
Message-ID: <7650.979387596@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001 10:46:44 +0000 (GMT), 
David Woodhouse <dwmw2@infradead.org> wrote:
>On Sat, 13 Jan 2001, Keith Owens wrote:
>Actually, my testing showed that modutils was quite OK with symbols which
>may or may not be present. But compiling such code into the kernel, at
>least on MIPS and m68k, didn't work.

Weak symbols were added to gcc somewhere between 2.7.2.3 and 2.91.66.
At least two architectures are using versions of gcc that predate (by a
few days) the addition of weak symbols.  Davem hit this problem on
sparc with the weak references to kallsyms, he had to define the
symbols instead of letting them resolve to zero, gcc on sparc silently
ignored weak.

>I doubt this would have implemented weak symbols completely, though.
>Fixing up the reference in weaktest.o if myfun.o was loaded later, etc.
>And we don't really want to 'fix' that either.

Weak is not enough.  We need dynamic symbol binding if we plan to
support a cooperative model for objects instead of a strict hierarchic
model.

BTW, modutils cannot automatically fill in upward references when a
module is loaded.  A reference is a use count, an automatic reference
would be an automatic use count with no way of removing it.  Code that
calls upwards to a symbol must perform an overt action to get the
reference and cope with the case when the symbol is not there.  Think
of it as a probe, "do I have facility XXX yet?".  It is up to the
caller to probe as often as required.  Hot plugging for symbols, wheee!

>> That last point is especially important for IA64 where function
>> pointers do not reference the function directly, instead they point to
>> a function descriptor with two fields, one of which is the function
>> address.  Casting the unsigned long address of a function into a
>> function pointer fails miserably on IA64, and gcc does not even give
>> any warnings.  foo = (int (*)(int))get_module_symbol(NULL, "funcname")
>> is architecture dependent.
>
>But fixable.

Probably not.  The generated IA64 object code for this case is
completely wrong, not surprising since we are lying to gcc.

x.o:     file format elf64-ia64-little

Disassembly of section .text:

0000000000000000 <test1>:
unsigned long value = 0xc0002000;	// example, not a real ia64 address

void test1(void)
{
   0:          [MII]       alloc r34=ar.pfs,4,4,0
        void (*test2)(void);
   6:                      mov r35=r12		// &test2
   c:                      adds r12=-16,r12	// adjust stack pointer
  10:          [MII]       nop.m 0x0
        test2 = (void (*)(void))value;
  16:                      mov r33=b0		// save return address
                        12: GPREL22     value
  1c:                      addl r14=0,r1;;	// &value
  20:          [MMI]       ld8 r14=[r14];;	// value
  26:                      st8 [r35]=r14	// test2 = value 0xc0002000
  2c:                      nop.i 0x0
        test2();
  30:          [MII]       ld8 r14=[r35]	// read test2, 0xc0002000
  36:                      mov r32=r1;;		// save current global pointer
  3c:                      nop.i 0x0
  40:          [MII]       ld8 r15=[r14]	// dereference test2, wrong
  46:                      adds r14=8,r14;;	// test2 + 8, 0xc0002008
  4c:                      nop.i 0x0
  50:          [MII]       ld8 r1=[r14]		// new gp from 0xc0002008, wrong
  56:                      mov b6=r15;;		// & target function, wrong
  5c:                      nop.i 0x0
  60:          [MIB]       nop.m 0x0
  66:                      nop.i 0x0
  6c:                      br.call.sptk.many b0=b6;; // call indirect function, oops
  70:          [MII]       mov r1=r32		// restore gp

By casting 'test2 = (void (*)(void))value' we claim that value is the
address of the the function descriptor which must contain

  { actual address of function, global data pointer for function }

gcc trusts us and tries to use the data at location 0xc0002000 as a
function descriptor.  Because get_module_symbol() returns the address
of the first instruction in a function, that code would load the actual
address and global pointer from the first 16 bytes of the function's
code area.  Needless to say, it does not work.

Fixing this would mean tweaking get_module_symbol() on IA64 to
recognise that the symbol is a function, build a function descriptor on
the fly and return the address of the descriptor.  But the information
about the types of symbols is not available in the kernel nor in
modules after they are loaded, get_module_symbol() cannot differentiate
between functions and anything else.  There is also the small matter of
grubbing around in the arch dependent bit of struct modules to find the
global pointer for the target function, more complexity.

>But what about keeping a separate table, with PUBLISH_SYMBOL() or
>something slightly more sensibly named? That way, get_published_symbol()
>can only get at those symbols which were supposed to be listed, and if
>someone really wants EXPORT_SYMBOL() and PUBLISH_SYMBOL() they can do
>that.

I don't see the point.  EXPORT_SYMBOL() says that the symbol can be
accessed by anybody.  The current hierarchical binding model restricts
access to modules that load after this module.  If we remove the strict
hierarchical binding of module symbols, why worry whether the caller is
above or below this module?  IOW, there is no need for a different
definition that says the symbol can also be accessed by the kernel or
by earlier module loads.  Upward references to a symbol are another
story.

>> > inter_module_xxx is modversions safe.  It still does no type checking
>> because it uses void * for the data structure, but the exporter and
>> user have to declare their common data area which reduces the chance of
>> version skew.
>
>I'm not sure I follow. The exporter and the user have to each declare
>their common data area, which means they don't have to declare it
>identically, and there's just as much chance of version skew as before,
>surely? With get_module_symbol both had to declare it, too.

get_module_symbol() was usually used with a cast from unsigned long to
some type that was defined in the calling .c file.  That made the
caller code responsible for using the correct declaration.  It is
better to define interfaces as shared data in a shared header.  Not
perfect, but better.

>And 'modversions safe' just means that there's no attempt to mangle the
>names so it's identical to the EXPORT_SYMBOL_NOVERS case above?

With inter_module_xxx you have no type checking on the registered data.
But you do not have to use EXPORT_SYMBOL_NOVERS on the shared symbols
which means that any other users of the symbols will still get type
checking.  Again, not perfect, but better.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
