Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVAHKIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVAHKIX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 05:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVAHKH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 05:07:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29316 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261918AbVAHKEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 05:04:41 -0500
Date: Fri, 7 Jan 2005 20:12:55 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
Message-ID: <20050107221255.GA8749@logos.cnet>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 04:15:28PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 7 Jan 2005, Alan Cox wrote:
> >
> > Please don't use that for mainline - do_brk_locked doesn't follow kernel
> > convention
> 
> I agree, I also find the "do_brk_locked()" naming confusing. To me it 
> implies that we already _are_ locked, not that we're going to lock.
> 
> On the other hand, I think Alan's patch is equally confusing: the calling 
> rules for "do_brk()" and "do_mmap()" are the same, and they are "caller 
> takes mmap_sem". 
> 
> So I think you _both_ broke kernel conventions.
> 
> So I'd personally much prefer to just first fix the bug minimally (by just
> taking the lock in the two places that need it), and then _separately_ say
> "we should warn if anybody ever calls 'do_brk()' without the lock". That's 
> how we tend to verify locking in other cases, ie we have things like
> 
> 	if (!spin_is_locked(&t->sighand->siglock))
> 		BUG();
> 
> to verify the calling conventions. Same would go for mmap_sem (although we
> don't seem to have any "sem_is_writelocked()" test - although you can fake
> it with
> 
> 	if (down_read_trylock(&mm->mmap_sem))
> 		BUG();
> 
> instead.
> 
> Now _that_ is a non-silent failure mode. The machine doesn't just silently 
> deadlock: it tells you exactly what's wrong.

Only problem is that current do_brk() callers dont take the lock - you would
need a version of do_brk() that doesnt warn for them? 

But yes, the warning is better than silent failure or security problem for 
out-of-the tree users.
