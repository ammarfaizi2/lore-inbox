Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWECUSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWECUSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWECUSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:18:33 -0400
Received: from fmr17.intel.com ([134.134.136.16]:55209 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750797AbWECUSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:18:32 -0400
Date: Tue, 2 May 2006 16:46:25 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: blaisorblade@yahoo.it, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 00/14] remap_file_pages protection support
Message-ID: <20060502234625.GA11255@goober>
References: <20060430172953.409399000@zion.home.lan> <1146565266.32045.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146565266.32045.29.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 12:21:06PM +0200, Arjan van de Ven wrote:
> 
> > This will be useful since the VMA lookup at fault time can be a bottleneck for
> > some programs (I've received a report about this from Ulrich Drepper and I've
> > been told that also Val Henson from Intel is interested about this). 
> 
> I've not seen much of this if any at all, the various caches that are in
> place for these lookups seem to function quite well; what we did see was
> glibc's malloc implementation being mistuned resulting in far too many
> mmaps than needed (which in turn leads to far too much page zeroing
> which is the really expensive part. It's not the vma lookup that is
> expensive, it's the page zeroing)

VMA lookup time hasn't been noticeable on the systems we're running
ebizzy[1] on, which is what Arjan is talking about.  I did see it with
a customer application last year - on a kernel without the RB tree for
looking up vma's.  My vague recollection of the oprofile results was
something on the order of 2-10% of cpu time spent in find_vma() and
similar vma handling functions.  This was on an application with 100's
of vmas due to malloc() being tuned to use mmap() too often.  Arjan
and I whomped up a patch to glibc to fix the root cause; for details
see:

http://sourceware.org/ml/libc-alpha/2006-03/msg00033.html

A more legitimate situation resulting in 100's of vma's is the JVM
case - you end up with at least 2 vma's per thread, for the stack and
guard page.  I personally have seen a JVM with over 100 threads in
active use and over 500 vma's. (One of the nice things about your
patch is that it will eliminate the separate guard page vma, reducing
the number of necessary vma's by one per thread.)

I intend to go back and look for find_vma() and friends while running
ebizzy, since I wrote the darn thing partly to expose that problem;
however I suspect it's mostly gone now that we have RB-trees for
vma's.  If you want to use ebizzy to evaluate your patches, just run
it with the -M "always mmap" argument and tune the various thread and
memory allocation options until you get a suitable number of vma's.

-VAL

[1] ebizzy is an application I wrote to replicate this kind of
workload.  For more info, see:

http://infohost.nmt.edu/~val/patches.html#ebizzy
