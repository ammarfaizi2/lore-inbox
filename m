Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVEPUPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVEPUPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVEPULy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:11:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:11187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261849AbVEPUKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:10:16 -0400
Date: Mon, 16 May 2005 13:09:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2, alpha and mips broke
Message-Id: <20050516130919.306a12ba.akpm@osdl.org>
In-Reply-To: <4288DC6D.1020606@ppp0.net>
References: <20050516021302.13bd285a.akpm@osdl.org>
	<4288DC6D.1020606@ppp0.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <jdittmer@ppp0.net> wrote:
>
> Comparing 2.6.12-rc4-mm1 to 2.6.12-rc4-mm2 (defconfig)
> ======================================================
> 
> - alpha: broke
>     AR      arch/alpha/lib/lib.a
>     GEN     .version
>     CHK     include/linux/compile.h
>     UPD     include/linux/compile.h
>     CC      init/version.o
>     LD      init/built-in.o
>     LD      .tmp_vmlinux1
>   mm/built-in.o(.text+0xe79c):/usr/src/ctest/mm/kernel/mm/slab.c:339: undefined reference to `__bad_size'
>   mm/built-in.o(.text+0xe7a0):/usr/src/ctest/mm/kernel/mm/slab.c:339: undefined reference to `__bad_size'
>   make[1]: *** [.tmp_vmlinux1] Error 1
>   make: *** [_all] Error 2
> 

argh, I forgot to add the patch to the series file, sorry.


From: Andrew Morton <akpm@osdl.org>

This doesn't work (on alpha, at least).

It's not inside __builtin_constant_p() so the compiler cannot be sure that all
the possible sizes have been checked for.

Cc: Christoph Lameter <clameter@engr.sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/slab.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff -puN mm/slab.c~numa-aware-slab-allocator-v3-__bad_size-fix mm/slab.c
--- 25-alpha/mm/slab.c~numa-aware-slab-allocator-v3-__bad_size-fix	2005-05-15 22:25:33.000000000 -0700
+++ 25-alpha-akpm/mm/slab.c	2005-05-15 22:30:10.000000000 -0700
@@ -325,7 +325,8 @@ struct kmem_list3 __initdata initkmem_li
  */
 static inline int index_of(const size_t size)
 {
-	int i = 0;
+	if (__builtin_constant_p(size)) {
+		int i = 0;
 
 #define CACHE(x) \
 	if (size <=x) \
@@ -334,11 +335,12 @@ static inline int index_of(const size_t 
 		i++;
 #include "linux/kmalloc_sizes.h"
 #undef CACHE
-	{
-		extern void __bad_size(void);
-		__bad_size();
-		return 0;
+		{
+			extern void __bad_size(void);
+			__bad_size();
+		}
 	}
+	return 0;
 }
 
 #define INDEX_AC index_of(sizeof(struct array_cache))
_

> 
> - mips: broke
>     CC      mm/mempool.o
>     CC      mm/oom_kill.o
>     CC      mm/fadvise.o
>     CC      mm/page_alloc.o
>     CC      mm/page-writeback.o
>     CC      mm/pdflush.o
>     CC      mm/readahead.o
>     CC      mm/slab.o
>   mm/slab.c:117:2: #error "Broken Configuration: CONFIG_NUMA not set but MAX_NUMNODES !=1 !!"
>   make[1]: *** [mm/slab.o] Error 1
>   make: *** [mm] Error 2
> 

OK, Christoph is scratching his head over that one.
