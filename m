Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281470AbRKTXD3>; Tue, 20 Nov 2001 18:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281469AbRKTXDO>; Tue, 20 Nov 2001 18:03:14 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:49680 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281467AbRKTXCh>; Tue, 20 Nov 2001 18:02:37 -0500
Message-ID: <3BFAE0E4.CFC678C0@zip.com.au>
Date: Tue, 20 Nov 2001 15:01:56 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Bouillet <Andre.Bouillet@web.de>
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: Kernel error during "umount" on ext3 with 2.4.15-pre7
In-Reply-To: <20011120230942.A540@charon>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Bouillet wrote:
> 
> Hello,
> 
> I got the following error from the kernel:
> 
> Unable to handle kernel paging request at virtual address 4bbdc8fd
> printing eip:
> c0113534
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[add_wait_queue_exclusive+28/36]    Tainted: P EFLAGS:
> 00010096
> eax: d76512a0   ebx: 4bbdc8fd   ecx: 00000202   edx: c1cebe68
> esi: c1cebe60   edi: c1cea000   ebp: cd1d04d0   esp: c1cebe48
> ds: 0018   es: 0018   ss: 0018
> Process umount (pid: 7461, stackpage=c1ceb000)
> Stack: d7651294 c1cebe60 c0105949 c13532c0 00000000 00000000 00000001
> c1cea000          d76512a0 4bbdc8fd c0105aa8 d7651294 00000000 d7651200
> c01d26f5 c13532c0          00000000 00000000 cd1d04d0 ce271f18 00000001
> c01126b0 c014cd12 d7651200 Call Trace: [__down+65/156]
> [__down_failed+8/12] [stext_lock+4133/10892] [schedule+548/852]
> [ext3_flushpage+34/40] charon kernel:    [do_flushpage+25/44]
> [truncate_complete_page+19/72] [truncate_list_pages+254/352]
> [truncate_inode_pages+67/108] [dispose_list+50/84]
> [invalidate_inodes+91/104] [kill_super+167/316] [__mntput+30/36]
> [path_release+39/44] [sys_umount+167/180] [sys_munmap+53/84]
> [sys_oldumount+12/16] [system_call+51/56] Code: 89 13 51 9d 5b 5e c3 90
> 9c 58 fa 8b 4a 0c 8b 52 08 89 4a 04

uh-oh.

kill_super() calls ext3_put_super(), which releases all the
filesystem resources.  kill_super() then calls invalidate_inodes()
which ends up inside the filesystem, which is now dead.

Before ext3, all the truncate cleanup code purely operated
at the buffer/page layer, and never made calls into the fs.
We changed that, and it broke.

I cannot believe this wasn't noticed before.

Thanks for the trace.

-
