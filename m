Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313102AbSDJOKI>; Wed, 10 Apr 2002 10:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313109AbSDJOKH>; Wed, 10 Apr 2002 10:10:07 -0400
Received: from [62.221.7.202] ([62.221.7.202]:48010 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313102AbSDJOKD>; Wed, 10 Apr 2002 10:10:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.8-pre3 set_bit cleanup II
Date: Wed, 10 Apr 2002 23:42:36 +1000
Message-Id: <E16vINE-0002Yc-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes over some bogus casts, and converts the ext2, hfs and
minix set-bit macros.  Also changes pte and open_fds to hand the
actual bitfield rather than whole structure.

No object code changes again...
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/mm/swapfile.c working-2.5.7-pre1-bitops/mm/swapfile.c
--- linux-2.5.7-pre1/mm/swapfile.c	Fri Mar  8 14:49:30 2002
+++ working-2.5.7-pre1-bitops/mm/swapfile.c	Sat Mar 16 12:59:37 2002
@@ -959,7 +959,7 @@
 		p->lowest_bit = 0;
 		p->highest_bit = 0;
 		for (i = 1 ; i < 8*PAGE_SIZE ; i++) {
-			if (test_bit(i,(char *) swap_header)) {
+			if (test_bit(i,(unsigned long *) swap_header)) {
 				if (!p->lowest_bit)
 					p->lowest_bit = i;
 				p->highest_bit = i;
@@ -974,7 +974,7 @@
 			goto bad_swap;
 		}
 		for (i = 1 ; i < maxpages ; i++) {
-			if (test_bit(i,(char *) swap_header))
+			if (test_bit(i,(unsigned long *) swap_header))
 				p->swap_map[i] = 0;
 			else
 				p->swap_map[i] = SWAP_MAP_BAD;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-ppc/bitops.h working-2.5.7-pre1-bitops/include/asm-ppc/bitops.h
--- linux-2.5.7-pre1/include/asm-ppc/bitops.h	Fri Mar 15 13:00:59 2002
+++ working-2.5.7-pre1-bitops/include/asm-ppc/bitops.h	Sat Mar 16 12:59:37 2002
@@ -394,8 +394,8 @@
 
 #ifdef __KERNEL__
 
-#define ext2_set_bit(nr, addr)		__test_and_set_bit((nr) ^ 0x18, addr)
-#define ext2_clear_bit(nr, addr)	__test_and_clear_bit((nr) ^ 0x18, addr)
+#define ext2_set_bit(nr, addr)	__test_and_set_bit((nr) ^ 0x18, (unsigned long *)(addr))
+#define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr) ^ 0x18, (unsigned long *)(addr))
 
 static __inline__ int ext2_test_bit(int nr, __const__ void * addr)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/hfs_sysdep.h working-2.5.7-pre1-bitops/include/linux/hfs_sysdep.h
--- linux-2.5.7-pre1/include/linux/hfs_sysdep.h	Fri Mar 15 13:32:10 2002
+++ working-2.5.7-pre1-bitops/include/linux/hfs_sysdep.h	Sat Mar 16 12:59:37 2002
@@ -200,16 +200,16 @@
 #endif
 
 static inline int hfs_clear_bit(int bitnr, hfs_u32 *lword) {
-	return test_and_clear_bit(BITNR(bitnr), lword);
+	return test_and_clear_bit(BITNR(bitnr), (unsigned long *)lword);
 }
 
 static inline int hfs_set_bit(int bitnr, hfs_u32 *lword) {
-	return test_and_set_bit(BITNR(bitnr), lword);
+	return test_and_set_bit(BITNR(bitnr), (unsigned long *)lword);
 }
 
 static inline int hfs_test_bit(int bitnr, const hfs_u32 *lword) {
 	/* the kernel should declare the second arg of test_bit as const */
-	return test_bit(BITNR(bitnr), (void *)lword);
+	return test_bit(BITNR(bitnr), (unsigned long *)lword);
 }
 
 #undef BITNR
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/bitops.h working-2.5.7-pre1-bitops/include/asm-i386/bitops.h
--- linux-2.5.7-pre1/include/asm-i386/bitops.h	Sat Mar 16 13:03:31 2002
+++ working-2.5.7-pre1-bitops/include/asm-i386/bitops.h	Sat Mar 16 13:48:31 2002
@@ -469,18 +469,23 @@
 
 #ifdef __KERNEL__
 
-#define ext2_set_bit                 __test_and_set_bit
-#define ext2_clear_bit               __test_and_clear_bit
-#define ext2_test_bit                test_bit
-#define ext2_find_first_zero_bit     find_first_zero_bit
-#define ext2_find_next_zero_bit      find_next_zero_bit
+#define ext2_set_bit(nr,addr) \
+	__test_and_set_bit((nr),(unsigned long*)addr)
+#define ext2_clear_bit(nr, addr) \
+	__test_and_clear_bit((nr),(unsigned long*)addr)
+#define ext2_test_bit(nr, addr)      test_bit((nr),(unsigned long*)addr)
+#define ext2_find_first_zero_bit(addr, size) \
+	find_first_zero_bit((unsigned long*)addr, size)
+#define ext2_find_next_zero_bit(addr, size, off) \
+	find_next_zero_bit((unsigned long*)addr, size, off)
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,(void*)addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,(void*)addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,(void*)addr)
+#define minix_test_bit(nr,addr) test_bit(nr,(void*)addr)
+#define minix_find_first_zero_bit(addr,size) \
+	find_first_zero_bit((void*)addr,size)
 
 #endif /* __KERNEL__ */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/pgtable.h working-2.5.7-pre1-bitops/include/asm-i386/pgtable.h
--- linux-2.5.7-pre1/include/asm-i386/pgtable.h	Sat Mar 16 13:27:33 2002
+++ working-2.5.7-pre1-bitops/include/asm-i386/pgtable.h	Sat Mar 16 13:48:37 2002
@@ -288,10 +288,10 @@
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 
-static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_DIRTY, ptep); }
-static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep); }
-static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, ptep); }
-static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, ptep); }
+static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
+static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low); }
+static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, &ptep->pte_low); }
+static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/fs/open.c working-2.5.7-pre1-bitops/fs/open.c
--- linux-2.5.7-pre1/fs/open.c	Fri Mar  8 14:49:26 2002
+++ working-2.5.7-pre1-bitops/fs/open.c	Sat Mar 16 12:59:37 2002
@@ -704,7 +704,7 @@
 	write_lock(&files->file_lock);
 
 repeat:
- 	fd = find_next_zero_bit(files->open_fds, 
+ 	fd = find_next_zero_bit(files->open_fds->fds_bits, 
 				files->max_fdset, 
 				files->next_fd);
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
