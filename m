Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTDXCy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbTDXCy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:54:26 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:50624 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263549AbTDXCx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:53:59 -0400
Date: Wed, 23 Apr 2003 23:01:57 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH][ANNOUNCE] Linux 2.5.68-ce3
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304232305_MC3-1-35C1-C1D0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Summary:
 	Fixes ethernet and hd detection order problems.
	Many other small bugfixes (aio, ppa, rpc, scheduler,
		ext3, vm, ide, memory leaks...)
	Performance enhancements (fat filesystem, scsi...) 
	
 New in 2.5.68-ce3:
=====================================================================
extraversion.3.patch					(me)
	- update version
oom_kill.1.patch					(wli)
	- prevent false out-of-memory kills
irq_align.3.patch					(me)
	- cache align start of x86 interrupt handler table
	- 8-byte align the handlers
	- move common_interrupt so it's after the
	  first 16 interrupts even when NR_IRQS = 224
tftp.1.patch						(Jeff Smith)
	- fix misspelling in Kconfig for TFTP conntrack
unusual.1.patch						(Hanno Boeck)
	- fixes for some unusual USB devices

Plus the following patches shamelessly stolen from 2.5.68-mm2:
	aio-retval-fix.patch			Async IO
	kobj_lock-fix.patch			Object locking
	ppa-null-pointer-fix.patch		Iomega Zip
	rpciod-atomic-allocations.patch		RPC
	sched_idle-typo-fix.patch		Scheduler
	sk-allocation.patch			Socket
	sym-do-160.patch			Make sym53c8xx do 160MB/s
================================================================================
 Older changelog entries removed -- see archives
================================================================================
 Makefile                            |    2 -
 arch/i386/kernel/entry.S            |   38 +++++++++++++++++++++++++++++-------
 arch/i386/kernel/io_apic.c          |    2 -
 drivers/char/keyboard.c             |    2 -
 drivers/ide/ide-probe.c             |    2 -
 drivers/isdn/tpam/tpam_queues.c     |    1 
 drivers/net/sis900.c                |    1 
 drivers/net/wan/sdla_ppp.c          |    3 --
 drivers/pci/bus.c                   |    9 +++++++-
 drivers/pci/probe.c                 |    2 -
 drivers/scsi/ppa.c                  |    6 +++--
 drivers/scsi/sym53c8xx_2/sym_hipd.c |    3 +-
 drivers/usb/storage/unusual_devs.h  |   25 +++++++++++++++++++++++
 fs/aio.c                            |    6 +++--
 fs/ext3/super.c                     |   12 +++++------
 fs/fat/inode.c                      |    1 
 fs/fat/misc.c                       |    1 
 include/linux/msdos_fs.h            |    3 --
 kernel/sched.c                      |    2 -
 lib/kobject.c                       |   19 ++++++++++++------
 mm/oom_kill.c                       |    7 +++++-
 mm/vmscan.c                         |   21 +++++++++++++++++--
 net/ax25/af_ax25.c                  |    2 +
 net/ipv4/netfilter/Kconfig          |    2 -
 net/ipv4/netfilter/ip_queue.c       |    8 +++++--
 net/ipv6/netfilter/ip6_queue.c      |    6 ++++-
 net/irda/irttp.c                    |    2 -
 net/sunrpc/clnt.c                   |    3 --
 net/sunrpc/sched.c                  |    2 -
 net/sunrpc/xprt.c                   |    1 
 30 files changed, 147 insertions(+), 47 deletions(-)
================================================================================
diff -u --exclude-from=/home/me/.exclude -r a/Makefile b/Makefile
--- a/Makefile	Sun Apr 20 06:26:50 2003
+++ b/Makefile	Wed Apr 23 13:45:47 2003
@ -1,7 +1,7 @
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 68
-EXTRAVERSION =
+EXTRAVERSION = -ce3
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
diff -u --exclude-from=/home/me/.exclude -r a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Sat Mar 29 09:16:32 2003
+++ b/arch/i386/kernel/entry.S	Wed Apr 23 11:47:23 2003
@ -42,6 +42,7 @
 
 #include <linux/config.h>
 #include <linux/linkage.h>
+#include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/errno.h>
 #include <asm/segment.h>
@ -49,6 +50,8 @
 #include <asm/page.h>
 #include "irq_vectors.h"
 
+#define L1ALIGN		.align L1_CACHE_BYTES,0x90
+
 EBX		= 0x00
 ECX		= 0x04
 EDX		= 0x08
@ -382,29 +385,50 @
 ENTRY(interrupt)
 .text
 
+	L1ALIGN				# first 16 entries fit in 128 bytes
 vector=0
-ENTRY(irq_entries_start)
-.rept NR_IRQS
-	ALIGN
-1:	pushl $vector-256
-	jmp common_interrupt
+ENTRY(low_irq_entries_start)
+.rept 16				# build just the first 16
+	.align 8,0x90
+1:	pushl $vector-256		# 5-byte instruction
+	jmp common_interrupt		# 2 bytes (always 8-bit offset here)
 .data
 	.long 1b
 .text
 vector=vector+1
 .endr
 
-	ALIGN
+	/* Placing common_interrupt here gives better packing
+	 * for interrupt handlers in io-apic mode.  Code in this
+	 * area does not place anything in .data, so this is safe
+	 * to do and will not corrupt the interrupt[] array.
+	 */
+	.align 8,0x90
 common_interrupt:
 	SAVE_ALL
 	call do_IRQ
 	jmp ret_from_intr
 
+.if NR_IRQS > 16
+	.align 8,0x90			# make ENTRY have exact address
+ENTRY(high_irq_entries_start)
+.rept NR_IRQS-16			# now the rest of the interrupt stubs
+	.align 8,0x90
+1:	pushl $vector-256		# 5-byte instruction
+	jmp common_interrupt		# 2 or 5 bytes (8 or 32-bit offset)
+.data
+	.long 1b
+.text
+vector=vector+1
+.endr
+.endif
+
 #define BUILD_INTERRUPT(name, nr)	\
+	.align 8,0x90;			\
 ENTRY(name)				\
 	pushl $nr-256;			\
 	SAVE_ALL			\
-	call smp_/**/name;	\
+	call smp_/**/name;		\
 	jmp ret_from_intr;
 
 /* The include is where all of the SMP etc. interrupts come from */
diff -u --exclude-from=/home/me/.exclude -r a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Sun Apr 20 06:26:50 2003
+++ b/arch/i386/kernel/io_apic.c	Sun Apr 20 17:41:22 2003
@ -1117,7 +1117,7 @
 	if (current_vector == SYSCALL_VECTOR)
 		goto next;
 
-	if (current_vector > FIRST_SYSTEM_VECTOR) {
+	if (current_vector >= FIRST_SYSTEM_VECTOR) {
 		offset = (offset + 1) & 7;
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
diff -u --exclude-from=/home/me/.exclude -r a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Tue Mar  4 22:29:17 2003
+++ b/drivers/char/keyboard.c	Sun Apr 20 14:46:11 2003
@ -601,7 +601,7 @
 		return;
 	if ((kbd->kbdmode == VC_RAW || 
 	     kbd->kbdmode == VC_MEDIUMRAW) && 
-	     value != K_SAK)
+	     value != KVAL(K_SAK))
 		return;		/* SAK is allowed even in raw mode */
 	fn_handler[value](vc, regs);
 }
diff -u --exclude-from=/home/me/.exclude -r a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Sun Apr 20 06:26:51 2003
+++ b/drivers/ide/ide-probe.c	Sun Apr 20 15:28:23 2003
@ -1214,7 +1214,7 @
 	spin_unlock_irq(&ide_lock);
 out_up:
 	up(&ide_cfg_sem);
-	return 0;
+	return 1;
 }
 
 static int ata_lock(dev_t dev, void *data)
diff -u --exclude-from=/home/me/.exclude -r a/drivers/isdn/tpam/tpam_queues.c b/drivers/isdn/tpam/tpam_queues.c
--- a/drivers/isdn/tpam/tpam_queues.c	Tue Mar  4 22:28:56 2003
+++ b/drivers/isdn/tpam/tpam_queues.c	Sun Apr 20 08:47:54 2003
@ -144,6 +144,7 @
 		do {
 			hpic = readl(card->bar0 + TPAM_HPIC_REGISTER);
 			if (waiting_too_long++ > 0xfffffff) {
+				kfree_skb(skb); 
 				spin_unlock(&card->lock);
 				printk(KERN_ERR "TurboPAM(tpam_irq): "
 						"waiting too long...\n");
diff -u --exclude-from=/home/me/.exclude -r a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	Sat Mar 29 09:16:22 2003
+++ b/drivers/net/sis900.c	Tue Apr 22 11:31:28 2003
@ -124,6 +124,7 @
 	{ "ICS LAN PHY",			0x0015, 0xF440, LAN },
 	{ "NS 83851 PHY",			0x2000, 0x5C20, MIX },
 	{ "Realtek RTL8201 PHY",		0x0000, 0x8200, LAN },
+	{ "VIA 6103 PHY",			0x0101, 0x8F20, LAN },
 	{0,},
 };
 
diff -u --exclude-from=/home/me/.exclude -r a/drivers/net/wan/sdla_ppp.c b/drivers/net/wan/sdla_ppp.c
--- a/drivers/net/wan/sdla_ppp.c	Sat Mar 29 09:16:22 2003
+++ b/drivers/net/wan/sdla_ppp.c	Sun Apr 20 08:47:54 2003
@ -1747,11 +1747,10 @
 					if (!test_bit(SEND_CRIT, &card->wandev.critical)){
 					 	ppp_send(card, skb->data, skb->len, htons(ETH_P_IPX));
 					}
-					dev_kfree_skb_any(skb);
-
 				} else {
 					++card->wandev.stats.rx_dropped;
 				}
+				dev_kfree_skb_any(skb);
 			} else {
 				/* Pass data up the protocol stack */
 	    			skb->dev = dev;
diff -u --exclude-from=/home/me/.exclude -r a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	Sat Mar 29 09:16:22 2003
+++ b/drivers/pci/bus.c	Sun Apr 20 11:55:24 2003
@ -75,7 +75,8 @
  * Add newly discovered PCI devices (which are on the bus->devices
  * list) to the global PCI device list, add the sysfs and procfs
  * entries.  Where a bridge is found, add the discovered bus to
- * the parents list of child buses, and recurse.
+ * the parents list of child buses, and recurse (breadth-first
+ * to be compatible with 2.4)
  *
  * Call hotplug for each new devices.
  */
@ -98,6 +99,12 @
 #endif
 		pci_create_sysfs_dev_files(dev);
 
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+
+		BUG_ON(list_empty(&dev->global_list));
+
 		/*
 		 * If there is an unattached subordinate bus, attach
 		 * it and then scan for unattached PCI devices.
diff -u --exclude-from=/home/me/.exclude -r a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Sat Mar 29 09:16:22 2003
+++ b/drivers/pci/probe.c	Sun Apr 20 11:55:33 2003
@ -173,7 +173,7 @
 		limit |= (io_limit_hi << 16);
 	}
 
-	if (base && base <= limit) {
+	if (base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
 		res->start = base;
 		res->end = limit + 0xfff;
diff -u --exclude-from=/home/me/.exclude -r a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
--- a/drivers/scsi/ppa.c	Tue Mar  4 22:29:23 2003
+++ b/drivers/scsi/ppa.c	Wed Apr 23 20:32:53 2003
@ -219,13 +219,15 @
 	    printk("  supported by the imm (ZIP Plus) driver. If the\n");
 	    printk("  cable is marked with \"AutoDetect\", this is what has\n");
 	    printk("  happened.\n");
-	    spin_lock_irq(hreg->host_lock);
+	    if (hreg)	/* This is silly */
+		spin_lock_irq(hreg->host_lock);
 	    return 0;
 	}
 	try_again = 1;
 	goto retry_entry;
     } else {
-	spin_lock_irq(hreg->host_lock);
+	if (hreg)	/* And this should be unnecessary */
+		spin_lock_irq(hreg->host_lock);
 	return 1;		/* return number of hosts detected */
     }
 }
diff -u --exclude-from=/home/me/.exclude -r a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c	Sat Mar 29 09:16:22 2003
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c	Wed Apr 23 20:35:57 2003
@ -800,7 +800,8 @
 	 * Btw, 'period' is in tenths of nanoseconds.
 	 */
 	period = (4 * div_10M[0] + np->clock_khz - 1) / np->clock_khz;
-	if	(period <= 250)		np->minsync = 10;
+	if	(period == 250)		np->minsync = 9;
+	else if	(period <= 250)		np->minsync = 10;
 	else if	(period <= 303)		np->minsync = 11;
 	else if	(period <= 500)		np->minsync = 12;
 	else				np->minsync = (period + 40 - 1) / 40;
diff -u --exclude-from=/home/me/.exclude -r a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h	Sun Apr 20 06:26:52 2003
+++ b/drivers/usb/storage/unusual_devs.h	Wed Apr 23 20:20:41 2003
@ -236,6 +236,13 @
 		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
 
+/* This entry is needed because the device reports Sub=ff */
+UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x0432, 
+		"Sony",
+		"DSC-F707/U10/U20", 
+		US_SC_SCSI, US_PR_CB, NULL,
+		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
+
 /* Reported by wimeeks.nl */
 UNUSUAL_DEV(  0x054c, 0x0025, 0x0100, 0x0100, 
 		"Sony",
@ -268,6 +275,12 @
 		"PEG Mass Storage",
 		US_SC_8070, US_PR_CBI, NULL,
 		US_FL_FIX_INQUIRY ),
+
+UNUSUAL_DEV(  0x054c, 0x0058, 0x0000, 0x9999,
+                "Sony",
+		"PEG-N760C Mass Storage",
+		US_SC_8070, US_PR_CBI, NULL,
+		US_FL_FIX_INQUIRY ),
 		
 UNUSUAL_DEV(  0x057b, 0x0000, 0x0000, 0x0299, 
 		"Y-E Data",
@ -375,6 +388,12 @
 		US_SC_SCSI, US_PR_BULK, NULL,
 		US_FL_FIX_INQUIRY | US_FL_MODE_XLATE),
 
+UNUSUAL_DEV(  0x0636, 0x0003, 0x0000, 0x9999,
+		"Vivitar",
+		"Vivicam 35Xx",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_START_STOP | US_FL_FIX_INQUIRY | US_FL_MODE_XLATE),
+
 UNUSUAL_DEV(  0x0644, 0x0000, 0x0100, 0x0100, 
 		"TEAC",
 		"Floppy Drive",
@ -440,6 +459,12 @
 		US_FL_SINGLE_LUN | US_FL_START_STOP ),
 #endif
 
+UNUSUAL_DEV(  0x0784, 0x1688, 0x0000, 0x9999,
+		"Vivitar",
+		"Vivicam 36xx",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_START_STOP | US_FL_FIX_INQUIRY | US_FL_MODE_XLATE),
+
 #ifdef CONFIG_USB_STORAGE_FREECOM
 UNUSUAL_DEV(  0x07ab, 0xfc01, 0x0000, 0x9999,
 		"Freecom",
diff -u --exclude-from=/home/me/.exclude -r a/fs/aio.c b/fs/aio.c
--- a/fs/aio.c	Sun Apr 20 06:26:23 2003
+++ b/fs/aio.c	Wed Apr 23 20:24:09 2003
@ -204,6 +204,7 @
 {
 	struct mm_struct *mm;
 	struct kioctx *ctx;
+	int ret = 0;
 
 	/* Prevent overflows */
 	if ((nr_events > (0x10000000U / sizeof(struct io_event))) ||
@ -233,7 +234,8 @
 	INIT_LIST_HEAD(&ctx->run_list);
 	INIT_WORK(&ctx->wq, aio_kick_handler, ctx);
 
-	if (aio_setup_ring(ctx) < 0)
+	ret = aio_setup_ring(ctx);
+	if (unlikely(ret < 0))
 		goto out_freectx;
 
 	/* limit the number of system wide aios */
@ -259,7 +261,7 @
 
 out_freectx:
 	kmem_cache_free(kioctx_cachep, ctx);
-	ctx = ERR_PTR(-ENOMEM);
+	ctx = ERR_PTR(ret);
 
 	dprintk("aio: error allocating ioctx %p\n", ctx);
 	return ctx;
diff -u --exclude-from=/home/me/.exclude -r a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Sun Apr 20 06:26:52 2003
+++ b/fs/ext3/super.c	Tue Apr 22 11:07:42 2003
@ -982,12 +982,6 @
 		return;
 	}
 
-	if (s_flags & MS_RDONLY) {
-		printk(KERN_INFO "EXT3-fs: %s: orphan cleanup on readonly fs\n",
-		       sb->s_id);
-		sb->s_flags &= ~MS_RDONLY;
-	}
-
 	if (EXT3_SB(sb)->s_mount_state & EXT3_ERROR_FS) {
 		if (es->s_last_orphan)
 			jbd_debug(1, "Errors on filesystem, "
@ -997,6 +991,12 @
 		return;
 	}
 
+	if (s_flags & MS_RDONLY) {
+		printk(KERN_INFO "EXT3-fs: %s: orphan cleanup on readonly fs\n",
+		       sb->s_id);
+		sb->s_flags &= ~MS_RDONLY;
+	}
+
 	while (es->s_last_orphan) {
 		struct inode *inode;
 
diff -u --exclude-from=/home/me/.exclude -r a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	Sun Apr 20 06:26:23 2003
+++ b/fs/fat/inode.c	Tue Apr 22 10:57:28 2003
@ -898,6 +898,7 @
 			       sbi->fsinfo_sector);
 		} else {
 			sbi->free_clusters = CF_LE_L(fsinfo->free_clusters);
+			sbi->prev_free = CF_LE_L(fsinfo->next_cluster);
 		}
 
 		brelse(fsinfo_bh);
diff -u --exclude-from=/home/me/.exclude -r a/fs/fat/misc.c b/fs/fat/misc.c
--- a/fs/fat/misc.c	Tue Mar  4 22:29:34 2003
+++ b/fs/fat/misc.c	Tue Apr 22 10:57:28 2003
@ -74,6 +74,7 @
 		       MSDOS_SB(sb)->fsinfo_sector);
 	} else {
 		fsinfo->free_clusters = CF_LE_L(MSDOS_SB(sb)->free_clusters);
+		fsinfo->next_cluster = CF_LE_L(MSDOS_SB(sb)->prev_free);
 		mark_buffer_dirty(bh);
 	}
 	brelse(bh);
diff -u --exclude-from=/home/me/.exclude -r a/include/linux/msdos_fs.h b/include/linux/msdos_fs.h
--- a/include/linux/msdos_fs.h	Tue Mar  4 22:29:33 2003
+++ b/include/linux/msdos_fs.h	Tue Apr 22 10:57:28 2003
@ -146,8 +146,7 @
 	__u32   reserved1[120];	/* Nothing as far as I can tell */
 	__u32   signature2;	/* 0x61417272L */
 	__u32   free_clusters;	/* Free cluster count.  -1 if unknown */
-	__u32   next_cluster;	/* Most recently allocated cluster.
-				 * Unused under Linux. */
+	__u32   next_cluster;	/* Most recently allocated cluster */
 	__u32   reserved2[4];
 };
 
diff -u --exclude-from=/home/me/.exclude -r a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Sun Apr 20 06:26:52 2003
+++ b/kernel/sched.c	Wed Apr 23 20:34:25 2003
@ -1130,7 +1130,7 @
 #endif
 		if (!(j % IDLE_REBALANCE_TICK)) {
 			spin_lock(&this_rq->lock);
-			load_balance(this_rq, 0, cpu_to_node_mask(this_cpu));
+			load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
 			spin_unlock(&this_rq->lock);
 		}
 		return;
diff -u --exclude-from=/home/me/.exclude -r a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Sun Apr 20 06:26:52 2003
+++ b/lib/kobject.c	Wed Apr 23 20:30:26 2003
@ -336,12 +336,14 @
 struct kobject * kobject_get(struct kobject * kobj)
 {
 	struct kobject * ret = kobj;
-	spin_lock(&kobj_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&kobj_lock, flags);
 	if (kobj && atomic_read(&kobj->refcount) > 0)
 		atomic_inc(&kobj->refcount);
 	else
 		ret = NULL;
-	spin_unlock(&kobj_lock);
+	spin_unlock_irqrestore(&kobj_lock, flags);
 	return ret;
 }
 
@ -371,10 +373,15 @
 
 void kobject_put(struct kobject * kobj)
 {
-	if (!atomic_dec_and_lock(&kobj->refcount, &kobj_lock))
-		return;
-	spin_unlock(&kobj_lock);
-	kobject_cleanup(kobj);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (atomic_dec_and_lock(&kobj->refcount, &kobj_lock)) {
+		spin_unlock_irqrestore(&kobj_lock, flags);
+		kobject_cleanup(kobj);
+	} else {
+		local_irq_restore(flags);
+	}
 }
 
 
diff -u --exclude-from=/home/me/.exclude -r a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c	Sat Mar 29 09:16:43 2003
+++ b/mm/oom_kill.c	Wed Apr 23 14:27:35 2003
@ -258,6 +258,11 @
 	oom_kill();
 
 reset:
-	first = now;
+	/*
+	 * We dropped the lock above, so check to be sure the variable
+	 * first only ever increases to prevent false OOM's.
+	 */
+	if time_after(now, first)
+		first = now;
 	count = 0;
 }
diff -u --exclude-from=/home/me/.exclude -r a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Sun Apr 20 06:26:52 2003
+++ b/mm/vmscan.c	Tue Apr 22 05:37:51 2003
@ -558,6 +558,7 @
 refill_inactive_zone(struct zone *zone, const int nr_pages_in,
 			struct page_state *ps, int priority)
 {
+	int pgmoved;
 	int pgdeactivate = 0;
 	int nr_pages = nr_pages_in;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
@ -571,6 +572,7 @
 	long swap_tendency;
 
 	lru_add_drain();
+	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (nr_pages && !list_empty(&zone->active_list)) {
 		page = list_entry(zone->active_list.prev, struct page, lru);
@ -585,9 +587,12 @
 		} else {
 			page_cache_get(page);
 			list_add(&page->lru, &l_hold);
+			pgmoved++;
 		}
 		nr_pages--;
 	}
+	zone->nr_active   -= pgmoved;
+	zone->nr_inactive += pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
 	/*
@ -647,10 +652,10 @
 			continue;
 		}
 		list_add(&page->lru, &l_inactive);
-		pgdeactivate++;
 	}
 
 	pagevec_init(&pvec, 1);
+	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
 		page = list_entry(l_inactive.prev, struct page, lru);
@ -660,19 +665,27 @
 		if (!TestClearPageActive(page))
 			BUG();
 		list_move(&page->lru, &zone->inactive_list);
+		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
+			zone->nr_inactive += pgmoved;
 			spin_unlock_irq(&zone->lru_lock);
+			pgdeactivate += pgmoved;
+			pgmoved = 0;
 			if (buffer_heads_over_limit)
 				pagevec_strip(&pvec);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
+	zone->nr_inactive += pgmoved;
+	pgdeactivate += pgmoved;
 	if (buffer_heads_over_limit) {
 		spin_unlock_irq(&zone->lru_lock);
 		pagevec_strip(&pvec);
 		spin_lock_irq(&zone->lru_lock);
 	}
+
+	pgmoved = 0;
 	while (!list_empty(&l_active)) {
 		page = list_entry(l_active.prev, struct page, lru);
 		prefetchw_prev_lru_page(page, &l_active, flags);
@ -680,14 +693,16 @
 			BUG();
 		BUG_ON(!PageActive(page));
 		list_move(&page->lru, &zone->active_list);
+		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
+			zone->nr_active += pgmoved;
+			pgmoved = 0;
 			spin_unlock_irq(&zone->lru_lock);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
-	zone->nr_active -= pgdeactivate;
-	zone->nr_inactive += pgdeactivate;
+	zone->nr_active += pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);
 
diff -u --exclude-from=/home/me/.exclude -r a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
--- a/net/ax25/af_ax25.c	Sat Mar 29 09:16:22 2003
+++ b/net/ax25/af_ax25.c	Sun Apr 20 08:47:54 2003
@ -1202,6 +1202,8 @
 		ax25_insert_socket(ax25);
 	} else {
 		if (ax25->ax25_dev == NULL) {
+			if (digi != NULL)
+				kfree(digi);
 			err = -EHOSTUNREACH;
 			goto out;
 		}
diff -u --exclude-from=/home/me/.exclude -r a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
--- a/net/ipv4/netfilter/Kconfig	Sun Apr 20 06:26:24 2003
+++ b/net/ipv4/netfilter/Kconfig	Wed Apr 23 20:14:20 2003
@ -48,7 +48,7 @
 	  <file:Documentation/modules.txt>.  If unsure, say `Y'.
 
 config IP_NF_TFTP
-	tristate "TFTP prtocol support"
+	tristate "TFTP protocol support"
 	depends on IP_NF_CONNTRACK
 	help
 	  TFTP connection tracking helper, this is required depending
diff -u --exclude-from=/home/me/.exclude -r a/net/ipv4/netfilter/ip_queue.c b/net/ipv4/netfilter/ip_queue.c
--- a/net/ipv4/netfilter/ip_queue.c	Sun Apr 20 06:26:24 2003
+++ b/net/ipv4/netfilter/ip_queue.c	Sun Apr 20 08:47:54 2003
@ -298,10 +298,11 @
 		goto err_out_free;
 		
 	write_lock_bh(&queue_lock);
-	
+
 	if (!peer_pid)
-		goto err_out_unlock;
+		goto err_out_free_nskb; 
 
+	/* netlink_unicast will either free the nskb or attach it to a socket */ 
 	status = netlink_unicast(ipqnl, nskb, peer_pid, MSG_DONTWAIT);
 	if (status < 0)
 		goto err_out_unlock;
@ -312,6 +313,9 @
 
 	write_unlock_bh(&queue_lock);
 	return status;
+
+err_out_free_nskb:
+	kfree_skb(nskb); 
 	
 err_out_unlock:
 	write_unlock_bh(&queue_lock);
diff -u --exclude-from=/home/me/.exclude -r a/net/ipv6/netfilter/ip6_queue.c b/net/ipv6/netfilter/ip6_queue.c
--- a/net/ipv6/netfilter/ip6_queue.c	Sun Apr 20 06:26:24 2003
+++ b/net/ipv6/netfilter/ip6_queue.c	Sun Apr 20 08:47:54 2003
@ -304,8 +304,9 @
 	write_lock_bh(&queue_lock);
 	
 	if (!peer_pid)
-		goto err_out_unlock;
+		goto err_out_free_nskb; 
 
+ 	/* netlink_unicast will either free the nskb or attach it to a socket */ 
 	status = netlink_unicast(ipqnl, nskb, peer_pid, MSG_DONTWAIT);
 	if (status < 0)
 		goto err_out_unlock;
@ -317,6 +318,9 @
 	write_unlock_bh(&queue_lock);
 	return status;
 	
+err_out_free_nskb:
+	kfree_skb(nskb); 
+	
 err_out_unlock:
 	write_unlock_bh(&queue_lock);
 
diff -u --exclude-from=/home/me/.exclude -r a/net/irda/irttp.c b/net/irda/irttp.c
--- a/net/irda/irttp.c	Tue Mar  4 22:29:23 2003
+++ b/net/irda/irttp.c	Sun Apr 20 08:47:54 2003
@ -263,7 +263,7 @
 
 	IRDA_DEBUG(2, "%s(), rx_sdu_size=%d\n",  __FUNCTION__,
 		   self->rx_sdu_size);
-	ASSERT(n <= self->rx_sdu_size, return NULL;);
+	ASSERT(n <= self->rx_sdu_size, {dev_kfree_skb(skb); return NULL;});
 
 	/* Set the new length */
 	skb_trim(skb, n);
diff -u --exclude-from=/home/me/.exclude -r a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
--- a/net/sunrpc/clnt.c	Sun Apr 20 06:26:24 2003
+++ b/net/sunrpc/clnt.c	Wed Apr 23 20:33:37 2003
@ -514,10 +514,9 @
 
 	if (rpc_malloc(task, bufsiz << 1) != NULL)
 		return;
-	printk(KERN_INFO "RPC: buffer allocation failed for task %p\n", task); 
+	dprintk("RPC: buffer allocation failed for task %p\n", task); 
 
 	if (RPC_IS_ASYNC(task) || !(task->tk_client->cl_intr && signalled())) {
-		xprt_release(task);
 		task->tk_action = call_reserve;
 		rpc_delay(task, HZ>>4);
 		return;
diff -u --exclude-from=/home/me/.exclude -r a/net/sunrpc/sched.c b/net/sunrpc/sched.c
--- a/net/sunrpc/sched.c	Sun Apr 20 06:26:24 2003
+++ b/net/sunrpc/sched.c	Wed Apr 23 20:33:37 2003
@ -672,7 +672,7 @
 {
 	int	gfp;
 
-	if (task->tk_flags & RPC_TASK_SWAPPER)
+	if (task->tk_flags & (RPC_TASK_SWAPPER|RPC_TASK_ASYNC))
 		gfp = GFP_ATOMIC;
 	else
 		gfp = GFP_NOFS;
diff -u --exclude-from=/home/me/.exclude -r a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
--- a/net/sunrpc/xprt.c	Sun Apr 20 06:26:52 2003
+++ b/net/sunrpc/xprt.c	Wed Apr 23 20:34:58 2003
@ -1461,6 +1461,7 @
 	if (xprt->prot == IPPROTO_UDP) {
 		sk->data_ready = udp_data_ready;
 		sk->no_check = UDP_CSUM_NORCV;
+		sk->allocation = GFP_NOFS;
 		xprt_set_connected(xprt);
 	} else {
 		struct tcp_opt *tp = tcp_sk(sk);


------
 Chuck
