Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318126AbSGMItm>; Sat, 13 Jul 2002 04:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318127AbSGMItl>; Sat, 13 Jul 2002 04:49:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40121 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318126AbSGMItl>;
	Sat, 13 Jul 2002 04:49:41 -0400
Date: Sat, 13 Jul 2002 04:52:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Menage <pmenage@ensim.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Maneesh Soni <maneesh@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17) 
In-Reply-To: <E17T4Kh-0005pB-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0207130409090.13648-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jul 2002, Paul Menage wrote:

> >Note: measurements on 2.4 do not make sense; reduction of cacheline
> >bouncing between 2.4 and 2.5 will change the results anyway and
> >if any of these patches are going to be applied to 2.4, reduction of
> >cacheline bouncing on ->d_count is going to go in before that one.
> 
> I think there are some other possibilities for cache-bounce removal in
> struct dentry. The most obvious one is d_vfs_flags - not only does it
> get written to on every d_lookup (to set DCACHE_REFERENCED) but it also
> shares a cache line (on Pentium IV) with d_op, d_iname and part of
> d_name (along with d_sb and d_fsdata, but these don't seem to be so
> crucial).
> 
> Some quick stats gathering suggested that DCACHE_REFERENCED is already
> set 95%-98% of the time, so this cache bounce is not even doing anything
> useful. I submitted this patch a while ago making the DCACHE_REFERENCED
> bit setting be conditional on it not being already set, which didn't
> generate any interest. One problem with this patch would be the
> additional branch prediction misses (on some architectures?) that would
> work against the benefits of not dirtying a cache line. 

Frankly, I'd rather moved setting DCACHE_REFERENCED to dput().  We don't
care for that bit for dentries with positive ->d_count.

So I'd just do

vi fs/dcache.c -c '/|= DCACHE_R/d|/nr_un/pu|<|x'

and be done with that.  Linus?

