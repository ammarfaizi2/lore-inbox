Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129295AbQK0G0h>; Mon, 27 Nov 2000 01:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129880AbQK0G02>; Mon, 27 Nov 2000 01:26:28 -0500
Received: from [209.249.10.20] ([209.249.10.20]:37016 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129295AbQK0G0K>; Mon, 27 Nov 2000 01:26:10 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 26 Nov 2000 21:56:01 -0800
Message-Id: <200011270556.VAA12506@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org, meissner@spectacle-pond.org
Subject: Re: [PATCH] removal of "static foo = 0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Meissner wrote:
>On Sat, Nov 25, 2000 at 11:55:11PM +0000, Tim Waugh wrote:
>> On Sat, Nov 25, 2000 at 10:53:00PM +0000, James A Sutherland wrote:
>> 
>> > Which is silly. The variable is explicitly defined to be zero
>> > anyway, whether you put this in your code or not.
>> 
>> Why doesn't the compiler just leave out explicit zeros from the
>> 'initial data' segment then?  Seems like it ought to be tought to..
>
>Because sometimes it matters.  For example, in kernel mode (and certainly for
>embedded programs that I'm more familiar with), the kernel does go through and
>zero out the so called BSS segment, so that normally uninitialized static
>variables will follow the rules as laid out under the C standards (both C89 and
>C99).  I can imagine however, that the code that is executed before the BSS
>area is zeroed out needs to be extra careful in terms of statics that it
>references, and those must be hand initialized.

	Since that code is already careful to hand initialize what
it needs and explicitly zeroes the BSS, that sounds like an argument
that it *is* safe to change gcc to move data that is intialized to
all zeroes into bss, either as a compiler option or even not
optionally.

	I am not a gcc hacker, but it looks to me like one could
copy the code from output_constant and the functions that it
calls (in gcc-2.95.2/gcc/gcc/varasm.c) to walk the tree to figure
out if the data was all zeroes.  I even started writing a routine
for assemble_variable to call to try to test just for the integer case
(basically just by cutting and pasting code).  I include it here just
to illustrate.  Note: this code doesn't even type check properly when
I try to compile it, so I know it's very wrong, but it's as good as
posting pseudo code to explain my thinking).

void
clear_zero_initialization(tree decl)
{
        tree exp = DECL_INITIAL(decl);
        enum tree_code code;

        if (exp == NULL)
                return;

        code = TREE_CODE (TREE_TYPE (exp));
        if (lang_expand_constant)
                exp = (*lang_expand_constant) (exp);

        while ((TREE_CODE (exp) == NOP_EXPR
                && (TREE_TYPE (exp) == TREE_TYPE (TREE_OPERAND (exp, 0))
                    || AGGREGATE_TYPE_P (TREE_TYPE (exp))))
               || TREE_CODE (exp) == NON_LVALUE_EXPR)
                exp = TREE_OPERAND (exp, 0);

        if (code == INTEGER_TYPE && exp == const0_rtx)
                DECL_INITIAL(decl) = NULL;
}


	At the moment, I have started daydreaming about instead
writing an "elf squeezer" to do this and other space optimizations
by modifying objdump.  However, I do think that such an improvement
to gcc would be at least a bit useful to the larger user base than
just those people who use binutils-based systems.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
