Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTFOBow (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 21:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTFOBow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 21:44:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261773AbTFOBov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 21:44:51 -0400
Date: Sat, 14 Jun 2003 18:58:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Florin Iucha <florin@iucha.net>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71
In-Reply-To: <20030615014221.GA25303@iucha.net>
Message-ID: <Pine.LNX.4.44.0306141849290.20728-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 14 Jun 2003, Florin Iucha wrote:
> 
> I booted 2.5.71 and in 3-4 minutes my X froze. I did a SysReq-S and a
> SysReq-T.
> 
> SysReq-T unfroze the box. I logged out from Gnome, went into a console
> and attempted to login. In the middle of typing the id, the nfs/rpc 
> oops came, then the big oops and the box locked up.

Ok, that does look like the list poisoning. The poisoning uses 0x00100100
as the poison value, and that's the address that oopsed for you:

> Unable to handle kernel paging request at virtual address 00100104
>  printing eip:
> c0166951
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c0166951>]    Not tainted
> EFLAGS: 00010286
> EIP is at dput+0x91/0x200
> eax: 00100100   ebx: e8ea3500   ecx: e8ea3514   edx: 00200200
> esi: e69ea000   edi: e8ea3514   ebp: e8ea35dc   esp: e69ebea4
> ds: 007b   es: 007b   ss: 0068
> Process umount (pid: 768, threadinfo=e69ea000 task=e8fce680)
> Stack: e8ea3500 c0454c50 e8ea3500 00000000 e8ea3514 c03454bc e8ea3500 e8ea3500 
>        e8e33528 e8e334c0 e8ea3570 e8ea35c0 e8ea35c0 e8e339a8 e8e33940 c0345aaf 
>        e8ea35c0 e8ea3800 e8ea3800 effe4d80 e8e97e19 00000005 10ee271a 00000010 
> Call Trace:
>  [<c03454bc>] rpc_depopulate+0xac/0x150
>  [<c0345aaf>] rpc_rmdir+0x7f/0xc0
>  [<c033639f>] rpc_destroy_client+0x5f/0x90
>  [<c018925f>] nfs_put_super+0x1f/0x50
>  [<c0156706>] generic_shutdown_super+0x176/0x190
>  [<c0156fc7>] kill_anon_super+0x17/0x50
>  [<c018b7d9>] nfs_kill_super+0x19/0x30
>  [<c015644e>] deactivate_super+0x5e/0xc0
>  [<c016bfcf>] sys_umount+0x3f/0x90
>  [<c016c037>] sys_oldumount+0x17/0x20
>  [<c010aa67>] syscall_call+0x7/0xb
> Code: 89 50 04 89 02 c7 41 04 00 02 20 00 c7 43 14 00 01 10 00 ff 

We had earlier problems with NFS unmounting, and I thought they were 
resolved, but obviously they aren't.

Florin, does it work for you if you remove the poisoning in 
<linux/list.h>? (Just search for "POISON" and remove those lines).

Trond, any ideas?

		Linus

