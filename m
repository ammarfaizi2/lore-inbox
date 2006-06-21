Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWFUUNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWFUUNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWFUUNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:13:04 -0400
Received: from kevlar.burdell.org ([66.92.73.214]:8626 "EHLO
	kevlar.burdell.org") by vger.kernel.org with ESMTP id S1751355AbWFUUND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:13:03 -0400
Date: Wed, 21 Jun 2006 16:12:58 -0400
From: Sonny Rao <sonny@burdell.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, anton@samba.org
Subject: Re: Possible bug in do_execve()
Message-ID: <20060621201258.GB10052@kevlar.burdell.org>
References: <20060620022506.GA3673@kevlar.burdell.org> <20060621184129.GB16576@sergelap.austin.ibm.com> <20060621185508.GA9234@kevlar.burdell.org> <20060621190910.GC16576@sergelap.austin.ibm.com> <20060621192726.GA10052@kevlar.burdell.org> <20060621194250.GD16576@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621194250.GD16576@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 02:42:50PM -0500, Serge E. Hallyn wrote:
> Quoting Sonny Rao (sonny@burdell.org):
> > On Wed, Jun 21, 2006 at 02:09:10PM -0500, Serge E. Hallyn wrote:
> > <snip>
> > > > Yeah, I proposed a similar patch to Anton, and it would quiet the
> > > > warning on powerpc, but that's not the point.  It happens that powerpc
> > > > doesn't use 0 as a context id, but that may not be true on another
> > > > architecture.  That's really what I'm concerned about.
> > > 
> > > FWIW, ppc and cris do the NO_CONTEXT check, while others don't
> > > even have a arch-specific 'mm->context.id'.
> > 
> > Good point.  I probably stated that concern too narrowly.  Probably
> > what I should say is: What is the pre-condition for calling
> > destroy_context() ?  Is it that init_new_context() must have
> > succeeded?  Or is it merely that mm.context has been zeroed
> > out?
> 
> Right, that may be the right question.  If that's the case, then the
> problem is really include/linux/sched.h:__mmdrop() which is what's
> calling destroy_context().  Separating that out becomes a pretty
> big patch affecting at least all mmput() and mmdrop() callers.

So mmdrop() inlines to an atomic_dec_and_test on mm_count and a call
to __mmdrop which makes three calls : mm_free_pgd(), destroy_context(),
and free_mm().  I _think_ that in this case __mmdrop() will always get
called.

We know that the destroy_context() is unnecessary, but mm_free_pgd()
and free_mm() are necessary.

I was thinking we _could_ open code these calls in exec.c but that seems
like a "Really Bad Idea" w.r.t abstraction/maintenance etc,
and the alternative is to make another function/macro just for this
special case, which also seems like a poor choice.

> > It seems to assume that mm->context is valid before doing a check.
> > 
> > Since I don't have a sparc64 box, I can't check to see if this
> > actually breaks things or not.
> 
> So we can either go through all arch's and make sure destroy_context is
> safe for invalid context, or split mmput() and destroy_context()...
> 
> The former seems easier, but the latter seems more robust in the face of
> future code changes I guess.

Yes, the former does seem easier, and perhaps easiest is to do that
and document what the pre-conditions are so future developers at least
have a clue.
