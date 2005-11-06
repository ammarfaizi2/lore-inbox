Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVKFW5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVKFW5V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVKFW5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:57:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750789AbVKFW5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:57:20 -0500
Date: Sun, 6 Nov 2005 14:57:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: hugh@veritas.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
Message-Id: <20051106145710.0af9bb63.akpm@osdl.org>
In-Reply-To: <20051106112838.0d524f65.akpm@osdl.org>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
	<20051106112838.0d524f65.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  Hugh Dickins <hugh@veritas.com> wrote:
>  >
>  > The split ptlock patch enlarged the default SMP PREEMPT struct page from
>  > 32 to 36 bytes on most 32-bit platforms, from 32 to 44 bytes on PA-RISC
>  > 7xxx (without PREEMPT).  That was not my intention, and I don't believe
>  > that split ptlock deserves any such slice of the user's memory.
>  > 
>  > While leaving most of the page_private() mods in place for the moment,
>  > could we please try this patch, or something like it?  Again to overlay
>  > the spinlock_t from &page->private onwards, with corrected BUILD_BUG_ON
>  > that we don't go beyond ->lru; with poisoning of the fields overlaid,
>  > and unsplit config verifying that the split config is safe to use them.
>  > 
> 
>  This patch makes the ppc64 crash.  See
>  http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02976.jpg
> 
>  I don't know what the access address was (ia32 nicely tells you), but if
>  it's `DAR' then we have LIST_POISON1.  Which would indicate that the slab
>  page which backs the mm_struct itself is getting freed-up-pte-page
>  treatment, which is deeply screwed up.
> 
>  I'll try it on x86_64 and ia64, see if it's specific to ppc64.

Yup, the patch works OK on x86, x86_64 and ia64.
