Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932790AbVJ3CUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbVJ3CUF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 22:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbVJ3CUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 22:20:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42201 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932790AbVJ3CUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 22:20:03 -0400
Date: Sat, 29 Oct 2005 19:19:46 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rohit.seth@intel.com, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051029191946.1832adaf.pj@sgi.com>
In-Reply-To: <4364296E.1080905@yahoo.com.au>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	<20051029184728.100e3058.pj@sgi.com>
	<4364296E.1080905@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick, replying to pj:
> >  3) The "inline" you added to buffered_rmqueue() blew up my compile.
> 
> How? Why? This should be solved because a future possible feature
> (early allocation from pcp lists) will want inlining in order to
> propogate the constant 'replenish' argument.

If I make the following change to a copy of mm/page_alloc.c:

=================================
--- 2.6.14-rc5-mm1-cpuset-patches.orig/mm/page_alloc.c  2005-10-29 19:04:13.745641793 -0700
+++ 2.6.14-rc5-mm1-cpuset-patches/mm/page_alloc.c       2005-10-29 19:04:03.085367810 -0700
@@ -713,7 +713,7 @@ static inline void prep_zero_page(struct
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
  */
-struct page *
+struct inline page *
 buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags)
 {
 	unsigned long flags;
=================================

Then it goes from compiling ok, to failing with 61 lines of
error output, beginning with:

mm/page_alloc.c:716: error: parse error before "inline"
mm/page_alloc.c:721: error: `gfp_flags' undeclared here (not in a function)
mm/page_alloc.c:723: error: parse error before "if"
mm/page_alloc.c:726: warning: type defaults to `int' in declaration of `pcp'
mm/page_alloc.c:726: error: `zone' undeclared here (not in a function)
mm/page_alloc.c:726: error: braced-group within expression allowed only inside a function
mm/page_alloc.c:726: warning: data definition has no type or storage class
mm/page_alloc.c:726: warning: type defaults to `int' in declaration of `debug_smp_processor_id'
mm/page_alloc.c:726: warning: function declaration isn't a prototype
mm/page_alloc.c:726: error: conflicting types for `debug_smp_processor_id'
include/linux/smp.h:131: error: previous declaration of `debug_smp_processor_id'          

This is gcc 3.3.3, compiling sn2_defconfig on and for an SN2.

Perhaps "inline struct page *" would work better than "struct inline page *" ?
... yes ... that fixes my compiler complaints.

Also ... buffered_rmqueue() is a rather large function to be inlining.
And if it is inlined, then are you expecting to also have an out of
line copy, for use by the call to it from mm/swap_prefetch.c
prefetch_get_page()?

Adding the 'inline' keyword increases my kernel text size by
1448 bytes, for the extra copy of this code used inline from
the call to it from mm/page_alloc.c:get_page_from_freelist().
Is that really worth it?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
