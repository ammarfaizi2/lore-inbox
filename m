Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbULFWcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbULFWcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbULFWce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:32:34 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:655 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261681AbULFWca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:32:30 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jesper Juhl <juhl-lkml@dif.dk>
Date: Mon, 6 Dec 2004 23:37:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH 2.6] clean-up: fixes "comparison between signed 
Cc: linux-kernel@vger.kernel.org, mroos@ut.ee
X-mailer: Pegasus Mail v3.50
Message-ID: <2C0CC42621D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Dec 04 at 23:11, Jesper Juhl wrote:
> On Mon, 6 Dec 2004, Riina Kikas wrote:
> 
> > This patch fixes warning "comparison between signed and unsigned"
> > occuring on line 308
> > 
> > Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>
> > 
> > --- a/arch/i386/mm/fault.c    2004-12-02 21:30:30.000000000 +0000
> > +++ b/arch/i386/mm/fault.c    2004-12-02 21:30:59.000000000 +0000
> > @@ -302,7 +302,13 @@
> >        * pusha) doing post-decrement on the stack and that
> >        * doesn't show up until later..
> >        */
> > -     if (address + 32 < regs->esp)
> > +     unsigned long regs_esp;
> > +     if (regs->esp < 0) {
> > +         regs_esp = 0;
> > +     } else {
> > +         regs_esp = regs->esp;
> > +     }
> > +     if (address + 32 < regs_esp)
> >           goto bad_area;
> >   }
> >   if (expand_stack(vma, address))
> 
> This seems a bit silly. If the stack pointer (esp) is ever negative that's 
> clearly a bug somewhere. So instead of testing it for <0 and then setting 
> your regs_esp variable to 0 it would make more sense to me to just 
> BUG_ON(regs->esp < 0) or something, if you want to do anything at all. And 
> if you want to silence the warning a exlicit cast to unsigned long should 
> do I'd say, but I have a feeling the best thing is to just leave that 
> warning alone, the code seems to be fine.

regs->esp is < 0 almost always - user stack starts at 0xBFFFFFFF, which
is negative number when you treat it as 'long'.  Change is wrong, now
when esp is in top 2GB 'address' is never evaluated as invalid, and it
was definitely not intention.

Correct is (if any fix is needed at all) typecast regs->esp to unsigned
long, eventually with check that address is less than (unsigned long)-32,
as area at VA 0 is not going to grow "down" to 0xFFFFFxxx, even if you
nicely ask.
                                                     Best regards,
                                                            Petr Vandrovec
                                                            

