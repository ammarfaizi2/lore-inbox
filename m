Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263870AbTCUTfI>; Fri, 21 Mar 2003 14:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263868AbTCUTeN>; Fri, 21 Mar 2003 14:34:13 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61060
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263838AbTCUTcy>; Fri, 21 Mar 2003 14:32:54 -0500
Date: Fri, 21 Mar 2003 20:48:05 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212048.h2LKm5nC026503@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update ide headers to match changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/linux/ide.h linux-2.5.65-ac2/include/linux/ide.h
--- linux-2.5.65/include/linux/ide.h	2003-03-03 19:20:16.000000000 +0000
+++ linux-2.5.65-ac2/include/linux/ide.h	2003-03-20 18:23:19.000000000 +0000
@@ -341,10 +339,7 @@
 #include <asm/ide.h>
 
 /* Currently only m68k, apus and m8xx need it */
-#ifdef IDE_ARCH_ACK_INTR
-extern int ide_irq_lock;
-# define ide_ack_intr(hwif) (hwif->hw.ack_intr ? hwif->hw.ack_intr(hwif) : 1)
-#else
+#ifndef IDE_ARCH_ACK_INTR
 # define ide_ack_intr(hwif) (1)
 #endif
 
@@ -731,6 +726,7 @@
 
 	unsigned present	: 1;	/* drive is physically present */
 	unsigned dead		: 1;	/* device ejected hint */
+	unsigned id_read	: 1;	/* 1=id read from disk 0 = synthetic */
 	unsigned noprobe 	: 1;	/* from:  hdx=noprobe */
 	unsigned removable	: 1;	/* 1 if need to do check_media_change */
 	unsigned is_flash	: 1;	/* 1 if probed as flash */
@@ -850,7 +846,7 @@
 #define task_rq_offset(rq) \
 	(((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE)
 
-extern inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
+static inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
 {
 	/*
 	 * fs request
@@ -864,7 +860,7 @@
 	return rq->buffer + task_rq_offset(rq);
 }
 
-extern inline void ide_unmap_buffer(struct request *rq, char *buffer, unsigned long *flags)
+static inline void ide_unmap_buffer(struct request *rq, char *buffer, unsigned long *flags)
 {
 	if (rq->bio)
 		bio_kunmap_irq(buffer, flags);
@@ -978,7 +974,7 @@
 	ide_startstop_t (*ide_dma_queued_start)(ide_drive_t *drive);
 
 	void (*OUTB)(u8 addr, unsigned long port);
-	void (*OUTBSYNC)(u8 addr, unsigned long port);
+	void (*OUTBSYNC)(ide_drive_t *drive, u8 addr, unsigned long port);
 	void (*OUTW)(u16 addr, unsigned long port);
 	void (*OUTL)(u32 addr, unsigned long port);
 	void (*OUTSW)(unsigned long port, void *addr, u32 count);
@@ -1184,6 +1180,7 @@
 	int		(*end_request)(ide_drive_t *, int, int);
 	u8		(*sense)(ide_drive_t *, const char *, u8);
 	ide_startstop_t	(*error)(ide_drive_t *, const char *, u8);
+	ide_startstop_t	(*abort)(ide_drive_t *, const char *);
 	int		(*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
 	void		(*pre_reset)(ide_drive_t *);
 	unsigned long	(*capacity)(ide_drive_t *);
@@ -1283,6 +1280,13 @@
 ide_startstop_t ide_error (ide_drive_t *drive, const char *msg, byte stat);
 
 /*
+ * Abort a running command on the controller triggering the abort
+ * from a host side, non error situation
+ * (drive, msg)
+ */
+extern ide_startstop_t ide_abort(ide_drive_t *, const char *);
+
+/*
  * Issue a simple drive command
  * The drive must be selected beforehand.
  *
@@ -1330,12 +1334,6 @@
 extern ide_startstop_t ide_do_reset (ide_drive_t *);
 
 /*
- * Re-Start an operation for an IDE interface.
- * The caller should return immediately after invoking this.
- */
-extern int restart_request (ide_drive_t *, struct request *);
-
-/*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
 extern void ide_init_drive_cmd (struct request *rq);
@@ -1730,6 +1728,19 @@
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
 
 extern spinlock_t ide_lock;
+extern struct semaphore ide_cfg_sem;
+/*
+ * Structure locking:
+ *
+ * ide_cfg_sem and ide_lock together protect changes to
+ * ide_hwif_t->{next,hwgroup}
+ * ide_drive_t->next
+ *
+ * ide_hwgroup_t->busy: ide_lock
+ * ide_hwgroup_t->hwif: ide_lock
+ * ide_hwif_t->mate: constant, no locking
+ * ide_drive_t->hwif: constant, no locking
+ */
 
 #define local_irq_set(flags)	do { local_save_flags((flags)); local_irq_enable(); } while (0)
 
