Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263198AbTDCBJy>; Wed, 2 Apr 2003 20:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263203AbTDCBJy>; Wed, 2 Apr 2003 20:09:54 -0500
Received: from codepoet.org ([166.70.99.138]:6793 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S263198AbTDCBJw>;
	Wed, 2 Apr 2003 20:09:52 -0500
Date: Wed, 2 Apr 2003 18:21:20 -0700
From: Erik Andersen <andersen@codepoet.org>
To: marcelo@conectiva.com.br
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] missing -ac stuff in include/linux/ide.h
Message-ID: <20030403012120.GE10796@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	marcelo@conectiva.com.br, linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that there was a partial IDE merge with -ac, but the
needed changes to include/linux/ide.h are absent.  Without this
patch the latest 2.4 BK tree for 2.4.21 pre6, at least as of
ChangeSet 1.1095, does not compile.  Plese apply,

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.21pre5/include/linux/ide.h linux.21pre5-ac3/include/linux/ide.h
--- linux.21pre5/include/linux/ide.h	2003-02-27 19:13:40.000000000 +0000
+++ linux.21pre5-ac3/include/linux/ide.h	2003-03-11 20:25:39.000000000 +0000
@@ -743,6 +743,7 @@
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned dead		: 1;	/* 1=dead, no new attachments */
+	unsigned id_read	: 1;	/* 1=id read from disk 0 = synthetic */
 	unsigned addressing;		/*      : 3;
 					 *  0=28-bit
 					 *  1=48-bit
@@ -828,12 +829,12 @@
 #define ide_rq_offset(rq) \
 	(((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
 
-extern inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
+static inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
 {
 	return bh_kmap_irq(rq->bh, flags) + ide_rq_offset(rq);
 }
 
-extern inline void ide_unmap_buffer(char *buffer, unsigned long *flags)
+static inline void ide_unmap_buffer(char *buffer, unsigned long *flags)
 {
 	bh_kunmap_irq(buffer, flags);
 }
@@ -942,7 +943,7 @@
 #endif
 
 	void (*OUTB)(u8 addr, unsigned long port);
-	void (*OUTBSYNC)(u8 addr, unsigned long port);
+	void (*OUTBSYNC)(ide_drive_t *drive, u8 addr, unsigned long port);
 	void (*OUTW)(u16 addr, unsigned long port);
 	void (*OUTL)(u32 addr, unsigned long port);
 	void (*OUTSW)(unsigned long port, void *addr, u32 count);
@@ -1081,12 +1082,13 @@
 	struct ide_settings_s	*next;
 } ide_settings_t;
 
-void ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set);
-void ide_remove_setting(ide_drive_t *drive, char *name);
-ide_settings_t *ide_find_setting_by_name(ide_drive_t *drive, char *name);
-int ide_read_setting(ide_drive_t *t, ide_settings_t *setting);
-int ide_write_setting(ide_drive_t *drive, ide_settings_t *setting, int val);
-void ide_add_generic_settings(ide_drive_t *drive);
+extern struct semaphore ide_setting_sem;
+extern int ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set);
+extern void ide_remove_setting(ide_drive_t *drive, char *name);
+extern ide_settings_t *ide_find_setting_by_name(ide_drive_t *drive, char *name);
+extern int ide_read_setting(ide_drive_t *t, ide_settings_t *setting);
+extern int ide_write_setting(ide_drive_t *drive, ide_settings_t *setting, int val);
+extern void ide_add_generic_settings(ide_drive_t *drive);
 
 /*
  * /proc/ide interface
@@ -1151,6 +1153,7 @@
 	int		(*end_request)(ide_drive_t *, int);
 	u8		(*sense)(ide_drive_t *, const char *, u8);
 	ide_startstop_t	(*error)(ide_drive_t *, const char *, u8);
+	ide_startstop_t	(*abort)(ide_drive_t *, const char *);
 	int		(*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
 	int		(*open)(struct inode *, struct file *, ide_drive_t *);
 	void		(*release)(struct inode *, struct file *, ide_drive_t *);
@@ -1291,6 +1294,7 @@
  * (drive, msg, status)
  */
 extern ide_startstop_t ide_error(ide_drive_t *, const char *, u8);
+extern ide_startstop_t ide_abort(ide_drive_t *, const char *);
 
 /*
  * Issue a simple drive command
@@ -1591,14 +1595,6 @@
  */
 extern request_queue_t *ide_get_queue(kdev_t dev);
 
-/*
- * CompactFlash cards and their brethern pretend to be removable hard disks,
- * but they never have a slave unit, and they don't have doorlock mechanisms.
- * This test catches them, and is invoked elsewhere when setting appropriate
- * config bits.
- */
-extern int drive_is_flashcard(ide_drive_t *);
-
 extern int ide_spin_wait_hwgroup(ide_drive_t *);
 extern void ide_timer_expiry(unsigned long);
 extern void ide_intr(int irq, void *dev_id, struct pt_regs *regs);
@@ -1611,6 +1607,8 @@
 extern int ide_attach_drive(ide_drive_t *);
 
 extern int ideprobe_init(void);
+extern int idedefault_attach(ide_drive_t *);
+extern int idedefault_init(void);
 extern int idedisk_attach(ide_drive_t *);
 extern int idedisk_init(void);
 extern int ide_cdrom_attach(ide_drive_t *);

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
