Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVCCCUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVCCCUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVCCCSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:18:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39304 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261393AbVCCCOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:14:15 -0500
Date: Wed, 2 Mar 2005 18:13:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
In-Reply-To: <20050302174507.7991af94.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
 <20050302174507.7991af94.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Andrew Morton wrote:

> > -	if (!PageReserved(old_page))
> > -		page_cache_get(old_page);
>
> hm, this seems to be an unrelated change.  You're saying that this page is
> protected from munmap() by munmap()'s down_write(mmap_sem), yes?  What
> stops memory reclaim from freeing old_page?

This is a related change discussed during V16 with Nick.

The page is protected from munmap because of the down_read(mmap_sem) in
the arch specific code before calling handle_mm_fault.

> > -	mark_page_accessed(page);
> > +	SetPageReferenced(page);
>
> Another unrelated change.  IIRC, this is indeed equivalent, but I forget
> why.  Care to remind me?

Seems that mark_page_accessed was discouraged in favor SetPageReferenced.
We agreed that we wanted this change earlier (I believe that was in
November?).

> Overall, do we know which architectures are capable of using this feature?
> Would ppc64 (and sparc64?) still have a problem with page_table_lock no
> longer protecting their internals?

That is up to the arch maintainers. Add something to arch/xx/Kconfig to
allow atomic operations for an arch. Out of the box it only works for
x86_64, ia64 and ia32.

> I'd really like to see other architecture maintainers stand up and say
> "yes, we need this".

You definitely need this for machines with high SMP counts.

> Did you consider doing the locking at the pte page level?  That could be
> neater than all those games with atomic pte operattions.

Earlier releases back in September 2004 had some pte locking code (and
AFAIK Nick also played around with pte locking) but that
was less efficient than atomic operations.
