Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135963AbREBVAV>; Wed, 2 May 2001 17:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135964AbREBVAD>; Wed, 2 May 2001 17:00:03 -0400
Received: from zeus.kernel.org ([209.10.41.242]:7305 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135998AbREBU45>;
	Wed, 2 May 2001 16:56:57 -0400
Date: Wed, 2 May 2001 21:52:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Maintaniner on duty <hugh@norma.kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Both 2.4.4aa2 and 2.4.4aa3 fail to compile
Message-ID: <20010502215227.Q1162@athlon.random>
In-Reply-To: <200105020124.f421OIG01555@norma.kjist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105020124.f421OIG01555@norma.kjist.ac.kr>; from hugh@norma.kjist.ac.kr on Wed, May 02, 2001 at 10:24:18AM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 10:24:18AM +0900, Maintaniner on duty wrote:
> 
> With gcc-2.95.2 provided by SuSE-7.0 for Alpha on UP2000 SMP with 2GB memory
> 
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8 -mcpu=ev6 -Wa,-mev6    -c -o extable.o extable.c
> extable.c: In function `search_exception_table_without_gp':
> extable.c:54: `modlist_lock' undeclared (first use in this function)
> extable.c:54: (Each undeclared identifier is reported only once
> extable.c:54: for each function it appears in.)
> make[2]: *** [extable.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/arch/alpha/mm'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux/arch/alpha/mm'
> make: *** [_dir_arch/alpha/mm] Error 2

Sorry for that, please try this incremental patch (also for Alan) [it
didn't triggered because you know I don't use modules on my 2G alpha]:

--- 2.4.4aa3/arch/alpha/mm/extable.c.~1~	Tue May  1 13:30:02 2001
+++ 2.4.4aa3/arch/alpha/mm/extable.c	Wed May  2 21:40:49 2001
@@ -46,6 +46,7 @@
 	ret = search_one_table(__start___ex_table, __stop___ex_table - 1,
 			       addr - gp);
 #else
+	extern spinlock_t modlist_lock;
 	unsigned long flags;
 	/* The kernel is the last "module" -- no need to treat it special. */
 	struct module *mp;
@@ -76,15 +77,23 @@
 			       addr - exc_gp);
 	if (ret) return ret;
 #else
+	extern spinlock_t modlist_lock;
+	unsigned long flags;
 	/* The kernel is the last "module" -- no need to treat it special. */
 	struct module *mp;
+
+	ret = 0;
+	spin_lock_irqsave(&modlist_lock, flags);
 	for (mp = module_list; mp ; mp = mp->next) {
-		if (!mp->ex_table_start)
+		if (!mp->ex_table_start || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr - exc_gp);
-		if (ret) return ret;
+		if (ret)
+			break;
 	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+	if (ret) return ret;
 #endif
 
 	/*

Also note that none 2.4 kernel will ever run stable on a alpha if
compiled with 2.95.*, you _must_ use egcs 1.1.2 or the very latest 2.96
with two houndred patches if you want to have a chance to run a 2.4
kernel stable on an alpha (NOTE: only on the alpha, x86 and other
architectures are a completly different matter). So I have to reject any
(runtime) bugreport of 2.4 alpha kernels compiled with any 2.95.*, sorry.

Andrea
