Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUJ0IVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUJ0IVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUJ0IVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:21:34 -0400
Received: from ozlabs.org ([203.10.76.45]:29134 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262328AbUJ0IV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:21:27 -0400
Date: Wed, 27 Oct 2004 18:20:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: James Cloos <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: MAP_SHARED bizarrely slow
Message-ID: <20041027082003.GL1676@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, James Cloos <cloos@jhcloos.com>,
	linux-kernel@vger.kernel.org
References: <20041027064527.GJ1676@zax> <m3u0sgiq0b.fsf@lugabout.cloos.reno.nv.us> <20041027010659.15ec7e90.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027010659.15ec7e90.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 01:06:59AM -0700, Andrew Morton wrote:
> James Cloos <cloos@jhcloos.com> wrote:
> >
> > >>>>> "David" == David Gibson <david@gibson.dropbear.id.au> writes:
> > 
> > David> http://www.ozlabs.org/people/dgibson/maptest.tar.gz
> > 
> > David> On a number of machines I've tested - both ppc64 and x86 - the
> > David> SHARED version is consistently and significantly (50-100%)
> > David> slower than the PRIVATE version.
> > 
> > Just gave it a test on my laptop and server.  Both are p3.  The
> > laptop is under heavier mem pressure; the server has just under
> > a gig with most free/cache/buff.  Laptop is still running 2.6.7
> > whereas the server is bk as of 2004-10-24.
> > 
> > Buth took about 11 seconds for the private and around 30 seconds
> > for the shared tests.
> > 
> 
> I get the exact opposite, on a P4:
> 
> vmm:/home/akpm/maptest> time ./mm-sharemmap 
> ./mm-sharemmap  10.81s user 0.05s system 100% cpu 10.855 total
> vmm:/home/akpm/maptest> time ./mm-sharemmap
> ./mm-sharemmap  11.04s user 0.05s system 100% cpu 11.086 total
> vmm:/home/akpm/maptest> time ./mm-privmmap 
> ./mm-privmmap  26.91s user 0.02s system 100% cpu 26.903 total
> vmm:/home/akpm/maptest> time ./mm-privmmap
> ./mm-privmmap  26.89s user 0.02s system 100% cpu 26.894 total
> vmm:/home/akpm/maptest> uname -a
> Linux vmm 2.6.10-rc1-mm1 #14 SMP Tue Oct 26 23:23:23 PDT 2004 i686 i686 i386 GNU/Linux

How very odd.  I've now understood what was happening (see other
post), but I'm not sure what could reverse the situation.  Can you
download the test tarball again - I've put up an updated version which
pretouches the pages and gives some extra info.  Running it both with
and without pretouch would be interesting (#if 0/1 in matmul.h to
change).

> It's all user time so I can think of no reason apart from physical page
> allocation order causing additional TLB reloads in one case.  One is using
> anonymous pages and the other is using shmem-backed pages, although I can't
> think why that would make a difference.
> 
> 
> Let's back out the no-buddy-bitmap patches:
> 
> vmm:/home/akpm/maptest> time ./mm-sharemmap 
> ./mm-sharemmap  12.01s user 0.06s system 99% cpu 12.087 total
> vmm:/home/akpm/maptest> time ./mm-sharemmap
> ./mm-sharemmap  12.56s user 0.05s system 100% cpu 12.607 total
> vmm:/home/akpm/maptest> time ./mm-privmmap 
> ./mm-privmmap  26.74s user 0.03s system 99% cpu 26.776 total
> vmm:/home/akpm/maptest> time ./mm-privmmap
> ./mm-privmmap  26.66s user 0.02s system 100% cpu 26.674 total
> 
> much the same.
> 
> Backing out "[PATCH] tweak the buddy allocator for better I/O merging" from
> June 24 makes no difference.
> 

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
