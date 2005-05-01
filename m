Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVEAUWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVEAUWh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 16:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVEAUWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 16:22:37 -0400
Received: from mail.dif.dk ([193.138.115.101]:26583 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262659AbVEAUWb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 16:22:31 -0400
Date: Sun, 1 May 2005 22:26:01 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2
In-Reply-To: <20050501201145.GA14429@ime.usp.br>
Message-ID: <Pine.LNX.4.62.0505012224350.2488@dragon.hyggekrogen.localhost>
References: <20050501201145.GA14429@ime.usp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2005, Rogério Brito wrote:

> Hi, Andrew. Hi, Ben.
> I've been trying to compile kernel 2.6.12-rc3-mm2 on my PowerMac 9500 with
> a G3 upgrade card (it's an OldWorld machine) and I get compilation errors
> with Debian's gcc-3.4 (3.4.4 20050314 (prerelease) (Debian 3.4.3-12)),
> available in testing.
> Here is the error that I get:
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>   CC      fs/partitions/check.o
>   CC      fs/partitions/mac.o
>   CC      fs/partitions/msdos.o
>   LD      fs/partitions/built-in.o
>   CC      fs/proc/mmu.o
>   CC      fs/proc/task_mmu.o
> fs/proc/task_mmu.c: In function `smaps_pte_range':
> fs/proc/task_mmu.c:177: warning: implicit declaration of function `kmap_atomic'
> fs/proc/task_mmu.c:177: error: `KM_PTE0' undeclared (first use in this function)
> fs/proc/task_mmu.c:177: error: (Each undeclared identifier is reported only once
> fs/proc/task_mmu.c:177: error: for each function it appears in.)
> fs/proc/task_mmu.c:207: warning: implicit declaration of function `kunmap_atomic'
> make[3]: *** [fs/proc/task_mmu.o] Error 1
> make[2]: *** [fs/proc] Error 2
> make[1]: *** [fs] Error 2
> make[1]: Leaving directory `/home/rbrito/src/linux'
> make: *** [stamp-build] Error 2
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

I recently posted this patch in another thread, give it a try : 

--- linux-2.6.12-rc3-mm2-orig/fs/proc/task_mmu.c	2005-05-01 04:04:25.000000000 +0200
+++ linux-2.6.12-rc3-mm2/fs/proc/task_mmu.c	2005-05-01 17:49:14.000000000 +0200
@@ -2,6 +2,7 @@
 #include <linux/hugetlb.h>
 #include <linux/mount.h>
 #include <linux/seq_file.h>
+#include <linux/highmem.h>
 
 #include <asm/elf.h>
 #include <asm/uaccess.h>
@@ -204,7 +205,7 @@ static void smaps_pte_range(pmd_t *pmd,
 			}
 		}
 	} while (address < end);
-	pte_unmap(pte);
+	pte_unmap((void *)pte);
 }
 
 static void smaps_pmd_range(pud_t *pud,


