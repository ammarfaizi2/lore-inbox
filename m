Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSLIFYR>; Mon, 9 Dec 2002 00:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSLIFYQ>; Mon, 9 Dec 2002 00:24:16 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:25821 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262826AbSLIFYP>; Mon, 9 Dec 2002 00:24:15 -0500
Date: Mon, 9 Dec 2002 11:00:29 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
Message-ID: <20021209110029.F17375@in.ibm.com>
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com> <20021205162329.A12588@in.ibm.com> <3DEFB0EB.9893DB9@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DEFB0EB.9893DB9@digeo.com>; from akpm@digeo.com on Thu, Dec 05, 2002 at 12:02:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Sorry for the delayed response... I was out of station and couldn't
reply earlier ....

On Thu, Dec 05, 2002 at 12:02:51PM -0800, Andrew Morton wrote:
> Dipankar Sarma wrote:
> > 
> > Hi Andrew,
> > 
> > On Wed, Dec 04, 2002 at 08:32:58PM -0800, Andrew Morton wrote:
> > > Where in the kernel is such a large number of 4-, 8- or 16-byte
> > > objects being used?
> > 
> > Well, kernel objects may not be that small, but one would expect
> > the per-cpu parts of the kernel objects to be sometimes small, often down to
> > a couple of counters counting statistics.
> 
> Sorry, "one would expect" is not sufficient grounds for incorporation of
> a new allocator.  As far as I can tell, all the proposed users are in
> fact allocating decent-sized aggregates, and that will remain the usual
> case.

The main objective of the interlaced allocator was cacheline utilisation
more than main memory fragmentation (That has been my understanding at least).
Without the interlaced allocator, we'd just pad up data and lose
precious cacheline space.  If you have a general purpose object
allocator, one would want objects in different cachelines as kmalloc
does, but that is not the case for kmalloc_percpu users.  If obj A and
obj B exists on the same cacheline, atleast objB does not take
another cacheline...If you hit objB after objA, you gain, but if
you don't, you don't lose.
 
As for the object sizes
1. We are assuming 32 bytes cachelines in this thread I suppose
But ppc64 has a 128 byte cacheline and s390 a 256 byte Jumbo cacheline.
I guess with larger cacheline sizes you have lesser no of cachelines --
makes cachelines all the more precious.  (Right now, I am speaking
in ignorance of the ppc64 and s390 cache architectures .. I
can just see L1_CACHE_SHIFT in the kernel sources).  So wouldn't
interlaced allocations help these archs .. even when you have 64
bytes big objects?
 
2. When we have a case for data structures to be per-cpued, not all
the members will be frequently modified or 'bouncy'... say if you take
netdevice stats, rx and tx counters are likely to be hot
and bouncy....and others not that hot... making the whole
structure per-cpu might not be good, but we did not have
a clean workaround until kmalloc_percpu.  So when you start
identifying hot objects in these data structures, and making
per-cpu objects only of hot objects, your object size
tends to go down .. making a case for the interlaced allocator .....
This capability is not possible without the interlaced allocator no?

Does this make a reasonable case for interlaced allocator now?
(Of course, blklist init in the patch has to be modified to create
blklists for objects of size 4, 8 .... SMP_CACHE_BYTES/2)
 
Thanks,
Kiran 
