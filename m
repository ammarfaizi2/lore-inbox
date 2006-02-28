Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751871AbWB1GHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbWB1GHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 01:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWB1GHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 01:07:30 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:38561 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751871AbWB1GH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 01:07:29 -0500
Date: Tue, 28 Feb 2006 01:04:01 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: make bitops safe
To: Richard Henderson <rth@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Message-ID: <200602280106_MC3-1-B974-9231@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060228005436.GA24895@redhat.com>

On Mon, 27 Feb 2006 at 16:54:36 -0800, Richard Henderson wrote:

> On Tue, Feb 28, 2006 at 12:47:22AM +0100, Andi Kleen wrote:
> > I remember asking rth about this at some point and IIRC
> > he expressed doubts if it would actually do what expected. Richard?
> 
> It's a bit dicey to be sure.  GCC may or may not be able to look
> through the size of the array and not kill things beyond it.  If
> one could be *sure* of some actual maximum index, this would be
> fine, but I don't think you can.
> 

In theory the bit offset could be from -2**31 to 2**31 - 1

> One could reasonably argue that if you used a structure with a
> flexible array member, that GCC could not look through that.  But
> again I'm not 100% positive this is handled properly.

This seems to work but causes more problems than it solves:

#define vaddr ((volatile long *) addr)
static inline void set_bit(int nr, volatile unsigned long * addr)
{
        __asm__ __volatile__( "lock ; "
                "btsl %2,%1"
                :"+m" (*(vaddr + (nr>>5)))
                :"m" (*vaddr),"Ir" (nr)
                );
}

First, it generates the byte offset nr>>5 and puts it in a register
even though it will never be used in the asm.  I can't find a constraint
that says "I'll be accessing this address but I don't need you to generate
it for me."  Second, the compiler thinks *vaddr will be read when it
really won't (unless nr>>5 == 0 in which case constraint 0 takes care
of it.)

Generated code when nr is a variable:

        movl nr,%edx
        movl %edx,%eax
        sarl $5,%eax
        sall $2,%eax
        lock ; btsl %edx,addr

This causes a register reload afterward (assuming all regs are busy) and
can cause a function to use more stack space.  That plus the three extra
instructions made me go with the full memory clobber instead.

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

