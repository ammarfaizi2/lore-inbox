Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267934AbTB1Oyc>; Fri, 28 Feb 2003 09:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267941AbTB1Oyc>; Fri, 28 Feb 2003 09:54:32 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:4224 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S267934AbTB1Oy1>;
	Fri, 28 Feb 2003 09:54:27 -0500
Date: Fri, 28 Feb 2003 16:04:47 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Memory modified after freeing in 2.5.63?
Message-ID: <20030228150447.GA3862@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  for some time I'm using patch attached at the end of this email, 
which modifies check_poison function to not only verify that
last byte is POISON_END, but also that all preceeding bytes are
either POISON_BEFORE or POISON_AFTER bytes. 

  And now when I returned from my month vacation and upgraded 
from 2.5.52 to 2.5.63, when dselect/apt updates dozens of packages, 
I'm getting memory corruption reports as shown below - 22nd byte 
in vm_area_struct - which looks like that VM_ACCOUNT in vm_flags 
is set after vma is freeed...  Any clue? Setting VM_ACCOUNT
in mremap.c:move_vma after calling do_unmap() looks suspicious
to me, but as I know almost nothing about MM...

  Kernel is SMP, 2.5.63, with all debugging except stack frame
enabled, running on UP P4.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

(* = POISON_AFTER, . = POISON_BEFORE, number = other value)
    
Corruption! start=d134abb4, expend=d134abf3, problemat=d134abca
Data: **********************7B ****************************************A5 
Next: 71 F0 2C .A5 C2 0F 17 20 E2 32 DA 00 40 01 40 00 50 01 40 A4 9F 9A D9 25 00 00 00 73 00 10 00 
slab error in check_poison_obj(): cache `vm_area_struct': object was modified after freeing
Call Trace:
 [<c014165c>] check_poison_obj+0xf7/0x130
 [<c0143ba9>] cache_alloc_debugcheck_after+0xbd/0xc5
 [<c0142ac7>] kmem_cache_alloc+0x6c/0xaa
 [<c014cb50>] split_vma+0x56/0x123
 [<c014ccdd>] do_munmap+0xc0/0x1cd
 [<c014b832>] sys_brk+0x127/0x12b
 [<c01096cf>] syscall_call+0x7/0xb

Corruption! start=d134a734, expend=d134a773, problemat=d134a74a
Data: **********************7B ****************************************A5 
Next: 71 F0 2C .71 F0 2C .************************
slab error in check_poison_obj(): cache `vm_area_struct': object was modified after freeing
Call Trace:
 [<c014165c>] check_poison_obj+0xf7/0x130
 [<c0143ba9>] cache_alloc_debugcheck_after+0xbd/0xc5
 [<c0142212>] kmem_flagcheck+0x1f/0x2b
 [<c0142ac7>] kmem_cache_alloc+0x6c/0xaa
 [<c014e27f>] move_vma+0x269/0x598
 [<c012b0be>] update_wall_time+0xd/0x36
 [<c014d3f8>] arch_get_unmapped_area+0x72/0xb7
 [<c014e83b>] do_mremap+0x28d/0x3eb
 [<c014ea0a>] sys_mremap+0x71/0x9a
 [<c01096cf>] syscall_call+0x7/0xb

Corruption! start=d13b76a4, expend=d13b76e3, problemat=d13b76ba
Data: **********************7B ****************************************A5 
Next: 71 F0 2C .A5 C2 0F 17 90 A8 F3 D9 00 20 20 40 00 20 21 40 94 01 B6 D9 25 00 00 00 75 00 00 00 
slab error in check_poison_obj(): cache `vm_area_struct': object was modified after freeing
Call Trace:
 [<c014165c>] check_poison_obj+0xf7/0x130
 [<c0143ba9>] cache_alloc_debugcheck_after+0xbd/0xc5
 [<c0142ac7>] kmem_cache_alloc+0x6c/0xaa
 [<c014cb50>] split_vma+0x56/0x123
 [<c014ccdd>] do_munmap+0xc0/0x1cd
 [<c014b832>] sys_brk+0x127/0x12b
 [<c01096cf>] syscall_call+0x7/0xb

Corruption! start=d134aecc, expend=d134af0b, problemat=d134aee2
Data: **********************7B ****************************************A5 
Next: 71 F0 2C .71 F0 2C .************************
slab error in check_poison_obj(): cache `vm_area_struct': object was modified after freeing
Call Trace:
 [<c014165c>] check_poison_obj+0xf7/0x130
 [<c0143ba9>] cache_alloc_debugcheck_after+0xbd/0xc5
 [<c0142ac7>] kmem_cache_alloc+0x6c/0xaa
 [<c014e27f>] move_vma+0x269/0x598
 [<c012b0be>] update_wall_time+0xd/0x36
 [<c014d3f8>] arch_get_unmapped_area+0x72/0xb7
 [<c014e83b>] do_mremap+0x28d/0x3eb
 [<c014ea0a>] sys_mremap+0x71/0x9a
 [<c01096cf>] syscall_call+0x7/0xb

diff -urdN linux/mm/slab.c linux/mm/slab.c
--- linux/mm/slab.c	2003-02-24 20:20:02.000000000 +0000
+++ linux/mm/slab.c	2003-02-24 20:54:51.000000000 +0000
@@ -768,6 +768,20 @@
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }
 
+static void* fprob(unsigned char* addr, unsigned int size) {
+	unsigned char* end;
+	
+	end = addr + size - 1;
+
+	for (; addr < end; addr++) {
+		if (*addr != POISON_BEFORE && *addr != POISON_AFTER)
+			return addr;
+	}
+	if (*addr != POISON_END)
+		return addr;
+	return NULL;
+}
+
 static void check_poison_obj(kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
@@ -776,9 +790,32 @@
 		addr += BYTES_PER_WORD;
 		size -= 2*BYTES_PER_WORD;
 	}
-	end = memchr(addr, POISON_END, size);
-	if (end != (addr+size-1))
+	end = fprob(addr, size);
+	if (end) {
+		int s;
+		printk(KERN_ERR "Corruption! start=%p, expend=%p, problemat=%p\n", addr, addr+size-1, end);
+		printk(KERN_ERR "Data: ");
+		for (s = 0; s < size; s++) {
+			if (((char*)addr)[s] == POISON_BEFORE)
+				printk(".");
+			else if (((char*)addr)[s] == POISON_AFTER)
+				printk("*");
+			else
+				printk("%02X ", ((unsigned char*)addr)[s]);
+		}
+		printk("\n");
+		printk(KERN_ERR "Next: ");
+		for (; s < size + 32; s++) {
+			if (((char*)addr)[s] == POISON_BEFORE)
+				printk(".");
+			else if (((char*)addr)[s] == POISON_AFTER)
+				printk("*");
+			else
+				printk("%02X ", ((unsigned char*)addr)[s]);
+		}
+		printk("\n");
 		slab_error(cachep, "object was modified after freeing");
+	}
 }
 #endif
 
