Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbUD2Rq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUD2Rq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 13:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUD2Rq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 13:46:58 -0400
Received: from ns.suse.de ([195.135.220.2]:1774 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263228AbUD2Rq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 13:46:56 -0400
Subject: Re: 2.6.6-rc[23] boot failure on x86_64
From: Chris Mason <mason@suse.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040429171255.21762.qmail@lwn.net>
References: <20040429171255.21762.qmail@lwn.net>
Content-Type: text/plain
Message-Id: <1083260713.30344.291.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 13:45:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 13:12, Jonathan Corbet wrote:
> 2.6.5 runs happily on my Athlon64 system, but the last two 2.6.6-rc
> releases (I never tried -rc1) fail.  It gets as far as starting init, then
> goes into a long, unstoppable series of oopsen; I can't come up with a way
> to make it halt so that I can actually read what's going on. 
> 
> One time it did stop with a series of three-line messages on screen:
> 
>   Unable to handle kernel paging request @ fffffffb82777c88 RIP:
>   [<ffffffff80462a88>] PML4 103027 PGD 0
>   Oops: 0000 [909589208]

Could you try reversing this one:

-chris

Name: Fix cpumask iterator over empty cpu set
Status: Trivial

Can't use _ffs() without first checking for zero, and if bits beyond
NR_CPUS set it'll give bogus results.  Use find_first_bit

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26180-linux-2.6.6-rc2-bk5/include/asm-generic/cpumask_arith.h .26180-linux-2.6.6-rc2-bk5.updated/include/asm-generic/cpumask_arith.h
--- .26180-linux-2.6.6-rc2-bk5/include/asm-generic/cpumask_arith.h	2004-01-10 13:59:33.000000000 +1100
+++ .26180-linux-2.6.6-rc2-bk5.updated/include/asm-generic/cpumask_arith.h	2004-04-28 09:50:23.000000000 +1000
@@ -43,7 +43,7 @@
 #define cpus_promote(map)		({ map; })
 #define cpumask_of_cpu(cpu)		({ ((cpumask_t)1) << (cpu); })
 
-#define first_cpu(map)			__ffs(map)
+#define first_cpu(map)			find_first_bit(&(map), NR_CPUS)
 #define next_cpu(cpu, map)		find_next_bit(&(map), NR_CPUS, cpu + 1)
 
 #endif /* __ASM_GENERIC_CPUMASK_ARITH_H */


