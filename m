Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVECWFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVECWFc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVECWFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:05:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:62127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261846AbVECWFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:05:04 -0400
Date: Tue, 3 May 2005 15:04:48 -0700
From: cliff white <cliffw@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, sneakums@zork.net,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       =?ISO-8859-1?Q?Rog?= =?ISO-8859-1?Q?=E9rio?= Brito 
	<rbrito@ime.usp.br>
Subject: Re: 2.6.12-rc3-mm2: ppc pte_offset_map()
Message-ID: <20050503150448.651bf748@es175>
In-Reply-To: <Pine.LNX.4.62.0505020054351.2488@dragon.hyggekrogen.localhost>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<6uu0lnf0gm.fsf@zork.zork.net>
	<Pine.LNX.4.62.0505011749280.2488@dragon.hyggekrogen.localhost>
	<20050501154654.2bf7606d.akpm@osdl.org>
	<Pine.LNX.4.62.0505020054351.2488@dragon.hyggekrogen.localhost>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005 01:01:11 +0200 (CEST)
Jesper Juhl <juhl-lkml@dif.dk> wrote:

> On Sun, 1 May 2005, Andrew Morton wrote:
> 
> > Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > >
> > > On Sun, 1 May 2005, Sean Neakums wrote:
> > > 
> > > > On my Mackertosh (PowerBook5.4), build fails with the following:
> > > > 
> > > >   fs/proc/task_mmu.c: In function `smaps_pte_range':
> > > >   fs/proc/task_mmu.c:177: warning: implicit declaration of function `kmap_atomic'
> > > >   fs/proc/task_mmu.c:177: error: `KM_PTE0' undeclared (first use in this function)
> > > >   fs/proc/task_mmu.c:177: error: (Each undeclared identifier is reported only once
> > > >   fs/proc/task_mmu.c:177: error: for each function it appears in.)
> > > >   fs/proc/task_mmu.c:207: warning: implicit declaration of function `kunmap_atomic'
> > > > 
> > > > With the naive patch below, it builds with this warning and everything works.
> > > > 
> > > >   fs/proc/task_mmu.c: In function `smaps_pte_range':
> > > >   fs/proc/task_mmu.c:208: warning: passing arg 1 of `kunmap_atomic' makes pointer from integer without a cast
> > > > 
> > > 
> > > Try this patch :
> > > 
> > > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> > > 
> > > --- linux-2.6.12-rc3-mm2-orig/fs/proc/task_mmu.c	2005-05-01 04:04:25.000000000 +0200
> > > +++ linux-2.6.12-rc3-mm2/fs/proc/task_mmu.c	2005-05-01 17:49:14.000000000 +0200
> > > @@ -2,6 +2,7 @@
> > >  #include <linux/hugetlb.h>
> > >  #include <linux/mount.h>
> > >  #include <linux/seq_file.h>
> > > +#include <linux/highmem.h>
> > >  
> > >  #include <asm/elf.h>
> > >  #include <asm/uaccess.h>
> > > @@ -204,7 +205,7 @@ static void smaps_pte_range(pmd_t *pmd,
> > >  			}
> > >  		}
> > >  	} while (address < end);
> > > -	pte_unmap(pte);
> > > +	pte_unmap((void *)pte);
> > >  }
> > 
> > Should be
> > 
> > 	pte_unmap(ptep);
> > 
> Of course, stupid me. I should have seen the 
> 	[...]
>         ptep = pte_offset_map(pmd, address);
> 	[...]
>             pte = *ptep;
>             address += PAGE_SIZE;
>             ptep++;
> 	[...]
> bit a few lines above. Guess I should have spend more than 2min creating 
> the patch.
> 
> Thanks.
> 
> Here's an updated patch.

Works for me on iBook, G4. Compiles fine and boots. No performance info yet.
Thanks bunches 
cliffw

> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> --- linux-2.6.12-rc3-mm2-orig/fs/proc/task_mmu.c	2005-05-01 04:04:25.000000000 +0200
> +++ linux-2.6.12-rc3-mm2/fs/proc/task_mmu.c	2005-05-02 00:59:11.000000000 +0200
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
> +	pte_unmap(ptep);
>  }
>  
>  static void smaps_pmd_range(pud_t *pud,
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
