Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbULGXhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbULGXhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 18:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbULGXhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 18:37:21 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:5248 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261923AbULGXhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 18:37:14 -0500
Date: Wed, 8 Dec 2004 00:36:52 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, mroos@ut.ee, Riina Kikas <riinak@ut.ee>
Subject: Re: [PATCH 2.6] clean-up: fixes "comparison between signed
Message-ID: <20041207233652.GA9939@vana.vc.cvut.cz>
References: <2C0CC42621D@vcnet.vc.cvut.cz> <Pine.LNX.4.61.0412062352430.3390@dragon.hygekrogen.localhost> <20041207010259.GA12352@vana.vc.cvut.cz> <Pine.LNX.4.61.0412080016570.3320@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412080016570.3320@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 12:20:01AM +0100, Jesper Juhl wrote:
> On Tue, 7 Dec 2004, Petr Vandrovec wrote:
> 
> > On Tue, Dec 07, 2004 at 12:09:05AM +0100, Jesper Juhl wrote:
> > > On Mon, 6 Dec 2004, Petr Vandrovec wrote:
> > > > Correct is (if any fix is needed at all) typecast regs->esp to unsigned
> > > > long, 
> > > 
> > > That would have been my suggestion as well.
> > > 
> > > >eventually with check that address is less than (unsigned long)-32,
> > > > as area at VA 0 is not going to grow "down" to 0xFFFFFxxx, even if you
> > > > nicely ask.
> > > 
> > > you mean something like this - right?
> > 
> > Yes.  Though I believe that we already take vma == NULL path when address is that big.
> 
> Hmm, where? - maybe I'm blind or just stupid, but I don't seem to be able 
> to find where we do that.
> And would it hurt to have that additional check there as well in case 
> address was modified after the previous check and before being passed to 
> do_page_fault ? (note: I'm writing this last bit without having mined the 
> source for info yet).

If find_vma() returns NULL, it is bad_area, and no further tests occur.  Otherwise
if vma->vm_start <= address, it is good area.

Only when these two conditions are satisifed (find_vma found vma, and this vma begins
above vma's vm_start, regs->esp is checked.  And as vma->vm_start can be at most 
0xFFFFF000 (it is page aligned, and you cannot have vma at 4GB - actually you cannot 
have vma above 3GB on normal kernel, or 4GB-<whatever>MB on 4G/4G kernel), there is 
no way how 'address' could be in top 4KB, and so adding 32 to it cannot overflow 
32bit variable.

At least I believe this...
								Petr Vandrovec


