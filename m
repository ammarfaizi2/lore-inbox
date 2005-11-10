Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVKJCQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVKJCQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVKJCQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:16:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751439AbVKJCQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:16:55 -0500
Date: Wed, 9 Nov 2005 18:16:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] mm: atomic64 page counts
Message-Id: <20051109181641.4b627eee.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511100156320.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100156320.5814@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> Page count and page mapcount might overflow their 31 bits on 64-bit
>  architectures, especially now we're refcounting the ZERO_PAGE.  We could
>  quite easily avoid counting it, but shared file pages may also overflow.
> 
>  Prefer not to enlarge struct page: don't assign separate atomic64_ts to
>  count and mapcount, instead keep them both in one atomic64_t - the count
>  in the low 23 bits and the mapcount in the high 41 bits.  But of course
>  that can only work if we don't duplicate mapcount in count in this case.
> 
>  The low 23 bits can accomodate 0x7fffff, that's 2 * PID_MAX_LIMIT - 1,
>  which seems adequate for tasks with a transient hold on pages; and the
>  high 41 bits would use 16TB of page table space to back max mapcount.

hm.   I thought we were going to address this by

a) checking for an insane number of mappings of the same page in the
   pagefault handler(s) and 

b) special-casing ZERO_PAGEs on the page unallocator path.

That'll generate faster and smaller code than adding an extra shift and
possibly larger constants in lots of places.

It's cleaner, too.
