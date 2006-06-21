Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbWFUT1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbWFUT1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWFUT1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:27:31 -0400
Received: from kevlar.burdell.org ([66.92.73.214]:60337 "EHLO
	kevlar.burdell.org") by vger.kernel.org with ESMTP id S932686AbWFUT1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:27:30 -0400
Date: Wed, 21 Jun 2006 15:27:26 -0400
From: Sonny Rao <sonny@burdell.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, anton@samba.org
Subject: Re: Possible bug in do_execve()
Message-ID: <20060621192726.GA10052@kevlar.burdell.org>
References: <20060620022506.GA3673@kevlar.burdell.org> <20060621184129.GB16576@sergelap.austin.ibm.com> <20060621185508.GA9234@kevlar.burdell.org> <20060621190910.GC16576@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621190910.GC16576@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 02:09:10PM -0500, Serge E. Hallyn wrote:
<snip>
> > Yeah, I proposed a similar patch to Anton, and it would quiet the
> > warning on powerpc, but that's not the point.  It happens that powerpc
> > doesn't use 0 as a context id, but that may not be true on another
> > architecture.  That's really what I'm concerned about.
> 
> FWIW, ppc and cris do the NO_CONTEXT check, while others don't
> even have a arch-specific 'mm->context.id'.

Good point.  I probably stated that concern too narrowly.  Probably
what I should say is: What is the pre-condition for calling
destroy_context() ?  Is it that init_new_context() must have
succeeded?  Or is it merely that mm.context has been zeroed
out?

Here's destroy context on sparc64:

void destroy_context(struct mm_struct *mm)
{
        unsigned long flags, i;

        for (i = 0; i < MM_NUM_TSBS; i++)
                tsb_destroy_one(&mm->context.tsb_block[i]);

        spin_lock_irqsave(&ctx_alloc_lock, flags);

        if (CTX_VALID(mm->context)) {
                unsigned long nr = CTX_NRBITS(mm->context);
                mmu_context_bmap[nr>>6] &= ~(1UL << (nr & 63));
        }

        spin_unlock_irqrestore(&ctx_alloc_lock, flags);
}

It seems to assume that mm->context is valid before doing a check.

Since I don't have a sparc64 box, I can't check to see if this
actually breaks things or not.

