Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUBZWOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUBZWOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:14:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10728 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261168AbUBZWNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:13:43 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, davej@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: raid 5 with >= 5 members broken on x86
References: <orznb5leqs.fsf@free.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0402261329450.7830@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 26 Feb 2004 19:13:32 -0300
In-Reply-To: <Pine.LNX.4.58.0402261329450.7830@ppc970.osdl.org>
Message-ID: <or1xohpjzn.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> On Thu, 26 Feb 2004, Alexandre Oliva wrote:
>> 
>> I suppose I could just change lines from +g to +r, like xor_pII_mmx_5,
>> but avoiding the pushes and pops is more efficient, and making sure
>> GCC doesn't get clever about sharing or reusing p4 and p5, it's just
>> as safe.  This approach should probably be extended to the other uses
>> of push and pop due to limitations in the number of operands.

> You can't do this in a separate inline asm.

There's a reason why I added both asms, one with volatile and one
without.  I know what I'm doing.  I even tried to explain it in the
comments.  Did you read them?  Let me try again.

+	__asm__ ("" : "+r" (p4), "+r" (p5));

This makes sure GCC no longer knows what's in p4 and p5.  They're no
longer shared with anything they might have been shared with before.
So, when we read from p4 and p5, we know that, even if p4 and p5 are
reloaded into some other register, they're not shared with anything
else.  We don't need the above to be volatile because it's ok to
reorder it with the preparation of the arguments for the asm below, or
with anything before.  The point is only to get rid of any potential
sharing of value that the variables might have with whatever might
have been assigned to them before.

 	__asm__ __volatile__ (
[...]
 	: "+g" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3)
 	: "r" (p4), "r" (p5)
 	: "memory");

Ok, so we read from p4 and p5, that GCC knew nothing about.  GCC
doesn't know they changed.  But that's ok, because immediately after
this volatile asm, there's another:

+	__asm__ __volatile__ ("" : "+r" (p4), "+r" (p5));

This one tells GCC: look, I'm clobbering these registers.  They no
longer have the values they used to.  Strictly speaking, this is not
even necessary, since the variables go out of scope at the end of the
function.  But strictly speaking, it's correct, in that it implies GCC
will make no assumptions that the registers that held the values of p4
and p5 at the end of the previous asm statement still do.

So the only possibility of problem would be in case GCC used the
registers with the modified values of p4 and p5 as addresses for
output reloads for any of the other operands of the second asm (the
first volatile one).  But GCC can't possibly do this because it has no
idea of what values p4 and p5 have.

So it the assembly sequence is strictly correct, even though it
requires some deep knowledge of the semantics of asm statements to
conclude that.

> There is nothing to say that gcc wouldn't do a re-load or something
> in between, so you really need to tell the _first_ ask about it.

The only other reload it could do is an input reload of p4 and p5,
which, again, doesn't matter, because p4 and p5 are dead anyway.
Should we actually be interested in their values, I very much agree
with you it wouldn't work.  But in this case, we don't need their
values.  We just want to tell GCC it doesn't know what's in those
variables any more.

So, it doesn't know what's in the p4 and p5 registers before the asm
volatile, because of the first non-volatile asm, and it doesn't know
what's in the variables afterwards, because of the last volatile asm,
so (i) it won't attempt to reuse the values that are modified in the
asm even though it doesn't know, and (ii) these registers won't have
been reused with anything else from before.

I claim it's safe and correct.

>> Yet another possibility is to just use +r for p4 and p5; this works in
>> GCC 3.1 and above.  I wasn't sure the kernel was willing to require
>> that, so I took the most conservative approach.

> No, I don't think we're ready to force a bigger and slower compiler
> on x86 for something like this.

Ok.

> One approach is to just do the loop _outside_ of the asm?

IIUC the loop has to be aligned to work as quickly as possible.

> Btw, the "xor_pII_mmx_5()" thing just uses "+r" for the line count,
> so why doesn't that work for this case?

It does.  I even said so.  But it's slower because of the unnecessary
pushes and pops.  The optimization I propose here could be used for
xor_pII_mmx_5 as well.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Happy GNU Year!                     oliva@{lsd.ic.unicamp.br, gnu.org}
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist                Professional serial bug killer
