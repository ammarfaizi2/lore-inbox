Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310214AbSCSGbk>; Tue, 19 Mar 2002 01:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310223AbSCSGba>; Tue, 19 Mar 2002 01:31:30 -0500
Received: from ccs.covici.com ([209.249.181.196]:19585 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S310214AbSCSGb0>;
	Tue, 19 Mar 2002 01:31:26 -0500
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6 PPP deflate breakage on UP
In-Reply-To: <200203101643.RAA02302@harpo.it.uu.se>
From: John Covici <covici@ccs.covici.com>
Date: Tue, 19 Mar 2002 01:31:20 -0500
Message-ID: <m3k7s9f4qv.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1.90
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch also works, but may not be the most elegant in the
world.

--- ppp_deflate.c.orig	Mon Mar 18 03:42:05 2002
+++ ppp_deflate.c	Mon Mar 18 12:28:48 2002
@@ -41,6 +41,8 @@
 #include <linux/ppp-comp.h>
 
 #include <linux/zlib.h>
+#include <asm/softirq.h>
+extern asmlinkage void do_softirq();
 
 static spinlock_t comp_free_list_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(comp_free_list);

on Sun, 10 Mar 2002 17:43:43 +0100 (MET) Mikael Pettersson <mikpe@csd.uu.se> wrote:

> In kernel 2.5.6, PPP deflate isn't compiled correctly if CONFIG_SMP
> is off: the macros local_bh_enable() and local_bh_disable() aren't
> expanded and instead turn into references to undefined functions.
> The problem is that <linux/smp_lock.h> is insufficient in UP configs.
>
> The patch below adds an #include <linux/interrupt.h> which works
> around this. I'm not sure about <linux/smp_lock.h>: it really doesn't
> look appropriate for the locking primitives being used in ppp_deflate.c.
>
> /Mikael
>
> --- linux-2.5.6/drivers/net/ppp_deflate.c.~1~	Sat Mar  9 12:53:13 2002
> +++ linux-2.5.6/drivers/net/ppp_deflate.c	Sun Mar 10 14:32:04 2002
> @@ -35,6 +35,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/smp_lock.h>
>  
>  #include <linux/ppp_defs.h>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
         John Covici
         covici@ccs.covici.com
