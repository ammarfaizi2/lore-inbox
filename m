Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbULHWQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbULHWQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbULHWQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:16:23 -0500
Received: from mail.dif.dk ([193.138.115.101]:17831 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261391AbULHWNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:13:52 -0500
Date: Wed, 8 Dec 2004 23:24:03 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, mroos@ut.ee, Riina Kikas <riinak@ut.ee>
Subject: Re: [PATCH 2.6] clean-up: fixes "comparison between signed
In-Reply-To: <20041207233652.GA9939@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.61.0412082316180.3467@dragon.hygekrogen.localhost>
References: <2C0CC42621D@vcnet.vc.cvut.cz> <Pine.LNX.4.61.0412062352430.3390@dragon.hygekrogen.localhost>
 <20041207010259.GA12352@vana.vc.cvut.cz> <Pine.LNX.4.61.0412080016570.3320@dragon.hygekrogen.localhost>
 <20041207233652.GA9939@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, Petr Vandrovec wrote:

> On Wed, Dec 08, 2004 at 12:20:01AM +0100, Jesper Juhl wrote:
> > On Tue, 7 Dec 2004, Petr Vandrovec wrote:
> > 
> > > On Tue, Dec 07, 2004 at 12:09:05AM +0100, Jesper Juhl wrote:
> > > > On Mon, 6 Dec 2004, Petr Vandrovec wrote:
> > > > > Correct is (if any fix is needed at all) typecast regs->esp to unsigned
> > > > > long, 
> > > > 
> > > > That would have been my suggestion as well.
> > > > 
> > > > >eventually with check that address is less than (unsigned long)-32,
> > > > > as area at VA 0 is not going to grow "down" to 0xFFFFFxxx, even if you
> > > > > nicely ask.
> > > > 
> > > > you mean something like this - right?
> > > 
> > > Yes.  Though I believe that we already take vma == NULL path when address is that big.
> > 
> > Hmm, where? - maybe I'm blind or just stupid, but I don't seem to be able 
> > to find where we do that.
> > And would it hurt to have that additional check there as well in case 
> > address was modified after the previous check and before being passed to 
> > do_page_fault ? (note: I'm writing this last bit without having mined the 
> > source for info yet).
> 
> If find_vma() returns NULL, it is bad_area, and no further tests occur.  Otherwise
> if vma->vm_start <= address, it is good area.
> 
> Only when these two conditions are satisifed (find_vma found vma, and this vma begins
> above vma's vm_start, regs->esp is checked.  And as vma->vm_start can be at most 
> 0xFFFFF000 (it is page aligned, and you cannot have vma at 4GB - actually you cannot 
> have vma above 3GB on normal kernel, or 4GB-<whatever>MB on 4G/4G kernel), there is 
> no way how 'address' could be in top 4KB, and so adding 32 to it cannot overflow 
> 32bit variable.
> 
> At least I believe this...

Having read your explanation (thank you) and re-read the code I think you 
are right. If that's indeed the case, then it would seem that the code is 
just fine and the best we can do is just add an explicit cast to unsigned 
long to shut up the compiler.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk2-orig/arch/i386/mm/fault.c linux-2.6.10-rc3-bk2/arch/i386/mm/fault.c
--- linux-2.6.10-rc3-bk2-orig/arch/i386/mm/fault.c	2004-12-06 22:24:16.000000000 +0100
+++ linux-2.6.10-rc3-bk2/arch/i386/mm/fault.c	2004-12-08 23:14:59.000000000 +0100
@@ -305,7 +305,7 @@ fastcall void do_page_fault(struct pt_re
 		 * pusha) doing post-decrement on the stack and that
 		 * doesn't show up until later..
 		 */
-		if (address + 32 < regs->esp)
+		if (address + 32 < (unsigned long)regs->esp)
 			goto bad_area;
 	}
 	if (expand_stack(vma, address))


If you agree I'll forward the patch to Andrew.


-- 
Jesper Juhl


