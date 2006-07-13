Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWGMHrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWGMHrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWGMHrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:47:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:678 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751503AbWGMHrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:47:06 -0400
Date: Thu, 13 Jul 2006 00:47:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix oom roll-back of __vmalloc_area_node
Message-Id: <20060713004704.6271db85.akpm@osdl.org>
In-Reply-To: <44B5F87E.6020708@web.de>
References: <44B3FDE4.4040209@web.de>
	<20060713001433.801fa304.akpm@osdl.org>
	<44B5F87E.6020708@web.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 09:38:38 +0200
Jan Kiszka <jan.kiszka@web.de> wrote:

> > I think the change would be a good one even if it didn't fix a bug, thanks.
> >
> >   
> Meanwhile I thought about an even simpler solution:
> 
> 
> __vunmap must not rely on area->nr_pages when picking the
> release methode for area->pages. It may be too small when
> __vmalloc_area_node failed due to lacking memory. Check
> for the vmalloc address range instead.
> 
> Signed-off by: Jan Kiszka <jan.kiszka@web.de>
> 
> Index: linux-2.6/mm/vmalloc.c
> ===================================================================
> --- linux-2.6.orig/mm/vmalloc.c
> +++ linux-2.6/mm/vmalloc.c
> @@ -340,7 +340,7 @@ void __vunmap(void *addr, int deallocate
>  			__free_page(area->pages[i]);
>  		}
>  
> -		if (area->nr_pages > PAGE_SIZE/sizeof(struct page *))
> +		if (area->pages >= VMALLOC_START && area->pages < VMALLOC_END)
>  			vfree(area->pages);
>  		else
>  			kfree(area->pages);

Nah, your first patch was better.  Very clear, direct, explicit.

It even had a comment.
