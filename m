Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274001AbRI0Wjb>; Thu, 27 Sep 2001 18:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274002AbRI0WjW>; Thu, 27 Sep 2001 18:39:22 -0400
Received: from [195.223.140.107] ([195.223.140.107]:36347 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274001AbRI0WjO>;
	Thu, 27 Sep 2001 18:39:14 -0400
Date: Fri, 28 Sep 2001 00:39:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert_Macaulay@Dell.com
Cc: riel@conectiva.com.br, ckulesa@as.arizona.edu,
        linux-kernel@vger.kernel.org, bmatthews@redhat.com,
        marcelo@conectiva.com.br, torvalds@transmeta.com
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9 -ac14/15(+stuff)]
Message-ID: <20010928003924.R14277@athlon.random>
In-Reply-To: <8F120FA493CAD743B30EEB8F356985B501A7819D@AUSXMBT102VS1.amer.dell.com> <20010928003746.Q14277@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010928003746.Q14277@athlon.random>; from andrea@suse.de on Fri, Sep 28, 2001 at 12:37:46AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 12:37:46AM +0200, Andrea Arcangeli wrote:
> On Thu, Sep 27, 2001 at 05:34:17PM -0500, Robert_Macaulay@Dell.com wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Andrea Arcangeli [mailto:andrea@suse.de]
> > > Sent: Thursday, September 27, 2001 5:13 PM
> > > To: Macaulay, Robert
> > > Cc: Rik van Riel; Craig Kulesa; linux-kernel@vger.kernel.org; Bob
> > > Matthews; Marcelo Tosatti; Linus Torvalds
> > > Subject: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs.
> > > 2.4.9-ac14/15(+stuff)]
> > > 
> > > @@ -2519,7 +2521,9 @@
> > >  	int tryagain = 1;
> > >  
> > >  	do {
> > > -		if (buffer_dirty(p) || buffer_locked(p)) {
> > > +		if (unlikely(buffer_pending_IO(p)))
> > > +			tryagain = 0;
> > > +		else if (buffer_dirty(p) || buffer_locked(p)) {
> > >  			if (test_and_set_bit(BH_Wait_IO, &p->b_state)) {
> > >  				if (buffer_dirty(p)) {
> > >  					ll_rw_block(WRITE, 1, &p);
> > > 
> > 
> > Im getting an undefined reference to the unlikely function in this patch.
> 
> ok, try adding #include <linux/compiler.h> to include/linux/kernel.h, I
> prefer to have likely/unlikely always available.

--- 2.4.10aa2/fs/inode.c.~1~	Wed Sep 26 18:45:27 2001
+++ 2.4.10aa2/fs/inode.c	Fri Sep 28 00:38:39 2001
@@ -17,7 +17,6 @@
 #include <linux/swapctl.h>
 #include <linux/prefetch.h>
 #include <linux/locks.h>
-#include <linux/compiler.h>
 
 /*
  * New inode.c implementation.
--- 2.4.10aa2/include/linux/kernel.h.~1~	Wed Sep 26 18:51:24 2001
+++ 2.4.10aa2/include/linux/kernel.h	Fri Sep 28 00:38:13 2001
@@ -11,6 +11,7 @@
 #include <linux/linkage.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/compiler.h>
 
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
--- 2.4.10aa2/mm/page_alloc.c.~1~	Wed Sep 26 18:45:28 2001
+++ 2.4.10aa2/mm/page_alloc.c	Fri Sep 28 00:38:22 2001
@@ -17,7 +17,6 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/slab.h>
-#include <linux/compiler.h>
 #include <linux/vmalloc.h>
 
 int nr_swap_pages;
--- 2.4.10aa2/mm/slab.c.~1~	Wed Sep 26 18:45:29 2001
+++ 2.4.10aa2/mm/slab.c	Fri Sep 28 00:38:24 2001
@@ -72,7 +72,6 @@
 #include	<linux/slab.h>
 #include	<linux/interrupt.h>
 #include	<linux/init.h>
-#include	<linux/compiler.h>
 #include	<asm/uaccess.h>
 
 /*
--- 2.4.10aa2/mm/swapfile.c.~1~	Sun Sep 23 21:11:43 2001
+++ 2.4.10aa2/mm/swapfile.c	Fri Sep 28 00:38:26 2001
@@ -14,7 +14,6 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/shm.h>
-#include <linux/compiler.h>
 
 #include <asm/pgtable.h>
 
--- 2.4.10aa2/mm/vmscan.c.~1~	Wed Sep 26 18:45:28 2001
+++ 2.4.10aa2/mm/vmscan.c	Fri Sep 28 00:38:29 2001
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/highmem.h>
 #include <linux/file.h>
-#include <linux/compiler.h>
 
 #include <asm/pgalloc.h>
 

Andrea
