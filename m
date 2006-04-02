Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWDBF0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWDBF0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 00:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWDBF0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 00:26:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750801AbWDBF0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 00:26:23 -0500
Date: Sat, 1 Apr 2006 21:25:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: vatsa@in.ibm.com, mingo@elte.hu, suresh.b.siddha@intel.com,
       dino@in.ibm.com, pj@sgi.com, hawkes@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2 1/4] sched_domain - handle kmalloc failure
Message-Id: <20060401212533.61a02f9d.akpm@osdl.org>
In-Reply-To: <442F2A79.1040903@yahoo.com.au>
References: <20060401185222.GA10591@in.ibm.com>
	<442F2A79.1040903@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Srivatsa Vaddagiri wrote:
> > Andrew/Nick/Ingo,
> > 	Here's a different version of the patch that tries to handle mem
> > allocation failures in build_sched_domains by bailing out and cleaning up 
> > thus-far allocated memory. The patch has a direct consequence that we disable 
> > load balancing completely (even at sibling level) upon *any* memory allocation 
> > failure. Is that acceptable?
> > 
> 
> I guess so. Ideal solution would be to make all required allocations first,
> then fail the build_sched_domains and fall back to the old structure.

I'd have thought so.

> But
> I guess that gets pretty complicated.

Maybe.  Sometimes it's just a matter of running the code twice - first pass
is allocate-stuff mode, second pass is use-stuff mode.

> In reality (and after your patch 2/4), I don't think the page allocator will
> ever fail any of these allocations.

That is presently true, as long as the amounts being allocated are small
enough.

> In that case, would it be simpler just
> to add a __GFP_NOFAIL here and forget about it?

No new __GFP_NOFAILs, please.

The fact that the CPU addition will succeed, but it'll run forever more
with load balancing disabled still seems Just Wrong to me.  We should
either completely succeed or completely fail.
