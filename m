Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbTARTW6>; Sat, 18 Jan 2003 14:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbTARTW6>; Sat, 18 Jan 2003 14:22:58 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13799 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264969AbTARTWU>; Sat, 18 Jan 2003 14:22:20 -0500
Date: Sat, 18 Jan 2003 20:31:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] small cleanup for drivers/scsi/*53c8xx*
Message-ID: <20030118193113.GK10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups in drivers/scsi/*53c8xx*:
- remove #if'd code foer kernels < 2.4.4
- remove MIN/MAX

diffstat output:
 ncr53c8xx.c      |   89 ++-------------
 ncr53c8xx.h      |   19 ---
 sym53c8xx.c      |  319 +++++--------------------------------------------------
 sym53c8xx_comm.h |  234 +---------------------------------------
 sym53c8xx_defs.h |   18 ---
 5 files changed, 56 insertions(+), 623 deletions(-)

cu
Adrian


--- linux-2.5.59-full/drivers/scsi/sym53c8xx_comm.h.old	2003-01-18 19:48:28.000000000 +0100
+++ linux-2.5.59-full/drivers/scsi/sym53c8xx_comm.h	2003-01-18 20:07:36.000000000 +0100
@@ -62,21 +62,7 @@
 **	driver includes	this file.
 */
 
-#define MIN(a,b)        (((a) < (b)) ? (a) : (b))
-#define MAX(a,b)        (((a) > (b)) ? (a) : (b))
-
-/*==========================================================
-**
-**	Hmmm... What complex some PCI-HOST bridges actually 
-**	are, despite the fact that the PCI specifications 
-**	are looking so smart and simple! ;-)
-**
-**==========================================================
-*/
-
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,47)
 #define SCSI_NCR_DYNAMIC_DMA_MAPPING
-#endif
 
 /*==========================================================
 **
@@ -262,8 +248,6 @@
 **==========================================================
 */
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,2,0)
-
 typedef struct pci_dev *pcidev_t;
 typedef struct device *device_t;
 #define PCIDEV_NULL		(0)
@@ -278,15 +262,7 @@
 {
 	u_long base;
 
-#if LINUX_VERSION_CODE > LinuxVersionCode(2,3,12)
 	base = pdev->resource[index].start;
-#else
-	base = pdev->base_address[index];
-#if BITS_PER_LONG > 32
-	if ((base & 0x7) == 0x4)
-		*base |= (((u_long)pdev->base_address[++index]) << 32);
-#endif
-#endif
 	return (base & ~0x7ul);
 }
 
@@ -310,104 +286,6 @@
 #undef PCI_BAR_OFFSET
 }
 
-#else	/* Incomplete emulation of current PCI code for pre-2.2 kernels */
-
-typedef unsigned int pcidev_t;
-typedef unsinged int device_t;
-#define PCIDEV_NULL		(~0u)
-#define PciBusNumber(d)		((d)>>8)
-#define PciDeviceFn(d)		((d)&0xff)
-#define __PciDev(busn, devfn)	(((busn)<<8)+(devfn))
-
-#define pci_present pcibios_present
-
-#define pci_read_config_byte(d, w, v) \
-	pcibios_read_config_byte(PciBusNumber(d), PciDeviceFn(d), w, v)
-#define pci_read_config_word(d, w, v) \
-	pcibios_read_config_word(PciBusNumber(d), PciDeviceFn(d), w, v)
-#define pci_read_config_dword(d, w, v) \
-	pcibios_read_config_dword(PciBusNumber(d), PciDeviceFn(d), w, v)
-
-#define pci_write_config_byte(d, w, v) \
-	pcibios_write_config_byte(PciBusNumber(d), PciDeviceFn(d), w, v)
-#define pci_write_config_word(d, w, v) \
-	pcibios_write_config_word(PciBusNumber(d), PciDeviceFn(d), w, v)
-#define pci_write_config_dword(d, w, v) \
-	pcibios_write_config_dword(PciBusNumber(d), PciDeviceFn(d), w, v)
-
-static pcidev_t __init
-pci_find_device(unsigned int vendor, unsigned int device, pcidev_t prev)
-{
-	static unsigned short pci_index;
-	int retv;
-	unsigned char bus_number, device_fn;
-
-	if (prev == PCIDEV_NULL)
-		pci_index = 0;
-	else
-		++pci_index;
-	retv = pcibios_find_device (vendor, device, pci_index,
-				    &bus_number, &device_fn);
-	return retv ? PCIDEV_NULL : __PciDev(bus_number, device_fn);
-}
-
-static u_short __init PciVendorId(pcidev_t dev)
-{
-	u_short vendor_id;
-	pci_read_config_word(dev, PCI_VENDOR_ID, &vendor_id);
-	return vendor_id;
-}
-
-static u_short __init PciDeviceId(pcidev_t dev)
-{
-	u_short device_id;
-	pci_read_config_word(dev, PCI_DEVICE_ID, &device_id);
-	return device_id;
-}
-
-static u_int __init PciIrqLine(pcidev_t dev)
-{
-	u_char irq;
-	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-	return irq;
-}
-
-static int __init 
-pci_get_base_address(pcidev_t dev, int offset, u_long *base)
-{
-	u_int32 tmp;
-	
-	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + offset, &tmp);
-	*base = tmp;
-	offset += sizeof(u_int32);
-	if ((tmp & 0x7) == 0x4) {
-#if BITS_PER_LONG > 32
-		pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + offset, &tmp);
-		*base |= (((u_long)tmp) << 32);
-#endif
-		offset += sizeof(u_int32);
-	}
-	return offset;
-}
-static u_long __init
-pci_get_base_cookie(struct pci_dev *pdev, int offset)
-{
-	u_long base;
-
-	(void) pci_get_base_address(dev, offset, &base);
-
-	return base;
-}
-
-#endif	/* LINUX_VERSION_CODE >= LinuxVersionCode(2,2,0) */
-
-/* Does not make sense in earlier kernels */
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,4,0)
-#define pci_enable_device(pdev)		(0)
-#endif
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,4,4)
-#define	scsi_set_pci_device(inst, pdev)	(0)
-#endif
 
 /*==========================================================
 **
@@ -430,7 +308,6 @@
 **==========================================================
 */
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
 spinlock_t DRIVER_SMP_LOCK = SPIN_LOCK_UNLOCKED;
 #define	NCR_LOCK_DRIVER(flags)     spin_lock_irqsave(&DRIVER_SMP_LOCK, flags)
 #define	NCR_UNLOCK_DRIVER(flags)   \
@@ -445,49 +322,14 @@
 #define	NCR_UNLOCK_SCSI_DONE(host, flags) \
 		spin_unlock_irqrestore(((host)->host_lock), flags)
 
-#else
-
-#define	NCR_LOCK_DRIVER(flags)     do { save_flags(flags); cli(); } while (0)
-#define	NCR_UNLOCK_DRIVER(flags)   do { restore_flags(flags); } while (0)
-
-#define	NCR_INIT_LOCK_NCB(np)      do { } while (0)
-#define	NCR_LOCK_NCB(np, flags)    do { save_flags(flags); cli(); } while (0)
-#define	NCR_UNLOCK_NCB(np, flags)  do { restore_flags(flags); } while (0)
-
-#define	NCR_LOCK_SCSI_DONE(host, flags)    do {;} while (0)
-#define	NCR_UNLOCK_SCSI_DONE(host, flags)  do {;} while (0)
-
-#endif
-
-/*==========================================================
-**
-**	Memory mapped IO
-**
-**	Since linux-2.1, we must use ioremap() to map the io 
-**	memory space and iounmap() to unmap it. This allows 
-**	portability. Linux 1.3.X and 2.0.X allow to remap 
-**	physical pages addresses greater than the highest 
-**	physical memory address to kernel virtual pages with 
-**	vremap() / vfree(). That was not portable but worked 
-**	with i386 architecture.
-**
-**==========================================================
-*/
-
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,1,0)
-#define ioremap vremap
-#define iounmap vfree
-#endif
 
 #ifdef __sparc__
 #  include <asm/irq.h>
-#  define memcpy_to_pci(a, b, c)	memcpy_toio((a), (b), (c))
-#elif defined(__alpha__)
-#  define memcpy_to_pci(a, b, c)	memcpy_toio((a), (b), (c))
-#else	/* others */
-#  define memcpy_to_pci(a, b, c)	memcpy_toio((a), (b), (c))
 #endif
 
+#define memcpy_to_pci(a, b, c)	memcpy_toio((a), (b), (c))
+
+
 #ifndef SCSI_NCR_PCI_MEM_NOT_SUPPORTED
 static u_long __init remap_pci_mem(u_long base, u_long size)
 {
@@ -506,27 +348,6 @@
 
 #endif /* not def SCSI_NCR_PCI_MEM_NOT_SUPPORTED */
 
-/*==========================================================
-**
-**	Insert a delay in micro-seconds and milli-seconds.
-**
-**	Under Linux, udelay() is restricted to delay < 
-**	1 milli-second. In fact, it generally works for up 
-**	to 1 second delay. Since 2.1.105, the mdelay() function 
-**	is provided for delays in milli-seconds.
-**	Under 2.0 kernels, udelay() is an inline function 
-**	that is very inaccurate on Pentium processors.
-**
-**==========================================================
-*/
-
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,105)
-#define UDELAY udelay
-#define MDELAY mdelay
-#else
-static void UDELAY(long us) { udelay(us); }
-static void MDELAY(long ms) { while (ms--) UDELAY(1000); }
-#endif
 
 /*==========================================================
 **
@@ -546,12 +367,6 @@
 **==========================================================
 */
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,0)
-#define __GetFreePages(flags, order) __get_free_pages(flags, order)
-#else
-#define __GetFreePages(flags, order) __get_free_pages(flags, order, 0)
-#endif
-
 #define MEMO_SHIFT	4	/* 16 bytes minimum memory chunk */
 #if PAGE_SIZE >= 8192
 #define MEMO_PAGE_ORDER	0	/* 1 PAGE  maximum */
@@ -592,13 +407,13 @@
 	void (*freep)(struct m_pool *, m_addr_t);
 #define M_GETP()		mp->getp(mp)
 #define M_FREEP(p)		mp->freep(mp, p)
-#define GetPages()		__GetFreePages(MEMO_GFP_FLAGS, MEMO_PAGE_ORDER)
+#define GetPages()		__get_free_pages(MEMO_GFP_FLAGS, MEMO_PAGE_ORDER)
 #define FreePages(p)		free_pages(p, MEMO_PAGE_ORDER)
 	int nump;
 	m_vtob_s *(vtob[VTOB_HASH_SIZE]);
 	struct m_pool *next;
 #else
-#define M_GETP()		__GetFreePages(MEMO_GFP_FLAGS, MEMO_PAGE_ORDER)
+#define M_GETP()		__get_free_pages(MEMO_GFP_FLAGS, MEMO_PAGE_ORDER)
 #define M_FREEP(p)		free_pages(p, MEMO_PAGE_ORDER)
 #endif	/* SCSI_NCR_DYNAMIC_DMA_MAPPING */
 	struct m_link h[PAGE_SHIFT-MEMO_SHIFT+MEMO_PAGE_ORDER+1];
@@ -1191,7 +1006,7 @@
 static void __init
 S24C16_set_bit(ncr_slot *np, u_char write_bit, u_char *gpreg, int bit_mode)
 {
-	UDELAY (5);
+	udelay (5);
 	switch (bit_mode){
 	case SET_BIT:
 		*gpreg |= write_bit;
@@ -1208,7 +1023,7 @@
 
 	}
 	OUTB (nc_gpreg, *gpreg);
-	UDELAY (5);
+	udelay (5);
 }
 
 /*
@@ -1433,7 +1248,7 @@
 static void __init T93C46_Clk(ncr_slot *np, u_char *gpreg)
 {
 	OUTB (nc_gpreg, *gpreg | 0x04);
-	UDELAY (2);
+	udelay (2);
 	OUTB (nc_gpreg, *gpreg);
 }
 
@@ -1442,7 +1257,7 @@
  */
 static void __init T93C46_Read_Bit(ncr_slot *np, u_char *read_bit, u_char *gpreg)
 {
-	UDELAY (2);
+	udelay (2);
 	T93C46_Clk(np, gpreg);
 	*read_bit = INB (nc_gpreg);
 }
@@ -1460,7 +1275,7 @@
 	*gpreg |= 0x10;
 		
 	OUTB (nc_gpreg, *gpreg);
-	UDELAY (2);
+	udelay (2);
 
 	T93C46_Clk(np, gpreg);
 }
@@ -1472,7 +1287,7 @@
 {
 	*gpreg &= 0xef;
 	OUTB (nc_gpreg, *gpreg);
-	UDELAY (2);
+	udelay (2);
 
 	T93C46_Clk(np, gpreg);
 }
@@ -2316,38 +2131,11 @@
 		pci_write_config_word(pdev, PCI_COMMAND, command);
 	}
 
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,2,0)
-	if ( is_prep ) {
-		if (io_port >= 0x10000000) {
-			printk(NAME53C8XX ": reallocating io_port (Wacky IBM)");
-			io_port = (io_port & 0x00FFFFFF) | 0x01000000;
-			pci_write_config_dword(pdev,
-					       PCI_BASE_ADDRESS_0, io_port);
-		}
-		if (base >= 0x10000000) {
-			printk(NAME53C8XX ": reallocating base (Wacky IBM)");
-			base = (base & 0x00FFFFFF) | 0x01000000;
-			pci_write_config_dword(pdev,
-					       PCI_BASE_ADDRESS_1, base);
-		}
-		if (base_2 >= 0x10000000) {
-			printk(NAME53C8XX ": reallocating base2 (Wacky IBM)");
-			base_2 = (base_2 & 0x00FFFFFF) | 0x01000000;
-			pci_write_config_dword(pdev,
-					       PCI_BASE_ADDRESS_2, base_2);
-		}
-	}
-#endif
 #endif	/* __powerpc__ */
 
 #if defined(__i386__) && !defined(MODULE)
 	if (!cache_line_size) {
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,1,75)
-		extern char x86;
-		switch(x86) {
-#else
 		switch(boot_cpu_data.x86) {
-#endif
 		case 4:	suggested_cache_line_size = 4; break;
 		case 6:
 		case 5:	suggested_cache_line_size = 8; break;
--- linux-2.5.59-full/drivers/scsi/ncr53c8xx.h.old	2003-01-18 19:39:13.000000000 +0100
+++ linux-2.5.59-full/drivers/scsi/ncr53c8xx.h	2003-01-18 19:40:20.000000000 +0100
@@ -50,8 +50,6 @@
 **	Used by hosts.c and ncr53c8xx.c with module configuration.
 */
 
-#if (LINUX_VERSION_CODE >= 0x020400) || defined(HOSTS_C) || defined(MODULE)
-
 #include <scsi/scsicam.h>
 
 int ncr53c8xx_abort(Scsi_Cmnd *);
@@ -68,8 +66,6 @@
 #endif
 
 
-#if	LINUX_VERSION_CODE >= LinuxVersionCode(2,1,75)
-
 #define NCR53C8XX {     .name           = "",			\
 			.detect         = ncr53c8xx_detect,	\
 			.release        = ncr53c8xx_release,	\
@@ -84,19 +80,4 @@
 			.cmd_per_lun    = SCSI_NCR_CMD_PER_LUN,	\
 			.use_clustering = DISABLE_CLUSTERING} 
 
-#else
-
-#define NCR53C8XX {	NULL, NULL, NULL, NULL,				\
-			NULL,			ncr53c8xx_detect,	\
-			ncr53c8xx_release,	ncr53c8xx_info,	NULL,	\
-			ncr53c8xx_queue_command,ncr53c8xx_abort,	\
-			ncr53c8xx_reset, NULL,	scsicam_bios_param,	\
-			SCSI_NCR_CAN_QUEUE,	7,			\
-			SCSI_NCR_SG_TABLESIZE,	SCSI_NCR_CMD_PER_LUN,	\
-			0,	0,	DISABLE_CLUSTERING} 
- 
-#endif /* LINUX_VERSION_CODE */
-
-#endif /* defined(HOSTS_C) || defined(MODULE) */ 
-
 #endif /* NCR53C8XX_H */
--- linux-2.5.59-full/drivers/scsi/ncr53c8xx.c.old	2003-01-18 19:40:53.000000000 +0100
+++ linux-2.5.59-full/drivers/scsi/ncr53c8xx.c	2003-01-18 20:15:40.000000000 +0100
@@ -115,17 +115,11 @@
 **==========================================================
 */
 
-#define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
-
 #include <linux/module.h>
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,17)
 #include <linux/spinlock.h>
-#elif LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
-#include <asm/spinlock.h>
-#endif
 #include <linux/delay.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -142,21 +136,7 @@
 
 #include <linux/version.h>
 #include <linux/blk.h>
-
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,35)
 #include <linux/init.h>
-#endif
-
-#ifndef	__init
-#define	__init
-#endif
-#ifndef	__initdata
-#define	__initdata
-#endif
-
-#if LINUX_VERSION_CODE <= LinuxVersionCode(2,1,92)
-#include <linux/bios32.h>
-#endif
 
 #include "scsi.h"
 #include "hosts.h"
@@ -205,7 +185,7 @@
 **	Donnot compile integrity checking code for Linux-2.3.0 
 **	and above since SCSI data structures are not ready yet.
 */
-/* #if LINUX_VERSION_CODE < LinuxVersionCode(2,3,0) */
+/* #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) */
 #if 0
 #define	SCSI_NCR_INTEGRITY_CHECKING
 #endif
@@ -1049,9 +1029,7 @@
 					/*  when lcb is not allocated.	*/
 	Scsi_Cmnd	*done_list;	/* Commands waiting for done()  */
 					/* callback to be invoked.      */ 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
 	spinlock_t	smp_lock;	/* Lock for SMP threading       */
-#endif
 
 	/*----------------------------------------------------------------
 	**	Chip and controller indentification.
@@ -3038,7 +3016,7 @@
 		if (opcode == 0) {
 			printk (KERN_ERR "%s: ERROR0 IN SCRIPT at %d.\n",
 				ncr_name(np), (int) (src-start-1));
-			MDELAY (1000);
+			mdelay (1000);
 		};
 
 		if (DEBUG_FLAGS & DEBUG_SCRIPT)
@@ -3068,7 +3046,7 @@
 			if ((tmp1 ^ tmp2) & 3) {
 				printk (KERN_ERR"%s: ERROR1 IN SCRIPT at %d.\n",
 					ncr_name(np), (int) (src-start-1));
-				MDELAY (1000);
+				mdelay (1000);
 			}
 			/*
 			**	If PREFETCH feature not enabled, remove 
@@ -3816,11 +3794,7 @@
 	instance->max_id	= np->maxwide ? 16 : 8;
 	instance->max_lun	= SCSI_NCR_MAX_LUN;
 #ifndef SCSI_NCR_IOMAPPED
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,29)
 	instance->base		= (unsigned long) np->reg;
-#else
-	instance->base		= (char *) np->reg;
-#endif
 #endif
 	instance->irq		= device->slot.irq;
 	instance->unique_id	= device->slot.io_port;
@@ -3900,12 +3874,7 @@
 	*/
 
 	if (request_irq(device->slot.irq, ncr53c8xx_intr,
-			((driver_setup.irqm & 0x10) ? 0 : SA_SHIRQ) |
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,2,0)
-			((driver_setup.irqm & 0x20) ? 0 : SA_INTERRUPT),
-#else
-			0,
-#endif
+			((driver_setup.irqm & 0x10) ? 0 : SA_SHIRQ),
 			"ncr53c8xx", np)) {
 #ifdef __sparc__
 		printk(KERN_ERR "%s: request irq %s failure\n",
@@ -3951,7 +3920,7 @@
 	if (driver_setup.settle_delay > 2) {
 		printk(KERN_INFO "%s: waiting %d seconds for scsi devices to settle...\n",
 			ncr_name(np), driver_setup.settle_delay);
-		MDELAY (1000 * driver_setup.settle_delay);
+		mdelay (1000 * driver_setup.settle_delay);
 	}
 
 	/*
@@ -4674,7 +4643,7 @@
 	/*
 	**	command
 	*/
-	memcpy(cp->cdb_buf, cmd->cmnd, MIN(cmd->cmd_len, sizeof(cp->cdb_buf)));
+	memcpy(cp->cdb_buf, cmd->cmnd, min(cmd->cmd_len, sizeof(cp->cdb_buf)));
 	cp->phys.cmd.addr		= cpu_to_scr(CCB_PHYS (cp, cdb_buf[0]));
 	cp->phys.cmd.size		= cpu_to_scr(cmd->cmd_len);
 
@@ -4816,7 +4785,7 @@
 			ncr_name(np), settle_delay);
 
 	ncr_chip_reset(np, 100);
-	UDELAY (2000);	/* The 895 needs time for the bus mode to settle */
+	udelay (2000);	/* The 895 needs time for the bus mode to settle */
 	if (enab_int)
 		OUTW (nc_sien, RST);
 	/*
@@ -4827,7 +4796,7 @@
 	if (np->device_id != PSEUDO_ZALON_720_ID)
 		OUTB (nc_dcntl, (np->rv_dcntl & IRQM));
 	OUTB (nc_scntl1, CRST);
-	UDELAY (200);
+	udelay (200);
 
 	if (!driver_setup.bus_check)
 		goto out;
@@ -5048,7 +5017,7 @@
 	printk("%s: stopping the timer\n", ncr_name(np));
 #endif
 	np->release_stage = 1;
-	for (i = 50 ; i && np->release_stage != 2 ; i--) MDELAY (100);
+	for (i = 50 ; i && np->release_stage != 2 ; i--) mdelay (100);
 	if (np->release_stage != 2)
 		printk("%s: the timer seems to be already stopped\n", ncr_name(np));
 	else np->release_stage = 2;
@@ -5559,7 +5528,7 @@
 static void ncr_chip_reset(ncb_p np, int delay)
 {
 	OUTB (nc_istat,  SRST);
-	UDELAY (delay);
+	udelay (delay);
 	OUTB (nc_istat,  0   );
 
 	if (np->features & FE_EHP)
@@ -5588,7 +5557,7 @@
 
 	if (reset) {
 		OUTB (nc_istat,  SRST);
-		UDELAY (100);
+		udelay (100);
 	}
 	else {
 		OUTB (nc_stest3, TE|CSF);
@@ -8539,11 +8508,11 @@
 	if (np->multiplier > 2) {  /* Poll bit 5 of stest4 for quadrupler */
 		int i = 20;
 		while (!(INB(nc_stest4) & LCKFRQ) && --i > 0)
-			UDELAY (20);
+			udelay (20);
 		if (!i)
 			printk("%s: the chip cannot lock the frequency\n", ncr_name(np));
 	} else			/* Wait 20 micro-seconds for doubler	*/
-		UDELAY (20);
+		udelay (20);
 	OUTB(nc_stest3, HSC);		/* Halt the scsi clock		*/
 	OUTB(nc_scntl3,	scntl3);
 	OUTB(nc_stest1, (DBLEN|DBLSEL));/* Select clock multiplier	*/
@@ -8584,7 +8553,7 @@
 	OUTB (nc_stime1, gen);	/* set to nominal delay of 1<<gen * 125us */
 	while (!(INW(nc_sist) & GEN) && ms++ < 100000) {
 		for (count = 0; count < 10; count ++)
-			UDELAY (100);	/* count ms */
+			udelay (100);	/* count ms */
 	}
 	OUTB (nc_stime1, 0);	/* disable general purpose timer */
  	/*
@@ -9335,28 +9304,13 @@
 
 /*==========================================================
 **
-**	/proc directory entry.
-**
-**==========================================================
-*/
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
-static struct proc_dir_entry proc_scsi_ncr53c8xx = {
-    PROC_SCSI_NCR53C8XX, 9, NAME53C8XX,
-    S_IFDIR | S_IRUGO | S_IXUGO, 2
-};
-#endif
-
-/*==========================================================
-**
 **	Boot command line.
 **
 **==========================================================
 */
 #ifdef	MODULE
 char *ncr53c8xx = 0;	/* command line passed by insmod */
-# if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,30)
 MODULE_PARM(ncr53c8xx, "s");
-# endif
 #endif
 
 int __init ncr53c8xx_setup(char *str)
@@ -9364,11 +9318,9 @@
 	return sym53c8xx__setup(str);
 }
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,13)
 #ifndef MODULE
 __setup("ncr53c8xx=", ncr53c8xx_setup);
 #endif
-#endif
 
 /*===================================================================
 **
@@ -9473,11 +9425,7 @@
 	**    Initialize driver general stuff.
 	*/
 #ifdef SCSI_NCR_PROC_INFO_SUPPORT
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
-     tpnt->proc_dir  = &proc_scsi_ncr53c8xx;
-#else
      tpnt->proc_name = NAME53C8XX;
-#endif
      tpnt->proc_info = ncr53c8xx_proc_info;
 #endif
 
@@ -9506,12 +9454,8 @@
 */
 MODULE_LICENSE("GPL");
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
-static
-#endif
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0) || defined(MODULE)
 #ifdef ENABLE_SCSI_ZALON
-Scsi_Host_Template driver_template =  {
+static Scsi_Host_Template driver_template =  {
 	.proc_name =		"zalon720",
 	.detect =		zalon7xx_detect,
 	.release =		zalon7xx_release,
@@ -9526,7 +9470,6 @@
 
 
 #else
-Scsi_Host_Template driver_template = NCR53C8XX;
+static Scsi_Host_Template driver_template = NCR53C8XX;
 #endif
 #include "scsi_module.c"
-#endif
--- linux-2.5.59-full/drivers/scsi/sym53c8xx_defs.h.old	2003-01-18 20:12:35.000000000 +0100
+++ linux-2.5.59-full/drivers/scsi/sym53c8xx_defs.h	2003-01-18 20:14:00.000000000 +0100
@@ -64,17 +64,8 @@
 #ifndef SYM53C8XX_DEFS_H
 #define SYM53C8XX_DEFS_H
 
-/*
-**	Check supported Linux versions
-*/
-
-#if !defined(LINUX_VERSION_CODE)
-#include <linux/version.h>
-#endif
 #include <linux/config.h>
 
-#define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
-
 /*
  * NCR PQS/PDS special device support.
  */
@@ -183,11 +174,6 @@
 #define	SCSI_NCR_IOMAPPED
 #elif defined(__alpha__)
 #define	SCSI_NCR_IOMAPPED
-#elif defined(__powerpc__)
-#if LINUX_VERSION_CODE <= LinuxVersionCode(2,4,3)
-#define	SCSI_NCR_IOMAPPED
-#define SCSI_NCR_PCI_MEM_NOT_SUPPORTED
-#endif
 #elif defined(__sparc__)
 #undef SCSI_NCR_IOMAPPED
 #elif defined(__hppa__) && defined(ENABLE_SCSI_ZALON)
@@ -378,10 +364,6 @@
 
 #ifdef	__BIG_ENDIAN
 
-#if	LINUX_VERSION_CODE < LinuxVersionCode(2,1,0)
-#error	"BIG ENDIAN byte ordering needs kernel version >= 2.1.0"
-#endif
-
 #define	inw_l2b		inw
 #define	inl_l2b		inl
 #define	outw_b2l	outw
--- linux-2.5.59-full/drivers/scsi/sym53c8xx.c.old	2003-01-18 19:47:16.000000000 +0100
+++ linux-2.5.59-full/drivers/scsi/sym53c8xx.c	2003-01-18 20:27:23.000000000 +0100
@@ -99,18 +99,12 @@
 **==========================================================
 */
 
-#define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
-
 #include <linux/module.h>
 
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,17)
 #include <linux/spinlock.h>
-#elif LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
-#include <asm/spinlock.h>
-#endif
 #include <linux/delay.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -125,21 +119,7 @@
 
 #include <linux/version.h>
 #include <linux/blk.h>
-
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,35)
 #include <linux/init.h>
-#endif
-
-#ifndef	__init
-#define	__init
-#endif
-#ifndef	__initdata
-#define	__initdata
-#endif
-
-#if LINUX_VERSION_CODE <= LinuxVersionCode(2,1,92)
-#include <linux/bios32.h>
-#endif
 
 #include "scsi.h"
 #include "hosts.h"
@@ -147,17 +127,6 @@
 #include <linux/types.h>
 
 /*
-**	Define BITS_PER_LONG for earlier linux versions.
-*/
-#ifndef	BITS_PER_LONG
-#if (~0UL) == 0xffffffffUL
-#define	BITS_PER_LONG	32
-#else
-#define	BITS_PER_LONG	64
-#endif
-#endif
-
-/*
 **	Define the BSD style u_int32 and u_int64 type.
 **	Are in fact u_int32_t and u_int64_t :-)
 */
@@ -170,22 +139,13 @@
 **	Donnot compile integrity checking code for Linux-2.3.0 
 **	and above since SCSI data structures are not ready yet.
 */
-/* #if LINUX_VERSION_CODE < LinuxVersionCode(2,3,0) */
+/* #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) */
 #if 0
 #define	SCSI_NCR_INTEGRITY_CHECKING
 #endif
 
-#define MIN(a,b)        (((a) < (b)) ? (a) : (b))
-#define MAX(a,b)        (((a) > (b)) ? (a) : (b))
 
-/*
-**	Hmmm... What complex some PCI-HOST bridges actually are, 
-**	despite the fact that the PCI specifications are looking 
-**	so smart and simple! ;-)
-*/
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,47)
 #define SCSI_NCR_DYNAMIC_DMA_MAPPING
-#endif
 
 /*==========================================================
 **
@@ -439,8 +399,6 @@
 **	code.
 */
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,2,0)
-
 typedef struct pci_dev *pcidev_t;
 #define PCIDEV_NULL		(0)
 #define PciBusNumber(d)		(d)->bus->number
@@ -454,15 +412,7 @@
 {
 	u_long base;
 
-#if LINUX_VERSION_CODE > LinuxVersionCode(2,3,12)
 	base = pdev->resource[index].start;
-#else
-	base = pdev->base_address[index];
-#if BITS_PER_LONG > 32
-	if ((base & 0x7) == 0x4)
-		*base |= (((u_long)pdev->base_address[++index]) << 32);
-#endif
-#endif
 	return (base & ~0x7ul);
 }
 
@@ -486,103 +436,6 @@
 #undef PCI_BAR_OFFSET
 }
 
-#else	/* Incomplete emulation of current PCI code for pre-2.2 kernels */
-
-typedef unsigned int pcidev_t;
-#define PCIDEV_NULL		(~0u)
-#define PciBusNumber(d)		((d)>>8)
-#define PciDeviceFn(d)		((d)&0xff)
-#define __PciDev(busn, devfn)	(((busn)<<8)+(devfn))
-
-#define pci_present pcibios_present
-
-#define pci_read_config_byte(d, w, v) \
-	pcibios_read_config_byte(PciBusNumber(d), PciDeviceFn(d), w, v)
-#define pci_read_config_word(d, w, v) \
-	pcibios_read_config_word(PciBusNumber(d), PciDeviceFn(d), w, v)
-#define pci_read_config_dword(d, w, v) \
-	pcibios_read_config_dword(PciBusNumber(d), PciDeviceFn(d), w, v)
-
-#define pci_write_config_byte(d, w, v) \
-	pcibios_write_config_byte(PciBusNumber(d), PciDeviceFn(d), w, v)
-#define pci_write_config_word(d, w, v) \
-	pcibios_write_config_word(PciBusNumber(d), PciDeviceFn(d), w, v)
-#define pci_write_config_dword(d, w, v) \
-	pcibios_write_config_dword(PciBusNumber(d), PciDeviceFn(d), w, v)
-
-static pcidev_t __init
-pci_find_device(unsigned int vendor, unsigned int device, pcidev_t prev)
-{
-	static unsigned short pci_index;
-	int retv;
-	unsigned char bus_number, device_fn;
-
-	if (prev == PCIDEV_NULL)
-		pci_index = 0;
-	else
-		++pci_index;
-	retv = pcibios_find_device (vendor, device, pci_index,
-				    &bus_number, &device_fn);
-	return retv ? PCIDEV_NULL : __PciDev(bus_number, device_fn);
-}
-
-static u_short __init PciVendorId(pcidev_t dev)
-{
-	u_short vendor_id;
-	pci_read_config_word(dev, PCI_VENDOR_ID, &vendor_id);
-	return vendor_id;
-}
-
-static u_short __init PciDeviceId(pcidev_t dev)
-{
-	u_short device_id;
-	pci_read_config_word(dev, PCI_DEVICE_ID, &device_id);
-	return device_id;
-}
-
-static u_int __init PciIrqLine(pcidev_t dev)
-{
-	u_char irq;
-	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-	return irq;
-}
-
-static int __init 
-pci_get_base_address(pcidev_t dev, int offset, u_long *base)
-{
-	u_int32 tmp;
-	
-	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + offset, &tmp);
-	*base = tmp;
-	offset += sizeof(u_int32);
-	if ((tmp & 0x7) == 0x4) {
-#if BITS_PER_LONG > 32
-		pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + offset, &tmp);
-		*base |= (((u_long)tmp) << 32);
-#endif
-		offset += sizeof(u_int32);
-	}
-	return offset;
-}
-static u_long __init
-pci_get_base_cookie(struct pci_dev *pdev, int offset)
-{
-	u_long base;
-
-	(void) pci_get_base_address(dev, offset, &base);
-
-	return base;
-}
-
-#endif	/* LINUX_VERSION_CODE >= LinuxVersionCode(2,2,0) */
-
-/* Does not make sense in earlier kernels */
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,4,0)
-#define pci_enable_device(pdev)		(0)
-#endif
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,4,4)
-#define	scsi_set_pci_device(inst, pdev)	(0)
-#endif
 
 /*==========================================================
 **
@@ -630,8 +483,6 @@
 **	  wished (e.g.: threaded by controller).
 */
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
-
 spinlock_t sym53c8xx_lock = SPIN_LOCK_UNLOCKED;
 #define	NCR_LOCK_DRIVER(flags)     spin_lock_irqsave(&sym53c8xx_lock, flags)
 #define	NCR_UNLOCK_DRIVER(flags)   spin_unlock_irqrestore(&sym53c8xx_lock,flags)
@@ -645,45 +496,14 @@
 #define	NCR_UNLOCK_SCSI_DONE(host, flags) \
 		spin_unlock_irqrestore(((host)->host_lock), flags)
 
-#else
-
-#define	NCR_LOCK_DRIVER(flags)     do { save_flags(flags); cli(); } while (0)
-#define	NCR_UNLOCK_DRIVER(flags)   do { restore_flags(flags); } while (0)
-
-#define	NCR_INIT_LOCK_NCB(np)      do { } while (0)
-#define	NCR_LOCK_NCB(np, flags)    do { save_flags(flags); cli(); } while (0)
-#define	NCR_UNLOCK_NCB(np, flags)  do { restore_flags(flags); } while (0)
-
-#define	NCR_LOCK_SCSI_DONE(host, flags)    do {;} while (0)
-#define	NCR_UNLOCK_SCSI_DONE(host, flags)  do {;} while (0)
-
-#endif
-
-/*
-**	Memory mapped IO
-**
-**	Since linux-2.1, we must use ioremap() to map the io memory space.
-**	iounmap() to unmap it. That allows portability.
-**	Linux 1.3.X and 2.0.X allow to remap physical pages addresses greater 
-**	than the highest physical memory address to kernel virtual pages with 
-**	vremap() / vfree(). That was not portable but worked with i386 
-**	architecture.
-*/
-
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,1,0)
-#define ioremap vremap
-#define iounmap vfree
-#endif
 
 #ifdef __sparc__
 #  include <asm/irq.h>
-#  define memcpy_to_pci(a, b, c)	memcpy_toio((a), (b), (c))
-#elif defined(__alpha__)
-#  define memcpy_to_pci(a, b, c)	memcpy_toio((a), (b), (c))
-#else	/* others */
-#  define memcpy_to_pci(a, b, c)	memcpy_toio((a), (b), (c))
 #endif
 
+#define memcpy_to_pci(a, b, c)	memcpy_toio((a), (b), (c))
+
+
 #ifndef SCSI_NCR_PCI_MEM_NOT_SUPPORTED
 static u_long __init remap_pci_mem(u_long base, u_long size)
 {
@@ -703,25 +523,6 @@
 #endif /* not def SCSI_NCR_PCI_MEM_NOT_SUPPORTED */
 
 /*
-**	Insert a delay in micro-seconds and milli-seconds.
-**	-------------------------------------------------
-**	Under Linux, udelay() is restricted to delay < 1 milli-second.
-**	In fact, it generally works for up to 1 second delay.
-**	Since 2.1.105, the mdelay() function is provided for delays 
-**	in milli-seconds.
-**	Under 2.0 kernels, udelay() is an inline function that is very 
-**	inaccurate on Pentium processors.
-*/
-
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,105)
-#define UDELAY udelay
-#define MDELAY mdelay
-#else
-static void UDELAY(long us) { udelay(us); }
-static void MDELAY(long ms) { while (ms--) UDELAY(1000); }
-#endif
-
-/*
 **	Simple power of two buddy-like allocator
 **	----------------------------------------
 **	This simple code is not intended to be fast, but to provide 
@@ -735,12 +536,6 @@
 **	real bus astraction, btw).
 */
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,0)
-#define __GetFreePages(flags, order) __get_free_pages(flags, order)
-#else
-#define __GetFreePages(flags, order) __get_free_pages(flags, order, 0)
-#endif
-
 #define MEMO_SHIFT	4	/* 16 bytes minimum memory chunk */
 #if PAGE_SIZE >= 8192
 #define MEMO_PAGE_ORDER	0	/* 1 PAGE  maximum */
@@ -781,13 +576,13 @@
 	void (*freep)(struct m_pool *, m_addr_t);
 #define M_GETP()		mp->getp(mp)
 #define M_FREEP(p)		mp->freep(mp, p)
-#define GetPages()		__GetFreePages(MEMO_GFP_FLAGS, MEMO_PAGE_ORDER)
+#define GetPages()		__get_free_pages(MEMO_GFP_FLAGS, MEMO_PAGE_ORDER)
 #define FreePages(p)		free_pages(p, MEMO_PAGE_ORDER)
 	int nump;
 	m_vtob_s *(vtob[VTOB_HASH_SIZE]);
 	struct m_pool *next;
 #else
-#define M_GETP()		__GetFreePages(MEMO_GFP_FLAGS, MEMO_PAGE_ORDER)
+#define M_GETP()		__get_free_pages(MEMO_GFP_FLAGS, MEMO_PAGE_ORDER)
 #define M_FREEP(p)		free_pages(p, MEMO_PAGE_ORDER)
 #endif	/* SCSI_NCR_DYNAMIC_DMA_MAPPING */
 	struct m_link h[PAGE_SHIFT-MEMO_SHIFT+MEMO_PAGE_ORDER+1];
@@ -1278,21 +1073,15 @@
 
 #endif	/* SCSI_DATA_UNKNOWN */
 
-
 /*
-**	/proc directory entry and proc_info function
+**      /proc directory entry and proc_info function
 */
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
-static struct proc_dir_entry proc_scsi_sym53c8xx = {
-    PROC_SCSI_SYM53C8XX, 9, NAME53C8XX,
-    S_IFDIR | S_IRUGO | S_IXUGO, 2
-};
-#endif
 #ifdef SCSI_NCR_PROC_INFO_SUPPORT
 static int sym53c8xx_proc_info(char *buffer, char **start, off_t offset,
 			int length, int hostno, int func);
 #endif
 
+
 /*
 **	Driver setup.
 **
@@ -1307,9 +1096,7 @@
 	driver_safe_setup __initdata	= SCSI_NCR_DRIVER_SAFE_SETUP;
 # ifdef	MODULE
 char *sym53c8xx = 0;	/* command line passed by insmod */
-#  if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,30)
 MODULE_PARM(sym53c8xx, "s");
-#  endif
 # endif
 #endif
 
@@ -2026,9 +1813,7 @@
 					/*  when lcb is not allocated.	*/
 	Scsi_Cmnd	*done_list;	/* Commands waiting for done()  */
 					/* callback to be invoked.      */ 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
 	spinlock_t	smp_lock;	/* Lock for SMP threading       */
-#endif
 
 	/*----------------------------------------------------------------
 	**	Chip and controller indentification.
@@ -4547,7 +4332,7 @@
 		if (opcode == 0) {
 			printk (KERN_INFO "%s: ERROR0 IN SCRIPT at %d.\n",
 				ncr_name(np), (int) (src-start-1));
-			MDELAY (10000);
+			mdelay (10000);
 			continue;
 		};
 
@@ -4597,7 +4382,7 @@
 			if ((tmp1 ^ tmp2) & 3) {
 				printk (KERN_ERR"%s: ERROR1 IN SCRIPT at %d.\n",
 					ncr_name(np), (int) (src-start-1));
-				MDELAY (1000);
+				mdelay (1000);
 			}
 			/*
 			**	If PREFETCH feature not enabled, remove 
@@ -5813,9 +5598,6 @@
 			((driver_setup.irqm & 0x20) ? 0 : SA_INTERRUPT),
 #else
 			((driver_setup.irqm & 0x10) ? 0 : SA_SHIRQ) |
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,2,0)
-			((driver_setup.irqm & 0x20) ? 0 : SA_INTERRUPT),
-#else
 			0,
 #endif
 #endif
@@ -5851,7 +5633,7 @@
 	if (driver_setup.settle_delay > 2) {
 		printk(KERN_INFO "%s: waiting %d seconds for scsi devices to settle...\n",
 			ncr_name(np), driver_setup.settle_delay);
-		MDELAY (1000 * driver_setup.settle_delay);
+		mdelay (1000 * driver_setup.settle_delay);
 	}
 
 	/*
@@ -5877,11 +5659,7 @@
 	instance->max_id	= np->maxwide ? 16 : 8;
 	instance->max_lun	= MAX_LUN;
 #ifndef SCSI_NCR_IOMAPPED
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,29)
 	instance->base		= (unsigned long) np->reg;
-#else
-	instance->base		= (char *) np->reg;
-#endif
 #endif
 	instance->irq		= np->irq;
 	instance->unique_id	= np->base_io;
@@ -6826,7 +6604,7 @@
 	/*
 	**	command
 	*/
-	memcpy(cp->cdb_buf, cmd->cmnd, MIN(cmd->cmd_len, sizeof(cp->cdb_buf)));
+	memcpy(cp->cdb_buf, cmd->cmnd, min(cmd->cmd_len, sizeof(cp->cdb_buf)));
 	cp->phys.cmd.addr	= cpu_to_scr(CCB_PHYS (cp, cdb_buf[0]));
 	cp->phys.cmd.size	= cpu_to_scr(cmd->cmd_len);
 
@@ -6965,7 +6743,7 @@
 static void ncr_chip_reset (ncb_p np)
 {
 	OUTB (nc_istat, SRST);
-	UDELAY (10);
+	udelay (10);
 	OUTB (nc_istat, 0);
 }
 
@@ -6987,7 +6765,7 @@
 			if (INB (nc_dstat) & ABRT);
 				break;
 		}
-		UDELAY(5);
+		udelay(5);
 	}
 	OUTB (nc_istat, 0);
 	if (!i)
@@ -7026,7 +6804,7 @@
 			ncr_name(np), settle_delay);
 
 	ncr_soft_reset(np);	/* Soft reset the chip */
-	UDELAY (2000);	/* The 895/6 need time for the bus mode to settle */
+	udelay (2000);	/* The 895/6 need time for the bus mode to settle */
 	if (enab_int)
 		OUTW (nc_sien, RST);
 	/*
@@ -7036,7 +6814,7 @@
 	OUTB (nc_stest3, TE);
 	OUTB (nc_dcntl, (np->rv_dcntl & IRQM));
 	OUTB (nc_scntl1, CRST);
-	UDELAY (200);
+	udelay (200);
 
 	if (!driver_setup.bus_check)
 		goto out;
@@ -7226,7 +7004,7 @@
 **	Set release_stage to 1 and wait that ncr_timeout() set it to 2.
 */
 	np->release_stage = 1;
-	for (i = 50 ; i && np->release_stage != 2 ; i--) MDELAY (100);
+	for (i = 50 ; i && np->release_stage != 2 ; i--) mdelay (100);
 	if (np->release_stage != 2)
 		printk("%s: the timer seems to be already stopped\n",
 			ncr_name(np));
@@ -7378,12 +7156,11 @@
 		}
 	}
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,99)
 	/*
 	**	Move residual byte count to user structure.
 	*/
 	cmd->resid = cp->resid;
-#endif
+
 	/*
 	**	Check the status.
 	*/
@@ -7682,7 +7459,7 @@
 	*/
 
 	OUTB (nc_istat,  0x00   );	/*  Remove Reset, abort */
-	UDELAY (2000);	/* The 895 needs time for the bus mode to settle */
+	udelay (2000);	/* The 895 needs time for the bus mode to settle */
 
 	OUTB (nc_scntl0, np->rv_scntl0 | 0xc0);
 					/*  full arb., ena parity, par->ATN  */
@@ -12353,13 +12130,13 @@
 						(np->multiplier > 2)) {  
 		int i = 20;	 /* Poll bit 5 of stest4 for quadrupler */
 		while (!(INB(nc_stest4) & LCKFRQ) && --i > 0)
-			UDELAY (20);
+			udelay (20);
 		if (!i)
 		    printk("%s: the chip cannot lock the frequency\n",
 						 ncr_name(np));
 
 	} else			/* Wait 120 micro-seconds for multiplier*/
-		UDELAY (120);
+		udelay (120);
 
 	OUTB(nc_stest3, HSC);		/* Halt the scsi clock		*/
 	OUTB(nc_scntl3,	scntl3);
@@ -12405,7 +12182,7 @@
 	while (!(INW(nc_sist) & GEN) && ms++ < 100000) {
 		/* count 1ms */
 		for (count = 0; count < 10; count++)
-			UDELAY (100);	
+			udelay (100);	
 	}
 	OUTB (nc_stime1, 0);	/* disable general purpose timer */
  	/*
@@ -12746,11 +12523,9 @@
 	return 1;
 }
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,13)
 #ifndef MODULE
 __setup("sym53c8xx=", sym53c8xx_setup);
 #endif
-#endif
 
 static int 
 sym53c8xx_pci_init(Scsi_Host_Template *tpnt, pcidev_t pdev, ncr_device *device);
@@ -12887,11 +12662,7 @@
 	**    Initialize driver general stuff.
 	*/
 #ifdef SCSI_NCR_PROC_INFO_SUPPORT
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
-     tpnt->proc_dir  = &proc_scsi_sym53c8xx;
-#else
      tpnt->proc_name = NAME53C8XX;
-#endif
      tpnt->proc_info = sym53c8xx_proc_info;
 #endif
 
@@ -13215,38 +12986,11 @@
 		pci_write_config_word(pdev, PCI_COMMAND, command);
 	}
 
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,2,0)
-	if ( is_prep ) {
-		if (io_port >= 0x10000000) {
-			printk(NAME53C8XX ": reallocating io_port (Wacky IBM)");
-			io_port = (io_port & 0x00FFFFFF) | 0x01000000;
-			pci_write_config_dword(pdev,
-					       PCI_BASE_ADDRESS_0, io_port);
-		}
-		if (base >= 0x10000000) {
-			printk(NAME53C8XX ": reallocating base (Wacky IBM)");
-			base = (base & 0x00FFFFFF) | 0x01000000;
-			pci_write_config_dword(pdev,
-					       PCI_BASE_ADDRESS_1, base);
-		}
-		if (base_2 >= 0x10000000) {
-			printk(NAME53C8XX ": reallocating base2 (Wacky IBM)");
-			base_2 = (base_2 & 0x00FFFFFF) | 0x01000000;
-			pci_write_config_dword(pdev,
-					       PCI_BASE_ADDRESS_2, base_2);
-		}
-	}
-#endif
 #endif	/* __powerpc__ */
 
 #if defined(__i386__) && !defined(MODULE)
 	if (!cache_line_size) {
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,1,75)
-		extern char x86;
-		switch(x86) {
-#else
 		switch(boot_cpu_data.x86) {
-#endif
 		case 4:	suggested_cache_line_size = 4; break;
 		case 6:
 		case 5:	suggested_cache_line_size = 8; break;
@@ -14268,7 +14012,7 @@
 static void __init
 S24C16_set_bit(ncr_slot *np, u_char write_bit, u_char *gpreg, int bit_mode)
 {
-	UDELAY (5);
+	udelay (5);
 	switch (bit_mode){
 	case SET_BIT:
 		*gpreg |= write_bit;
@@ -14285,7 +14029,7 @@
 
 	}
 	OUTB (nc_gpreg, *gpreg);
-	UDELAY (5);
+	udelay (5);
 }
 
 /*
@@ -14510,7 +14254,7 @@
 static void __init T93C46_Clk(ncr_slot *np, u_char *gpreg)
 {
 	OUTB (nc_gpreg, *gpreg | 0x04);
-	UDELAY (2);
+	udelay (2);
 	OUTB (nc_gpreg, *gpreg);
 }
 
@@ -14519,7 +14263,7 @@
  */
 static void __init T93C46_Read_Bit(ncr_slot *np, u_char *read_bit, u_char *gpreg)
 {
-	UDELAY (2);
+	udelay (2);
 	T93C46_Clk(np, gpreg);
 	*read_bit = INB (nc_gpreg);
 }
@@ -14537,7 +14281,7 @@
 	*gpreg |= 0x10;
 		
 	OUTB (nc_gpreg, *gpreg);
-	UDELAY (2);
+	udelay (2);
 
 	T93C46_Clk(np, gpreg);
 }
@@ -14549,7 +14293,7 @@
 {
 	*gpreg &= 0xef;
 	OUTB (nc_gpreg, *gpreg);
-	UDELAY (2);
+	udelay (2);
 
 	T93C46_Clk(np, gpreg);
 }
@@ -14692,10 +14436,5 @@
 
 MODULE_LICENSE("GPL");
 
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
-static
-#endif
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0) || defined(MODULE)
-Scsi_Host_Template driver_template = SYM53C8XX;
+static Scsi_Host_Template driver_template = SYM53C8XX;
 #include "scsi_module.c"
-#endif
