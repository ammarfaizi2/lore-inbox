Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSKEKQ4>; Tue, 5 Nov 2002 05:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264758AbSKEKQ4>; Tue, 5 Nov 2002 05:16:56 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:4103 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264755AbSKEKQz>; Tue, 5 Nov 2002 05:16:55 -0500
Date: Tue, 5 Nov 2002 11:23:26 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alexander Zarochentcev <zam@namesys.com>
Cc: reiser <reiser@namesys.com>, Nikita Danilov <Nikita@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Message-ID: <20021105102326.GD19762@louise.pinerecords.com>
References: <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com> <3DC1DF02.7060307@namesys.com> <20021101102327.GA26306@louise.pinerecords.com> <15810.46998.714820.519167@crimson.namesys.com> <20021102132421.GJ28803@louise.pinerecords.com> <15814.21309.758207.21416@laputa.namesys.com> <3DC773B0.4070701@namesys.com> <20021105095904.GC19762@louise.pinerecords.com> <15815.39064.694477.303428@crimson.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15815.39064.694477.303428@crimson.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > I just noticed the file
>  > http://thebsh.namesys.com/snapshots/2002.10.31/reiser4.diff
>  > had changed, the difference from the original 20021031 snapshot being:
>  > 
>  > --- fs_reiser4.diff.old 2002-10-31 14:11:50.000000000 +0100
>  > +++ fs_reiser4.diff.new 2002-11-04 16:57:46.000000000 +0100
>  > @@ -46903,7 +46903,7 @@
>  >  +#if REISER4_USER_LEVEL_SIMULATION
>  >  +#    define check_spin_is_locked(s)     spin_is_locked(s)
>  >  +#    define check_spin_is_not_locked(s) spin_is_not_locked(s)
>  > -+#elif defined( CONFIG_DEBUG_SPINLOCK ) && defined( CONFIG_SMP )
>  > ++#elif 0 && defined( CONFIG_DEBUG_SPINLOCK ) && defined( CONFIG_SMP )
>  >  +#    define check_spin_is_not_locked(s) ( ( s ) -> owner != get_current() )
>  >  +#    define spin_is_not_locked(s)       ( ( s ) -> owner == NULL )
>  >  +#    define check_spin_is_locked(s)     ( ( s ) -> owner == get_current() )
>  > 
>  > So either someone is messing about with your webserver or you want multiple
>  > versions of the supposedly same diff floating around (not exactly suitable
>  > for gathering bugreports, is it?).  If you're short on disk space, how about
>  > gzipping the fs diff?  Squeezes down to ~500k from almost 2MB.
> 
> done for 2002.10.31 snapshot.

Well the point is -- could you create a new dir each time you do updates
to the current snapshot?

Here's export-pagevec_deactivate_inactive.diff for 2.5.46:

diff -urN linux-2.5.46/mm/Makefile linux-2.5.46r4/mm/Makefile
--- linux-2.5.46/mm/Makefile	2002-11-05 11:07:21.000000000 +0100
+++ linux-2.5.46.1/mm/Makefile	2002-11-05 11:13:11.000000000 +0100
@@ -2,7 +2,7 @@
 # Makefile for the linux memory manager.
 #
 
-export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o
+export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o swap.o
 
 obj-y	 := memory.o mmap.o filemap.o fremap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_alloc.o \
diff -urN linux-2.5.46/mm/swap.c linux-2.5.46.1/mm/swap.c
--- linux-2.5.46/mm/swap.c	2002-11-05 11:07:21.000000000 +0100
+++ linux-2.5.46.1/mm/swap.c	2002-11-05 11:13:35.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/buffer_head.h>
 #include <linux/prefetch.h>
 #include <linux/percpu.h>
+#include <linux/module.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -227,6 +228,7 @@
 		spin_unlock_irq(&zone->lru_lock);
 	__pagevec_release(pvec);
 }
+EXPORT_SYMBOL(pagevec_deactivate_inactive);
 
 /*
  * Add the passed pages to the LRU, then drop the caller's refcount
