Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWDWLYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWDWLYR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 07:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWDWLYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 07:24:17 -0400
Received: from [212.70.37.24] ([212.70.37.24]:27147 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751373AbWDWLYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 07:24:16 -0400
From: Al Boldi <a1426z@gawab.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [FIX] ide-io: increase timeout value to allow for slave wakeup
Date: Sun, 23 Apr 2006 14:22:31 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <200604222359.21652.a1426z@gawab.com> <200604230721.54550.a1426z@gawab.com> <20060422214356.0f8afbcb.akpm@osdl.org>
In-Reply-To: <20060422214356.0f8afbcb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604231422.31176.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Al Boldi <a1426z@gawab.com> wrote:
> > Andrew Morton wrote:
> > > Al Boldi <a1426z@gawab.com> wrote:
> > > > During an STR resume cycle, the ide master disk times-out when there
> > > > is also a slave present (especially CD).  Increasing the timeout in
> > > > ide-io from 10,000 to 100,000 fixes this problem.
> > > >
> > > > Andrew, do I have to send a patch or can you take care of this
> > > > one-liner?
> > >
> > > Please see the thread "sata suspend resume ..." on this mailing list,
> > > starting Wed, 19 Apr.  It sounds like the same thing.
> >
> > Yes, that's what prompted me to look into ide-io.
> > So, will the sata fix also fix ide-io?
>
> Oh.  No.  Please send a patch.

--- 16/drivers/ide/ide-io.c.orig	2006-03-31 19:12:11.000000000 +0300
+++ 16/drivers/ide/ide-io.c	2006-04-23 13:24:15.000000000 +0300
@@ -932,7 +932,7 @@ static ide_startstop_t start_request (id
 			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
 		SELECT_DRIVE(drive);
 		HWIF(drive)->OUTB(8, HWIF(drive)->io_ports[IDE_CONTROL_OFFSET]);
-		rc = ide_wait_not_busy(HWIF(drive), 10000);
+		rc = ide_wait_not_busy(HWIF(drive), 100000);
 		if (rc)
 			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);
 	}

Also apply this one to get rid of this message:

	hdb: set_drive_speed_status: status=0x40 { DriveReady }
	ide: failed opcode was: unknown

Maybe someone on the ide list can comment on this first though.

--- 16/include/linux/ide.h.orig	2006-03-31 19:12:51.000000000 +0300
+++ 16/include/linux/ide.h	2006-04-23 13:06:32.000000000 +0300
@@ -120,7 +120,7 @@ typedef unsigned char	byte;	/* used ever
 #define IDE_BCOUNTL_REG		IDE_LCYL_REG
 #define IDE_BCOUNTH_REG		IDE_HCYL_REG
 
-#define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==(good))
+#define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==((stat)&(good)))
 #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
 #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
 #define BAD_STAT		(BAD_R_STAT  | DRQ_STAT)

