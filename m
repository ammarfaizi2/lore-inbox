Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318997AbSIDBKz>; Tue, 3 Sep 2002 21:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318999AbSIDBKz>; Tue, 3 Sep 2002 21:10:55 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:46088 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318997AbSIDBKy>; Tue, 3 Sep 2002 21:10:54 -0400
Message-ID: <3D755E2D.7A6D55C6@zip.com.au>
Date: Tue, 03 Sep 2002 18:13:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm1
References: <3D7437AC.74EAE22B@zip.com.au> <20020904004028.GS888@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Mon, Sep 02, 2002 at 09:16:44PM -0700, Andrew Morton wrote:
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.33/2.5.33-mm1/
> > Seven new patches - mostly just code cleanups.
> > +slablru-speedup.patch
> >   A patch to improve slablru cpu efficiency.  Ed is
> >   redoing this.
> 
> count_list() appears to be the largest consumer of cpu after this is
> done, or so say the profiles after running updatedb by hand on
> 2.5.33-mm1 on a 900MHz P-III T21 Thinkpad with 256MB of RAM.

That's my /proc/meminfo:buffermem counter-upper.  I said it would suck ;)
Probably count_list(&inode_unused) can just be nuked.  I don't think blockdev
inodes ever go onto inode_unused.

>   4608 __rdtsc_delay                            164.5714
>   2627 __generic_copy_to_user                    36.4861
>   2401 count_list                                42.8750
>   1415 find_inode_fast                           29.4792
>   1325 do_anonymous_page                          3.3801
> 
> It also looks like there's either a bit of internal fragmentation or a
> missing kmem_cache_reap() somewhere:
> 
>   ext3_inode_cache:    20001KB    51317KB   38.97
>       dentry_cache:     4734KB    18551KB   25.52
>    radix_tree_node:     1811KB     1923KB   94.20
>        buffer_head:     1132KB     1378KB   82.12

That's really outside the control of slablru.  It's determined
by the cache-specific LRU algorithms, and the allocation order.

You'll need to look at the second-last and third-last columns in
/proc/slabinfo (boy I wish that thing had a heading line, or a nice
program to interpret it):

ext3_inode_cache     959   2430    448  264  270    1

That's 264 pages in use, 270 total.  If there's a persistent gap between
these then there is a problem - could well be that slablru is not locating
the pages which were liberated by the pruning sufficiently quickly.

Calling kmem_cache_reap() after running the pruners will fix that up.
