Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKREvT>; Fri, 17 Nov 2000 23:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130346AbQKREvK>; Fri, 17 Nov 2000 23:51:10 -0500
Received: from nat-su-33.valinux.com ([198.186.202.33]:34914 "EHLO
	tytlal.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S129097AbQKREuv>; Fri, 17 Nov 2000 23:50:51 -0500
Date: Fri, 17 Nov 2000 20:16:03 -0800
From: Chip Salzenberg <chip@valinux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.2.18pre21: DRM update
Message-ID: <20001117201603.A3439@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update from the main DRM tree, but with cosmetic changes
removed and only meat left.  This patch is already in VA's shipping
kernel, so you know we really trust it.  :-,

BTW, this patch is not fluff: It includes bug fixes.  But it's pretty
big, so if you want to wait until 2.2.19 I'll understand....

Index: drivers/char/Makefile
--- drivers/char/Makefile.prev
+++ drivers/char/Makefile	Fri Nov 17 13:30:04 2000
@@ -12,5 +12,5 @@
 SUB_DIRS     := 
 MOD_SUB_DIRS := $(SUB_DIRS)
-ALL_SUB_DIRS := $(SUB_DIRS) rio ftape joystick drm agp
+ALL_SUB_DIRS := $(SUB_DIRS) rio ftape joystick
 
 #
@@ -395,4 +395,16 @@
 endif
 
+ifeq ($(CONFIG_DRM),y)
+O_OBJS += drm/drm.o
+ALL_SUB_DIRS += drm
+MOD_SUB_DIRS += drm
+SUB_DIRS += drm
+else
+  ifeq ($(CONFIG_DRM),m)
+  ALL_SUB_DIRS += drm
+  MOD_SUB_DIRS += drm
+  endif
+endif
+
 ifeq ($(CONFIG_INTEL_RNG),y)
 O_OBJS += i810_rng.o
@@ -650,16 +662,4 @@
 OX_OBJS += h8.o
 endif
-
-
-ifeq ($(CONFIG_DRM),y)
-SUB_DIRS += drm
-O_OBJS += drm/drm.o
-MOD_SUB_DIRS += drm
-else
-  ifeq ($(CONFIG_DRM),m)
-  MOD_SUB_DIRS += drm
-  endif
-endif
-
 
 ifeq ($(L_I2C),y)

Index: drivers/char/drm/drmP.h
--- drivers/char/drm/drmP.h.prev
+++ drivers/char/drm/drmP.h	Fri Nov 17 13:30:04 2000
@@ -34,4 +34,9 @@
 
 #ifdef __KERNEL__
+#ifdef __alpha__
+/* add include of current.h so that "current" is defined
+ * before static inline funcs in wait.h. 4/21/2000 S + B */
+#include <asm/current.h>
+#endif /* __alpha__ */
 #include <linux/config.h>
 #include <linux/module.h>
@@ -47,8 +52,11 @@
 #include <linux/sched.h>
 #include <linux/smp_lock.h>	/* For (un)lock_kernel */
+#include <linux/mm.h>
+#ifdef __alpha__
+#include <asm/pgtable.h> /* For pte_wrprotect */
+#endif
 #include <asm/io.h>
 #include <asm/mman.h>
 #include <asm/uaccess.h>
-#include <asm/pgtable.h>
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
@@ -133,8 +141,86 @@
 #endif
 
+				/* module_init/module_exit added in 2.3.13 */
+#ifndef module_init
+#define module_init(x)  int init_module(void) { return x(); }
+#endif
+#ifndef module_exit
+#define module_exit(x)  void cleanup_module(void) { x(); }
+#endif
+
+				/* virt_to_page added in 2.4.0-test6 */
+#if LINUX_VERSION_CODE < 0x020400
+#define virt_to_page(kaddr) (mem_map + MAP_NR(kaddr))
+#endif
+
 				/* Generic cmpxchg added in 2.3.x */
 #ifndef __HAVE_ARCH_CMPXCHG
 				/* Include this here so that driver can be
                                    used with older kernels. */
+#if defined(__alpha__)
+static __inline__ unsigned long
+__cmpxchg_u32(volatile int *m, int old, int new)
+{
+	unsigned long prev, cmp;
+
+	__asm__ __volatile__(
+	"1:	ldl_l %0,%2\n"
+	"	cmpeq %0,%3,%1\n"
+	"	beq %1,2f\n"
+	"	mov %4,%1\n"
+	"	stl_c %1,%2\n"
+	"	beq %1,3f\n"
+	"2:	mb\n"
+	".subsection 2\n"
+	"3:	br 1b\n"
+	".previous"
+	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
+	: "r"((long) old), "r"(new), "m"(*m));
+
+	return prev;
+}
+
+static __inline__ unsigned long
+__cmpxchg_u64(volatile long *m, unsigned long old, unsigned long new)
+{
+	unsigned long prev, cmp;
+
+	__asm__ __volatile__(
+	"1:	ldq_l %0,%2\n"
+	"	cmpeq %0,%3,%1\n"
+	"	beq %1,2f\n"
+	"	mov %4,%1\n"
+	"	stq_c %1,%2\n"
+	"	beq %1,3f\n"
+	"2:	mb\n"
+	".subsection 2\n"
+	"3:	br 1b\n"
+	".previous"
+	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
+	: "r"((long) old), "r"(new), "m"(*m));
+
+	return prev;
+}
+
+static __inline__ unsigned long
+__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
+{
+	switch (size) {
+		case 4:
+			return __cmpxchg_u32(ptr, old, new);
+		case 8:
+			return __cmpxchg_u64(ptr, old, new);
+	}
+	return old;
+}
+#define cmpxchg(ptr,o,n)						 \
+  ({									 \
+     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _n_ = (n);					 \
+     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
+				    (unsigned long)_n_, sizeof(*(ptr))); \
+  })
+
+#elif __i386__
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      unsigned long new, int size)
@@ -167,4 +253,5 @@
   ((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),		\
 				 (unsigned long)(n),sizeof(*(ptr))))
+#endif /* i386 & alpha */
 #endif
 
@@ -316,4 +403,5 @@
 	int		  high_mark;   /* High water mark		   */
 	atomic_t	  wfh;	       /* If waiting for high mark	   */
+	spinlock_t        lock;
 } drm_freelist_t;
 
@@ -344,4 +432,5 @@
 	struct drm_file	  *prev;
 	struct drm_device *dev;
+	int 		  remove_auth_on_close;
 } drm_file_t;
 
@@ -552,4 +641,7 @@
 				       unsigned long address,
 				       int write_access);
+extern unsigned long drm_vm_shm_nopage_lock(struct vm_area_struct *vma,
+					    unsigned long address,
+					    int write_access);
 extern unsigned long drm_vm_dma_nopage(struct vm_area_struct *vma,
 				       unsigned long address,
@@ -563,4 +655,7 @@
 				      unsigned long address,
 				      int write_access);
+extern struct page *drm_vm_shm_nopage_lock(struct vm_area_struct *vma,
+					   unsigned long address,
+					   int write_access);
 extern struct page *drm_vm_dma_nopage(struct vm_area_struct *vma,
 				      unsigned long address,
@@ -572,7 +667,5 @@
 				  struct vm_area_struct *vma);
 extern int	     drm_mmap(struct file *filp, struct vm_area_struct *vma);
-extern struct vm_operations_struct drm_vm_ops;
-extern struct vm_operations_struct drm_vm_shm_ops;
-extern struct vm_operations_struct drm_vm_dma_ops;
+
 
 				/* Proc support (proc.c) */

Index: drivers/char/drm/mga_drm.h
--- drivers/char/drm/mga_drm.h.prev
+++ drivers/char/drm/mga_drm.h	Fri Nov 17 13:30:04 2000
@@ -74,15 +74,17 @@
 /* 3d state excluding texture units:
  */
-#define MGA_CTXREG_DSTORG   0	/* validated */
-#define MGA_CTXREG_MACCESS  1	
-#define MGA_CTXREG_PLNWT    2	
-#define MGA_CTXREG_DWGCTL    3	
-#define MGA_CTXREG_ALPHACTRL 4
-#define MGA_CTXREG_FOGCOLOR  5
-#define MGA_CTXREG_WFLAG     6
-#define MGA_CTXREG_TDUAL0    7
-#define MGA_CTXREG_TDUAL1    8
-#define MGA_CTXREG_FCOL      9
-#define MGA_CTX_SETUP_SIZE   10
+#define MGA_CTXREG_DSTORG     0	/* validated */
+#define MGA_CTXREG_MACCESS    1	
+#define MGA_CTXREG_PLNWT      2 	
+#define MGA_CTXREG_DWGCTL     3	
+#define MGA_CTXREG_ALPHACTRL  4
+#define MGA_CTXREG_FOGCOLOR   5
+#define MGA_CTXREG_WFLAG      6
+#define MGA_CTXREG_TDUAL0     7
+#define MGA_CTXREG_TDUAL1     8
+#define MGA_CTXREG_FCOL       9
+#define MGA_CTXREG_STENCIL    10
+#define MGA_CTXREG_STENCILCTL 11
+#define MGA_CTX_SETUP_SIZE    12
 
 /* 2d state
@@ -234,4 +236,5 @@
 	 */
    	int ctxOwner;
+   	int vertexsize;
 } drm_mga_sarea_t;	
 
@@ -242,4 +245,6 @@
 	unsigned int clear_depth;
 	unsigned int flags;
+	unsigned int clear_depth_mask;
+	unsigned int clear_color_mask;
 } drm_mga_clear_t;
 

Index: drivers/char/drm/mga_drv.h
--- drivers/char/drm/mga_drv.h.prev
+++ drivers/char/drm/mga_drv.h	Fri Nov 17 13:30:04 2000
@@ -40,6 +40,6 @@
 typedef struct {
 	u32 buffer_status;
-   	unsigned int num_dwords;
-   	unsigned int max_dwords;
+   	int num_dwords;
+   	int max_dwords;
    	u32 *current_dma_ptr;
    	u32 *head;
@@ -51,5 +51,5 @@
 
 typedef struct _drm_mga_freelist {
-   	unsigned int age;
+   	__volatile__ unsigned int age;
    	drm_buf_t *buf;
    	struct _drm_mga_freelist *next;
@@ -83,4 +83,5 @@
    	drm_mga_warp_index_t WarpIndex[MGA_MAX_G400_PIPES];
 	unsigned int WarpPipe;
+	unsigned int vertexsize;
    	atomic_t pending_bufs;
    	void *status_page;
@@ -129,5 +130,4 @@
 extern int mga_flush_ioctl(struct inode *inode, struct file *filp,
 			   unsigned int cmd, unsigned long arg);
-extern void mga_flush_write_combine(void);
 extern unsigned int mga_create_sync_tag(drm_device_t *dev);
 extern drm_buf_t *mga_freelist_get(drm_device_t *dev);
@@ -180,4 +180,5 @@
 extern int  mga_context_switch_complete(drm_device_t *dev, int new);
 
+#define mga_flush_write_combine()	mb()
 
 typedef enum {
@@ -210,17 +211,24 @@
 			int outcount, num_dwords
 
-#define PRIM_OVERFLOW(dev, dev_priv, length) do {			\
-	drm_mga_prim_buf_t *tmp_buf =					\
- 		dev_priv->prim_bufs[dev_priv->current_prim_idx];	\
-	if( test_bit(MGA_BUF_NEEDS_OVERFLOW,				\
-		  &tmp_buf->buffer_status)) {				\
- 		mga_advance_primary(dev);				\
- 		mga_dma_schedule(dev, 1);				\
- 	} else if( tmp_buf->max_dwords - tmp_buf->num_dwords < length ||\
- 	    tmp_buf->sec_used > MGA_DMA_BUF_NR/2) {			\
-		set_bit(MGA_BUF_FORCE_FIRE, &tmp_buf->buffer_status);	\
- 		mga_advance_primary(dev);				\
- 		mga_dma_schedule(dev, 1);				\
-	}								\
+#define PRIM_OVERFLOW(dev, dev_priv, length) do {			   \
+	drm_mga_prim_buf_t *tmp_buf =					   \
+ 		dev_priv->prim_bufs[dev_priv->current_prim_idx];	   \
+	if( test_bit(MGA_BUF_NEEDS_OVERFLOW, &tmp_buf->buffer_status)) {   \
+ 		mga_advance_primary(dev);				   \
+ 		mga_dma_schedule(dev, 1);				   \
+		tmp_buf = dev_priv->prim_bufs[dev_priv->current_prim_idx]; \
+ 	} else if( tmp_buf->max_dwords - tmp_buf->num_dwords < length ||   \
+ 	           tmp_buf->sec_used > MGA_DMA_BUF_NR/2) {		   \
+		set_bit(MGA_BUF_FORCE_FIRE, &tmp_buf->buffer_status);	   \
+ 		mga_advance_primary(dev);				   \
+ 		mga_dma_schedule(dev, 1);				   \
+		tmp_buf = dev_priv->prim_bufs[dev_priv->current_prim_idx]; \
+	}								   \
+	if(MGA_VERBOSE)							   \
+		DRM_DEBUG("PRIMGETPTR in %s\n", __FUNCTION__);		   \
+	dma_ptr = tmp_buf->current_dma_ptr;				   \
+	num_dwords = tmp_buf->num_dwords;				   \
+	phys_head = tmp_buf->phys_head;					   \
+	outcount = 0;							   \
 } while(0)
 
@@ -288,5 +296,5 @@
 	if( ++outcount == 4) {						\
 		outcount = 0;						\
-		dma_ptr[0] = *(u32 *)tempIndex;				\
+		dma_ptr[0] = *(unsigned long *)tempIndex;		\
 		dma_ptr+=5;						\
 		num_dwords += 5;					\
@@ -369,4 +377,70 @@
 #define MGAREG_YTOP 				0x1c98
 #define MGAREG_ZORG 				0x1c0c
+
+/* Warp registers */
+#define MGAREG_WR0                              0x2d00
+#define MGAREG_WR1                              0x2d04
+#define MGAREG_WR2                              0x2d08
+#define MGAREG_WR3                              0x2d0c
+#define MGAREG_WR4                              0x2d10
+#define MGAREG_WR5                              0x2d14
+#define MGAREG_WR6                              0x2d18
+#define MGAREG_WR7                              0x2d1c
+#define MGAREG_WR8                              0x2d20
+#define MGAREG_WR9                              0x2d24
+#define MGAREG_WR10                             0x2d28
+#define MGAREG_WR11                             0x2d2c
+#define MGAREG_WR12                             0x2d30
+#define MGAREG_WR13                             0x2d34
+#define MGAREG_WR14                             0x2d38
+#define MGAREG_WR15                             0x2d3c
+#define MGAREG_WR16                             0x2d40
+#define MGAREG_WR17                             0x2d44
+#define MGAREG_WR18                             0x2d48
+#define MGAREG_WR19                             0x2d4c
+#define MGAREG_WR20                             0x2d50
+#define MGAREG_WR21                             0x2d54
+#define MGAREG_WR22                             0x2d58
+#define MGAREG_WR23                             0x2d5c
+#define MGAREG_WR24                             0x2d60
+#define MGAREG_WR25                             0x2d64
+#define MGAREG_WR26                             0x2d68
+#define MGAREG_WR27                             0x2d6c
+#define MGAREG_WR28                             0x2d70
+#define MGAREG_WR29                             0x2d74
+#define MGAREG_WR30                             0x2d78
+#define MGAREG_WR31                             0x2d7c
+#define MGAREG_WR32                             0x2d80
+#define MGAREG_WR33                             0x2d84
+#define MGAREG_WR34                             0x2d88
+#define MGAREG_WR35                             0x2d8c
+#define MGAREG_WR36                             0x2d90
+#define MGAREG_WR37                             0x2d94
+#define MGAREG_WR38                             0x2d98
+#define MGAREG_WR39                             0x2d9c
+#define MGAREG_WR40                             0x2da0
+#define MGAREG_WR41                             0x2da4
+#define MGAREG_WR42                             0x2da8
+#define MGAREG_WR43                             0x2dac
+#define MGAREG_WR44                             0x2db0
+#define MGAREG_WR45                             0x2db4
+#define MGAREG_WR46                             0x2db8
+#define MGAREG_WR47                             0x2dbc
+#define MGAREG_WR48                             0x2dc0
+#define MGAREG_WR49                             0x2dc4
+#define MGAREG_WR50                             0x2dc8
+#define MGAREG_WR51                             0x2dcc
+#define MGAREG_WR52                             0x2dd0
+#define MGAREG_WR53                             0x2dd4
+#define MGAREG_WR54                             0x2dd8
+#define MGAREG_WR55                             0x2ddc
+#define MGAREG_WR56                             0x2de0
+#define MGAREG_WR57                             0x2de4
+#define MGAREG_WR58                             0x2de8
+#define MGAREG_WR59                             0x2dec
+#define MGAREG_WR60                             0x2df0
+#define MGAREG_WR61                             0x2df4
+#define MGAREG_WR62                             0x2df8
+#define MGAREG_WR63                             0x2dfc
 
 #define PDEA_pagpxfer_enable			0x2

Index: drivers/char/drm/agpsupport.c
--- drivers/char/drm/agpsupport.c.prev
+++ drivers/char/drm/agpsupport.c	Fri Nov 17 13:30:04 2000
@@ -288,4 +288,8 @@ drm_agp_head_t *drm_agp_init(void)
 		memset((void *)head, 0, sizeof(*head));
 		(*drm_agp.copy_info)(&head->agp_info);
+		if (head->agp_info.chipset == NOT_SUPPORTED) {
+			drm_free(head, sizeof(*head), DRM_MEM_AGPLISTS);
+			return NULL;
+		}
 		head->memory = NULL;
 		switch (head->agp_info.chipset) {
@@ -295,18 +299,29 @@ drm_agp_head_t *drm_agp_init(void)
 		case INTEL_GX:         head->chipset = "Intel 440GX";      break;
 		case INTEL_I810:       head->chipset = "Intel i810";       break;
+#if LINUX_VERSION_CODE >= 0x020400
+		case INTEL_I840:       head->chipset = "Intel i840";       break;
+#endif
+
 		case VIA_GENERIC:      head->chipset = "VIA";              break;
 		case VIA_VP3:          head->chipset = "VIA VP3";          break;
 		case VIA_MVP3:         head->chipset = "VIA MVP3";         break;
+#if LINUX_VERSION_CODE >= 0x020400
+		case VIA_MVP4:         head->chipset = "VIA MVP4";         break;
+#endif
 		case VIA_APOLLO_PRO:   head->chipset = "VIA Apollo Pro";   break;
 		case VIA_APOLLO_KX133: head->chipset = "VIA Apollo KX133"; break;
 		case VIA_APOLLO_KT133: head->chipset = "VIA Apollo KT133"; break;
+
 		case SIS_GENERIC:      head->chipset = "SiS";              break;
+
 		case AMD_GENERIC:      head->chipset = "AMD";              break;
 		case AMD_IRONGATE:     head->chipset = "AMD Irongate";     break;
+
 		case ALI_GENERIC:      head->chipset = "ALi";              break;
 		case ALI_M1541:        head->chipset = "ALi M1541";        break;
-		default:
+
+		default:               head->chipset = "Unknown";          break;
 		}
-		DRM_INFO("AGP %d.%d on %s @ 0x%08lx %dMB\n",
+		DRM_INFO("AGP %d.%d on %s @ 0x%08lx %uMB\n",
 			 head->agp_info.version.major,
 			 head->agp_info.version.minor,

Index: drivers/char/drm/auth.c
--- drivers/char/drm/auth.c.prev
+++ drivers/char/drm/auth.c	Fri Nov 17 13:30:04 2000
@@ -127,10 +127,10 @@ int drm_getmagic(struct inode *inode, st
 		auth.magic = priv->magic;
 	} else {
-		spin_lock(&lock);
 		do {
+			spin_lock(&lock);
 			if (!sequence) ++sequence; /* reserve 0 */
 			auth.magic = sequence++;
+			spin_unlock(&lock);
 		} while (drm_find_file(dev, auth.magic));
-		spin_unlock(&lock);
 		priv->magic = auth.magic;
 		drm_add_magic(dev, priv, auth.magic);

Index: drivers/char/drm/dma.c
--- drivers/char/drm/dma.c.prev
+++ drivers/char/drm/dma.c	Fri Nov 17 13:30:05 2000
@@ -398,8 +398,8 @@ int drm_dma_enqueue(drm_device_t *dev, d
 	atomic_inc(&q->use_count);
 	if (atomic_read(&q->block_write)) {
-		current->state = TASK_INTERRUPTIBLE;
 		add_wait_queue(&q->write_queue, &entry);
 		atomic_inc(&q->block_count);
 		for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 			if (!atomic_read(&q->block_write)) break;
 			schedule();

Index: drivers/char/drm/ffb_drv.c
--- drivers/char/drm/ffb_drv.c.prev
+++ drivers/char/drm/ffb_drv.c	Fri Nov 17 13:30:05 2000
@@ -649,4 +649,5 @@ static int ffb_lock(struct inode *inode,
 	add_wait_queue(&dev->lock.lock_queue, &entry);
 	for (;;) {
+		current->state = TASK_INTERRUPTIBLE;
 		if (!dev->lock.hw_lock) {
 			/* Device has been unregistered */
@@ -664,5 +665,4 @@ static int ffb_lock(struct inode *inode,
 		/* Contention */
 		atomic_inc(&dev->total_sleeps);
-		current->state = TASK_INTERRUPTIBLE;
 		current->policy |= SCHED_YIELD;
 		schedule();

Index: drivers/char/drm/fops.c
--- drivers/char/drm/fops.c.prev
+++ drivers/char/drm/fops.c	Fri Nov 17 13:33:25 2000
@@ -216,11 +216,5 @@ int drm_write_string(drm_device_t *dev, 
 	}
 
-#if LINUX_VERSION_CODE < 0x020400
 	if (dev->buf_async) kill_fasync(dev->buf_async, SIGIO, POLL_IN);
-#else
-				/* Type of first parameter changed in
-                                   Linux 2.4.0-test2... */
-	if (dev->buf_async) kill_fasync(&dev->buf_async, SIGIO, POLL_IN);
-#endif
 	DRM_DEBUG("waking\n");
 	wake_up_interruptible(&dev->buf_readers);

Index: drivers/char/drm/gamma_dma.c
--- drivers/char/drm/gamma_dma.c.prev
+++ drivers/char/drm/gamma_dma.c	Fri Nov 17 13:30:05 2000
@@ -543,6 +543,6 @@ static int gamma_dma_send_buffers(drm_de
 	if (d->flags & _DRM_DMA_BLOCK) {
 		DRM_DEBUG("%d waiting\n", current->pid);
-		current->state = TASK_INTERRUPTIBLE;
 		for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 			if (!last_buf->waiting
 			    && !last_buf->pending)
@@ -775,4 +775,5 @@ int gamma_lock(struct inode *inode, stru
 		add_wait_queue(&dev->lock.lock_queue, &entry);
 		for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 			if (!dev->lock.hw_lock) {
 				/* Device has been unregistered */
@@ -791,5 +792,4 @@ int gamma_lock(struct inode *inode, stru
 				/* Contention */
 			atomic_inc(&dev->total_sleeps);
-			current->state = TASK_INTERRUPTIBLE;
 			schedule();
 			if (signal_pending(current)) {

Index: drivers/char/drm/gamma_drv.c
--- drivers/char/drm/gamma_drv.c.prev
+++ drivers/char/drm/gamma_drv.c	Fri Nov 17 13:30:05 2000
@@ -58,6 +58,6 @@ static drm_device_t	      gamma_device;
 
 static struct file_operations gamma_fops = {
-#if LINUX_VERSION_CODE >= 0x020322
-				/* This started being used approx. 2.3.34 */
+#if LINUX_VERSION_CODE >= 0x020400
+				/* This started being used during 2.4.0-test */
 	owner:   THIS_MODULE,
 #endif

Index: drivers/char/drm/i810_dma.c
--- drivers/char/drm/i810_dma.c.prev
+++ drivers/char/drm/i810_dma.c	Fri Nov 17 13:30:05 2000
@@ -283,6 +283,6 @@ static unsigned long i810_alloc_page(drm
 		return 0;
 	
-	atomic_inc(&mem_map[MAP_NR((void *) address)].count);
-	set_bit(PG_locked, &mem_map[MAP_NR((void *) address)].flags);
+	atomic_inc(&virt_to_page(address)->count);
+	set_bit(PG_locked, &virt_to_page(address)->flags);
    
 	return address;
@@ -294,7 +294,7 @@ static void i810_free_page(drm_device_t 
 		return;
 	
-	atomic_dec(&mem_map[MAP_NR((void *) page)].count);
-	clear_bit(PG_locked, &mem_map[MAP_NR((void *) page)].flags);
-	wake_up(&mem_map[MAP_NR((void *) page)].wait);
+	atomic_dec(&virt_to_page(page)->count);
+	clear_bit(PG_locked, &virt_to_page(page)->flags);
+	wake_up(&virt_to_page(page)->wait);
 	free_page(page);
 	return;
@@ -1069,9 +1069,9 @@ static void i810_dma_quiescent(drm_devic
 	}
       	atomic_set(&dev_priv->flush_done, 0);
-   	current->state = TASK_INTERRUPTIBLE;
    	add_wait_queue(&dev_priv->flush_queue, &entry);
    	end = jiffies + (HZ*3);
    
    	for (;;) {
+		current->state = TASK_INTERRUPTIBLE;
 	      	i810_dma_quiescent_emit(dev);
 	   	if (atomic_read(&dev_priv->flush_done) == 1) break;
@@ -1104,8 +1104,8 @@ static int i810_flush_queue(drm_device_t
 	}
       	atomic_set(&dev_priv->flush_done, 0);
-   	current->state = TASK_INTERRUPTIBLE;
    	add_wait_queue(&dev_priv->flush_queue, &entry);
    	end = jiffies + (HZ*3);
    	for (;;) {
+		current->state = TASK_INTERRUPTIBLE;
 	      	i810_dma_emit_flush(dev);
 	   	if (atomic_read(&dev_priv->flush_done) == 1) break;
@@ -1200,4 +1200,5 @@ int i810_lock(struct inode *inode, struc
 		add_wait_queue(&dev->lock.lock_queue, &entry);
 		for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 			if (!dev->lock.hw_lock) {
 				/* Device has been unregistered */
@@ -1215,5 +1216,4 @@ int i810_lock(struct inode *inode, struc
 				/* Contention */
 			atomic_inc(&dev->total_sleeps);
-			current->state = TASK_INTERRUPTIBLE;
 		   	DRM_DEBUG("Calling lock schedule\n");
 			schedule();

Index: drivers/char/drm/i810_drv.c
--- drivers/char/drm/i810_drv.c.prev
+++ drivers/char/drm/i810_drv.c	Fri Nov 17 13:30:05 2000
@@ -515,4 +515,5 @@ int i810_release(struct inode *inode, st
 	   	add_wait_queue(&dev->lock.lock_queue, &entry);
 		for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 			if (!dev->lock.hw_lock) {
 				/* Device has been unregistered */
@@ -529,5 +530,4 @@ int i810_release(struct inode *inode, st
 				/* Contention */
 			atomic_inc(&dev->total_sleeps);
-			current->state = TASK_INTERRUPTIBLE;
 			schedule();
 			if (signal_pending(current)) {

Index: drivers/char/drm/lists.c
--- drivers/char/drm/lists.c.prev
+++ drivers/char/drm/lists.c	Fri Nov 17 13:30:05 2000
@@ -117,4 +117,5 @@ int drm_freelist_create(drm_freelist_t *
 	bl->high_mark = 0;
 	atomic_set(&bl->wfh,   0);
+	bl->lock      = SPIN_LOCK_UNLOCKED;
 	++bl->initialized;
 	return 0;
@@ -131,6 +132,4 @@ int drm_freelist_destroy(drm_freelist_t 
 int drm_freelist_put(drm_device_t *dev, drm_freelist_t *bl, drm_buf_t *buf)
 {
-	drm_buf_t        *old, *prev;
-	int		 count = 0;
 	drm_device_dma_t *dma  = dev->dma;
 
@@ -153,13 +152,10 @@ int drm_freelist_put(drm_device_t *dev, 
 #endif
 	buf->list	= DRM_LIST_FREE;
-	do {
-		old       = bl->next;
-		buf->next = old;
-		prev      = cmpxchg(&bl->next, old, buf);
-		if (++count > DRM_LOOPING_LIMIT) {
-			DRM_ERROR("Looping\n");
-			return 1;
-		}
-	} while (prev != old);
+	
+	spin_lock(&bl->lock);
+	buf->next	= bl->next;
+	bl->next	= buf;
+	spin_unlock(&bl->lock);
+	
 	atomic_inc(&bl->count);
 	if (atomic_read(&bl->count) > dma->buf_count) {
@@ -178,29 +174,21 @@ int drm_freelist_put(drm_device_t *dev, 
 static drm_buf_t *drm_freelist_try(drm_freelist_t *bl)
 {
-	drm_buf_t         *old, *new, *prev;
 	drm_buf_t	  *buf;
-	int		  count = 0;
 
 	if (!bl) return NULL;
 	
 				/* Get buffer */
-	do {
-		old = bl->next;
-		if (!old) return NULL;
-		new  = bl->next->next;
-		prev = cmpxchg(&bl->next, old, new);
-		if (++count > DRM_LOOPING_LIMIT) {
-			DRM_ERROR("Looping\n");
-			return NULL;
-		}
-	} while (prev != old);
-	atomic_dec(&bl->count);
+	spin_lock(&bl->lock);
+	if (!bl->next) {
+		spin_unlock(&bl->lock);
+		return NULL;
+	}
+	buf	  = bl->next;
+	bl->next  = bl->next->next;
+	spin_unlock(&bl->lock);
 	
-	buf	  = old;
+	atomic_dec(&bl->count);
 	buf->next = NULL;
 	buf->list = DRM_LIST_NONE;
-	DRM_DEBUG("%d, count = %d, wfh = %d, w%d, p%d\n",
-		  buf->idx, atomic_read(&bl->count), atomic_read(&bl->wfh),
-		  buf->waiting, buf->pending);
 	if (buf->waiting || buf->pending) {
 		DRM_ERROR("Free buffer %d: w%d, p%d, l%d\n",
@@ -222,11 +210,8 @@ drm_buf_t *drm_freelist_get(drm_freelist
 		atomic_set(&bl->wfh, 1);
 	if (atomic_read(&bl->wfh)) {
-		DRM_DEBUG("Block = %d, count = %d, wfh = %d\n",
-			  block, atomic_read(&bl->count),
-			  atomic_read(&bl->wfh));
 		if (block) {
 			add_wait_queue(&bl->waiting, &entry);
-			current->state = TASK_INTERRUPTIBLE;
 			for (;;) {
+				current->state = TASK_INTERRUPTIBLE;
 				if (!atomic_read(&bl->wfh)
 				    && (buf = drm_freelist_try(bl))) break;

Index: drivers/char/drm/lock.c
--- drivers/char/drm/lock.c.prev
+++ drivers/char/drm/lock.c	Fri Nov 17 13:30:05 2000
@@ -129,8 +129,8 @@ static int drm_flush_queue(drm_device_t 
 	if (atomic_read(&q->use_count) > 1) {
 		atomic_inc(&q->block_write);
-		current->state = TASK_INTERRUPTIBLE;
 		add_wait_queue(&q->flush_queue, &entry);
 		atomic_inc(&q->block_count);
 		for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 			if (!DRM_BUFCOUNT(&q->waitlist)) break;
 			schedule();

Index: drivers/char/drm/memory.c
--- drivers/char/drm/memory.c.prev
+++ drivers/char/drm/memory.c	Fri Nov 17 13:30:05 2000
@@ -33,4 +33,5 @@
 #include <linux/config.h>
 #include "drmP.h"
+#include <linux/wrapper.h>
 
 typedef struct drm_mem_stats {
@@ -247,5 +248,10 @@ unsigned long drm_alloc_pages(int order,
 	     sz > 0;
 	     addr += PAGE_SIZE, sz -= PAGE_SIZE) {
+#if LINUX_VERSION_CODE >= 0x020400
+				/* Argument type changed in 2.4.0-test6/pre8 */
+		mem_map_reserve(virt_to_page(addr));
+#else
 		mem_map_reserve(MAP_NR(addr));
+#endif
 	}
 	
@@ -268,5 +274,10 @@ void drm_free_pages(unsigned long addres
 		     sz > 0;
 		     addr += PAGE_SIZE, sz -= PAGE_SIZE) {
+#if LINUX_VERSION_CODE >= 0x020400
+				/* Argument type changed in 2.4.0-test6/pre8 */
+			mem_map_unreserve(virt_to_page(addr));
+#else
 			mem_map_unreserve(MAP_NR(addr));
+#endif
 		}
 		free_pages(address, order);

Index: drivers/char/drm/mga_context.c
--- drivers/char/drm/mga_context.c.prev
+++ drivers/char/drm/mga_context.c	Fri Nov 17 13:30:05 2000
@@ -196,4 +196,8 @@ int mga_rmctx(struct inode *inode, struc
 	copy_from_user_ret(&ctx, (drm_ctx_t *)arg, sizeof(ctx), -EFAULT);
 	DRM_DEBUG("%d\n", ctx.handle);
+	if(ctx.handle == DRM_KERNEL_CONTEXT+1) {
+		priv->remove_auth_on_close = 1;
+	}
+
       	if(ctx.handle != DRM_KERNEL_CONTEXT) {
 	   	drm_ctxbitmap_free(dev, ctx.handle);

Index: drivers/char/drm/mga_dma.c
--- drivers/char/drm/mga_dma.c.prev
+++ drivers/char/drm/mga_dma.c	Fri Nov 17 13:30:05 2000
@@ -53,11 +53,10 @@ static unsigned long mga_alloc_page(drm_
 	unsigned long address;
    
-	DRM_DEBUG("%s\n", __FUNCTION__);
 	address = __get_free_page(GFP_KERNEL);
 	if(address == 0UL) {
 		return 0;
 	}
-	atomic_inc(&mem_map[MAP_NR((void *) address)].count);
-	set_bit(PG_locked, &mem_map[MAP_NR((void *) address)].flags);
+	atomic_inc(&virt_to_page(address)->count);
+	set_bit(PG_reserved, &virt_to_page(address)->flags);
    
 	return address;
@@ -66,12 +65,7 @@ static unsigned long mga_alloc_page(drm_
 static void mga_free_page(drm_device_t *dev, unsigned long page)
 {
-	DRM_DEBUG("%s\n", __FUNCTION__);
-
-	if(page == 0UL) {
-		return;
-	}
-	atomic_dec(&mem_map[MAP_NR((void *) page)].count);
-	clear_bit(PG_locked, &mem_map[MAP_NR((void *) page)].flags);
-	wake_up(&mem_map[MAP_NR((void *) page)].wait);
+	if(!page) return;
+	atomic_dec(&virt_to_page(page)->count);
+	clear_bit(PG_reserved, &virt_to_page(page)->flags);
 	free_page(page);
 	return;
@@ -80,16 +74,5 @@ static void mga_free_page(drm_device_t *
 static void mga_delay(void)
 {
-   	return;
-}
-
-void mga_flush_write_combine(void)
-{
-   	int xchangeDummy;
-	DRM_DEBUG("%s\n", __FUNCTION__);
-
-   	__asm__ volatile(" push %%eax ; xchg %%eax, %0 ; pop %%eax" : : "m" (xchangeDummy));
-   	__asm__ volatile(" push %%eax ; push %%ebx ; push %%ecx ; push %%edx ;"
-			 " movl $0,%%eax ; cpuid ; pop %%edx ; pop %%ecx ; pop %%ebx ;"
-			 " pop %%eax" : /* no outputs */ :  /* no inputs */ );
+	return;
 }
 
@@ -165,5 +148,5 @@ static inline void mga_dma_quiescent(drm
 	int i;
 
-	DRM_DEBUG("%s\n", __FUNCTION__);
+	DRM_DEBUG("dispatch_status = 0x%02x\n", dev_priv->dispatch_status);
 	end = jiffies + (HZ*3);
     	while(1) {
@@ -176,5 +159,7 @@ static inline void mga_dma_quiescent(drm
 				  atomic_read(&dev->total_irq), 
 				  atomic_read(&dma->total_lost));
-			DRM_ERROR("lockup\n"); 
+			DRM_ERROR("lockup: dispatch_status = 0x%02x,"
+				  " jiffies = %lu, end = %lu\n",
+				  dev_priv->dispatch_status, jiffies, end);
 			goto out_nolock;
 		}
@@ -226,29 +211,29 @@ drm_buf_t *mga_freelist_get(drm_device_t
    	drm_mga_freelist_t *next;
 	static int failed = 0;
+	int return_null = 0;
 
-	DRM_DEBUG("%s : tail->age : %d last_prim_age : %d\n", __FUNCTION__,
-	       dev_priv->tail->age, dev_priv->last_prim_age);
-   
 	if(failed >= 1000 && dev_priv->tail->age >= dev_priv->last_prim_age) {
-		DRM_DEBUG("I'm waiting on the freelist!!! %d\n", 
-		       dev_priv->last_prim_age);
-	   	set_bit(MGA_IN_GETBUF, &dev_priv->dispatch_status);
-		current->state = TASK_INTERRUPTIBLE;
+		DRM_DEBUG("Waiting on freelist,"
+			  " tail->age = %d, last_prim_age= %d\n",
+			  dev_priv->tail->age,
+			  dev_priv->last_prim_age);
 	   	add_wait_queue(&dev_priv->buf_queue, &entry);
+		set_bit(MGA_IN_GETBUF, &dev_priv->dispatch_status);
 	   	for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 		   	mga_dma_schedule(dev, 0);
-		   	if(!test_bit(MGA_IN_GETBUF, 
-				     &dev_priv->dispatch_status)) 
+			if(dev_priv->tail->age < dev_priv->last_prim_age)
 				break;
 		   	atomic_inc(&dev->total_sleeps);
 		   	schedule();
 		   	if (signal_pending(current)) {
-				clear_bit(MGA_IN_GETBUF,
-					  &dev_priv->dispatch_status);
-			   	goto failed_getbuf;
+				++return_null;
+				break;
 			}
 		}
-	   	current->state = TASK_RUNNING;
+		clear_bit(MGA_IN_GETBUF, &dev_priv->dispatch_status);
+		current->state = TASK_RUNNING;
 	   	remove_wait_queue(&dev_priv->buf_queue, &entry);
+		if (return_null) return NULL;
 	}
    
@@ -264,5 +249,4 @@ drm_buf_t *mga_freelist_get(drm_device_t
 	}
 
-failed_getbuf:
 	failed++;
    	return NULL;
@@ -313,5 +297,4 @@ static int mga_init_primary_bufs(drm_dev
    	int offset = init->reserved_map_agpstart;
 
-	DRM_DEBUG("%s\n", __FUNCTION__);
    	dev_priv->primary_size = ((init->primary_size + PAGE_SIZE - 1) / 
 				  PAGE_SIZE) * PAGE_SIZE;
@@ -334,5 +317,5 @@ static int mga_init_primary_bufs(drm_dev
 					temp);
 	if(dev_priv->ioremap == NULL) {
-		DRM_DEBUG("Ioremap failed\n");
+		DRM_ERROR("Ioremap failed\n");
 		return -ENOMEM;
 	}
@@ -340,5 +323,5 @@ static int mga_init_primary_bufs(drm_dev
    
    	for(i = 0; i < MGA_NUM_PRIM_BUFS; i++) {
-	   	prim_buffer = drm_alloc(sizeof(drm_mga_prim_buf_t), 
+	   	prim_buffer = drm_alloc(sizeof(drm_mga_prim_buf_t),
 					DRM_MEM_DRIVER);
 	   	if(prim_buffer == NULL) return -ENOMEM;
@@ -475,7 +458,6 @@ int mga_advance_primary(drm_device_t *de
    	if(test_and_set_bit(MGA_BUF_IN_USE, &prim_buffer->buffer_status)) {
 	   	add_wait_queue(&dev_priv->wait_queue, &entry);
-		current->state = TASK_INTERRUPTIBLE;
-
 	   	for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 		   	mga_dma_schedule(dev, 0);
 		   	if(!test_and_set_bit(MGA_BUF_IN_USE, 
@@ -522,10 +504,6 @@ static inline int mga_decide_to_fire(drm
 {
    	drm_mga_private_t *dev_priv = (drm_mga_private_t *)dev->dev_private;
-      	drm_device_dma_t  *dma	    = dev->dma;
-
-   	DRM_DEBUG("%s\n", __FUNCTION__);
 
    	if(test_bit(MGA_BUF_FORCE_FIRE, &dev_priv->next_prim->buffer_status)) {
-	   	atomic_inc(&dma->total_prio);
 	   	return 1;
 	}
@@ -533,5 +511,4 @@ static inline int mga_decide_to_fire(drm
 	if (test_bit(MGA_IN_GETBUF, &dev_priv->dispatch_status) &&
 	    dev_priv->next_prim->num_dwords) {
-	   	atomic_inc(&dma->total_prio);
 	   	return 1;
 	}
@@ -539,5 +516,4 @@ static inline int mga_decide_to_fire(drm
 	if (test_bit(MGA_IN_FLUSH, &dev_priv->dispatch_status) &&
 	    dev_priv->next_prim->num_dwords) {
-	   	atomic_inc(&dma->total_prio);
 	   	return 1;
 	}
@@ -546,5 +522,4 @@ static inline int mga_decide_to_fire(drm
 		if(test_bit(MGA_BUF_SWAP_PENDING, 
 			    &dev_priv->next_prim->buffer_status)) {
-			atomic_inc(&dma->total_dmas);
 			return 1;
 		}
@@ -553,5 +528,4 @@ static inline int mga_decide_to_fire(drm
    	if(atomic_read(&dev_priv->pending_bufs) <= MGA_NUM_PRIM_BUFS / 2) {
 		if(dev_priv->next_prim->sec_used >= MGA_DMA_BUF_NR / 8) {
-			atomic_inc(&dma->total_hit);
 			return 1;
 		}
@@ -560,10 +534,8 @@ static inline int mga_decide_to_fire(drm
    	if(atomic_read(&dev_priv->pending_bufs) >= MGA_NUM_PRIM_BUFS / 2) {
 		if(dev_priv->next_prim->sec_used >= MGA_DMA_BUF_NR / 4) {
-			atomic_inc(&dma->total_missed_free);
 			return 1;
 		}
 	}
 
-   	atomic_inc(&dma->total_tried);
    	return 0;
 }
@@ -572,9 +544,9 @@ int mga_dma_schedule(drm_device_t *dev, 
 {
       	drm_mga_private_t *dev_priv = (drm_mga_private_t *)dev->dev_private;
-      	drm_device_dma_t  *dma	    = dev->dma;
-	int retval = 0;
+	int               retval    = 0;
 
-   	if (test_and_set_bit(0, &dev->dma_flag)) {
-		atomic_inc(&dma->total_missed_dma);
+   	if (!dev_priv) return -EBUSY;
+	
+	if (test_and_set_bit(0, &dev->dma_flag)) {
 		retval = -EBUSY;
 		goto sch_out_wakeup;
@@ -591,16 +563,12 @@ int mga_dma_schedule(drm_device_t *dev, 
    	if (!locked && 
 	    !drm_lock_take(&dev->lock.hw_lock->lock, DRM_KERNEL_CONTEXT)) {
-	   	atomic_inc(&dma->total_missed_lock);
 	   	clear_bit(0, &dev->dma_flag);
-		DRM_DEBUG("Not locked\n");
 		retval = -EBUSY;
 		goto sch_out_wakeup;
 	}
-   	DRM_DEBUG("I'm locked\n");
 
    	if(!test_and_set_bit(MGA_IN_DISPATCH, &dev_priv->dispatch_status)) {
 	   	/* Fire dma buffer */
 	   	if(mga_decide_to_fire(dev)) {
-		   	DRM_DEBUG("idx :%d\n", dev_priv->next_prim->idx);
 			clear_bit(MGA_BUF_FORCE_FIRE, 
 				  &dev_priv->next_prim->buffer_status);
@@ -614,6 +582,4 @@ int mga_dma_schedule(drm_device_t *dev, 
 			clear_bit(MGA_IN_DISPATCH, &dev_priv->dispatch_status);
 		}
-	} else {
-		DRM_DEBUG("I can't get the dispatch lock\n");
 	}
    	
@@ -625,4 +591,6 @@ int mga_dma_schedule(drm_device_t *dev, 
 	}
 
+	clear_bit(0, &dev->dma_flag);
+
 sch_out_wakeup:
       	if(test_bit(MGA_IN_FLUSH, &dev_priv->dispatch_status) &&
@@ -634,15 +602,7 @@ sch_out_wakeup:
 
 	if(test_bit(MGA_IN_GETBUF, &dev_priv->dispatch_status) &&
-	   dev_priv->tail->age < dev_priv->last_prim_age) {
-		clear_bit(MGA_IN_GETBUF, &dev_priv->dispatch_status);
-		DRM_DEBUG("Waking up buf queue\n");
+	   dev_priv->tail->age < dev_priv->last_prim_age)
 		wake_up_interruptible(&dev_priv->buf_queue);
-	} else if (test_bit(MGA_IN_GETBUF, &dev_priv->dispatch_status)) {
-	   	DRM_DEBUG("Not waking buf_queue on %d %d\n", 
-			  atomic_read(&dev->total_irq), 
-			  dev_priv->last_prim_age);
-	}
 
-   	clear_bit(0, &dev->dma_flag);
 	return retval;
 }
@@ -654,5 +614,4 @@ static void mga_dma_service(int irq, voi
     	drm_mga_prim_buf_t *last_prim_buffer;
 
-	DRM_DEBUG("%s\n", __FUNCTION__);
     	atomic_inc(&dev->total_irq);
 	if((MGA_READ(MGAREG_STATUS) & 0x00000001) != 0x00000001) return;
@@ -664,5 +623,4 @@ static void mga_dma_service(int irq, voi
 		dev_priv->last_prim_age = last_prim_buffer->prim_age;
       	clear_bit(MGA_BUF_IN_USE, &last_prim_buffer->buffer_status);
-   	wake_up_interruptible(&dev_priv->wait_queue);
       	clear_bit(MGA_BUF_SWAP_PENDING, &last_prim_buffer->buffer_status);
       	clear_bit(MGA_IN_DISPATCH, &dev_priv->dispatch_status);
@@ -670,9 +628,9 @@ static void mga_dma_service(int irq, voi
    	queue_task(&dev->tq, &tq_immediate);
    	mark_bh(IMMEDIATE_BH);
+   	wake_up_interruptible(&dev_priv->wait_queue);
 }
 
 static void mga_dma_task_queue(void *device)
 {
-	DRM_DEBUG("%s\n", __FUNCTION__);
 	mga_dma_schedule((drm_device_t *)device, 0);
 }
@@ -680,10 +638,11 @@ static void mga_dma_task_queue(void *dev
 int mga_dma_cleanup(drm_device_t *dev)
 {
-	DRM_DEBUG("%s\n", __FUNCTION__);
-
 	if(dev->dev_private) {
 		drm_mga_private_t *dev_priv = 
 			(drm_mga_private_t *) dev->dev_private;
       
+		if (dev->irq) mga_flush_queue(dev);
+		mga_dma_quiescent(dev);
+
 		if(dev_priv->ioremap) {
 			int temp = (dev_priv->warp_ucode_size + 
@@ -728,7 +687,4 @@ static int mga_dma_initialize(drm_device
 	drm_mga_private_t *dev_priv;
 	drm_map_t *sarea_map = NULL;
-	int i;
-
-	DRM_DEBUG("%s\n", __FUNCTION__);
 
 	dev_priv = drm_alloc(sizeof(drm_mga_private_t), DRM_MEM_DRIVER);
@@ -766,22 +722,16 @@ static int mga_dma_initialize(drm_device
    	init_waitqueue_head(&dev_priv->flush_queue);
 	init_waitqueue_head(&dev_priv->buf_queue);
-	dev_priv->WarpPipe = -1;
+	dev_priv->WarpPipe = 0xff000000;
+	dev_priv->vertexsize = 0;
 
-   	DRM_DEBUG("chipset: %d ucode_size: %d backOffset: %x depthOffset: %x\n",
-		  dev_priv->chipset, dev_priv->warp_ucode_size, 
+   	DRM_DEBUG("chipset=%d ucode_size=%d backOffset=%x depthOffset=%x\n",
+		  dev_priv->chipset, dev_priv->warp_ucode_size,
 		  dev_priv->backOffset, dev_priv->depthOffset);
    	DRM_DEBUG("cpp: %d sgram: %d stride: %d maccess: %x\n",
 		  dev_priv->cpp, dev_priv->sgram, dev_priv->stride, 
 		  dev_priv->mAccess);
-   
-	memcpy(&dev_priv->WarpIndex, &init->WarpIndex, 
-	       sizeof(drm_mga_warp_index_t) * MGA_MAX_WARP_PIPES);
 
-   	for (i = 0 ; i < MGA_MAX_WARP_PIPES ; i++) 
-		DRM_DEBUG("warp pipe %d: installed: %d phys: %lx size: %x\n",
-			  i, 
-			  dev_priv->WarpIndex[i].installed,
-			  dev_priv->WarpIndex[i].phys_addr,
-			  dev_priv->WarpIndex[i].size);
+	memcpy(&dev_priv->WarpIndex, &init->WarpIndex,
+	       sizeof(drm_mga_warp_index_t) * MGA_MAX_WARP_PIPES);
 
    	if(mga_init_primary_bufs(dev, init) != 0) {
@@ -953,16 +903,14 @@ static int mga_flush_queue(drm_device_t 
    	int ret = 0;
 
-   	DRM_DEBUG("%s\n", __FUNCTION__);
+   	if(!dev_priv) return 0;
 
-   	if(dev_priv == NULL) {
-	   	return 0;
-	}
-   
    	if(dev_priv->next_prim->num_dwords != 0) {
-   		current->state = TASK_INTERRUPTIBLE;
    		add_wait_queue(&dev_priv->flush_queue, &entry);
+		if (test_bit(MGA_IN_FLUSH, &dev_priv->dispatch_status)) 
+			DRM_ERROR("Incorrect mga_flush_queue logic\n");
 		set_bit(MGA_IN_FLUSH, &dev_priv->dispatch_status);
 		mga_dma_schedule(dev, 0);
    		for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 	   		if (!test_bit(MGA_IN_FLUSH, 
 				      &dev_priv->dispatch_status)) 
@@ -993,5 +941,6 @@ void mga_reclaim_buffers(drm_device_t *d
 	if(dma->buflist == NULL) return;
 
-	DRM_DEBUG("%s\n", __FUNCTION__);
+	DRM_DEBUG("buf_count=%d\n", dma->buf_count);
+	
         mga_flush_queue(dev);
 
@@ -1042,4 +991,5 @@ int mga_lock(struct inode *inode, struct
 		add_wait_queue(&dev->lock.lock_queue, &entry);
 		for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 			if (!dev->lock.hw_lock) {
 				/* Device has been unregistered */
@@ -1057,5 +1007,4 @@ int mga_lock(struct inode *inode, struct
 				/* Contention */
 			atomic_inc(&dev->total_sleeps);
-			current->state = TASK_INTERRUPTIBLE;
 			schedule();
 			if (signal_pending(current)) {
@@ -1076,5 +1025,6 @@ int mga_lock(struct inode *inode, struct
 	}
    
-	DRM_DEBUG("%d %s\n", lock.context, ret ? "interrupted" : "has lock");
+	if (ret) DRM_DEBUG("%d %s\n", lock.context,
+			   ret ? "interrupted" : "has lock");
 	return ret;
 }

Index: drivers/char/drm/mga_drv.c
--- drivers/char/drm/mga_drv.c.prev
+++ drivers/char/drm/mga_drv.c	Fri Nov 17 13:30:05 2000
@@ -43,7 +43,7 @@ static void __attribute__((unused)) unus
 
 #define MGA_NAME	 "mga"
-#define MGA_DESC	 "Matrox g200/g400"
-#define MGA_DATE	 "20000719"
-#define MGA_MAJOR	 1
+#define MGA_DESC	 "Matrox G200/G400"
+#define MGA_DATE	 "20000910"
+#define MGA_MAJOR	 2
 #define MGA_MINOR	 0
 #define MGA_PATCHLEVEL	 0
@@ -53,6 +53,6 @@ drm_ctx_t		      mga_res_ctx;
 
 static struct file_operations mga_fops = {
-#if LINUX_VERSION_CODE >= 0x020322
-				/* This started being used approx. 2.3.34 */
+#if LINUX_VERSION_CODE >= 0x020400
+				/* This started being used during 2.4.0-test */
 	owner:   THIS_MODULE,
 #endif
@@ -224,4 +224,5 @@ static int mga_takedown(drm_device_t *de
 	DRM_DEBUG("\n");
 
+	if (dev->dev_private) mga_dma_cleanup(dev);
 	if (dev->irq) mga_irq_uninstall(dev);
 	
@@ -423,5 +424,4 @@ static void mga_cleanup(void)
 	}
 	drm_ctxbitmap_cleanup(dev);
-	mga_dma_cleanup(dev);
 #ifdef CONFIG_MTRR
    	if(dev->agp && dev->agp->agp_mtrr) {
@@ -515,15 +515,19 @@ int mga_release(struct inode *inode, str
 	    && dev->lock.pid == current->pid) {
 	      	mga_reclaim_buffers(dev, priv->pid);
-		DRM_ERROR("Process %d dead, freeing lock for context %d\n",
-			  current->pid,
-			  _DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock));
+		DRM_INFO("Process %d dead (ctx %d, d_s = 0x%02x)\n",
+			 current->pid,
+			 _DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock),
+			 dev->dev_private ?
+			 ((drm_mga_private_t *)dev->dev_private)
+			 ->dispatch_status
+			 : 0);
+
+		if (dev->dev_private)
+			((drm_mga_private_t *)dev->dev_private)
+				->dispatch_status &= MGA_IN_DISPATCH;
+		
 		drm_lock_free(dev,
 			      &dev->lock.hw_lock->lock,
 			      _DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock));
-		
-				/* FIXME: may require heavy-handed reset of
-                                   hardware at this point, possibly
-                                   processed via a callback to the X
-                                   server. */
 	} else if (dev->lock.hw_lock) {
 	   	/* The lock is required to reclaim buffers */
@@ -531,4 +535,5 @@ int mga_release(struct inode *inode, str
 	   	add_wait_queue(&dev->lock.lock_queue, &entry);
 		for (;;) {
+			current->state = TASK_INTERRUPTIBLE;
 			if (!dev->lock.hw_lock) {
 				/* Device has been unregistered */
@@ -545,5 +550,4 @@ int mga_release(struct inode *inode, str
 				/* Contention */
 			atomic_inc(&dev->total_sleeps);
-			current->state = TASK_INTERRUPTIBLE;
 			schedule();
 			if (signal_pending(current)) {
@@ -556,4 +560,7 @@ int mga_release(struct inode *inode, str
 	   	if(!retcode) {
 		   	mga_reclaim_buffers(dev, priv->pid);
+			if (dev->dev_private)
+				((drm_mga_private_t *)dev->dev_private)
+					->dispatch_status &= MGA_IN_DISPATCH;
 		   	drm_lock_free(dev, &dev->lock.hw_lock->lock,
 				      DRM_KERNEL_CONTEXT);
@@ -563,4 +570,11 @@ int mga_release(struct inode *inode, str
 
 	down(&dev->struct_sem);
+	if (priv->remove_auth_on_close == 1) {
+		drm_file_t *temp = dev->file_first;
+		while(temp) {
+			temp->authenticated = 0;
+			temp = temp->next;
+		}
+	}
 	if (priv->prev) priv->prev->next = priv->next;
 	else		dev->file_first	 = priv->next;
@@ -620,5 +634,8 @@ int mga_ioctl(struct inode *inode, struc
 
 		if (!func) {
-			DRM_DEBUG("no function\n");
+			DRM_DEBUG("no function: pid = %d, cmd = 0x%02x,"
+				  " nr = 0x%02x, dev 0x%x, auth = %d\n",
+				  current->pid, cmd, nr, dev->device,
+				  priv->authenticated);
 			retcode = -EINVAL;
 		} else if ((ioctl->root_only && !capable(CAP_SYS_ADMIN))

Index: drivers/char/drm/mga_state.c
--- drivers/char/drm/mga_state.c.prev
+++ drivers/char/drm/mga_state.c	Fri Nov 17 13:30:05 2000
@@ -35,4 +35,20 @@
 #include "drm.h"
 
+/* If you change the functions to set state, PLEASE
+ * change these values
+ */
+
+#define MGAEMITCLIP_SIZE	10
+#define MGAEMITCTX_SIZE		20
+#define MGAG200EMITTEX_SIZE 	20
+#define MGAG400EMITTEX0_SIZE	30
+#define MGAG400EMITTEX1_SIZE	25
+#define MGAG400EMITPIPE_SIZE	50
+#define MGAG200EMITPIPE_SIZE	15
+
+#define MAX_STATE_SIZE ((MGAEMITCLIP_SIZE * MGA_NR_SAREA_CLIPRECTS) + \
+			MGAEMITCTX_SIZE + MGAG400EMITTEX0_SIZE + \
+			MGAG400EMITTEX1_SIZE + MGAG400EMITPIPE_SIZE)
+
 static void mgaEmitClipRect(drm_mga_private_t * dev_priv,
 			    drm_clip_rect_t * box)
@@ -41,26 +57,26 @@ static void mgaEmitClipRect(drm_mga_priv
 	unsigned int *regs = sarea_priv->ContextState;
 	PRIMLOCALS;
-	DRM_DEBUG("%s\n", __FUNCTION__);
 
 	/* This takes 10 dwords */
 	PRIMGETPTR(dev_priv);
 
-	/* Force reset of dwgctl (eliminates clip disable) */
+	/* Force reset of dwgctl on G400 (eliminates clip disable bit) */
+	if (dev_priv->chipset == MGA_CARD_TYPE_G400) {
 #if 0
-	PRIMOUTREG(MGAREG_DMAPAD, 0);
-	PRIMOUTREG(MGAREG_DWGSYNC, 0);
-	PRIMOUTREG(MGAREG_DWGSYNC, 0);
-	PRIMOUTREG(MGAREG_DWGCTL, regs[MGA_CTXREG_DWGCTL]);
+		PRIMOUTREG(MGAREG_DMAPAD, 0);
+		PRIMOUTREG(MGAREG_DWGSYNC, 0);
+		PRIMOUTREG(MGAREG_DWGSYNC, 0);
+		PRIMOUTREG(MGAREG_DWGCTL, regs[MGA_CTXREG_DWGCTL]);
 #else
-	PRIMOUTREG(MGAREG_DWGCTL, regs[MGA_CTXREG_DWGCTL]);
-	PRIMOUTREG(MGAREG_LEN + MGAREG_MGA_EXEC, 0x80000000);
-	PRIMOUTREG(MGAREG_DWGCTL, regs[MGA_CTXREG_DWGCTL]);
-	PRIMOUTREG(MGAREG_LEN + MGAREG_MGA_EXEC, 0x80000000);
+		PRIMOUTREG(MGAREG_DWGCTL, regs[MGA_CTXREG_DWGCTL]);
+		PRIMOUTREG(MGAREG_LEN + MGAREG_MGA_EXEC, 0x80000000);
+		PRIMOUTREG(MGAREG_DWGCTL, regs[MGA_CTXREG_DWGCTL]);
+		PRIMOUTREG(MGAREG_LEN + MGAREG_MGA_EXEC, 0x80000000);
 #endif
-
+	}
 	PRIMOUTREG(MGAREG_DMAPAD, 0);
 	PRIMOUTREG(MGAREG_CXBNDRY, ((box->x2) << 16) | (box->x1));
-	PRIMOUTREG(MGAREG_YTOP, box->y1 * dev_priv->stride / 2);
-	PRIMOUTREG(MGAREG_YBOT, box->y2 * dev_priv->stride / 2);
+	PRIMOUTREG(MGAREG_YTOP, box->y1 * dev_priv->stride / dev_priv->cpp);
+	PRIMOUTREG(MGAREG_YBOT, box->y2 * dev_priv->stride / dev_priv->cpp);
 
 	PRIMADVANCE(dev_priv);
@@ -72,7 +88,6 @@ static void mgaEmitContext(drm_mga_priva
 	unsigned int *regs = sarea_priv->ContextState;
 	PRIMLOCALS;
-	DRM_DEBUG("%s\n", __FUNCTION__);
 
-	/* This takes a max of 15 dwords */
+	/* This takes a max of 20 dwords */
 	PRIMGETPTR(dev_priv);
 
@@ -92,4 +107,9 @@ static void mgaEmitContext(drm_mga_priva
 		PRIMOUTREG(MGAREG_TDUALSTAGE1, regs[MGA_CTXREG_TDUAL1]);
 		PRIMOUTREG(MGAREG_FCOL, regs[MGA_CTXREG_FCOL]);
+
+		PRIMOUTREG(MGAREG_STENCIL, regs[MGA_CTXREG_STENCIL]);
+		PRIMOUTREG(MGAREG_STENCILCTL, regs[MGA_CTXREG_STENCILCTL]);
+		PRIMOUTREG(MGAREG_DMAPAD, 0);
+		PRIMOUTREG(MGAREG_DMAPAD, 0);
 	} else {
 		PRIMOUTREG(MGAREG_FCOL, regs[MGA_CTXREG_FCOL]);
@@ -126,7 +146,7 @@ static void mgaG200EmitTex(drm_mga_priva
 	PRIMOUTREG(MGAREG_TEXWIDTH, regs[MGA_TEXREG_WIDTH]);
 	PRIMOUTREG(MGAREG_TEXHEIGHT, regs[MGA_TEXREG_HEIGHT]);
-	PRIMOUTREG(0x2d00 + 24 * 4, regs[MGA_TEXREG_WIDTH]);
+	PRIMOUTREG(MGAREG_WR24, regs[MGA_TEXREG_WIDTH]);
 
-	PRIMOUTREG(0x2d00 + 34 * 4, regs[MGA_TEXREG_HEIGHT]);
+	PRIMOUTREG(MGAREG_WR34, regs[MGA_TEXREG_HEIGHT]);
 	PRIMOUTREG(MGAREG_TEXTRANS, 0xffff);
 	PRIMOUTREG(MGAREG_TEXTRANSHIGH, 0xffff);
@@ -136,15 +156,15 @@ static void mgaG200EmitTex(drm_mga_priva
 }
 
+#define TMC_dualtex_enable 		0x80
+
 static void mgaG400EmitTex0(drm_mga_private_t * dev_priv)
 {
 	drm_mga_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	unsigned int *regs = sarea_priv->TexState[0];
-	int multitex = sarea_priv->WarpPipe & MGA_T2;
 	PRIMLOCALS;
-	DRM_DEBUG("%s\n", __FUNCTION__);
 
 	PRIMGETPTR(dev_priv);
 
-	/* This takes a max of 30 dwords */
+	/* This takes 30 dwords */
 
 	PRIMOUTREG(MGAREG_TEXCTL2, regs[MGA_TEXREG_CTL2] | 0x00008000);
@@ -161,20 +181,18 @@ static void mgaG400EmitTex0(drm_mga_priv
 	PRIMOUTREG(MGAREG_TEXWIDTH, regs[MGA_TEXREG_WIDTH]);
 	PRIMOUTREG(MGAREG_TEXHEIGHT, regs[MGA_TEXREG_HEIGHT]);
-	PRIMOUTREG(0x2d00 + 49 * 4, 0);
+	PRIMOUTREG(MGAREG_WR49, 0);
 
-	PRIMOUTREG(0x2d00 + 57 * 4, 0);
-	PRIMOUTREG(0x2d00 + 53 * 4, 0);
-	PRIMOUTREG(0x2d00 + 61 * 4, 0);
-	PRIMOUTREG(MGAREG_DMAPAD, 0);
+	PRIMOUTREG(MGAREG_WR57, 0);
+	PRIMOUTREG(MGAREG_WR53, 0);
+	PRIMOUTREG(MGAREG_WR61, 0);
+	PRIMOUTREG(MGAREG_WR52, 0x40);
 
-	if (!multitex) {
-		PRIMOUTREG(0x2d00 + 52 * 4, 0x40);
-		PRIMOUTREG(0x2d00 + 60 * 4, 0x40);
-		PRIMOUTREG(MGAREG_DMAPAD, 0);
-		PRIMOUTREG(MGAREG_DMAPAD, 0);
-	}
+	PRIMOUTREG(MGAREG_WR60, 0x40);
+	PRIMOUTREG(MGAREG_WR54, regs[MGA_TEXREG_WIDTH] | 0x40);
+	PRIMOUTREG(MGAREG_WR62, regs[MGA_TEXREG_HEIGHT] | 0x40);
+	PRIMOUTREG(MGAREG_DMAPAD, 0);
 
-	PRIMOUTREG(0x2d00 + 54 * 4, regs[MGA_TEXREG_WIDTH] | 0x40);
-	PRIMOUTREG(0x2d00 + 62 * 4, regs[MGA_TEXREG_HEIGHT] | 0x40);
+	PRIMOUTREG(MGAREG_DMAPAD, 0);
+	PRIMOUTREG(MGAREG_DMAPAD, 0);
 	PRIMOUTREG(MGAREG_TEXTRANS, 0xffff);
 	PRIMOUTREG(MGAREG_TEXTRANSHIGH, 0xffff);
@@ -210,12 +228,12 @@ static void mgaG400EmitTex1(drm_mga_priv
 	PRIMOUTREG(MGAREG_TEXWIDTH, regs[MGA_TEXREG_WIDTH]);
 	PRIMOUTREG(MGAREG_TEXHEIGHT, regs[MGA_TEXREG_HEIGHT]);
-	PRIMOUTREG(0x2d00 + 49 * 4, 0);
+	PRIMOUTREG(MGAREG_WR49, 0);
 
-	PRIMOUTREG(0x2d00 + 57 * 4, 0);
-	PRIMOUTREG(0x2d00 + 53 * 4, 0);
-	PRIMOUTREG(0x2d00 + 61 * 4, 0);
-	PRIMOUTREG(0x2d00 + 52 * 4, regs[MGA_TEXREG_WIDTH] | 0x40);
+	PRIMOUTREG(MGAREG_WR57, 0);
+	PRIMOUTREG(MGAREG_WR53, 0);
+	PRIMOUTREG(MGAREG_WR61, 0);
+	PRIMOUTREG(MGAREG_WR52, regs[MGA_TEXREG_WIDTH] | 0x40);
 
-	PRIMOUTREG(0x2d00 + 60 * 4, regs[MGA_TEXREG_HEIGHT] | 0x40);
+	PRIMOUTREG(MGAREG_WR60, regs[MGA_TEXREG_HEIGHT] | 0x40);
 	PRIMOUTREG(MGAREG_TEXTRANS, 0xffff);
 	PRIMOUTREG(MGAREG_TEXTRANSHIGH, 0xffff);
@@ -225,12 +243,14 @@ static void mgaG400EmitTex1(drm_mga_priv
 }
 
-#define EMIT_PIPE 50
+#define MAGIC_FPARAM_HEX_VALUE 0x46480000
+/* This is the hex value of 12800.0f which is a magic value we must
+ * set in wr56.
+ */
+
 static void mgaG400EmitPipe(drm_mga_private_t * dev_priv)
 {
 	drm_mga_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	unsigned int pipe = sarea_priv->WarpPipe;
-	float fParam = 12800.0f;
 	PRIMLOCALS;
-	DRM_DEBUG("%s\n", __FUNCTION__);
 
 	PRIMGETPTR(dev_priv);
@@ -264,12 +284,12 @@ static void mgaG400EmitPipe(drm_mga_priv
 
 			PRIMOUTREG(MGAREG_LEN + MGAREG_MGA_EXEC, 1);
-			PRIMOUTREG(MGAREG_DMAPAD, 0);
 			PRIMOUTREG(MGAREG_DWGSYNC, 0x7000);
-			PRIMOUTREG(MGAREG_DMAPAD, 0);
-
-			PRIMOUTREG(MGAREG_TEXCTL2, 0 | 0x00008000);
+			PRIMOUTREG(MGAREG_TEXCTL2, 0x00008000);
 			PRIMOUTREG(MGAREG_LEN + MGAREG_MGA_EXEC, 0);
+
 			PRIMOUTREG(MGAREG_TEXCTL2, 0x80 | 0x00008000);
 			PRIMOUTREG(MGAREG_LEN + MGAREG_MGA_EXEC, 0);
+			PRIMOUTREG(MGAREG_DMAPAD, 0);
+			PRIMOUTREG(MGAREG_DMAPAD, 0);
 		}
 
@@ -287,16 +307,16 @@ static void mgaG400EmitPipe(drm_mga_priv
 	PRIMOUTREG(MGAREG_WFLAG, 0);
 	PRIMOUTREG(MGAREG_WFLAG1, 0);
-	PRIMOUTREG(0x2d00 + 56 * 4, *((u32 *) (&fParam)));
+	PRIMOUTREG(MGAREG_WR56, MAGIC_FPARAM_HEX_VALUE);
 	PRIMOUTREG(MGAREG_DMAPAD, 0);
 
-	PRIMOUTREG(0x2d00 + 49 * 4, 0);	/* Tex stage 0 */
-	PRIMOUTREG(0x2d00 + 57 * 4, 0);	/* Tex stage 0 */
-	PRIMOUTREG(0x2d00 + 53 * 4, 0);	/* Tex stage 1 */
-	PRIMOUTREG(0x2d00 + 61 * 4, 0);	/* Tex stage 1 */
+	PRIMOUTREG(MGAREG_WR49, 0);	/* Tex stage 0 */
+	PRIMOUTREG(MGAREG_WR57, 0);	/* Tex stage 0 */
+	PRIMOUTREG(MGAREG_WR53, 0);	/* Tex stage 1 */
+	PRIMOUTREG(MGAREG_WR61, 0);	/* Tex stage 1 */
 
-	PRIMOUTREG(0x2d00 + 54 * 4, 0x40);	/* Tex stage 0 : w */
-	PRIMOUTREG(0x2d00 + 62 * 4, 0x40);	/* Tex stage 0 : h */
-	PRIMOUTREG(0x2d00 + 52 * 4, 0x40);	/* Tex stage 1 : w */
-	PRIMOUTREG(0x2d00 + 60 * 4, 0x40);	/* Tex stage 1 : h */
+	PRIMOUTREG(MGAREG_WR54, 0x40);	/* Tex stage 0 : w */
+	PRIMOUTREG(MGAREG_WR62, 0x40);	/* Tex stage 0 : h */
+	PRIMOUTREG(MGAREG_WR52, 0x40);	/* Tex stage 1 : w */
+	PRIMOUTREG(MGAREG_WR60, 0x40);	/* Tex stage 1 : h */
 
 	/* Dma pading required due to hw bug */
@@ -324,10 +344,10 @@ static void mgaG200EmitPipe(drm_mga_priv
 	PRIMOUTREG(MGAREG_WVRTXSZ, 7);
 	PRIMOUTREG(MGAREG_WFLAG, 0);
-	PRIMOUTREG(0x2d00 + 24 * 4, 0);	/* tex w/h */
+	PRIMOUTREG(MGAREG_WR24, 0);	/* tex w/h */
 
-	PRIMOUTREG(0x2d00 + 25 * 4, 0x100);
-	PRIMOUTREG(0x2d00 + 34 * 4, 0);	/* tex w/h */
-	PRIMOUTREG(0x2d00 + 42 * 4, 0xFFFF);
-	PRIMOUTREG(0x2d00 + 60 * 4, 0xFFFF);
+	PRIMOUTREG(MGAREG_WR25, 0x100);
+	PRIMOUTREG(MGAREG_WR34, 0);	/* tex w/h */
+	PRIMOUTREG(MGAREG_WR42, 0xFFFF);
+	PRIMOUTREG(MGAREG_WR60, 0xFFFF);
 
 	/* Dma pading required due to hw bug */
@@ -488,14 +508,11 @@ static void mga_dma_dispatch_tex_blit(dr
 	u16 y2;
 	PRIMLOCALS;
-	DRM_DEBUG("%s\n", __FUNCTION__);
 
 	y2 = length / 64;
 
 	PRIM_OVERFLOW(dev, dev_priv, 30);
-	PRIMGETPTR(dev_priv);
 
 	PRIMOUTREG(MGAREG_DSTORG, destOrg);
 	PRIMOUTREG(MGAREG_MACCESS, 0x00000000);
-	DRM_DEBUG("srcorg : %lx\n", bus_address | use_agp);
 	PRIMOUTREG(MGAREG_SRCORG, (u32) bus_address | use_agp);
 	PRIMOUTREG(MGAREG_AR5, 64);
@@ -511,8 +528,8 @@ static void mga_dma_dispatch_tex_blit(dr
 	PRIMOUTREG(MGAREG_YDSTLEN + MGAREG_MGA_EXEC, y2);
 
+	PRIMOUTREG(MGAREG_DMAPAD, 0);
 	PRIMOUTREG(MGAREG_SRCORG, 0);
 	PRIMOUTREG(MGAREG_PITCH, dev_priv->stride / dev_priv->cpp);
-	PRIMOUTREG(MGAREG_DMAPAD, 0);
-	PRIMOUTREG(MGAREG_DMAPAD, 0);
+	PRIMOUTREG(MGAREG_DWGSYNC, 0x7000);
 	PRIMADVANCE(dev_priv);
 }
@@ -527,14 +544,5 @@ static void mga_dma_dispatch_vertex(drm_
 	int use_agp = PDEA_pagpxfer_enable;
 	int i = 0;
-	int primary_needed;
 	PRIMLOCALS;
-	DRM_DEBUG("%s\n", __FUNCTION__);
-
-	DRM_DEBUG("dispatch vertex %d addr 0x%lx, "
-		  "length 0x%x nbox %d dirty %x\n",
-		  buf->idx, address, length,
-		  sarea_priv->nbox, sarea_priv->dirty);
-
-	DRM_DEBUG("used : %d, total : %d\n", buf->used, buf->total);
 
 	if (buf->used) {
@@ -543,19 +551,14 @@ static void mga_dma_dispatch_vertex(drm_
 		 */
 		buf_priv->dispatched = 1;
-		primary_needed = (50 + 15 + 15 + 30 + 25 +
-				  10 + 15 * MGA_NR_SAREA_CLIPRECTS);
-		PRIM_OVERFLOW(dev, dev_priv, primary_needed);
+		PRIM_OVERFLOW(dev, dev_priv,
+			      (MAX_STATE_SIZE + (5 * MGA_NR_SAREA_CLIPRECTS)));
 		mgaEmitState(dev_priv);
+
+#if 0
+		length = dev_priv->vertexsize * 3 * 4;
+#endif
+
 		do {
 			if (i < sarea_priv->nbox) {
-				DRM_DEBUG("idx %d Emit box %d/%d:"
-					  "%d,%d - %d,%d\n",
-					  buf->idx,
-					  i, sarea_priv->nbox,
-					  sarea_priv->boxes[i].x1,
-					  sarea_priv->boxes[i].y1,
-					  sarea_priv->boxes[i].x2,
-					  sarea_priv->boxes[i].y2);
-
 				mgaEmitClipRect(dev_priv,
 						&sarea_priv->boxes[i]);
@@ -593,12 +596,5 @@ static void mga_dma_dispatch_indices(drm
 	int use_agp = PDEA_pagpxfer_enable;
 	int i = 0;
-	int primary_needed;
 	PRIMLOCALS;
-	DRM_DEBUG("%s\n", __FUNCTION__);
-
-	DRM_DEBUG("dispatch indices %d addr 0x%x, "
-		  "start 0x%x end 0x%x nbox %d dirty %x\n",
-		  buf->idx, address, start, end,
-		  sarea_priv->nbox, sarea_priv->dirty);
 
 	if (start != end) {
@@ -607,20 +603,10 @@ static void mga_dma_dispatch_indices(drm
 		 */
 		buf_priv->dispatched = 1;
-		primary_needed = (50 + 15 + 15 + 30 + 25 +
-				  10 + 15 * MGA_NR_SAREA_CLIPRECTS);
-		PRIM_OVERFLOW(dev, dev_priv, primary_needed);
+		PRIM_OVERFLOW(dev, dev_priv,
+			      (MAX_STATE_SIZE + (5 * MGA_NR_SAREA_CLIPRECTS)));
 		mgaEmitState(dev_priv);
 
 		do {
 			if (i < sarea_priv->nbox) {
-				DRM_DEBUG("idx %d Emit box %d/%d:"
-					  "%d,%d - %d,%d\n",
-					  buf->idx,
-					  i, sarea_priv->nbox,
-					  sarea_priv->boxes[i].x1,
-					  sarea_priv->boxes[i].y1,
-					  sarea_priv->boxes[i].x2,
-					  sarea_priv->boxes[i].y2);
-
 				mgaEmitClipRect(dev_priv,
 						&sarea_priv->boxes[i]);
@@ -649,5 +635,7 @@ static void mga_dma_dispatch_indices(drm
 static void mga_dma_dispatch_clear(drm_device_t * dev, int flags,
 				   unsigned int clear_color,
-				   unsigned int clear_zval)
+				   unsigned int clear_zval,
+				   unsigned int clear_colormask,
+				   unsigned int clear_depthmask)
 {
 	drm_mga_private_t *dev_priv = dev->dev_private;
@@ -658,7 +646,5 @@ static void mga_dma_dispatch_clear(drm_d
 	unsigned int cmd;
 	int i;
-	int primary_needed;
 	PRIMLOCALS;
-	DRM_DEBUG("%s\n", __FUNCTION__);
 
 	if (dev_priv->sgram)
@@ -667,21 +653,12 @@ static void mga_dma_dispatch_clear(drm_d
 		cmd = MGA_CLEAR_CMD | DC_atype_rstr;
 
-	primary_needed = nbox * 70;
-	if (primary_needed == 0)
-		primary_needed = 70;
-	PRIM_OVERFLOW(dev, dev_priv, primary_needed);
-	PRIMGETPTR(dev_priv);
+	PRIM_OVERFLOW(dev, dev_priv, 35 * MGA_NR_SAREA_CLIPRECTS);
 
 	for (i = 0; i < nbox; i++) {
 		unsigned int height = pbox[i].y2 - pbox[i].y1;
 
-		DRM_DEBUG("dispatch clear %d,%d-%d,%d flags %x!\n",
-			  pbox[i].x1, pbox[i].y1, pbox[i].x2,
-			  pbox[i].y2, flags);
-
 		if (flags & MGA_FRONT) {
-			DRM_DEBUG("clear front\n");
-			PRIMOUTREG(MGAREG_DMAPAD, 0);
 			PRIMOUTREG(MGAREG_DMAPAD, 0);
+			PRIMOUTREG(MGAREG_PLNWT, clear_colormask);
 			PRIMOUTREG(MGAREG_YDSTLEN,
 				   (pbox[i].y1 << 16) | height);
@@ -696,7 +673,6 @@ static void mga_dma_dispatch_clear(drm_d
 
 		if (flags & MGA_BACK) {
-			DRM_DEBUG("clear back\n");
-			PRIMOUTREG(MGAREG_DMAPAD, 0);
 			PRIMOUTREG(MGAREG_DMAPAD, 0);
+			PRIMOUTREG(MGAREG_PLNWT, clear_colormask);
 			PRIMOUTREG(MGAREG_YDSTLEN,
 				   (pbox[i].y1 << 16) | height);
@@ -711,7 +687,6 @@ static void mga_dma_dispatch_clear(drm_d
 
 		if (flags & MGA_DEPTH) {
-			DRM_DEBUG("clear depth\n");
-			PRIMOUTREG(MGAREG_DMAPAD, 0);
 			PRIMOUTREG(MGAREG_DMAPAD, 0);
+			PRIMOUTREG(MGAREG_PLNWT, clear_depthmask);
 			PRIMOUTREG(MGAREG_YDSTLEN,
 				   (pbox[i].y1 << 16) | height);
@@ -742,12 +717,9 @@ static void mga_dma_dispatch_swap(drm_de
 	drm_clip_rect_t *pbox = sarea_priv->boxes;
 	int i;
-	int primary_needed;
+	int pixel_stride = dev_priv->stride / dev_priv->cpp;
+
 	PRIMLOCALS;
-	DRM_DEBUG("%s\n", __FUNCTION__);
 
-	primary_needed = nbox * 5;
-	primary_needed += 65;
-	PRIM_OVERFLOW(dev, dev_priv, primary_needed);
-	PRIMGETPTR(dev_priv);
+	PRIM_OVERFLOW(dev, dev_priv, (MGA_NR_SAREA_CLIPRECTS * 5) + 20);
 
 	PRIMOUTREG(MGAREG_DMAPAD, 0);
@@ -759,5 +731,5 @@ static void mga_dma_dispatch_swap(drm_de
 	PRIMOUTREG(MGAREG_MACCESS, dev_priv->mAccess);
 	PRIMOUTREG(MGAREG_SRCORG, dev_priv->backOffset);
-	PRIMOUTREG(MGAREG_AR5, dev_priv->stride / 2);
+	PRIMOUTREG(MGAREG_AR5, pixel_stride);
 
 	PRIMOUTREG(MGAREG_DMAPAD, 0);
@@ -768,8 +740,5 @@ static void mga_dma_dispatch_swap(drm_de
 	for (i = 0; i < nbox; i++) {
 		unsigned int h = pbox[i].y2 - pbox[i].y1;
-		unsigned int start = pbox[i].y1 * dev_priv->stride / 2;
-
-		DRM_DEBUG("dispatch swap %d,%d-%d,%d!\n",
-			  pbox[i].x1, pbox[i].y1, pbox[i].x2, pbox[i].y2);
+		unsigned int start = pbox[i].y1 * pixel_stride;
 
 		PRIMOUTREG(MGAREG_AR0, start + pbox[i].x2 - 1);
@@ -816,5 +785,8 @@ int mga_clear_bufs(struct inode *inode, 
 	dev_priv->sarea_priv->dirty |= MGA_UPLOAD_CTX;
 	mga_dma_dispatch_clear(dev, clear.flags,
-			       clear.clear_color, clear.clear_depth);
+			       clear.clear_color,
+			       clear.clear_depth,
+			       clear.clear_color_mask,
+			       clear.clear_depth_mask);
 	PRIMUPDATE(dev_priv);
 	mga_flush_write_combine();

Index: drivers/char/drm/r128_dma.c
--- drivers/char/drm/r128_dma.c.prev
+++ drivers/char/drm/r128_dma.c	Fri Nov 17 13:30:05 2000
@@ -69,22 +69,6 @@ int R128_READ_PLL(drm_device_t *dev, int
 }
 
-static void r128_flush_write_combine(void)
-{
-	int xchangeDummy;
+#define r128_flush_write_combine()	mb()
 
-	__asm__ volatile("push %%eax ;"
-			 "xchg %%eax, %0 ;"
-			 "pop %%eax" : : "m" (xchangeDummy));
-	__asm__ volatile("push %%eax ;"
-			 "push %%ebx ;"
-			 "push %%ecx ;"
-			 "push %%edx ;"
-			 "movl $0,%%eax ;"
-			 "cpuid ;"
-			 "pop %%edx ;"
-			 "pop %%ecx ;"
-			 "pop %%ebx ;"
-			 "pop %%eax" : /* no outputs */ :  /* no inputs */ );
-}
 
 static void r128_status(drm_device_t *dev)

Index: drivers/char/drm/r128_drv.c
--- drivers/char/drm/r128_drv.c.prev
+++ drivers/char/drm/r128_drv.c	Fri Nov 17 13:30:05 2000
@@ -52,6 +52,6 @@ drm_ctx_t	              r128_res_ctx;
 
 static struct file_operations r128_fops = {
-#if LINUX_VERSION_CODE >= 0x020322
-				/* This started being used approx. 2.3.34 */
+#if LINUX_VERSION_CODE >= 0x020400
+				/* This started being used during 2.4.0-test */
 	owner:   THIS_MODULE,
 #endif
@@ -608,4 +608,5 @@ int r128_lock(struct inode *inode, struc
                 add_wait_queue(&dev->lock.lock_queue, &entry);
                 for (;;) {
+                        current->state = TASK_INTERRUPTIBLE;
                         if (!dev->lock.hw_lock) {
                                 /* Device has been unregistered */
@@ -620,8 +621,6 @@ int r128_lock(struct inode *inode, struc
                                 break;  /* Got lock */
                         }
-
                                 /* Contention */
                         atomic_inc(&dev->total_sleeps);
-                        current->state = TASK_INTERRUPTIBLE;
 #if 1
 			current->policy |= SCHED_YIELD;

Index: drivers/char/drm/tdfx_drv.c
--- drivers/char/drm/tdfx_drv.c.prev
+++ drivers/char/drm/tdfx_drv.c	Fri Nov 17 13:30:05 2000
@@ -567,4 +567,5 @@ int tdfx_lock(struct inode *inode, struc
                 add_wait_queue(&dev->lock.lock_queue, &entry);
                 for (;;) {
+                        current->state = TASK_INTERRUPTIBLE;
                         if (!dev->lock.hw_lock) {
                                 /* Device has been unregistered */
@@ -579,8 +580,6 @@ int tdfx_lock(struct inode *inode, struc
                                 break;  /* Got lock */
                         }
-                        
                                 /* Contention */
                         atomic_inc(&dev->total_sleeps);
-                        current->state = TASK_INTERRUPTIBLE;
 #if 1
 			current->policy |= SCHED_YIELD;

Index: drivers/char/drm/vm.c
--- drivers/char/drm/vm.c.prev
+++ drivers/char/drm/vm.c	Fri Nov 17 13:30:05 2000
@@ -45,4 +45,10 @@ struct vm_operations_struct   drm_vm_shm
 };
 
+struct vm_operations_struct   drm_vm_shm_lock_ops = {
+	nopage:	 drm_vm_shm_nopage_lock,
+	open:	 drm_vm_open,
+	close:	 drm_vm_close,
+};
+
 struct vm_operations_struct   drm_vm_dma_ops = {
 	nopage:	 drm_vm_dma_nopage,
@@ -78,4 +84,38 @@ struct page *drm_vm_shm_nopage(struct vm
 #endif
 {
+#if LINUX_VERSION_CODE >= 0x020300
+	drm_map_t	 *map	 = (drm_map_t *)vma->vm_private_data;
+#else
+	drm_map_t	 *map	 = (drm_map_t *)vma->vm_pte;
+#endif
+	unsigned long	 physical;
+	unsigned long	 offset;
+
+	if (address > vma->vm_end) return NOPAGE_SIGBUS; /* Disallow mremap */
+	if (!map)    		   return NOPAGE_OOM;  /* Nothing allocated */
+
+	offset	 = address - vma->vm_start;
+	physical = (unsigned long)map->handle + offset;
+	atomic_inc(&virt_to_page(physical)->count); /* Dec. by kernel */
+
+	DRM_DEBUG("0x%08lx => 0x%08lx\n", address, physical);
+#if LINUX_VERSION_CODE < 0x020317
+	return physical;
+#else
+	return virt_to_page(physical);
+#endif
+}
+
+#if LINUX_VERSION_CODE < 0x020317
+unsigned long drm_vm_shm_nopage_lock(struct vm_area_struct *vma,
+				     unsigned long address,
+				     int write_access)
+#else
+				/* Return type changed in 2.3.23 */
+struct page *drm_vm_shm_nopage_lock(struct vm_area_struct *vma,
+				    unsigned long address,
+				    int write_access)
+#endif
+{
 	drm_file_t	 *priv	 = vma->vm_file->private_data;
 	drm_device_t	 *dev	 = priv->dev;
@@ -90,5 +130,5 @@ struct page *drm_vm_shm_nopage(struct vm
 	page	 = offset >> PAGE_SHIFT;
 	physical = (unsigned long)dev->lock.hw_lock + offset;
-	atomic_inc(&mem_map[MAP_NR(physical)].count); /* Dec. by kernel */
+	atomic_inc(&virt_to_page(physical)->count); /* Dec. by kernel */
 
 	DRM_DEBUG("0x%08lx (page %lu) => 0x%08lx\n", address, page, physical);
@@ -96,5 +136,5 @@ struct page *drm_vm_shm_nopage(struct vm
 	return physical;
 #else
-	return mem_map + MAP_NR(physical);
+	return virt_to_page(physical);
 #endif
 }
@@ -125,5 +165,5 @@ struct page *drm_vm_dma_nopage(struct vm
 	page	 = offset >> PAGE_SHIFT;
 	physical = dma->pagelist[page] + (offset & (~PAGE_MASK));
-	atomic_inc(&mem_map[MAP_NR(physical)].count); /* Dec. by kernel */
+	atomic_inc(&virt_to_page(physical)->count); /* Dec. by kernel */
 
 	DRM_DEBUG("0x%08lx (page %lu) => 0x%08lx\n", address, page, physical);
@@ -131,5 +171,5 @@ struct page *drm_vm_dma_nopage(struct vm
 	return physical;
 #else
-	return mem_map + MAP_NR(physical);
+	return virt_to_page(physical);
 #endif
 }
@@ -211,5 +251,5 @@ int drm_mmap_dma(struct file *filp, stru
 
 				/* Length must match exact page count */
-	if ((length >> PAGE_SHIFT) != dma->page_count) {
+	if (!dma || (length >> PAGE_SHIFT) != dma->page_count) {
 		unlock_kernel();
 		return -EINVAL;
@@ -284,4 +324,7 @@ int drm_mmap(struct file *filp, struct v
 				pgprot_val(vma->vm_page_prot) &= ~_PAGE_PWT;
 			}
+#elif defined(__ia64__)
+			if (map->type != _DRM_AGP)
+				vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 #endif
 			vma->vm_flags |= VM_IO;	/* not in core dump */
@@ -299,5 +342,15 @@ int drm_mmap(struct file *filp, struct v
 		break;
 	case _DRM_SHM:
-		vma->vm_ops = &drm_vm_shm_ops;
+		if (map->flags & _DRM_CONTAINS_LOCK)
+			vma->vm_ops = &drm_vm_shm_lock_ops;
+		else {
+			vma->vm_ops = &drm_vm_shm_ops;
+#if LINUX_VERSION_CODE >= 0x020300
+			vma->vm_private_data = (void *)map;
+#else
+			vma->vm_pte = (unsigned long)map;
+#endif
+		}
+
 				/* Don't let this area swap.  Change when
 				   DRM_KERNEL advisory is supported. */

-- 
Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
   "Give me immortality, or give me death!"  // Firesign Theatre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
