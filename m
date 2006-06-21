Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbWFUTni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbWFUTni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWFUTni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:43:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46277 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932719AbWFUTng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:43:36 -0400
Date: Wed, 21 Jun 2006 14:42:50 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Sonny Rao <sonny@burdell.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, anton@samba.org
Subject: Re: Possible bug in do_execve()
Message-ID: <20060621194250.GD16576@sergelap.austin.ibm.com>
References: <20060620022506.GA3673@kevlar.burdell.org> <20060621184129.GB16576@sergelap.austin.ibm.com> <20060621185508.GA9234@kevlar.burdell.org> <20060621190910.GC16576@sergelap.austin.ibm.com> <20060621192726.GA10052@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621192726.GA10052@kevlar.burdell.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sonny Rao (sonny@burdell.org):
> On Wed, Jun 21, 2006 at 02:09:10PM -0500, Serge E. Hallyn wrote:
> <snip>
> > > Yeah, I proposed a similar patch to Anton, and it would quiet the
> > > warning on powerpc, but that's not the point.  It happens that powerpc
> > > doesn't use 0 as a context id, but that may not be true on another
> > > architecture.  That's really what I'm concerned about.
> > 
> > FWIW, ppc and cris do the NO_CONTEXT check, while others don't
> > even have a arch-specific 'mm->context.id'.
> 
> Good point.  I probably stated that concern too narrowly.  Probably
> what I should say is: What is the pre-condition for calling
> destroy_context() ?  Is it that init_new_context() must have
> succeeded?  Or is it merely that mm.context has been zeroed
> out?

Right, that may be the right question.  If that's the case, then the
problem is really include/linux/sched.h:__mmdrop() which is what's
calling destroy_context().  Separating that out becomes a pretty
big patch affecting at least all mmput() and mmdrop() callers.

> Here's destroy context on sparc64:
> 
> void destroy_context(struct mm_struct *mm)
> {
>         unsigned long flags, i;
> 
>         for (i = 0; i < MM_NUM_TSBS; i++)
>                 tsb_destroy_one(&mm->context.tsb_block[i]);
> 
>         spin_lock_irqsave(&ctx_alloc_lock, flags);
> 
>         if (CTX_VALID(mm->context)) {
>                 unsigned long nr = CTX_NRBITS(mm->context);
>                 mmu_context_bmap[nr>>6] &= ~(1UL << (nr & 63));
>         }
> 
>         spin_unlock_irqrestore(&ctx_alloc_lock, flags);
> }
> 
> It seems to assume that mm->context is valid before doing a check.
> 
> Since I don't have a sparc64 box, I can't check to see if this
> actually breaks things or not.

So we can either go through all arch's and make sure destroy_context is
safe for invalid context, or split mmput() and destroy_context()...

The former seems easier, but the latter seems more robust in the face of
future code changes I guess.

-serge
