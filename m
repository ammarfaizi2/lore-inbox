Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUJ0IJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUJ0IJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbUJ0IJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:09:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:1731 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262322AbUJ0IJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:09:00 -0400
Date: Wed, 27 Oct 2004 01:06:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Cloos <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org, david@gibson.dropbear.id.au
Subject: Re: MAP_SHARED bizarrely slow
Message-Id: <20041027010659.15ec7e90.akpm@osdl.org>
In-Reply-To: <m3u0sgiq0b.fsf@lugabout.cloos.reno.nv.us>
References: <20041027064527.GJ1676@zax>
	<m3u0sgiq0b.fsf@lugabout.cloos.reno.nv.us>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cloos <cloos@jhcloos.com> wrote:
>
> >>>>> "David" == David Gibson <david@gibson.dropbear.id.au> writes:
> 
> David> http://www.ozlabs.org/people/dgibson/maptest.tar.gz
> 
> David> On a number of machines I've tested - both ppc64 and x86 - the
> David> SHARED version is consistently and significantly (50-100%)
> David> slower than the PRIVATE version.
> 
> Just gave it a test on my laptop and server.  Both are p3.  The
> laptop is under heavier mem pressure; the server has just under
> a gig with most free/cache/buff.  Laptop is still running 2.6.7
> whereas the server is bk as of 2004-10-24.
> 
> Buth took about 11 seconds for the private and around 30 seconds
> for the shared tests.
> 

I get the exact opposite, on a P4:

vmm:/home/akpm/maptest> time ./mm-sharemmap 
./mm-sharemmap  10.81s user 0.05s system 100% cpu 10.855 total
vmm:/home/akpm/maptest> time ./mm-sharemmap
./mm-sharemmap  11.04s user 0.05s system 100% cpu 11.086 total
vmm:/home/akpm/maptest> time ./mm-privmmap 
./mm-privmmap  26.91s user 0.02s system 100% cpu 26.903 total
vmm:/home/akpm/maptest> time ./mm-privmmap
./mm-privmmap  26.89s user 0.02s system 100% cpu 26.894 total
vmm:/home/akpm/maptest> uname -a
Linux vmm 2.6.10-rc1-mm1 #14 SMP Tue Oct 26 23:23:23 PDT 2004 i686 i686 i386 GNU/Linux

It's all user time so I can think of no reason apart from physical page
allocation order causing additional TLB reloads in one case.  One is using
anonymous pages and the other is using shmem-backed pages, although I can't
think why that would make a difference.


Let's back out the no-buddy-bitmap patches:

vmm:/home/akpm/maptest> time ./mm-sharemmap 
./mm-sharemmap  12.01s user 0.06s system 99% cpu 12.087 total
vmm:/home/akpm/maptest> time ./mm-sharemmap
./mm-sharemmap  12.56s user 0.05s system 100% cpu 12.607 total
vmm:/home/akpm/maptest> time ./mm-privmmap 
./mm-privmmap  26.74s user 0.03s system 99% cpu 26.776 total
vmm:/home/akpm/maptest> time ./mm-privmmap
./mm-privmmap  26.66s user 0.02s system 100% cpu 26.674 total

much the same.

Backing out "[PATCH] tweak the buddy allocator for better I/O merging" from
June 24 makes no difference.

