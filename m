Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbTDWUgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTDWUgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:36:24 -0400
Received: from ns.suse.de ([213.95.15.193]:11530 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264273AbTDWUgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:36:15 -0400
Date: Wed, 23 Apr 2003 22:46:35 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030423224635.A25828@suse.de>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Apr 21, Marcelo Tosatti wrote:

> 
> Here goes the first candidate for 2.4.21.
> 
> Please test it extensively.

2.4.20 needs these patches to compile with gcc3.3. It does still apply
to 2.4.21-rc1.
The extern inline -> static inline is only a workaround and must not go
in, I hope a more recent gcc-3.3 has a fix for the inline bugs.

Please review:

 drivers/net/irda/ma600.c        |    2 +-
 drivers/net/tokenring/olympic.c |    4 ++--
 drivers/sound/cs46xx.c          |    4 ++--
 include/asm-ppc/io.h            |   34 +++++++++++++++++-----------------
 include/asm-ppc/pgalloc.h       |   12 ++++++------
 include/asm-ppc/semaphore.h     |    8 ++++----
 include/asm-ppc/uaccess.h       |   10 +++++-----
 net/decnet/dn_table.c           |    3 +--
 8 files changed, 38 insertions(+), 39 deletions(-)


diff -purNX /kernel_exclude.txt linux_ppc/drivers/net/irda/ma600.c linux_ppc/drivers/net/irda/ma600.c
--- linux_ppc/drivers/net/irda/ma600.c	2002-11-28 23:53:13.000000000 +0000
+++ linux_ppc/drivers/net/irda/ma600.c	2003-02-03 12:51:14.000000000 +0000
@@ -53,7 +53,7 @@
 	if(!(expr)) { \
 	        printk( "Assertion failed! %s,%s,%s,line=%d\n",\
         	#expr,__FILE__,__FUNCTION__,__LINE__); \
-	        ##func}
+	        func}
 #endif
 
 /* convert hex value to ascii hex */
diff -purNX /kernel_exclude.txt linux_ppc/drivers/net/tokenring/olympic.c linux_ppc/drivers/net/tokenring/olympic.c
--- linux_ppc/drivers/net/tokenring/olympic.c	2002-11-28 23:53:14.000000000 +0000
+++ linux_ppc/drivers/net/tokenring/olympic.c	2003-02-03 12:46:04.000000000 +0000
@@ -655,8 +655,8 @@ static int olympic_open(struct net_devic
 	printk(" stat_ring[7]: %p\n", &(olympic_priv->olympic_rx_status_ring[7])  );
 
 	printk("RXCDA: %x, rx_ring[0]: %p\n",readl(olympic_mmio+RXCDA),&olympic_priv->olympic_rx_ring[0]);
-	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr =
-%08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
+	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr ="
+"%08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
 #endif
 
 	writew((((readw(olympic_mmio+RXENQ)) & 0x8000) ^ 0x8000) | i,olympic_mmio+RXENQ);
diff -purNX /kernel_exclude.txt linux_ppc/drivers/sound/cs46xx.c linux_ppc/drivers/sound/cs46xx.c
--- linux_ppc/drivers/sound/cs46xx.c	2002-08-03 00:39:44.000000000 +0000
+++ linux_ppc/drivers/sound/cs46xx.c	2003-02-03 12:51:14.000000000 +0000
@@ -947,8 +947,8 @@ static void cs_play_setup(struct cs_stat
 
 struct InitStruct
 {
-    u32 long off;
-    u32 long val;
+    u32 off;
+    u32 val;
 } InitArray[] = { {0x00000040, 0x3fc0000f},
                   {0x0000004c, 0x04800000},
 
diff -purNX /kernel_exclude.txt linux_ppc/include/asm-ppc/io.h linux_ppc/include/asm-ppc/io.h
--- linux_ppc/include/asm-ppc/io.h	2001-11-03 01:43:54.000000000 +0000
+++ linux_ppc/include/asm-ppc/io.h	2003-02-03 12:29:32.000000000 +0000
@@ -84,7 +84,7 @@ extern unsigned long pci_dram_offset;
  * and potentially some CHRPs -- paulus.
  */
 #define __do_in_asm(name, op)				\
-extern __inline__ unsigned int name(unsigned int port)	\
+static __inline__ unsigned int name(unsigned int port)	\
 {							\
 	unsigned int x;					\
 	__asm__ __volatile__(				\
@@ -109,7 +109,7 @@ extern __inline__ unsigned int name(unsi
 }
 
 #define __do_out_asm(name, op)				\
-extern __inline__ void name(unsigned int val, unsigned int port) \
+static __inline__ void name(unsigned int val, unsigned int port) \
 {							\
 	__asm__ __volatile__(				\
 		op " %0,0,%1\n"				\
@@ -203,7 +203,7 @@ extern void io_block_mapping(unsigned lo
  * address from the PCI point of view, thus buffer addresses also
  * have to be modified [mapped] appropriately.
  */
-extern inline unsigned long virt_to_bus(volatile void * address)
+static inline unsigned long virt_to_bus(volatile void * address)
 {
 #ifndef CONFIG_APUS
         if (address == (void *)0)
@@ -214,7 +214,7 @@ extern inline unsigned long virt_to_bus(
 #endif
 }
 
-extern inline void * bus_to_virt(unsigned long address)
+static inline void * bus_to_virt(unsigned long address)
 {
 #ifndef CONFIG_APUS
         if (address == 0)
@@ -229,7 +229,7 @@ extern inline void * bus_to_virt(unsigne
  * Change virtual addresses to physical addresses and vv, for
  * addresses in the area where the kernel has the RAM mapped.
  */
-extern inline unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(volatile void * address)
 {
 #ifndef CONFIG_APUS
 	return (unsigned long) address - KERNELBASE;
@@ -238,7 +238,7 @@ extern inline unsigned long virt_to_phys
 #endif
 }
 
-extern inline void * phys_to_virt(unsigned long address)
+static inline void * phys_to_virt(unsigned long address)
 {
 #ifndef CONFIG_APUS
 	return (void *) (address + KERNELBASE);
@@ -260,7 +260,7 @@ extern inline void * phys_to_virt(unsign
  * Acts as a barrier to ensure all previous I/O accesses have
  * completed before any further ones are issued.
  */
-extern inline void eieio(void)
+static inline void eieio(void)
 {
 	__asm__ __volatile__ ("eieio" : : : "memory");
 }
@@ -275,7 +275,7 @@ extern inline void eieio(void)
 /*
  * 8, 16 and 32 bit, big and little endian I/O operations, with barrier.
  */
-extern inline int in_8(volatile unsigned char *addr)
+static inline int in_8(volatile unsigned char *addr)
 {
 	int ret;
 
@@ -283,12 +283,12 @@ extern inline int in_8(volatile unsigned
 	return ret;
 }
 
-extern inline void out_8(volatile unsigned char *addr, int val)
+static inline void out_8(volatile unsigned char *addr, int val)
 {
 	__asm__ __volatile__("stb%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
 }
 
-extern inline int in_le16(volatile unsigned short *addr)
+static inline int in_le16(volatile unsigned short *addr)
 {
 	int ret;
 
@@ -297,7 +297,7 @@ extern inline int in_le16(volatile unsig
 	return ret;
 }
 
-extern inline int in_be16(volatile unsigned short *addr)
+static inline int in_be16(volatile unsigned short *addr)
 {
 	int ret;
 
@@ -305,18 +305,18 @@ extern inline int in_be16(volatile unsig
 	return ret;
 }
 
-extern inline void out_le16(volatile unsigned short *addr, int val)
+static inline void out_le16(volatile unsigned short *addr, int val)
 {
 	__asm__ __volatile__("sthbrx %1,0,%2; eieio" : "=m" (*addr) :
 			      "r" (val), "r" (addr));
 }
 
-extern inline void out_be16(volatile unsigned short *addr, int val)
+static inline void out_be16(volatile unsigned short *addr, int val)
 {
 	__asm__ __volatile__("sth%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
 }
 
-extern inline unsigned in_le32(volatile unsigned *addr)
+static inline unsigned in_le32(volatile unsigned *addr)
 {
 	unsigned ret;
 
@@ -325,7 +325,7 @@ extern inline unsigned in_le32(volatile 
 	return ret;
 }
 
-extern inline unsigned in_be32(volatile unsigned *addr)
+static inline unsigned in_be32(volatile unsigned *addr)
 {
 	unsigned ret;
 
@@ -333,13 +333,13 @@ extern inline unsigned in_be32(volatile 
 	return ret;
 }
 
-extern inline void out_le32(volatile unsigned *addr, int val)
+static inline void out_le32(volatile unsigned *addr, int val)
 {
 	__asm__ __volatile__("stwbrx %1,0,%2; eieio" : "=m" (*addr) :
 			     "r" (val), "r" (addr));
 }
 
-extern inline void out_be32(volatile unsigned *addr, int val)
+static inline void out_be32(volatile unsigned *addr, int val)
 {
 	__asm__ __volatile__("stw%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
 }
diff -purNX /kernel_exclude.txt linux_ppc/include/asm-ppc/pgalloc.h linux_ppc/include/asm-ppc/pgalloc.h
--- linux_ppc/include/asm-ppc/pgalloc.h	2001-05-21 22:02:06.000000000 +0000
+++ linux_ppc/include/asm-ppc/pgalloc.h	2003-02-03 12:12:37.000000000 +0000
@@ -55,7 +55,7 @@ extern unsigned long get_zero_page_fast(
 
 extern void __bad_pte(pmd_t *pmd);
 
-extern __inline__ pgd_t *get_pgd_slow(void)
+static __inline__ pgd_t *get_pgd_slow(void)
 {
 	pgd_t *ret;
 
@@ -64,7 +64,7 @@ extern __inline__ pgd_t *get_pgd_slow(vo
 	return ret;
 }
 
-extern __inline__ pgd_t *get_pgd_fast(void)
+static __inline__ pgd_t *get_pgd_fast(void)
 {
         unsigned long *ret;
 
@@ -77,14 +77,14 @@ extern __inline__ pgd_t *get_pgd_fast(vo
         return (pgd_t *)ret;
 }
 
-extern __inline__ void free_pgd_fast(pgd_t *pgd)
+static __inline__ void free_pgd_fast(pgd_t *pgd)
 {
         *(unsigned long **)pgd = pgd_quicklist;
         pgd_quicklist = (unsigned long *) pgd;
         pgtable_cache_size++;
 }
 
-extern __inline__ void free_pgd_slow(pgd_t *pgd)
+static __inline__ void free_pgd_slow(pgd_t *pgd)
 {
 	free_page((unsigned long)pgd);
 }
@@ -128,14 +128,14 @@ static inline pte_t *pte_alloc_one_fast(
         return (pte_t *)ret;
 }
 
-extern __inline__ void pte_free_fast(pte_t *pte)
+static __inline__ void pte_free_fast(pte_t *pte)
 {
         *(unsigned long **)pte = pte_quicklist;
         pte_quicklist = (unsigned long *) pte;
         pgtable_cache_size++;
 }
 
-extern __inline__ void pte_free_slow(pte_t *pte)
+static __inline__ void pte_free_slow(pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
diff -purNX /kernel_exclude.txt linux_ppc/include/asm-ppc/semaphore.h linux_ppc/include/asm-ppc/semaphore.h
--- linux_ppc/include/asm-ppc/semaphore.h	2002-11-28 23:53:15.000000000 +0000
+++ linux_ppc/include/asm-ppc/semaphore.h	2003-02-03 13:14:38.000000000 +0000
@@ -81,7 +81,7 @@ extern void __down(struct semaphore * se
 extern int  __down_interruptible(struct semaphore * sem);
 extern void __up(struct semaphore * sem);
 
-extern inline void down(struct semaphore * sem)
+static inline void down(struct semaphore * sem)
 {
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
@@ -95,7 +95,7 @@ extern inline void down(struct semaphore
 	smp_wmb();
 }
 
-extern inline int down_interruptible(struct semaphore * sem)
+static inline int down_interruptible(struct semaphore * sem)
 {
 	int ret = 0;
 
@@ -109,7 +109,7 @@ extern inline int down_interruptible(str
 	return ret;
 }
 
-extern inline int down_trylock(struct semaphore * sem)
+static inline int down_trylock(struct semaphore * sem)
 {
 	int ret;
 
@@ -122,7 +122,7 @@ extern inline int down_trylock(struct se
 	return ret;
 }
 
-extern inline void up(struct semaphore * sem)
+static inline void up(struct semaphore * sem)
 {
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
diff -purNX /kernel_exclude.txt linux_ppc/include/asm-ppc/uaccess.h linux_ppc/include/asm-ppc/uaccess.h
--- linux_ppc/include/asm-ppc/uaccess.h	2002-08-03 00:39:45.000000000 +0000
+++ linux_ppc/include/asm-ppc/uaccess.h	2003-02-03 13:14:50.000000000 +0000
@@ -35,7 +35,7 @@
 #define __access_ok(addr,size) (__kernel_ok || __user_ok((addr),(size)))
 #define access_ok(type,addr,size) __access_ok((unsigned long)(addr),(size))
 
-extern inline int verify_area(int type, const void * addr, unsigned long size)
+static inline int verify_area(int type, const void * addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
@@ -232,7 +232,7 @@ do {								\
 
 extern int __copy_tofrom_user(void *to, const void *from, unsigned long size);
 
-extern inline unsigned long
+static inline unsigned long
 copy_from_user(void *to, const void *from, unsigned long n)
 {
 	unsigned long over;
@@ -246,7 +246,7 @@ copy_from_user(void *to, const void *fro
 	return n;
 }
 
-extern inline unsigned long
+static inline unsigned long
 copy_to_user(void *to, const void *from, unsigned long n)
 {
 	unsigned long over;
@@ -267,7 +267,7 @@ copy_to_user(void *to, const void *from,
 
 extern unsigned long __clear_user(void *addr, unsigned long size);
 
-extern inline unsigned long
+static inline unsigned long
 clear_user(void *addr, unsigned long size)
 {
 	if (access_ok(VERIFY_WRITE, addr, size))
@@ -281,7 +281,7 @@ clear_user(void *addr, unsigned long siz
 
 extern int __strncpy_from_user(char *dst, const char *src, long count);
 
-extern inline long
+static inline long
 strncpy_from_user(char *dst, const char *src, long count)
 {
 	if (access_ok(VERIFY_READ, src, 1))
diff -purNX linux/kernel_exclude.txt linux_ppc.orig/net/decnet/dn_table.c linux_ppc/net/decnet/dn_table.c
--- linux_ppc.orig/net/decnet/dn_table.c	2001-12-21 17:42:05.000000000 +0000
+++ linux_ppc/net/decnet/dn_table.c	2003-02-06 08:24:01.000000000 +0000
@@ -836,8 +836,7 @@ struct dn_fib_table *dn_fib_get_table(in
                 return NULL;
 
         if (in_interrupt() && net_ratelimit()) {
-                printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing table 
-from interrupt\n"); 
+                printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing table from interrupt\n"); 
                 return NULL;
         }
         if ((t = kmalloc(sizeof(struct dn_fib_table), GFP_KERNEL)) == NULL)
-- 
USB is for mice, FireWire is for men!
