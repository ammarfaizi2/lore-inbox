Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbVHJPkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbVHJPkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVHJPkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:40:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965163AbVHJPkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:40:23 -0400
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Boot failure with slab debugging patch
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Wed, 10 Aug 2005 16:40:09 +0100
Message-ID: <15113.1123688409@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

This patch in 2.6.13-rc5-mm1:

	slab-leak-detector-give-longer-traces.patch

Causes the kernel to die with an oops on my test box during boot (see
attached), just about here, I think:

	static void inline *
	cache_alloc_debugcheck_after(kmem_cache_t *cachep,
				unsigned int __nocast flags, void *objp, void *caller)
	{
		if (!objp)	
			return objp;
		if (cachep->flags & SLAB_POISON) {
	#ifdef CONFIG_DEBUG_PAGEALLOC
			if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep))
				kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE, 1);
			else
				check_poison_obj(cachep, objp);
	#else
			check_poison_obj(cachep, objp);
	#endif
			poison_obj(cachep, objp, POISON_INUSE);
		}
		if (cachep->flags & SLAB_STORE_USER) {
			*dbg_userword1(cachep, objp) = caller; /* address(0) */
			*dbg_userword2(cachep, objp) = __builtin_return_address(1);
--->			*dbg_userword3(cachep, objp) = __builtin_return_address(2);
		}


Shortly after the call instruction to dbg_userword3().

Repealing that patch permits the kernel to work again.

David


Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 126088k/131072k available (2167k kernel code, 4476k reserved, 587k data, 188k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Unable to handle kernel paging request at virtual address fdf000e6
 printing eip:
c014a766
*pde = 00000000
Oops: 0000 [#1]
SMP
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c014a766>]    Not tainted VLI
EFLAGS: 00010282   (2.6.13-rc5-mm1)
EIP is at kmem_cache_alloc+0x146/0x230
eax: c115c568   ebx: 0000005a   ecx: 00000054   edx: fdf000e2
esi: c115c518   edi: c115f080   ebp: c03b3fa0   esp: c03b3f7c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03b2000 task=c0360c60)
Stack: c115f080 c115c518 0000005a 00000000 00000001 c03c4cdb c03669bc 800000d0
       c115c4ec 00000009 c03c4cdb c115f080 800000d0 00000000 80046800 00000000
       00000000 c03b2000 00000080 00000001 00000001 00000000 00099100 c03aa800
Call Trace:
 [<c03c4cdb>] kmem_cache_init+0x2eb/0x420
 [<c03c4cdb>] kmem_cache_init+0x2eb/0x420
 [<c03b49a2>] start_kernel+0xf2/0x190
 [<c03b43b0>] unknown_bootoption+0x0/0x1f0
Code: ff 8b 55 f0 89 10 89 74 24 04 89 3c 24 e8 83 d6 ff ff 8b 55 00 8b 52 04 89 10 89 74 24 04 89 3c 24 e8 3f d6 ff ff 8b 55 00 8b 12 <8b> 52 04 89 10 8b 47 1c f6 c4 04 0f 84 21 ff ff ff 89 f6 8d bc
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
