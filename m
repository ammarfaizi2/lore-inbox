Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUHOO5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUHOO5m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUHOO5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:57:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18396 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266758AbUHOO4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:56:07 -0400
Date: Sun, 15 Aug 2004 10:55:15 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: header updates for IDE changes
Message-ID: <20040815145515.GA9993@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "key" (generation) field to the ide taks object so that we can fix
the crash when you unload a pcmcia ide device (and later other pci hotplug 
devices etc) while having a proc file accessed

Add a remove function to be called on unload by later patches
Add a raw_taskfile function to allow drives to do command filters
Add configured bit so that we can differentiate currently ambigious interface
	states when unloading.
Add a prototype for ide_diag_taskfile (for raw_taskfile users)
Add prototypes for the ide key functions (code changes in next patch)



diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/include/linux/ide.h linux-2.6.8-rc3/include/linux/ide.h
--- linux.vanilla-2.6.8-rc3/include/linux/ide.h	2004-08-09 15:50:59.000000000 +0100
+++ linux-2.6.8-rc3/include/linux/ide.h	2004-08-12 16:45:17.000000000 +0100
@@ -849,12 +849,14 @@
 #define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
 
 struct ide_pci_device_s;
+struct ide_task_s;
 
 typedef struct hwif_s {
 	struct hwif_s *next;		/* for linked-list in ide_hwgroup_t */
 	struct hwif_s *mate;		/* other hwif from same PCI chip */
 	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
+	u16		key;		/* /proc persistent keying */
 
 	char name[6];			/* name of interface, eg. "ide0" */
 
@@ -909,10 +911,10 @@
 	int	(*quirkproc)(ide_drive_t *);
 	/* driver soft-power interface */
 	int	(*busproc)(ide_drive_t *, int);
-//	/* host rate limiter */
-//	u8	(*ratemask)(ide_drive_t *);
-//	/* device rate limiter */
-//	u8	(*ratefilter)(ide_drive_t *, u8);
+	/* hwif remove hook, called on unload/pci remove paths*/
+	void	(*remove)(struct hwif_s *);
+	/* allow command filter/control */
+	int	(*raw_taskfile)(ide_drive_t *, struct ide_task_s *, u8 *);
 #endif
 
 #if 0
@@ -980,7 +982,8 @@
 	unsigned long	select_data;	/* for use by chipset-specific code */
 
 	unsigned	noprobe    : 1;	/* don't probe for this interface */
-	unsigned	present    : 1;	/* this interface exists */
+	unsigned	present    : 1;	/* this interface exists logically (ie users) */
+	unsigned	configured : 1;	/* this hwif exists and is set up (may not be "present") */
 	unsigned	hold       : 1; /* this interface is always present */
 	unsigned	serialized : 1;	/* serialized all channel operation */
 	unsigned	sharing_irq: 1;	/* 1 = sharing irq with another hwif */
@@ -1082,6 +1085,9 @@
 extern int ide_write_setting(ide_drive_t *drive, ide_settings_t *setting, int val);
 extern void ide_add_generic_settings(ide_drive_t *drive);
 
+extern void *ide_drive_to_key(ide_drive_t *drive);
+extern ide_drive_t *ide_drive_from_key(void *);
+
 /*
  * /proc/ide interface
  */
@@ -1452,8 +1458,8 @@
 extern ide_startstop_t pre_task_mulout_intr(ide_drive_t *, struct request *);
 extern ide_startstop_t task_mulout_intr(ide_drive_t *);
 
+extern int ide_diag_taskfile(ide_drive_t *, ide_task_t *, unsigned long, u8 *);
 extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *);
-
 int ide_taskfile_ioctl(ide_drive_t *, unsigned int, unsigned long);
 int ide_cmd_ioctl(ide_drive_t *, unsigned int, unsigned long);
 int ide_task_ioctl(ide_drive_t *, unsigned int, unsigned long);

Signed-off-by: Alan Cox <alan@redhat.com>

