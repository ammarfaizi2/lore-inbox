Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVHHU6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVHHU6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVHHU6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:58:05 -0400
Received: from graphe.net ([209.204.138.32]:36794 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932205AbVHHU6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:58:04 -0400
Date: Mon, 8 Aug 2005 13:57:59 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [SLAB] __builtin_return_address use without FRAME_POINTER causes
 boot failure
Message-ID: <Pine.LNX.4.62.0508081353170.28612@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I kept getting boot failures in the slab allocator. The failure goes 
away if one is setting CONFIG_FRAME_POINTER. Seems that 
CONFIG_DEBUG_SLAB implies the use of __buildin_return_address() which 
needs the framepointer.

Crash with 2.6.15-rc3-mm1:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013bebf
*pde = 00000000
Oops: 0000 [#1]
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c013bebf>]    Not tainted VLI
EFLAGS: 00010292   (2.6.13-rc5-mm1)
EIP is at kmem_cache_alloc+0x16f/0x1c0
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: c17de13c
esi: c17df080   edi: c17de13c   ebp: c0377f6c   esp: c0377f48
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0376000 task=c0329b80)
Stack: c0377f7c 00000004 fffffffc 0000001c c013af6e 800000d0 0000002e 00000000
       c17df15c c17df140 c013af6e 00052c00 c0377f98 c17df15c 00000025 ffffffff
       fffffffc 00000004 00000054 c02e5551 00000014 ffffffc0 0000001c 00000040
Call Trace:
 [<c013af6e>] kmem_cache_create+0x59e/0x7b0
 [<c013af6e>] kmem_cache_create+0x59e/0x7b0
 [<c03826d1>] kmem_cache_init+0x1d1/0x380
 [<c03786dd>] start_kernel+0xcd/0x150
 [<c0378340>] unknown_bootoption+0x0/0x1a0
Code: 5a 75 8b eb ca 89 fa 89 f0 e8 8e e0 ff ff 8b 55 ec 89 10 89 fa 8b 45 00 8b 58 04 89 f0 e8 5a e0 ff ff 89 fa 89 18 8b 45 00 8b 00 <8b> 58 04 89 f0 e8 27 e0 ff ff 89 18 8b 46 18 e9 d7 fe ff ff 89
 <0>Kernel panic - not syncing: Attempted to kill the idle task!


Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc5-mm1/lib/Kconfig.debug
===================================================================
--- linux-2.6.13-rc5-mm1.orig/lib/Kconfig.debug	2005-08-08 11:02:36.000000000 -0700
+++ linux-2.6.13-rc5-mm1/lib/Kconfig.debug	2005-08-08 13:43:17.000000000 -0700
@@ -79,7 +79,7 @@
 
 config DEBUG_SLAB
 	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && FRAME_POINTER
 	help
 	  Say Y here to have the kernel do limited verification on memory
 	  allocation as well as poisoning memory on free to catch use of freed
