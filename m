Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVESSOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVESSOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 14:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVESSOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 14:14:36 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:25865 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261199AbVESSOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 14:14:25 -0400
To: Oleg <graycardinal@pisem.net>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: PROBLEM: kmem_cache_create: duplicate cache fat_cache
References: <200505181217.29904.graycardinal@pisem.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 20 May 2005 03:10:08 +0900
In-Reply-To: <200505181217.29904.graycardinal@pisem.net> (Oleg's message of "Wed, 18 May 2005 12:17:29 +0400")
Message-ID: <87br779jen.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg <graycardinal@pisem.net> writes:

> [1.] kmem_cache_create: duplicate cache fat_cache
> [2.] When I load module vfat, I'm have BUG. vfat is embedded in my kernel.
> [3.] modules
> [4.] Linux version 2.6.12-rc3-mm3 (root@localhost.localdomain) (gcc version 
> 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #18 SMP
> [5.] kmem_cache_create: duplicate cache fat_cache
> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:1491!
> invalid operand: 0000 [#1]
> PREEMPT SMP
> Modules linked in: fat nls_utf8 nls_cp866 nls_cp855 video hotkey
> CPU:    0
> EIP:    0060:[<c014a38f>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.12-rc3-mm3)
> EIP is at kmem_cache_create+0x45f/0x5e0
> eax: 00000030   ebx: f7d187b4   ecx: 0000000d   edx: 00000202
> esi: c03c91ef   edi: f885ed6e   ebp: f7de1580   esp: f74d1f44
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 2487, threadinfo=f74d0000 task=f7eef090)
> Stack: c03c6f80 f885ed64 00000004 00020000 f74d1f6c f7de15d8 000000a9 c0000000
>        fffffffc 00000004 00000010 f8862540 00000000 0804e130 f74d0000 f8806037
>        f885ed64 00000014 00000000 00020000 f8857000 00000000 f88060e5 c013a8f4
> Call Trace:
>  [<f8806037>] fat_cache_init+0x37/0x80 [fat]
>  [<f8857000>] init_once+0x0/0x20 [fat]
>  [<f88060e5>] init_fat_fs+0x5/0xc [fat]
>  [<c013a8f4>] sys_init_module+0x124/0x1a0
>  [<c0103175>] syscall_call+0x7/0xb
> Code: 00 04 00 74 ec e9 8a 01 00 00 8b 4c 24 40 c7 04 24 80 6f 3c c0 89 4c 24 
> 04 e8 4e 44 fd ff f0 ff 05 ac d2 50 c0 0f 8e 73 1a 00 00 <0f> 0b d3 05 95 65 
> 3c c0 8b 0b e9 65 ff ff ff 8b 47 50 c7 04 24

[...]

> [7.7.] module vfat && embedded vfat normal situation, and I'm don't like BUG 
> in my dmesg... Sorry, I'm from Russia.

Ummm... why is this normal situation? Didn't you run the
modules_install after changed .config?  Anyway, this patch returns
NULL instead of calling BUG().  This case seems to also happen with
user error.

Manfred, what do you think of this?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 mm/slab.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN mm/slab.c~slab-dont-call-bug mm/slab.c
--- linux-2.6.12-rc4/mm/slab.c~slab-dont-call-bug	2005-05-20 02:37:21.000000000 +0900
+++ linux-2.6.12-rc4-hirofumi/mm/slab.c	2005-05-20 02:39:42.000000000 +0900
@@ -1482,8 +1482,10 @@ next:
 				printk("kmem_cache_create: duplicate cache %s\n",name); 
 				up(&cache_chain_sem); 
 				unlock_cpu_hotplug();
-				BUG(); 
-			}	
+				set_fs(old_fs);
+				cachep = NULL;
+				goto oops;
+			}
 		}
 		set_fs(old_fs);
 	}
_
