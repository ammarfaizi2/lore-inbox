Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbTCJE0Z>; Sun, 9 Mar 2003 23:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262710AbTCJE0Z>; Sun, 9 Mar 2003 23:26:25 -0500
Received: from toq6.bellnexxia.net ([209.226.175.62]:48049 "EHLO
	toq6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262708AbTCJE0Y>; Sun, 9 Mar 2003 23:26:24 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH] nonlinear oddities
To: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: tomlins@cam.org
Date: Sat, 08 Mar 2003 20:37:47 -0500
References: <fa.o2ppdof.u56795@ifi.uio.no> <fa.k4ichtj.1rh0gp5@ifi.uio.no>
Organization: me
User-Agent: KNode/0.7.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030309013747.D394BC0@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote:

> 
> --On Thursday, March 06, 2003 19:14:47 +0000 Hugh Dickins
> <hugh@veritas.com> wrote:
> 
>> Now I think about it more, install_page's SetPageAnon is not good at all.
>> That (unlocked) page may already be mapped into other vmas as a shared
>> file page, non-zero mapcount, we can't suddenly switch it to Anon
>> (pte_chained) without doing the work to handle that case.
> 
> Ouch.  You're right.  I'll go stare at it for awhile and see if any
> solutions jump out at me.  I suppose at worst I could write a function to
> convert an object page to use pte_chains, but it'd be nice if that weren't
> necessary.
> 
> Dave McCracken

Does this look like the above happening?  

Mar  8 18:44:31 oscar kernel:  printing eip:
Mar  8 18:44:31 oscar kernel: c012a29c
Mar  8 18:44:31 oscar kernel: Oops: 0002
Mar  8 18:44:31 oscar kernel: CPU:    0
Mar  8 18:44:31 oscar kernel: EIP:    0060:[find_get_page+40/72]    Not tainted
Mar  8 18:44:31 oscar kernel: EFLAGS: 00010206
Mar  8 18:44:31 oscar kernel: EIP is at find_get_page+0x28/0x48
Mar  8 18:44:31 oscar kernel: eax: 6e2f6572   ebx: d3c7e000   ecx: 00000000   edx: d88a2288
Mar  8 18:44:31 oscar kernel: esi: 6e2f6572   edi: 00000000   ebp: d3c7fe34   esp: d3c7fe2c
Mar  8 18:44:31 oscar kernel: ds: 007b   es: 007b   ss: 0068
Mar  8 18:44:31 oscar kernel: Process startkde (pid: 1514, threadinfo=d3c7e000 task=d9446720)
Mar  8 18:44:31 oscar kernel: Stack: d3c7fea0 00000000 d3c7fe60 c012a61b d74e3b68 00000000 d3c7fea0 00000000
Mar  8 18:44:31 oscar kernel:        00000000 00001000 00000000 00000000 d74e3ad4 d3c7feb0 c012ab3f d74e3b68
Mar  8 18:44:31 oscar kernel:        d6b1366c d6b13620 d6b13640 d3c7fea0 c012a8c8 d3c7fed8 d6b13640 d6b13620
Mar  8 18:44:31 oscar kernel: Call Trace:
Mar  8 18:44:31 oscar kernel:  [do_generic_mapping_read+119/804] do_generic_mapping_read+0x77/0x324
Mar  8 18:44:31 oscar kernel:  [__generic_file_aio_read+379/408] __generic_file_aio_read+0x17b/0x198
Mar  8 18:44:31 oscar kernel:  [file_read_actor+0/252] file_read_actor+0x0/0xfc
Mar  8 18:44:31 oscar kernel:  [generic_file_read+127/156] generic_file_read+0x7f/0x9c
Mar  8 18:44:31 oscar kernel:  [handle_mm_fault+107/292] handle_mm_fault+0x6b/0x124
Mar  8 18:44:31 oscar kernel:  [do_page_fault+0/1029] do_page_fault+0x0/0x405
Mar  8 18:44:31 oscar kernel:  [open_namei+726/1020] open_namei+0x2d6/0x3fc
Mar  8 18:44:31 oscar kernel:  [dentry_open+231/480] dentry_open+0xe7/0x1e0
Mar  8 18:44:31 oscar kernel:  [file_ioctl+331/352] file_ioctl+0x14b/0x160
Mar  8 18:44:31 oscar kernel:  [vfs_read+171/336] vfs_read+0xab/0x150
Mar  8 18:44:31 oscar kernel:  [sys_read+40/60] sys_read+0x28/0x3c
Mar  8 18:44:31 oscar kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar  8 18:44:31 oscar kernel:
Mar  8 18:44:31 oscar kernel: Code: ff 46 04 90 ff 4b 10 8b 43 08 a8 08 74 06 e8 19 96 fe ff 90

This was with 64-mm2 after stoping X, changing some font parms, and restarting it

Ed Tomlinson

