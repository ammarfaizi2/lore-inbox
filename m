Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272279AbTHNKco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 06:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272280AbTHNKco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 06:32:44 -0400
Received: from blackhole.kfki.hu ([148.6.0.114]:65029 "EHLO blackhole.kfki.hu")
	by vger.kernel.org with ESMTP id S272279AbTHNKck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 06:32:40 -0400
Date: Thu, 14 Aug 2003 12:32:35 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: <linux-kernel@vger.kernel.org>
Subject: kmem_cache_destroy: Can't free all objects (2.6)
Message-ID: <Pine.LNX.4.33.0308141215430.7602-100000@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm working on performance testing netfilter ip_conntrack.  The tested
machine is a dual Xeon PC with Serverworks chipset and e1000 cards.

"Calibrating" without ip_conntrack loaded in went fine. However as
the ip_conntrack module was removed after a test, sometimes I got the
message:

slab error in kmem_cache_destroy(): cache `ip_conntrack': Can't free all
objects
Call Trace:
 [<c0136fe9>] kmem_cache_destroy+0xd8/0x116
 [<f889f3ba>] ip_conntrack_cleanup+0x43/0x6c [ip_conntrack]
 [<f889d61a>] init_or_cleanup+0x131/0x190 [ip_conntrack]
 [<f889fc13>] fini+0xf/0x19 [ip_conntrack]
 [<c012dd76>] sys_delete_module+0x13c/0x169
 [<c01402ab>] sys_munmap+0x45/0x66
 [<c0108f9b>] syscall_call+0x7/0xb

I cannot reliably reproduce the error. Sometimes it comes at the
first test run, sometimes at say the 20th, but I have never been able to
run all the planned 150 tests.

This happens both with 2.5.74 and 2.6.0-test1.

Rusty suggested to apply the following little patch to capture allocs and
frees:

--- linux-2.6.0-ct/mm/slab.c.orig       2003-07-25 13:48:26.000000000
+0200
+++ linux-2.6.0-ct/mm/slab.c    2003-07-25 13:56:51.000000000 +0200
@@ -280,6 +280,7 @@
        struct list_head        next;

 /* 5) statistics */
+       atomic_t                alloc,free;
 #if STATS
        unsigned long           num_active;
        unsigned long           num_allocations;
@@ -1389,6 +1390,10 @@
        up(&cache_chain_sem);

        if (__cache_shrink(cachep)) {
+               printk("Slab cache %s: %u allocs vs %u frees\n",
+                      cachep->name,
+                      atomic_read(&cachep->alloc),
+                      atomic_read(&cachep->free));
                slab_error(cachep, "Can't free all objects");
                down(&cache_chain_sem);
                list_add(&cachep->next,&cache_chain);
@@ -2022,7 +2027,10 @@
  */
 void * kmem_cache_alloc (kmem_cache_t *cachep, int flags)
 {
-       return __cache_alloc(cachep, flags);
+       void *ret = __cache_alloc(cachep, flags);
+       if (ret)
+               atomic_inc(&cachep->alloc);
+       return ret;
 }

 /**
@@ -2119,6 +2127,7 @@
 {
        unsigned long flags;

+       atomic_inc(&cachep->free);
        local_irq_save(flags);
        __cache_free(cachep, objp);
        local_irq_restore(flags);

The result with the patch applied is as follows:

Slab cache ip_conntrack: 2052678 allocs vs 2052678 frees
slab error in kmem_cache_destroy(): cache `ip_conntrack': Can't free all objects
Call Trace:
 [<c0133554>] __slab_error+0x24/0x28
 [<c013426d>] kmem_cache_destroy+0xa5/0x128
 [<f889f562>] ip_conntrack_cleanup+0x4a/0x70 [ip_conntrack]
 [<f889d5fa>] init_or_cleanup+0x16a/0x170 [ip_conntrack]
 [<f889fd63>] fini+0x7/0xb [ip_conntrack]
 [<c012b75e>] sys_delete_module+0x14a/0x16c
 [<c013da30>] sys_munmap+0x38/0x58
 [<c0108c27>] syscall_call+0x7/0xb

Slab debugging is enabled, no single message in the log. /proc/slabinfo
says (long lines wrapped):

slabinfo - version: 2.0 (statistics)
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>
: tunables <batchcount> <limit <sharedfactor>
: slabdata <active_slabs> <num_slabs> <sharedavail>
: globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <freelimit>
: cpustat <allochit <allocmiss <freehit <freemiss>
broken               128   2486    180   22    1
: tunables   32   16    8
: slabdata    113    113    128
: globalstat  664846 590238 26829    0    0    1   70
: cpustat 1 974008  78670 1990714  61964

Any hint or idea what can be the problem?

Please Cc answers to me, I'm not on the list.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlec@sunserv.kfki.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : KFKI Research Institute for Particle and Nuclear Physics
          H-1525 Budapest 114, POB. 49, Hungary

