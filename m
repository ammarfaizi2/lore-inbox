Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbULFW7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbULFW7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbULFW7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:59:06 -0500
Received: from mail.dif.dk ([193.138.115.101]:55244 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261340AbULFW67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:58:59 -0500
Date: Tue, 7 Dec 2004 00:09:05 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, mroos@ut.ee, Riina Kikas <riinak@ut.ee>
Subject: Re: [PATCH 2.6] clean-up: fixes "comparison between signed 
In-Reply-To: <2C0CC42621D@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.61.0412062352430.3390@dragon.hygekrogen.localhost>
References: <2C0CC42621D@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Petr Vandrovec wrote:

> On  6 Dec 04 at 23:11, Jesper Juhl wrote:
> > On Mon, 6 Dec 2004, Riina Kikas wrote:
> > 
> > > This patch fixes warning "comparison between signed and unsigned"
> > > occuring on line 308
> > > 
> > > Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>
> > > 
> > > --- a/arch/i386/mm/fault.c    2004-12-02 21:30:30.000000000 +0000
> > > +++ b/arch/i386/mm/fault.c    2004-12-02 21:30:59.000000000 +0000
> > > @@ -302,7 +302,13 @@
> > >        * pusha) doing post-decrement on the stack and that
> > >        * doesn't show up until later..
> > >        */
> > > -     if (address + 32 < regs->esp)
> > > +     unsigned long regs_esp;
> > > +     if (regs->esp < 0) {
> > > +         regs_esp = 0;
> > > +     } else {
> > > +         regs_esp = regs->esp;
> > > +     }
> > > +     if (address + 32 < regs_esp)
> > >           goto bad_area;
> > >   }
> > >   if (expand_stack(vma, address))
> > 
> > This seems a bit silly. If the stack pointer (esp) is ever negative that's 
> > clearly a bug somewhere. So instead of testing it for <0 and then setting 
> > your regs_esp variable to 0 it would make more sense to me to just 
> > BUG_ON(regs->esp < 0) or something, if you want to do anything at all. And 
> > if you want to silence the warning a exlicit cast to unsigned long should 
> > do I'd say, but I have a feeling the best thing is to just leave that 
> > warning alone, the code seems to be fine.
> 
> regs->esp is < 0 almost always - user stack starts at 0xBFFFFFFF, which
> is negative number when you treat it as 'long'.  

True, if you treat that nr as signed long it's clearly negative. I guess 
what twisted my head there was thinking about a register as a signed C 
type.
Why are the registers not defined as unsigned types in the struct in the 
first place?

>Change is wrong, now
> when esp is in top 2GB 'address' is never evaluated as invalid, and it
> was definitely not intention.
> 
> Correct is (if any fix is needed at all) typecast regs->esp to unsigned
> long, 

That would have been my suggestion as well.

>eventually with check that address is less than (unsigned long)-32,
> as area at VA 0 is not going to grow "down" to 0xFFFFFxxx, even if you
> nicely ask.

you mean something like this - right?

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk2-orig/arch/i386/mm/fault.c linux-2.6.10-rc3-bk2/arch/i386/mm/fault.c
--- linux-2.6.10-rc3-bk2-orig/arch/i386/mm/fault.c	2004-12-06 22:24:16.000000000 +0100
+++ linux-2.6.10-rc3-bk2/arch/i386/mm/fault.c	2004-12-07 00:04:33.000000000 +0100
@@ -305,7 +305,7 @@ fastcall void do_page_fault(struct pt_re
 		 * pusha) doing post-decrement on the stack and that
 		 * doesn't show up until later..
 		 */
-		if (address + 32 < regs->esp)
+		if (address + 32 < (unsigned long)regs->esp || address >= (~0UL - 32))
 			goto bad_area;
 	}
 	if (expand_stack(vma, address))


