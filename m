Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWKBJwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWKBJwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 04:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbWKBJwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 04:52:24 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:50913 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750841AbWKBJwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 04:52:23 -0500
Date: Thu, 02 Nov 2006 18:51:49 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "bibo,mao" <bibo.mao@intel.com>, David Howells <dhowells@redhat.com>,
       Ian Kent <raven@themaw.net>
Subject: Re: [BUG] 2.6.19-rc3 autofs crash on my IA64 box
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45485478.8060909@intel.com>
References: <45485478.8060909@intel.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20061102183020.446D.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.27 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> hi,
>   2.6.19-rc3 kernel crashes on my IA64 box, it seems the problem
> of autofs fs. I debug this problem, if autofs kernel does not
> match daemon version, it will call autofs_catatonic_mode.
> But at that time sbi->pipe is NULL.
> 
> void autofs_catatonic_mode(struct autofs_sb_info *sbi)
> {
>    .........
>    fput(sbi->pipe);        /* Close the pipe */
> 	^^^^^^^^^^^^
>  	sbi->pipe seems NULL;
>    autofs_hash_dputall(&sbi->dirhash); /* Remove all dentry pointers */
> }
> 

My box crashed too.

Following fix does not seem enough.
http://marc.theaimsgroup.com/?l=linux-kernel&m=116110204104327&w=2
If version does not match at autofs_fill_super(), then sbi->pipe
is not set yet.
I suppose something like following patch is necessary.

Thanks.

-------------
Index: stocktest/fs/autofs/waitq.c
===================================================================
--- stocktest.orig/fs/autofs/waitq.c	2006-03-10 11:36:40.000000000 +0900
+++ stocktest/fs/autofs/waitq.c	2006-11-02 18:44:58.000000000 +0900
@@ -40,7 +40,8 @@ void autofs_catatonic_mode(struct autofs
 		wake_up(&wq->queue);
 		wq = nwq;
 	}
-	fput(sbi->pipe);	/* Close the pipe */
+	if (sbi->pipe)
+		fput(sbi->pipe);	/* Close the pipe */
 	autofs_hash_dputall(&sbi->dirhash); /* Remove all dentry pointers */
 }
 

---------------

> 
> Starting automount: autofs: kernel does not match daemon version
> Unable to handle kernel NULL pointer dereference (address 0000000000000028)
> automount[3197]: Oops 8821862825984 [1]
> Modules linked in: sunrpc binfmt_misc dm_mirror dm_mod thermal processor fan cod
>  
> Pid: 3188, CPU 1, comm:            automount
> psr : 00001010085a6010 ifs : 8000000000000205 ip  : [<a00000010012bde0>]    Notd
> ip is at fput+0x20/0x60
> unat: 0000000000000000 pfs : 000000000000038b rsc : 0000000000000003
> rnat: 00000000000000a0 bsps: 000000000001003e pr  : 40a80004065625a9
> ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c0270033f
> csd : 0000000000000000 ssd : 0000000000000000
> b0  : a0000001001f4d00 b6  : a0000001001f2600 b7  : a000000100155c00
> f6  : 1003e0000000000000000 f7  : 1003e00000000000000a0
> f8  : 1003e0000000000000001 f9  : 1003e0000000000000001
> f10 : 000000000000000000000 f11 : 000000000000000000000
> r1  : a0000001009e6e10 r2  : 0000000000000028 r3  : e0000001f881c008
> r8  : 0000000000000001 r9  : 0000000040000000 r10 : ffffffffc0000001
> r11 : 0000000000000018 r12 : e0000001fab4fbe0 r13 : e0000001fab48000
> r14 : 0000000000000001 r15 : 0000000000000038 r16 : e0000001f881c030
> r17 : 00000000ffffffff r18 : e0000002fffa0f88 r19 : 0000000000000001
> r20 : e0000001fab48b64 r21 : a0007fffff1971b0 r22 : e0000002fff95198
> r23 : e0000002fff95188 r24 : 0000000000000001 r25 : 0000000000000000
> r26 : 0000000000000009 r27 : 0000000000000000 r28 : a018000000000000
> r29 : 8000000000000080 r30 : 0000000000000000 r31 : a0000001007fb2cc
>  
> Call Trace:
>  [<a000000100013b80>] show_stack+0x40/0xa0
>                                 sp=e0000001fab4f770 bsp=e0000001fab48fa0
>  [<a0000001000147e0>] show_regs+0x840/0x880
>                                 sp=e0000001fab4f940 bsp=e0000001fab48f48
>  [<a0000001000369e0>] die+0x1c0/0x2c0
>                                 sp=e0000001fab4f940 bsp=e0000001fab48f00
>  [<a0000001005734f0>] ia64_do_page_fault+0x930/0xa60
>                                 sp=e0000001fab4f960 bsp=e0000001fab48eb0
>  [<a00000010000c3a0>] ia64_leave_kernel+0x0/0x280
>                                 sp=e0000001fab4fa10 bsp=e0000001fab48eb0
>  [<a00000010012bde0>] fput+0x20/0x60
>                                 sp=e0000001fab4fbe0 bsp=e0000001fab48e88
>  [<a0000001001f4d00>] autofs_catatonic_mode+0xe0/0x120
>                                 sp=e0000001fab4fbe0 bsp=e0000001fab48e50
>  [<a0000001001f2640>] autofs_kill_sb+0x40/0x140
>                                 sp=e0000001fab4fbe0 bsp=e0000001fab48e20
>  [<a00000010012dc50>] deactivate_super+0xd0/0x120
>                                 sp=e0000001fab4fbe0 bsp=e0000001fab48de8
>  [<a00000010012f500>] get_sb_nodev+0xe0/0x160
>                                 sp=e0000001fab4fbe0 bsp=e0000001fab48da0
>  [<a0000001001f1b60>] autofs_get_sb+0x40/0x60
>                                 sp=e0000001fab4fbe0 bsp=e0000001fab48d60
>  [<a00000010012dd40>] vfs_kern_mount+0xa0/0x160
>                                 sp=e0000001fab4fbe0 bsp=e0000001fab48d18
>  [<a00000010012dec0>] do_kern_mount+0x60/0xa0
>                                 sp=e0000001fab4fbe0 bsp=e0000001fab48cd8
>  [<a00000010015ebc0>] do_mount+0xce0/0xde0
>                                 sp=e0000001fab4fbe0 bsp=e0000001fab48c80
>  [<a00000010015edb0>] sys_mount+0xf0/0x1c0
>                                 sp=e0000001fab4fe10 bsp=e0000001fab48be8
>  [<a00000010000c200>] ia64_ret_from_syscall+0x0/0x20
>                                 sp=e0000001fab4fe30 bsp=e0000001fab48be8
>  [<a000000000010620>] __kernel_syscall_via_break+0x0/0x20
>                                 sp=e0000001fab50000 bsp=e0000001fab48be8
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Yasunori Goto 


