Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946000AbWBDKGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946000AbWBDKGA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 05:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946013AbWBDKGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 05:06:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946000AbWBDKF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 05:05:59 -0500
Date: Sat, 4 Feb 2006 02:05:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: kiran@scalex86.org, clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 3/3] NUMA slab locking fixes -- fix cpu down and up
 locking
Message-Id: <20060204020525.065c880b.akpm@osdl.org>
In-Reply-To: <20060204020341.6a5a73ab.akpm@osdl.org>
References: <20060203205341.GC3653@localhost.localdomain>
	<20060203140748.082c11ee.akpm@osdl.org>
	<Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
	<20060204010857.GG3653@localhost.localdomain>
	<20060204012953.GJ3653@localhost.localdomain>
	<20060204020341.6a5a73ab.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Cleanup patch below.

After which we need to address this:

mm/slab.c: In function `cpuup_callback':
mm/slab.c:959: warning: `alien' might be used uninitialized in this function

I guess it won't cause crashes, but it makes me wonder if this was tested
on non-NUMA?

Is this right?

--- devel/mm/slab.c~numa-slab-locking-fixes-fix-cpu-down-and-up-locking-fix	2006-02-04 02:01:44.000000000 -0800
+++ devel-akpm/mm/slab.c	2006-02-04 02:01:44.000000000 -0800
@@ -901,8 +901,11 @@ static void drain_alien_cache(struct kme
 }
 #else
 #define alloc_alien_cache(node, limit) do { } while (0)
-#define free_alien_cache(ac_ptr) do { } while (0)
 #define drain_alien_cache(cachep, alien) do { } while (0)
+
+static inline void free_alien_cache(struct array_cache **ac_ptr)
+{
+}
 #endif
 
 static int __devinit cpuup_callback(struct notifier_block *nfb,
@@ -986,10 +989,12 @@ static int __devinit cpuup_callback(stru
 				l3->shared = shared;
 				shared = NULL;
 			}
+#ifdef CONFIG_NUMA
 			if (!l3->alien) {
 				l3->alien = alien;
 				alien = NULL;
 			}
+#endif
 			spin_unlock_irq(&l3->list_lock);
 
 			kfree(shared);
_

