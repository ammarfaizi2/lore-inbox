Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTEEIrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTEEIrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:47:06 -0400
Received: from [12.47.58.20] ([12.47.58.20]:33913 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262105AbTEEIrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:47:03 -0400
Date: Mon, 5 May 2003 02:01:04 -0700
From: Andrew Morton <akpm@digeo.com>
To: dougg@torque.net
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: illegal context for sleeping ... rmmod ide-cd + ide-scsi
Message-Id: <20030505020104.0abc66ba.akpm@digeo.com>
In-Reply-To: <3EB62347.8020109@torque.net>
References: <3EB62347.8020109@torque.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2003 08:59:27.0780 (UTC) FILETIME=[A2178640:01C312E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert <dougg@torque.net> wrote:
>
> In lk 2.5.69 (and in 68) both the ide-cd and ide-scsi
> modules generate a "sleeping function called from illegal
> context" stack trace when removed.
> 
> After "rmmod ide-cd" this appears:
>   Debug: sleeping function called from illegal context
>          at include/asm/semaphore.h:119
>   Call Trace:
>    [<c011dcec>] __might_sleep+0x5c/0x70

ide_unregister_subdriver() does spin_lock_irqsave(&ide_lock), then
calls auto_remove_settings(), which does down(&ide_setting_sem);

A simple fix might be:

diff -puN drivers/ide/ide.c~ide_setting_sem-fix drivers/ide/ide.c
--- 25/drivers/ide/ide.c~ide_setting_sem-fix	2003-05-05 01:59:01.000000000 -0700
+++ 25-akpm/drivers/ide/ide.c	2003-05-05 02:00:21.000000000 -0700
@@ -1131,13 +1131,12 @@ ide_settings_t *ide_find_setting_by_name
  *
  *	Automatically remove all the driver specific settings for this
  *	drive. This function may sleep and must not be called from IRQ
- *	context. Takes the settings_lock
+ *	context. The caller must hold ide_setting_sem.
  */
  
 static void auto_remove_settings (ide_drive_t *drive)
 {
 	ide_settings_t *setting;
-	down(&ide_setting_sem);
 repeat:
 	setting = drive->settings;
 	while (setting) {
@@ -1147,7 +1146,6 @@ repeat:
 		}
 		setting = setting->next;
 	}
-	up(&ide_setting_sem);
 }
 
 /**
@@ -2350,9 +2348,11 @@ int ide_unregister_subdriver (ide_drive_
 {
 	unsigned long flags;
 	
+	down(&ide_setting_sem);
 	spin_lock_irqsave(&ide_lock, flags);
 	if (drive->usage || drive->driver == &idedefault_driver || DRIVER(drive)->busy) {
 		spin_unlock_irqrestore(&ide_lock, flags);
+		up(&ide_setting_sem);
 		return 1;
 	}
 #if defined(CONFIG_BLK_DEV_IDEPNP) && defined(CONFIG_PNP) && defined(MODULE)
@@ -2363,6 +2363,7 @@ int ide_unregister_subdriver (ide_drive_
 	ide_remove_proc_entries(drive->proc, generic_subdriver_entries);
 #endif
 	auto_remove_settings(drive);
+	up(&ide_setting_sem);
 	drive->driver = &idedefault_driver;
 	setup_driver_defaults(drive);
 	spin_unlock_irqrestore(&ide_lock, flags);

_

