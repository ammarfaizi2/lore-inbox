Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267276AbSK3Rnr>; Sat, 30 Nov 2002 12:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbSK3Rnq>; Sat, 30 Nov 2002 12:43:46 -0500
Received: from [195.223.140.107] ([195.223.140.107]:3245 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267276AbSK3Rnq>;
	Sat, 30 Nov 2002 12:43:46 -0500
Date: Sat, 30 Nov 2002 18:50:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <conman@kolivas.net>,
       Srihari Vijayaraghavan <harisri@bigpond.com>
Subject: Re: [PATCHSET] Linux 2.4.20-jam0
Message-ID: <20021130175048.GF28164@dualathlon.random>
References: <20021129233807.GA1610@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021129233807.GA1610@werewolf.able.es>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2002 at 12:38:07AM +0100, J.A. Magallon wrote:
> - reverted the fast-pte part of -aa. Still have to try again
>   to see if it is more stable now.

AFIK this was reproduced by Srihari on nohighmem so it must be that
somebody is calling pgd_free_fast on a pgd that cannot be re-used.
Can you try this patch on top of 2.4.20rc2aa1? (or jam0 after backing
out the fast-pte removal that would otherwise forbid the debugging check
to trigger)

--- 2.4.20rc2aa1/include/asm-i386/pgalloc.h.~1~	2002-11-27 10:09:30.000000000 +0100
+++ 2.4.20rc2aa1/include/asm-i386/pgalloc.h	2002-11-30 18:43:29.000000000 +0100
@@ -97,6 +97,20 @@ static inline pgd_t *get_pgd_fast(void)
 
 static inline void free_pgd_fast(pgd_t *pgd)
 {
+	{
+		int i;
+		for (i = 0; i < USER_PTRS_PER_PGD; i++)
+			if (pgd_val(pgd[i])) {
+				printk("non zero idx %d\n", i);
+				BUG();
+			}
+		for (i = USER_PTRS_PER_PGD; i < PTRS_PER_PGD - USER_PTRS_PER_PGD -
+		     ((-VMALLOC_START + PGDIR_SIZE - 1) >> PGDIR_SHIFT); i++)
+			if (pgd_val(pgd[i]) != pgd_val(swapper_pg_dir[i])) {
+				printk("corrupted idx %d\n", i);
+				BUG();
+			}
+	}
 	*(unsigned long *)pgd = (unsigned long) pgd_quicklist;
 	pgd_quicklist = (unsigned long *) pgd;
 	pgtable_cache_size++;

the stack trace should tell us who is freeing a not valid pgd.
without this check the crash happens in an innocent place and it's not
obvious why it breaks.

Andrea
