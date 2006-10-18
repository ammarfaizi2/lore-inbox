Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422782AbWJRStO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422782AbWJRStO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbWJRStO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:49:14 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:42931 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422789AbWJRStM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:49:12 -0400
Subject: [PATCH] lockdep: fix ide/proc interaction
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 20:49:40 +0200
Message-Id: <1161197380.3036.73.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmmod/3080 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (proc_subdir_lock){--..}, at: [<c04a33b0>] remove_proc_entry+0x40/0x191

and this task is already holding:
 (ide_lock){++..}, at: [<c05651a2>] ide_unregister_subdriver+0x39/0xc8
which would create a new lock dependency:
 (ide_lock){++..} -> (proc_subdir_lock){--..}

but this new dependency connects a hard-irq-safe lock:
 (ide_lock){++..}
... which became hard-irq-safe at:
  [<c043c458>] lock_acquire+0x4b/0x6b
  [<c06129d7>] _spin_lock_irqsave+0x22/0x32
  [<c0567870>] ide_intr+0x17/0x1a9
  [<c044eb31>] handle_IRQ_event+0x20/0x4d
  [<c044ebf2>] __do_IRQ+0x94/0xef
  [<c0406771>] do_IRQ+0x9e/0xbd

to a hard-irq-unsafe lock:
 (proc_subdir_lock){--..}
... which became hard-irq-unsafe at:
...  [<c043c458>] lock_acquire+0x4b/0x6b
  [<c06126ab>] _spin_lock+0x19/0x28
  [<c04a32f2>] xlate_proc_name+0x1b/0x99
  [<c04a3547>] proc_create+0x46/0xdf
  [<c04a3642>] create_proc_entry+0x62/0xa5
  [<c07c1972>] proc_misc_init+0x1c/0x1d2
  [<c07c1844>] proc_root_init+0x4c/0xe9
  [<c07ad703>] start_kernel+0x294/0x3b3
  [<00000000>] 0x0

Move ide_remove_proc_entries() out from under ide_lock; there is nothing
that indicates that this is needed.

In specific, the call to ide_add_proc_entries() is unprotected, and there
is nothing else in the file using the respective ->proc fields. Also the
lock order around destroy_proc_ide_interface() suggests this.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 drivers/ide/ide.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/ide/ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide.c
+++ linux-2.6/drivers/ide/ide.c
@@ -973,8 +973,8 @@ ide_settings_t *ide_find_setting_by_name
  *	@drive: drive
  *
  *	Automatically remove all the driver specific settings for this
- *	drive. This function may sleep and must not be called from IRQ
- *	context. The caller must hold ide_setting_sem.
+ *	drive. This function may not be called from IRQ context. The
+ *	caller must hold ide_setting_sem.
  */
  
 static void auto_remove_settings (ide_drive_t *drive)
@@ -1874,11 +1874,22 @@ void ide_unregister_subdriver(ide_drive_
 {
 	unsigned long flags;
 	
-	down(&ide_setting_sem);
-	spin_lock_irqsave(&ide_lock, flags);
 #ifdef CONFIG_PROC_FS
 	ide_remove_proc_entries(drive->proc, driver->proc);
 #endif
+	down(&ide_setting_sem);
+	spin_lock_irqsave(&ide_lock, flags);
+	/*
+	 * ide_setting_sem protects the settings list
+	 * ide_lock protects the use of settings
+	 *
+	 * so we need to hold both, ide_settings_sem because we want to
+	 * modify the settings list, and ide_lock because we cannot take
+	 * a setting out that is being used.
+	 *
+	 * OTOH both ide_{read,write}_setting are only ever used under
+	 * ide_setting_sem.
+	 */
 	auto_remove_settings(drive);
 	spin_unlock_irqrestore(&ide_lock, flags);
 	up(&ide_setting_sem);


