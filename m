Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUHYJOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUHYJOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUHYJOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:14:37 -0400
Received: from [212.209.10.220] ([212.209.10.220]:31453 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S263429AbUHYJNq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:13:46 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: [2.6 PATCH 2/6] CRIS architecture update
Date: Wed, 25 Aug 2004 11:13:43 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F512@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains changes necessary to compile and boot with 2.6.8.1.

diff -urNP --exclude='*.cvsignore'
../linux/arch/cris/arch-v10/kernel/debugport.c
lx25/arch/cris/arch-v10/kernel/debugport.c
--- ../linux/arch/cris/arch-v10/kernel/debugport.c	Sat Aug 14 07:36:12
2004
+++ lx25/arch/cris/arch-v10/kernel/debugport.c	Tue Aug 24 08:12:19 2004
@@ -12,6 +12,12 @@
  *    init_etrax_debug()
  *
  * $Log: debugport.c,v $
+ * Revision 1.16  2004/08/24 06:12:19  starvik
+ * Whitespace cleanup
+ *
+ * Revision 1.15  2004/08/16 12:37:19  starvik
+ * Merge of Linux 2.6.8
+ *
  * Revision 1.14  2004/05/17 13:11:29  starvik
  * Disable DMA until real serial driver is up
  *
@@ -227,10 +233,21 @@
 }
 
 static struct tty_driver*
-console_device(struct console *c, int *index)
+console_device(int *index)
 {
-	*index = c->index;
-	return serial_driver;
+	struct console *c;
+	struct tty_driver *driver = NULL;
+  
+	acquire_console_sem();
+	for (c = console_drivers; c != NULL; c = c->next) {
+		if (!c->device)
+			continue;
+		driver = c->device(c, index);
+		if (driver)
+			break;
+	}
+	release_console_sem();
+	return driver;
 }
 
 static int __init 
diff -urNP --exclude='*.cvsignore'
../linux/arch/cris/arch-v10/drivers/axisflashmap.c
lx25/arch/cris/arch-v10/drivers/axisflashmap.c
--- ../linux/arch/cris/arch-v10/drivers/axisflashmap.c	Sat Aug 14 07:37:38
2004
+++ lx25/arch/cris/arch-v10/drivers/axisflashmap.c	Mon Aug 16 14:37:22
2004
@@ -11,6 +11,9 @@
  * partition split defined below.
  *
  * $Log: axisflashmap.c,v $
+ * Revision 1.10  2004/08/16 12:37:22  starvik
+ * Merge of Linux 2.6.8
+ *
  * Revision 1.8  2004/05/14 07:58:03  starvik
  * Merge of changes from 2.4
  *
@@ -153,6 +156,14 @@
 #define FLASH_CACHED_ADDR    KSEG_F
 #endif
 
+#if CONFIG_ETRAX_FLASH_BUSWIDTH==1
+#define flash_data __u8
+#elif CONFIG_ETRAX_FLASH_BUSWIDTH==2
+#define flash_data __u16
+#elif CONFIG_ETRAX_FLASH_BUSWIDTH==4
+#define flash_data __u16
+#endif
+
 /* From head.S */
 extern unsigned long romfs_start, romfs_length, romfs_in_flash;
 
@@ -161,19 +172,11 @@
 
 /* Map driver functions. */
 
-static __u8 flash_read8(struct map_info *map, unsigned long ofs)
-{
-	return *(__u8 *)(map->map_priv_1 + ofs);
-}
-
-static __u16 flash_read16(struct map_info *map, unsigned long ofs)
+static map_word flash_read(struct map_info *map, unsigned long ofs)
 {
-	return *(__u16 *)(map->map_priv_1 + ofs);
-}
-
-static __u32 flash_read32(struct map_info *map, unsigned long ofs)
-{
-	return *(volatile unsigned int *)(map->map_priv_1 + ofs);
+	map_word tmp;
+	tmp.x[0] = *(flash_data *)(map->map_priv_1 + ofs);
+	return tmp;
 }
 
 static void flash_copy_from(struct map_info *map, void *to,
@@ -182,19 +185,9 @@
 	memcpy(to, (void *)(map->map_priv_1 + from), len);
 }
 
-static void flash_write8(struct map_info *map, __u8 d, unsigned long adr)
-{
-	*(__u8 *)(map->map_priv_1 + adr) = d;
-}
-
-static void flash_write16(struct map_info *map, __u16 d, unsigned long adr)
-{
-	*(__u16 *)(map->map_priv_1 + adr) = d;
-}
-
-static void flash_write32(struct map_info *map, __u32 d, unsigned long adr)
+static void flash_write(struct map_info *map, map_word d, unsigned long
adr)
 {
-	*(__u32 *)(map->map_priv_1 + adr) = d;
+	*(flash_data *)(map->map_priv_1 + adr) = (flash_data)d.x[0];
 }
 
 /*
@@ -215,14 +208,10 @@
 static struct map_info map_cse0 = {
 	.name = "cse0",
 	.size = MEM_CSE0_SIZE,
-	.buswidth = CONFIG_ETRAX_FLASH_BUSWIDTH,
-	.read8 = flash_read8,
-	.read16 = flash_read16,
-	.read32 = flash_read32,
+	.bankwidth = CONFIG_ETRAX_FLASH_BUSWIDTH,
+	.read = flash_read,
 	.copy_from = flash_copy_from,
-	.write8 = flash_write8,
-	.write16 = flash_write16,
-	.write32 = flash_write32,
+	.write = flash_write,
 	.map_priv_1 = FLASH_UNCACHED_ADDR
 };
 
@@ -235,14 +224,10 @@
 static struct map_info map_cse1 = {
 	.name = "cse1",
 	.size = MEM_CSE1_SIZE,
-	.buswidth = CONFIG_ETRAX_FLASH_BUSWIDTH,
-	.read8 = flash_read8,
-	.read16 = flash_read16,
-	.read32 = flash_read32,
+	.bankwidth = CONFIG_ETRAX_FLASH_BUSWIDTH,
+	.read = flash_read,
 	.copy_from = flash_copy_from,
-	.write8 = flash_write8,
-	.write16 = flash_write16,
-	.write32 = flash_write32,
+	.write = flash_write,
 	.map_priv_1 = FLASH_UNCACHED_ADDR + MEM_CSE0_SIZE
 };
 
diff -urNP --exclude='*.cvsignore'
../linux/arch/cris/arch-v10/kernel/process.c
lx25/arch/cris/arch-v10/kernel/process.c
--- ../linux/arch/cris/arch-v10/kernel/process.c	Sat Aug 14 07:37:15
2004
+++ lx25/arch/cris/arch-v10/kernel/process.c	Mon Jun 21 12:29:55 2004
@@ -1,4 +1,4 @@
-/* $Id: process.c,v 1.6 2004/05/11 12:28:25 starvik Exp $
+/* $Id: process.c,v 1.7 2004/06/21 10:29:55 starvik Exp $
  * 
  *  linux/arch/cris/kernel/process.c
  *
@@ -214,13 +214,6 @@
 	return error;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-
-#define first_sched	((unsigned long)__sched_text_start)
-#define last_sched	((unsigned long)__sched_text_end)
-
 unsigned long get_wchan(struct task_struct *p)
 {
 #if 0
@@ -241,8 +234,8 @@
                 if (ebp < stack_page || ebp > 8184+stack_page)
                         return 0;
                 eip = *(unsigned long *) (ebp+4);
-                if (eip < first_sched || eip >= last_sched)
-                        return eip;
+		if (!in_sched_functions(eip))
+			return eip;
                 ebp = *(unsigned long *) ebp;
         } while (count++ < 16);
 #endif
diff -urNP --exclude='*.cvsignore'
../linux/arch/cris/arch-v10/kernel/ptrace.c
lx25/arch/cris/arch-v10/kernel/ptrace.c
--- ../linux/arch/cris/arch-v10/kernel/ptrace.c	Sat Aug 14 07:38:04 2004
+++ lx25/arch/cris/arch-v10/kernel/ptrace.c	Mon Jun 21 12:29:55 2004
@@ -50,6 +50,7 @@
 {
 	struct task_struct *child;
 	int ret;
+	unsigned long __user *datap = (unsigned long __user *)data;
 
 	lock_kernel();
 	ret = -EPERM;
@@ -111,7 +112,7 @@
 			if (copied != sizeof(tmp))
 				break;
 			
-			ret = put_user(tmp,(unsigned long *) data);
+			ret = put_user(tmp,datap);
 			break;
 		}
 
@@ -124,7 +125,7 @@
 				break;
 
 			tmp = get_reg(child, addr >> 2);
-			ret = put_user(tmp, (unsigned long *)data);
+			ret = put_user(tmp, datap);
 			break;
 		}
 		
@@ -222,7 +223,7 @@
 			for (i = 0; i <= PT_MAX; i++) {
 				tmp = get_reg(child, i);
 				
-				if (put_user(tmp, (unsigned long *) data)) {
+				if (put_user(tmp, datap)) {
 					ret = -EFAULT;
 					goto out_tsk;
 				}
@@ -240,7 +241,7 @@
 			unsigned long tmp;
 			
 			for (i = 0; i <= PT_MAX; i++) {
-				if (get_user(tmp, (unsigned long *) data)) {
+				if (get_user(tmp, datap)) {
 					ret = -EFAULT;
 					goto out_tsk;
 				}
diff -urNP --exclude='*.cvsignore'
../linux/arch/cris/arch-v10/kernel/signal.c
lx25/arch/cris/arch-v10/kernel/signal.c
--- ../linux/arch/cris/arch-v10/kernel/signal.c	Sat Aug 14 07:36:13 2004
+++ lx25/arch/cris/arch-v10/kernel/signal.c	Mon Jun 21 12:29:55 2004
@@ -264,7 +264,6 @@
 {
 	struct rt_sigframe __user *frame = (struct rt_sigframe *)rdusp();
 	sigset_t set;
-	stack_t st;
 
         /*
          * Since we stacked the signal on a dword boundary,
@@ -288,11 +287,8 @@
 	if (restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
 
-	if (__copy_from_user(&st, &frame->uc.uc_stack, sizeof(st)))
+	if (do_sigaltstack(&frame->uc.uc_stack, NULL, rdusp()) == -EFAULT)
 		goto badframe;
-	/* It is more difficult to avoid calling this function than to
-	   call it and ignore errors.  */
-	do_sigaltstack(&st, NULL, rdusp());
 
 	return regs->r10;
 
@@ -388,9 +384,9 @@
 		/* trampoline - the desired return ip is the retcode itself
*/
 		return_ip = (unsigned long)&frame->retcode;
 		/* This is movu.w __NR_sigreturn, r9; break 13; */
-		err |= __put_user(0x9c5f,         (short
*)(frame->retcode+0));
-		err |= __put_user(__NR_sigreturn, (short
*)(frame->retcode+2));
-		err |= __put_user(0xe93d,         (short
*)(frame->retcode+4));
+		err |= __put_user(0x9c5f,         (short
__user*)(frame->retcode+0));
+		err |= __put_user(__NR_sigreturn, (short
__user*)(frame->retcode+2));
+		err |= __put_user(0xe93d,         (short
__user*)(frame->retcode+4));
 	}
 
 	if (err)
@@ -450,9 +446,9 @@
 		/* trampoline - the desired return ip is the retcode itself
*/
 		return_ip = (unsigned long)&frame->retcode;
 		/* This is movu.w __NR_rt_sigreturn, r9; break 13; */
-		err |= __put_user(0x9c5f,            (short
*)(frame->retcode+0));
-		err |= __put_user(__NR_rt_sigreturn, (short
*)(frame->retcode+2));
-		err |= __put_user(0xe93d,            (short
*)(frame->retcode+4));
+		err |= __put_user(0x9c5f,            (short
__user*)(frame->retcode+0));
+		err |= __put_user(__NR_rt_sigreturn, (short
__user*)(frame->retcode+2));
+		err |= __put_user(0xe93d,            (short
__user*)(frame->retcode+4));
 	}
 
 	if (err)
diff -urNP --exclude='*.cvsignore' ../linux/include/asm-cris/bitops.h
lx25/include/asm-cris/bitops.h
--- ../linux/include/asm-cris/bitops.h	Sat Aug 14 07:37:58 2004
+++ lx25/include/asm-cris/bitops.h	Mon Aug 16 14:40:21 2004
@@ -88,7 +88,7 @@
  * It also implies a memory barrier.
  */
 
-extern inline int test_and_set_bit(int nr, void *addr)
+extern inline int test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned long flags;
@@ -104,7 +104,7 @@
 	return retval;
 }
 
-extern inline int __test_and_set_bit(int nr, void *addr)
+extern inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned int *adr = (unsigned int *)addr;
@@ -131,7 +131,7 @@
  * It also implies a memory barrier.
  */
 
-extern inline int test_and_clear_bit(int nr, void *addr)
+extern inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned long flags;
@@ -157,7 +157,7 @@
  * but actually fail.  You must protect multiple accesses with a lock.
  */
 
-extern inline int __test_and_clear_bit(int nr, void *addr)
+extern inline int __test_and_clear_bit(int nr, volatile unsigned long
*addr)
 {
 	unsigned int mask, retval;
 	unsigned int *adr = (unsigned int *)addr;
@@ -177,7 +177,7 @@
  * It also implies a memory barrier.
  */
 
-extern inline int test_and_change_bit(int nr, void *addr)
+extern inline int test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int mask, retval;
 	unsigned long flags;
@@ -194,7 +194,7 @@
 
 /* WARNING: non atomic and it can be reordered! */
 
-extern inline int __test_and_change_bit(int nr, void *addr)
+extern inline int __test_and_change_bit(int nr, volatile unsigned long
*addr)
 {
 	unsigned int mask, retval;
 	unsigned int *adr = (unsigned int *)addr;
@@ -215,7 +215,7 @@
  * This routine doesn't need to be atomic.
  */
 
-extern inline int test_bit(int nr, const void *addr)
+extern inline int test_bit(int nr, const volatile unsigned long *addr)
 {
 	unsigned int mask;
 	unsigned int *adr = (unsigned int *)addr;
@@ -259,7 +259,7 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-extern inline int find_next_zero_bit (void * addr, int size, int offset)
+extern inline int find_next_zero_bit (const unsigned long * addr, int size,
int offset)
 {
 	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
 	unsigned long result = offset & ~31UL;
@@ -301,7 +301,7 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-static __inline__ int find_next_bit(void *addr, int size, int offset)
+static __inline__ int find_next_bit(const unsigned long *addr, int size,
int offset)
 {
 	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
         unsigned long result = offset & ~31UL;
@@ -367,7 +367,7 @@
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
-extern inline int sched_find_first_bit(unsigned long *b)
+extern inline int sched_find_first_bit(const unsigned long *b)
 {
 	if (unlikely(b[0]))
 		return __ffs(b[0]);
diff -urNP --exclude='*.cvsignore' ../linux/include/asm-cris/pgtable.h
lx25/include/asm-cris/pgtable.h
--- ../linux/include/asm-cris/pgtable.h	Sat Aug 14 07:36:12 2004
+++ lx25/include/asm-cris/pgtable.h	Mon Oct 27 15:51:45 2003
@@ -344,5 +344,7 @@
 #define pte_to_pgoff(x)	(pte_val(x) >> 6)
 #define pgoff_to_pte(x)	__pte(((x) << 6) | _PAGE_FILE)
 
+typedef pte_t *pte_addr_t;
+
 #endif /* __ASSEMBLY__ */
 #endif /* _CRIS_PGTABLE_H */
diff -urNP --exclude='*.cvsignore' ../linux/include/asm-cris/types.h
lx25/include/asm-cris/types.h
--- ../linux/include/asm-cris/types.h	Sat Aug 14 07:37:14 2004
+++ lx25/include/asm-cris/types.h	Mon Jun 21 12:32:10 2004
@@ -52,7 +52,7 @@
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned short kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -urNP --exclude='*.cvsignore' ../linux/include/asm-cris/unistd.h
lx25/include/asm-cris/unistd.h
--- ../linux/include/asm-cris/unistd.h	Sat Aug 14 07:37:41 2004
+++ lx25/include/asm-cris/unistd.h	Mon Jun 21 12:32:10 2004
@@ -288,8 +288,10 @@
 #define __NR_mq_timedreceive	(__NR_mq_open+3)
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
- 
-#define NR_syscalls 283
+#define __NR_sys_kexec_load	283
+
+#define NR_syscalls 284
+
 
 
 #ifdef __KERNEL__

