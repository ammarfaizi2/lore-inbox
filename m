Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUHTHw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUHTHw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHTHw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:52:27 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:31150 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267633AbUHTHwG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:52:06 -0400
Date: Fri, 20 Aug 2004 18:47:28 +1000
From: Nathan Scott <nathans@sgi.com>
To: David Martinez Moreno <ender@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crashes and lockups in XFS filesystem (2.6.8-rc4 and 2.6.8.1-mm2).
Message-ID: <20040820084728.GQ14750@frodo>
References: <200408181816.57940.ender@debian.org> <20040819084410.GA14750@frodo> <200408192127.58996.ender@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200408192127.58996.ender@debian.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 09:27:58PM +0200, David Martinez Moreno wrote:
> El Jueves, 19 de Agosto de 2004 10:44, Nathan Scott escribió:
> > Did /mnt run out of space while doing that?  Or nearly?  There's
> > a known issue with that area of the XFS code, in conjunction with
> > 4K stacks at the moment - was that enabled in your .config?
> >
> > Looks like something stamped on parts of the xfs_mount structure
> > for the filesystem mounted at /mnt, a stack overrun would explain
> > that and your subsequent oopsen.
> 
> 	Bad news!
> 
> 	Aaarggh! It seemed that 2.6.8.1-mm2 was going to stand, and it did during an 
> entinre hour or so, but it failed as well. The XFS filesystem on the RAID 0 
> was being acceded by 100 users and I was copying files from it to the SCSI 
> disk sda1, under XFS as well.

Hmmm, that looks awfully similar to the problem other folks are
chasing (see thread "Possible dcache BUG").  Is it reproducible
for you by any chance?

There have been some debugging patches that Marcelo posted in that
thread, would be a good idea to try those out; although with your
crash its difficult to see which slab it is thats corrupted (iirc,
Marcelo's patch was targetting the buffer_head slab).

> 	The crash:
> 
> ------------[ cut here ]------------
> kernel BUG at include/linux/list.h:164!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c01332ef>]    Not tainted VLI
> EFLAGS: 00010006   (2.6.8.1-mm2)
> EIP is at shrink_cache+0x310/0x31d
> eax: ffffffff   ebx: c0426264   ecx: c1081658   edx: c10444f8
> esi: 0000000f   edi: c0426288   ebp: 0000000e   esp: c15afeb0
> ds: 007b   es: 007b   ss: 0068
> Process kswapd0 (pid: 10, threadinfo=c15ae000 task=c15620b0)
> Stack: c15afeb0 c15afeb0 c15ae000 00000020 c10444d8 c10d3d98 00000000 00000001
>        c13bcd20 c1251860 c13bb6a0 c13bb840 c13bb680 c129cce0 c129d980 c13fbc20
>        c13b8b20 c13c2940 c13c2960 c135f300 c13ba160 c13ba1c0 c13c9120 c13bcd00
> Call Trace:
>  [<c01328c8>] shrink_slab+0x85/0x187
>  [<c0133817>] shrink_zone+0x9e/0xb8
>  [<c0133bd4>] balance_pgdat+0x1c9/0x22d
>  [<c0133cff>] kswapd+0xc7/0xd7
>  [<c0113a2d>] autoremove_wake_function+0x0/0x57
>  [<c0113a2d>] autoremove_wake_function+0x0/0x57
>  [<c0133c38>] kswapd+0x0/0xd7
>  [<c0101fdd>] kernel_thread_helper+0x5/0xb
> Code: eb e4 8b 44 24 10 83 c5 01 89 50 04 89 02 8d 44 24 10 89 42 04 89 54 24 
> 10 e9 cd fd ff ff 0f 0b a5 00 d0 0d 3d c0 e9

-- 
Nathan
