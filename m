Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWGMHpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWGMHpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWGMHpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:45:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6053 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751500AbWGMHpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:45:08 -0400
Date: Thu, 13 Jul 2006 00:44:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: sekharan@us.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, arjan@infradead.org
Subject: Re: Random panics seen in 2.6.18-rc1
Message-Id: <20060713004445.cf7d1d96.akpm@osdl.org>
In-Reply-To: <20060713072635.GA907@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra>
	<20060713071221.GA31349@elte.hu>
	<20060713002803.cd206d91.akpm@osdl.org>
	<20060713072635.GA907@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 09:26:35 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > 
> > But what was that change _for_?  Presumably, to plug some lockdep 
> > problem. Which now will come back.
> 
> correct - but i first wanted to get the fix out, before trying to fix 
> the lockdep thing.

More yup.

> > And the additional arg to __cache_free() was rather a step backwards - 
> > this is fastpath.  With a bit more effort that could have been avoided 
> > (please).
> 
> yeah, i'll fix this. Any suggestions of how to avoid the parameter 
> passing? (without ugly #ifdeffery)

No, I don't see a way apart from inlining __cache_free(), or inlining
cache_free_alien() into both kfree() and kmem_cache_free(), both of which
are unattractive.

Well.  One could do

	local_irq_disable();
	cachep->array[smp_processor_id()]->lockdep_nested = 1;
	__cache_free(...)
	cachep->array[smp_processor_id()]->lockdep_nested = 0;
	local_irq_enable();

then do lots of ifdeffery to make that go away if !LOCKDEP.  But sheesh.
