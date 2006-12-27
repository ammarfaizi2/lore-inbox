Return-Path: <linux-kernel-owner+w=401wt.eu-S932822AbWL0Nws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbWL0Nws (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 08:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbWL0Nws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 08:52:48 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:8997 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932825AbWL0Nwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 08:52:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gJgPXZrrWMRHass984paggDOoVTwxWCk8A3i1saTG35XHkUcminU0+T3zXx0+B1bjEJJGr2K9bY5lZGlvU8X60S28BYEC+X228NiULW8aQHER2k5uuyMqKohnUpVqw3CypLclOOYc/f6LWwxpcvsus2rpwUJY2HHqOdOGRUldK8=
Message-ID: <b0943d9e0612270552n4a612103u5a5dafabeaec7ae5@mail.gmail.com>
Date: Wed, 27 Dec 2006 13:52:46 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061218072932.GA5624@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu>
	 <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com>
	 <20061218072932.GA5624@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > I could also use a simple allocator based on alloc_pages [...]
> > [...] It could be so simple that it would never need to free any
> > pages, just grow the size as required and reuse the freed memleak
> > objects from a list.
>
> sounds good to me. Please make it a per-CPU pool. We'll have to fix the
> locking too, to be per-CPU - memleak_lock is quite a scalability problem
> right now. (Add a memleak_object->cpu pointer so that freeing can be
> done on any other CPU as well.)

I did some simple statistics about allocations happening on one CPU
and freeing on a different one. On a 4-CPU ARM system (and without IRQ
balancing and without CONFIG_PREEMPT), these seem to happen in about
8-10% of the cases. Do you expect higher figures on other
systems/configurations?

As I mentioned in a different e-mail, a way to remove the global hash
table is to create per-cpu hashes. The only problem is that in these
8-10% of the cases, freeing would need to look up the other hashes.
This would become a problem with a high number of CPUs but I'm not
sure whether it would overtake the performance issues introduced by
cacheline ping-ponging in the single-hash case.

Any thoughts?

Thanks.

-- 
Catalin
