Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVEAWru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVEAWru (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVEAWru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:47:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:19918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261297AbVEAWr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 18:47:28 -0400
Date: Sun, 1 May 2005 15:46:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: sneakums@zork.net, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: 2.6.12-rc3-mm2: ppc pte_offset_map()
Message-Id: <20050501154654.2bf7606d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505011749280.2488@dragon.hyggekrogen.localhost>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<6uu0lnf0gm.fsf@zork.zork.net>
	<Pine.LNX.4.62.0505011749280.2488@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> On Sun, 1 May 2005, Sean Neakums wrote:
> 
> > On my Mackertosh (PowerBook5.4), build fails with the following:
> > 
> >   fs/proc/task_mmu.c: In function `smaps_pte_range':
> >   fs/proc/task_mmu.c:177: warning: implicit declaration of function `kmap_atomic'
> >   fs/proc/task_mmu.c:177: error: `KM_PTE0' undeclared (first use in this function)
> >   fs/proc/task_mmu.c:177: error: (Each undeclared identifier is reported only once
> >   fs/proc/task_mmu.c:177: error: for each function it appears in.)
> >   fs/proc/task_mmu.c:207: warning: implicit declaration of function `kunmap_atomic'
> > 
> > With the naive patch below, it builds with this warning and everything works.
> > 
> >   fs/proc/task_mmu.c: In function `smaps_pte_range':
> >   fs/proc/task_mmu.c:208: warning: passing arg 1 of `kunmap_atomic' makes pointer from integer without a cast
> > 
> 
> Try this patch :
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> --- linux-2.6.12-rc3-mm2-orig/fs/proc/task_mmu.c	2005-05-01 04:04:25.000000000 +0200
> +++ linux-2.6.12-rc3-mm2/fs/proc/task_mmu.c	2005-05-01 17:49:14.000000000 +0200
> @@ -2,6 +2,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/mount.h>
>  #include <linux/seq_file.h>
> +#include <linux/highmem.h>
>  
>  #include <asm/elf.h>
>  #include <asm/uaccess.h>
> @@ -204,7 +205,7 @@ static void smaps_pte_range(pmd_t *pmd,
>  			}
>  		}
>  	} while (address < end);
> -	pte_unmap(pte);
> +	pte_unmap((void *)pte);
>  }

Should be

	pte_unmap(ptep);


