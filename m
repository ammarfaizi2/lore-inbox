Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314607AbSEBQKY>; Thu, 2 May 2002 12:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314611AbSEBQKX>; Thu, 2 May 2002 12:10:23 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:49054 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314607AbSEBQKT>;
	Thu, 2 May 2002 12:10:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 1 May 2002 18:10:42 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <20020502030113.Q11414@dualathlon.random> <20020502152825.GE10495@krispykreme>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172wgk-00024p-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 17:28, Anton Blanchard wrote:
> > is this machine a numa machine? If not then discontigmem will work just
> > fine. also it's a matter of administration, even if it's a numa machine
> > you can use it just optimally with discontigmem+numa. Regardless of what
> > we do if the partitioning is bad the kernel will do bad. If you create
> > zillon discontigous nodes of 256K each, you'd need waste memory to
> > handle them regardless of nonlinear or discontigmem (with discontigmem
> > you will waste more memory than nonlinear yes, exactly because it's more
> > powerful, but I think a machine with an huge lot of non contigous 256K
> > chunks is misconfigured, it's like if you pretend to install linux on a
> > machine after you partitioned the HD with thousand of logical volumes
> > large 256K each [for the sake of this example let's assume there are
> > more than 256LV available in LVM], a sane partitioning requires you to
> > have at least a partition for /usr large 1 giga, depends what you're
> > doing of course, but requiring sane partitioning it's an admin problem
> > not a kernel problem IMHO).
> 
> Its not a NUMA machine, its one that allows shared processor logical
> partitions. While I would prefer the hypervisor to give each partition
> a nice memory map (and internally maintain a mapping to real memory)
> it does not. I can imagine if the machine has been up for many months
> memory could become very fragmented.
> 
> Also when we do hotplug memory support will discontigmem be able to
> efficiently handle memory turning up all over the place in the memory
> map?

My proposal for support of extremely fragmented physical memory maps is
to use a hash table instead of a direct table lookup in the following
four functions:

    logical_to_phys
    phys_to_logica
    pagenum_to_phys
    phys_to_pagenum
   
With the page.h organization:

#ifdef CONFIG_NONLINEAR
  #ifdef CONFIG_NONLINEAR_HASH
     <the hash table versions of above>
  #else
     <the direct table mappings>
  #endif
#else
  /* Stub definitions */
  #define logical_to_phys(p) (p)
  #define phys_to_logical(p) (p)
  #define ordinal_to_phys(n) ((n) << PAGE_SHIFT)
  #define phys_to_ordinal(p) ((p) >> PAGE_SHIFT)
#endif

The hash tables only be updated when the memory configuration changes.

In fact, we will may likely only need the hash table in one direction, in
the case that the virtual memory map is less fragmented than physical memory.
Then we can use a direct table to go the other direction, and we might want:

#ifdef CONFIG_NONLINEAR
  #ifdef CONFIG_NONLINEAR_PHASH
     <the hash table versions of above>
  #else
     <the direct table mappings>
  #endif
#else
  #define phys_to_logical(p) (p)
  #define phys_to_ordinal(p) ((p) >> PAGE_SHIFT)
#endif

#ifdef CONFIG_NONLINEAR
  #ifdef CONFIG_NONLINEAR_VHASH
     <the hash table versions of above>
  #else
     <the direct table mappings>
  #endif
#else
  #define logical_to_phys(p) (p)
  #define ordinal_to_phys(n) ((n) << PAGE_SHIFT)
#endif

These are all per-arch, though one of my goals is to reduce the
difference between arches, where it doesn't involve any compromise.

-- 
Daniel
