Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292362AbSCFAkc>; Tue, 5 Mar 2002 19:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292507AbSCFAkY>; Tue, 5 Mar 2002 19:40:24 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64729 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S292362AbSCFAkQ>;
	Tue, 5 Mar 2002 19:40:16 -0500
Date: Tue, 5 Mar 2002 19:40:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from ext2_get_block() version 2
In-Reply-To: <200203060023.g260NIB09974@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0203051935160.18755-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Mar 2002, Dave Hansen wrote:

First of all, learn to use fscking line breaks.

> I posted the initial version of this last week.  There was no discussion about the patch itself.  I can only hope that no news is good news :)
> 
> My first version of the patch reinitialized i_meta_lock for every read_inode call.  This is not a correct way to do it.  However, 2.4 does not have the capability to have fs-specific init_inode_once() functions.  This probably meant altering the sb_ops structure if I wanted ext2_inode_info-specific initialization.  To make the patch less intrusive, I put i_meta_lock right into the inode structure.  I think that this is a good compromize between keeping ext2 code separated from VFS and patch simplicity.  The lock is now initialized once per inode in fs/inode.c's init_once(). 

Denied.  You can trivially do that in ext2_read_inode() and ext2_new_inode().

> I noticed the extra lock initializations because I was using lockmeter and kernprof while running dbench.  I was seeing a large throughput decrease when my patch was applied, and kernprof told me that a big chunk of CPU time was being spent in lockmeter's rwlock_alloc.  I have the feeling that I've hit a bottleneck in lockmeter's code spinning on locks which protect lockmeter's data structures.  
> 
> The patch is against 2.4.19-pre2.  The patch significantly lowers BKL contention (50%) on a 2-way PII-300 running dbench 4.  Dbench throughput is not significantly affected, but that is probably a function of my puny little machine more than the effectiveness of the patch.  I'll have some results on a much more beefy 8-way PIII tomorrow.  Earlier versions of the patch reduced BKL contention during dbench by 60% on the 8-way.  CPU utilization spinning on the BKL has been as high as 40%.

ext2 patches _MUST_ get testing in 2.5 before they can go into 2.4.  At
the very least a month, preferably - two.  Until then consider them vetoed
for 2.4, no matter how BKL brigade feels about their crusade.

