Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVD0AGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVD0AGB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 20:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVD0AGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 20:06:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:52878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261855AbVD0AFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 20:05:48 -0400
Date: Tue, 26 Apr 2005 17:05:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: libor@topspin.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, timur.tabi@ammasso.com
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
Message-Id: <20050426170513.33b81f76.akpm@osdl.org>
In-Reply-To: <521x8xs04v.fsf@topspin.com>
References: <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
	<20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com>
	<20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com>
	<20050425171145.2f0fd7f8.akpm@osdl.org>
	<52acnmtmh6.fsf@topspin.com>
	<20050425173757.1dbab90b.akpm@osdl.org>
	<52wtqpsgff.fsf@topspin.com>
	<20050426084234.A10366@topspin.com>
	<52mzrlsflu.fsf@topspin.com>
	<20050426122850.44d06fa6.akpm@osdl.org>
	<5264y9s3bs.fsf@topspin.com>
	<20050426133229.416a5e66.akpm@osdl.org>
	<521x8xs04v.fsf@topspin.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
>     Andrew> Well I was vaguely proposing that the userspace library
>     Andrew> keep track of the byteranges and the underlying page
>     Andrew> states.  So in the above scenario userspace would leave
>     Andrew> the page at 0x1000 registered until all registrations
>     Andrew> against that page have been undone.
> 
> OK, I already have code in userspace that keeps reference counts for
> overlapping regions, etc.  However I'm not sure how to tie this in
> with reliable accounting of pinned memory -- we don't want malicious
> userspace code to be able fool the accounting, right?
> 
> So I'm still trying to puzzle out what to do.  I don't want to keep a
> complicated data structure in the kernel keeping track of what memory
> has been registered.  Right now, I just keep a list of structs, one
> for each region, and when a process dies, I just go through region by
> region and do a put_page() to balance off the get_user_pages().
> 
> However I don't see how to make it work if I put the reference
> counting for overlapping regions in userspace but when I want mlock()
> accounting in the kernel.  If a buggy/malicious app does:
> 
>     a) register from 0x0000 to 0x2fff
>     b) register from 0x1000 to 0x1fff
>     c) unregister from 0x0000 to 0x2fff

As far as the kernel is concerned, step b) should be a no-op.  (The kernel
might choose to split the vma, but that's not significant).

> then it seems the kernel is screwed unless it counts how many times a
> vma has been pinned.  And adding a pin_count member to vm_struct seems
> like a pretty damn major step.
> 
> We definitely have to make sure that userspace is never able to either
> unpin a page that is still registered with RDMA hardware, because that
> can lead to DMA to into memory that someone else owns.  On the other
> hand, we don't want userspace to be able to defeat resource accounting
> by tricking the kernel into keeping page_count elevated after it
> credits the memory back to a process's limit on locked pages.

The kernel can simply register and unregister ranges for RDMA.  So
effectively a particular page is in either the registered or unregistered
state.  Kernel accounting counts the number of registered pages and
compares this with rlimits.

On top of all that, your userspace library needs to keep track of when
pages should really be registered and unregistered with the kernel.  Using
overlap logic and per-page refcounting or whatever.

No?
