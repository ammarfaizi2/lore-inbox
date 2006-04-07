Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWDGEx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWDGEx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 00:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWDGEx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 00:53:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932258AbWDGEx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 00:53:58 -0400
Date: Thu, 6 Apr 2006 21:52:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, jbarnes@sgi.com, jes@trained-monkey.org,
       nickpiggin@yahoo.com.au, tony.luck@intel.com,
       mm-commits@vger.kernel.org
Subject: Re: + pg_uncached-is-ia64-only.patch added to -mm tree
Message-Id: <20060406215242.245340de.akpm@osdl.org>
In-Reply-To: <20060407134827.91a47e69.kamezawa.hiroyu@jp.fujitsu.com>
References: <200604070421.k374LXFs011197@shell0.pdx.osdl.net>
	<20060407134827.91a47e69.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> Hi, Andrew
> 
> On Thu, 06 Apr 2006 21:20:26 -0700
> akpm@osdl.org wrote:
> 
> > 
> > The patch titled
> > 
> >      PG_uncached is ia64 only
> > 
> > has been added to the -mm tree.  Its filename is
> > 
> >      pg_uncached-is-ia64-only.patch
> > 
> > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> > out what to do about this
> > 
> 
> in include/linux/mmzone.h
> ==
> #elif BITS_PER_LONG == 64
> /*
>  * with 64 bit flags field, there's plenty of room.
>  */
> #define FLAGS_RESERVED          32
> 
> #else

OK.

> 
> it looks this is used here.
> 
> #if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
> #error SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
> #endif
> 
> I'm not sure but please compile check FLAGS_RESRVED with SPARSEMEM or
> 

Yes, that test won't trigger.

> 
> #if (BITS_PER_LONG > 32)               /* 64-bit only flags. we can use full 
>                                           low 32bits */
> #define PG_uncached	31
> #endif
> 
> Hm..Is this  ugly ? :(

It's easier to change FLAGS_RESERVED ;)

diff -puN include/linux/page-flags.h~pg_uncached-is-ia64-only include/linux/page-flags.h
--- devel/include/linux/page-flags.h~pg_uncached-is-ia64-only	2006-04-06 21:50:51.000000000 -0700
+++ devel-akpm/include/linux/page-flags.h	2006-04-06 21:50:51.000000000 -0700
@@ -7,6 +7,8 @@
 
 #include <linux/percpu.h>
 #include <linux/cache.h>
+#include <linux/types.h>
+
 #include <asm/pgtable.h>
 
 /*
@@ -86,7 +88,10 @@
 #define PG_mappedtodisk		16	/* Has blocks allocated on-disk */
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
-#define PG_uncached		19	/* Page has been mapped as uncached */
+
+#if (BITS_PER_LONG > 32)
+#define PG_uncached		32	/* Page has been mapped as uncached */
+#endif
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
diff -puN include/linux/mmzone.h~pg_uncached-is-ia64-only include/linux/mmzone.h
--- devel/include/linux/mmzone.h~pg_uncached-is-ia64-only	2006-04-06 21:50:56.000000000 -0700
+++ devel-akpm/include/linux/mmzone.h	2006-04-06 21:51:12.000000000 -0700
@@ -457,7 +457,7 @@ extern struct zone *next_zone(struct zon
 /*
  * with 64 bit flags field, there's plenty of room.
  */
-#define FLAGS_RESERVED		32
+#define FLAGS_RESERVED		24
 
 #else
 
_

