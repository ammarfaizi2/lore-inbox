Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273803AbRIRCCq>; Mon, 17 Sep 2001 22:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273804AbRIRCCh>; Mon, 17 Sep 2001 22:02:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:58890 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273803AbRIRCCb>; Mon, 17 Sep 2001 22:02:31 -0400
Date: Tue, 18 Sep 2001 04:02:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918040240.M698@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109171608310.1108-100000@penguin.transmeta.com> <20010917211834.A31693@redhat.com> <20010918035055.J698@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010918035055.J698@athlon.random>; from andrea@suse.de on Tue, Sep 18, 2001 at 03:50:55AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 03:50:55AM +0200, Andrea Arcangeli wrote:
> On Mon, Sep 17, 2001 at 09:18:34PM -0400, Benjamin LaHaise wrote:
> > On Mon, Sep 17, 2001 at 05:08:37PM -0700, Linus Torvalds wrote:
> > > 
> > > Ok, the big thing here is continued merging, this time with Andrea.
> > > 
> > > I still don't like some of the VM changes, but integrating Andrea's VM
> > > changes results in (a) better performance and (b) much cleaner inactive
> > > page handling in particular. Besides, for the 2.4.x tree, the big priority
> > > is stability, we can re-address my other concerns during 2.5.x.
> > 
> > What is the idea behind merging complete and total utter CRAP into the 
> > tree?  Lets take a few completely fubar'd hunks as examples.  Let's start 
> > with fs/buffer.c:
> > 
> > Point 1. It doesn't compile with egcs 1.1.2.  Pretty remarkable for the only 
> > recommended stable compiler.
> 
> Sorry, I use gcc 3.0.2, but I assume fixing the compilation trouble with
> egcs 1.1.2 is trivial. Can you show which is the interested line of
> code so we can rewrite it in a compatible manner?

ah I just got a (verbose) report about one compilation trouble with old
kernels, the 00_rwsem patch that includes this backwards compatibility
hunk wasn't applied. This is a very very minor issue. Please Linus
include this patch to fix the compilation troubles with the old
compilers:

diff -urN 2.4.10pre10/include/linux/compiler.h rwsem/include/linux/compiler.h
--- 2.4.10pre10/include/linux/compiler.h	Thu Jan  1 01:00:00 1970
+++ rwsem/include/linux/compiler.h	Tue Sep 18 02:02:08 2001
@@ -0,0 +1,13 @@
+#ifndef __LINUX_COMPILER_H
+#define __LINUX_COMPILER_H
+
+/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
+   a mechanism by which the user can annotate likely branch directions and
+   expect the blocks to be reordered appropriately.  Define __builtin_expect
+   to nothing for earlier compilers.  */
+
+#if __GNUC__ == 2 && __GNUC_MINOR__ < 96
+#define __builtin_expect(x, expected_value) (x)
+#endif
+
+#endif /* __LINUX_COMPILER_H */

Then you need to simply include <linux/compile.h> from the files that
doesn't compile, this second patch is untested but it should do the
trick (00_rwsem-?? was including compile.h from the rwsem includes that
were in turn included by those files implicitly so I didn't need to add
compile.h in each file):

--- 2.4.10pre11/mm/slab.c.~1~	Tue Sep 18 02:43:04 2001
+++ 2.4.10pre11/mm/slab.c	Tue Sep 18 04:00:30 2001
@@ -72,6 +72,7 @@
 #include	<linux/slab.h>
 #include	<linux/interrupt.h>
 #include	<linux/init.h>
+#include	<linux/compile.h>
 #include	<asm/uaccess.h>
 
 /*
--- 2.4.10pre11/mm/page_alloc.c.~1~	Tue Sep 18 02:43:04 2001
+++ 2.4.10pre11/mm/page_alloc.c	Tue Sep 18 04:00:20 2001
@@ -17,6 +17,7 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/slab.h>
+#include <linux/compile.h>
 
 int nr_swap_pages;
 int nr_active_pages;
--- 2.4.10pre11/mm/vmscan.c.~1~	Tue Sep 18 02:43:04 2001
+++ 2.4.10pre11/mm/vmscan.c	Tue Sep 18 04:00:47 2001
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/highmem.h>
 #include <linux/file.h>
+#include <linux/compile.h>
 
 #include <asm/pgalloc.h>
 

Andrea
