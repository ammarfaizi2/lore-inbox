Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267815AbRGWEXc>; Mon, 23 Jul 2001 00:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267816AbRGWEXW>; Mon, 23 Jul 2001 00:23:22 -0400
Received: from smarty.smart.net ([207.176.80.102]:53253 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S267815AbRGWEXL>;
	Mon, 23 Jul 2001 00:23:11 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200107230439.AAA19725@smarty.smart.net>
Subject: Re: Why Plan 9 C compilers don't have asm("")
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Jul 2001 00:39:16 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

What if Forth only had one stack?

Looking at optimizations and calling conventions, I did some gas/cpp
macros that implement caller-hikes, callee passes. The caller makes the
space for the callee's stack frame, but it's up to the callee to populate
it if necessary. Sometimes it isn't. In assembly the current context can
see the whole stack, and "osimpa" macros not all included here make the
parent frame, the current frame, and the most recently exited child frame
3 sets of named locals. This is in conjunction with x86 RET imm16 , which
does a stack frame drop for free. I got the Ackerman function, a nasty
little recursion excercise, and rather C's home court, about 50% faster
than Gcc 3.0 -O3 -fomit-frame-pointer. The Gcc version does optimize out
the two tail recursions, leaving one non-tail recursion. I beat that with
all 3 tail recursions remaining in my code. i.e. this is the first version
that worked. I stared at this monster for 2 full days looking for where I
had written "increment" instead of "decrement". Now it appears to produce
the correct results.

..........................................................................

#define cell    4
#define cells   *4
#define sM       4 (%esp)
#define sN       8 (%esp)
                                        /* some of the parent's locals */
#define pM      ((def_hike +2)  cells) (%esp)
#define pN      ((def_hike +3)  cells) (%esp)


#define def(routine,HIKE)                       \
        def_hike    =       HIKE    ;       \
        .globl routine                  ;       \
        routine:

#define fed             ret $(def_hike cells)

#define child(callee)   child_hike = callee ## _hike

#define hike(by)        subl $(by cells) , %esp

#define do(callee)              \
        hike(def_hike)   ;\
        call callee
                                /* Asmacs exerpts as pertains */
#define testsubtract    cmpl
#define ifzero          jz
#define decrement       decl
#define increment       incl
#define to              ,
#define with            ,
#define copy            movl
#define A               %eax

def(Ack,2)
testsubtract $0 with pM
ifzero                                          alpha
        testsubtract $0 with pN
        ifzero                          beta
#                               return( Ack(M - 1, Ack(M, (N - 1))) );
                copy pN to A
                decrement A
                copy A to sN
                copy pM to A
                copy A to sM
                        do(Ack)
                copy A to sN
                decrement sM
                        do(Ack)
                                fed
#                                        return( N + 1 );
alpha:  copy pN to A                                    # M=0
        increment A
                        fed
#                                       return( Ack(M - 1, 1) );
beta:   copy $1 to sN                                   # N=0
        copy  pM to A
        decrement A
        copy A to sM
                do(Ack)
                        fed

#___ ___ ___ ___ ___ ___ ___ ___ ___ ___ ___ ___ ___ ___ ___ ___ ___

def(main,2)                                     # known OK
        copy $2 to sM
        copy $8 to sN
        do(Ack)
                        fed



/* Rick Hohensee 2001 */


/* The Ackerman function in GNU gas with cpp macros for "asmacs"
verbosifications and "osimpa" caller-hikes, callee-passes subroutine
parameter passing

Parts of asmacs, osimpa.cpp and local renamings included in this file for
clarity.

 osimpa stuff, with locals names to reflect the C code example and osimpa
callee-passes, i.e. pM instead of Pa, sM instead of a, etc.

The full asmacs is in Janet_Reno and H3sm. osimpa isn't out yet.
*/
 
....................................................................

I compared this to the C version on Bagley's language shootout
page by hacking that down to use

<snip>

main () {
return Ack(3,8);
}

so it just returns the low byte of the result, as does my code.

C can pick this up after the expressions are parsed. Whereas this models
"stack-array plus accumulator", that's actually less aggravation to
program directly than Forth stack manipulations (well, maybe), so I'll
probably code this on top of shasm without an expression parser. osimpa
stands for "one stack in memory plus accumulator".

Rick Hohensee
			www.clienux.com
