Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVJJXiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVJJXiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 19:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVJJXiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 19:38:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47356 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751094AbVJJXit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 19:38:49 -0400
Subject: Re: [PATCH] ppc highmem fix
From: Paolo Galtieri <pgaltieri@mvista.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1128986427.16630.6.camel@playin.mvista.com>
References: <1128986427.16630.6.camel@playin.mvista.com>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 16:38:49 -0700
Message-Id: <1128987529.16630.14.camel@playin.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 16:20 -0700, Paolo Galtieri wrote:
> I've noticed that the calculations for seg_size and nr_segs in
> __dma_sync_page_highmem() (arch/ppc/kernel/dma-mapping.c) are wrong.
> The incorrect calculations can result in either an oops or a panic when
> running fsck depending on the size of the partition.  The problem with
> the
> seg_size calculation is that it can result in a negative number if size
> is offset > size.  The problem with the nr_segs caculation is returns
> the
> wrong number of segments, e.g. it returns 1 when size is 200 and offset
> is 4095, when it should return 2 or more.
> 
> Here is the patch to fix the problem.
> 
> --- linux-2.6.14-rc3-git8/arch/ppc/kernel/dma-mapping.c 2005-10-10
> 13:55:37.000000000 -0700
> +++ linux-2.6.14/arch/ppc/kernel/dma-mapping.c  2005-10-10
> 13:57:51.000000000 -0700
> @@ -401,10 +401,10 @@
>  static inline void __dma_sync_page_highmem(struct page *page,
>                 unsigned long offset, size_t size, int direction)
>  {
> -       size_t seg_size = min((size_t)PAGE_SIZE, size) - offset;
> +       size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
>         size_t cur_size = seg_size;
>         unsigned long flags, start, seg_offset = offset;
> -       int nr_segs = PAGE_ALIGN(size + (PAGE_SIZE - offset))/PAGE_SIZE;
> +       int nr_segs = 1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
>         int seg_nr = 0;
> 
>         local_irq_save(flags);
> 
> 
> Paolo Galtieri (pgaltieri@mvista.com)
> 

I want to apologize in advance for the previous post.  When I included
the patch inline I dropped the tabs :-(.  Here is the correct patch with
tabs:

--- linux-2.6.14-rc3-git8/arch/ppc/kernel/dma-mapping.c	2005-10-10
13:55:37.000000000 -0700
+++ linux-2.6.14/arch/ppc/kernel/dma-mapping.c	2005-10-10
13:57:51.000000000 -0700
@@ -401,10 +401,10 @@
 static inline void __dma_sync_page_highmem(struct page *page,
 		unsigned long offset, size_t size, int direction)
 {
-	size_t seg_size = min((size_t)PAGE_SIZE, size) - offset;
+	size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
 	size_t cur_size = seg_size;
 	unsigned long flags, start, seg_offset = offset;
-	int nr_segs = PAGE_ALIGN(size + (PAGE_SIZE - offset))/PAGE_SIZE;
+	int nr_segs = 1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
 	int seg_nr = 0;
 
 	local_irq_save(flags);

Paolo

