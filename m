Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSGVFD0>; Mon, 22 Jul 2002 01:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSGVFD0>; Mon, 22 Jul 2002 01:03:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18697 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316135AbSGVFDZ>;
	Mon, 22 Jul 2002 01:03:25 -0400
Message-ID: <3D3B94AF.27A254EA@zip.com.au>
Date: Sun, 21 Jul 2002 22:14:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] low-latency zap_page_range
References: <1027196427.1116.753.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> The lock hold time in zap_page_range is horrid.
>

Yes, it is.  And although our mandate is to fix things
like this without grafted-on low latency hacks, zap_page_range()
may be one case where simply popping the lock is the best solution.
Not sure.

> ...
> +       while (size) {
> +               block = (size > ZAP_BLOCK_SIZE) ? ZAP_BLOCK_SIZE : size;
> +               end = address + block;
> +
> +               spin_lock(&mm->page_table_lock);
> +
> +               flush_cache_range(vma, address, end);
> +               tlb = tlb_gather_mmu(mm, 0);
> +               unmap_page_range(tlb, vma, address, end);
> +               tlb_finish_mmu(tlb, address, end);
> +
> +               spin_unlock(&mm->page_table_lock);
> +
> +               address += block;
> +               size -= block;
> +       }

This adds probably-unneeded extra work - we shouldn't go
dropping the lock unless that is actually required.  ie:
poll ->need_resched first.    Possible?

-
