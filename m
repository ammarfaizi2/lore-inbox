Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbUJ1Fys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbUJ1Fys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 01:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbUJ1Fyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 01:54:46 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:11142 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262787AbUJ1FyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 01:54:10 -0400
Date: Wed, 27 Oct 2004 22:54:07 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andrew Morton <akpm@osdl.org>
cc: James Cloos <cloos@jhcloos.com>, linux-kernel@vger.kernel.org,
       david@gibson.dropbear.id.au
Subject: Re: MAP_SHARED bizarrely slow
In-Reply-To: <20041027010659.15ec7e90.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0410272146210.4453@twinlark.arctic.org>
References: <20041027064527.GJ1676@zax> <m3u0sgiq0b.fsf@lugabout.cloos.reno.nv.us>
 <20041027010659.15ec7e90.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Andrew Morton wrote:

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
> 
> It's all user time so I can think of no reason apart from physical page
> allocation order causing additional TLB reloads in one case.  One is using
> anonymous pages and the other is using shmem-backed pages, although I can't
> think why that would make a difference.

you're experiencing the wonder of the L1 data cache on the P4 ... based on 
its behaviour i'm pretty sure that early in the pipeline they use the 
virtual address to match a virtual tag and procede with that data as if 
it's correct.  not until the TLB lookup and physical tag check many cycles 
later does it realise that it's done something wrong and pull kill / flush 
pipelines.

when you set up a virtual alias, like you have with the shared zero page, 
it becomes very confused.

in fact if you do something as simple as a 4 element pointer-chase where 
the cache lines for elt 0 and 2 alias, and cache lines for 1 and 3 alias 
then you can watch some p4 take up to 3000 cycles per reference.

-dean
