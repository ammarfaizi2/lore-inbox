Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWHaHsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWHaHsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 03:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWHaHsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 03:48:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50048 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751222AbWHaHso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 03:48:44 -0400
Date: Thu, 31 Aug 2006 17:47:42 +1000
From: David Chinner <dgc@sgi.com>
To: Yao Fei Zhu <walkinair@cn.ibm.com>
Cc: linux-kernel@vger.kernel.org, haveblue@us.ibm.com, xfs@oss.sgi.com
Subject: Re: kernel BUG in __xfs_get_blocks at fs/xfs/linux-2.6/xfs_aops.c:1293!
Message-ID: <20060831074742.GD807830@melbourne.sgi.com>
References: <44F67847.6030307@cn.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F67847.6030307@cn.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 01:48:55PM +0800, Yao Fei Zhu wrote:
> Problem description:
> Run fsstress on xfs file system with -n 1000 and -p 1000, after about 3 
> hours,
> test box will fall into xmon, and get
> kernel BUG in __xfs_get_blocks at fs/xfs/linux-2.6/xfs_aops.c:1293!
> 
> Hardware Environment
>    Machine type (p650, x235, SF2, etc.): B70+
>    Cpu type (Power4, Power5, IA-64, etc.): POWER5+
> Software Environmnet
>    Base OS: SLES10 GM
>    Kernel: 2.6.18-rc5
> 
> Additional information:
> 3:mon> e
> cpu 0x3: Vector: 700 (Program Check) at [c0000001e16632d0]
>    pc: d0000000006daa88: .__xfs_get_blocks+0x1a0/0x2a0 [xfs]
>    lr: d0000000006da984: .__xfs_get_blocks+0x9c/0x2a0 [xfs]
>    sp: c0000001e1663550
>   msr: 8000000000029032
>  current = 0xc0000001dde71310
>  paca    = 0xc0000000004c4900
>    pid   = 9217, comm = fsstress
> kernel BUG in __xfs_get_blocks at fs/xfs/linux-2.6/xfs_aops.c:1293!
> 3:mon> t
> [c0000001e1663640] c000000000108344 .__blockdev_direct_IO+0x560/0xcfc
> [c0000001e1663760] d0000000006dc43c .xfs_vm_direct_IO+0xec/0x13c [xfs]
> [c0000001e1663860] c0000000000a1474 .generic_file_direct_IO+0xe8/0x15c
> [c0000001e1663910] c0000000000a1748 .__generic_file_aio_read+0xf4/0x22c
> [c0000001e16639e0] d0000000006e4b94 .xfs_read+0x288/0x368 [xfs]
> [c0000001e1663ae0] d0000000006e0750 .xfs_file_aio_read+0x88/0x9c [xfs]
> [c0000001e1663b70] c0000000000d4df0 .do_sync_read+0xd4/0x130
> [c0000001e1663cf0] c0000000000d5c44 .vfs_read+0x118/0x200
> [c0000001e1663d90] c0000000000d6128 .sys_read+0x4c/0x8c
> [c0000001e1663e30] c00000000000871c syscall_exit+0x0/0x40

Hmmmm. We've mapped a range that has been reserved for a delayed
allocate extent during a direct I/O. That should not happen as XFS
flushes delalloc extents before executing a direct read and holds
the I/O lock which will prevent any new writes from mapping new
delalloc extents. Something went astray, though. :(

Can you give me some more detail on the machine you're running?
e.g. How many CPUs, RAM and what type of disk subsystem you are using?
That will make it easier for us to try to reproduce this problem.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
