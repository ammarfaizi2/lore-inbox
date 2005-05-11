Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVEKUMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVEKUMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVEKUMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:12:53 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:23180 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262042AbVEKUMl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:12:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bFwCo+nGkEfQJyXxtRkKS6clAxvwgEnH7Pmdnsiu7Q6RzPhpPhkzYZAC+Ivp6f0Bm19NbraHisyMUDBHQ79LmXPwM9zv7CJtyvAiz1PnmYWVfX8VcS58DVsQ+46IlVgdx3miIiAIqDycx9zSNREDWuExiiO7PJBEQWKXExfFdSw=
Message-ID: <78d18e2050511131246075b37@mail.gmail.com>
Date: Wed, 11 May 2005 16:12:41 -0400
From: William Jordan <bjordan.ics@gmail.com>
Reply-To: William Jordan <bjordan.ics@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Cc: Timur Tabi <timur.tabi@ammasso.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <Pine.LNX.4.61.0505071617470.5718@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	 <20050411171347.7e05859f.akpm@osdl.org>
	 <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com>
	 <4279142A.8050501@ammasso.com> <427A6A7E.8000604@ammasso.com>
	 <427BF8E1.2080006@ammasso.com>
	 <Pine.LNX.4.61.0505071304010.4713@goblin.wat.veritas.com>
	 <427CD49E.6080300@ammasso.com>
	 <Pine.LNX.4.61.0505071617470.5718@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/05, Hugh Dickins <hugh@veritas.com> wrote:
> > My understanding is that mlock() could in theory allow the page to be moved,
> > but that currently nothing in the kernel would actually move it.  However,
> > that could change in the future to allow hot-swapping of RAM.
> 
> That's my understanding too, that nothing currently does so.  Aside from
> hot-swapping RAM, there's also a need to be able to migrate pages around
> RAM, either to unfragment memory allowing higher-order allocations to
> succeed more often, or to get around extreme dmamem/normal-mem/highmem
> imbalances without dedicating huge reserves.  Those would more often
> succeed if uninhibited by mlock.

Hugh,

If I am reading you correctly, you are saying that mlock currently
prevents pages from migrating around to unfragment memory, but
get_user_pages does not prevent this? If this is the case, this could
very easily be the problem Timur was experiencing. He is using
get_user_pages to lock pages long term (for the life of the process,
beyond the bounds of a single system call).

If it is possible for a page to be migrated in physical memory during
extreme virtual memory pressure while the reference count is held with
get_user_pages, that would cause the problem where the hardware is no
longer mapped to the same page as the application.

BTW: In earlier kernels, I experienced the same issues in our IB
drivers when trying to pin pages using only get_user_pages.

-- 
Bill Jordan
InfiniCon Systems
