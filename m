Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSEVLhD>; Wed, 22 May 2002 07:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSEVLhC>; Wed, 22 May 2002 07:37:02 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:19119 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S311180AbSEVLhB>;
	Wed, 22 May 2002 07:37:01 -0400
Date: Wed, 22 May 2002 13:36:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Remove dead DISK_RECOVERY_TIME code.
Message-ID: <20020522133626.A32497@ucw.cz>
In-Reply-To: <20020522093013.GD312@pazke.ipt> <20020522114206.D31145@ucw.cz> <3CEB59E2.7020307@evision-ventures.com> <20020522131100.A32147@ucw.cz> <3CEB70F4.4030902@evision-ventures.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2002 at 12:20:36PM +0200, Martin Dalecki wrote:

> >>Any one of you who cares enough?
> > 
> > Here you go ...
> 
> Thank's looks fine applied.

And here is one more for you ...

-- 
Vojtech Pavlik
SuSE Labs

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="recovery_time.diff"

ChangeSet@1.585, 2002-05-22 13:34:07+02:00, vojtech@twilight.ucw.cz
  This removes all stuff related to DISK_RECOVERY_TIME. It seems to have been a hack to make
  some really broken hardware work - but broken beyond repair as well. It was reading the PIT
  timer without proper locking (hence interfering with system time), it was reading it regardless
  of the architecture (will work on PCs and similar only), etc, etc. Goodbye DISK_RECOVERY_TIME.


 drivers/ide/ide.c   |   35 -----------------------------------
 include/linux/ide.h |    7 -------
 2 files changed, 42 deletions(-)


diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Wed May 22 13:34:27 2002
+++ b/drivers/ide/ide.c	Wed May 22 13:34:27 2002
@@ -139,34 +139,6 @@
  */
 struct ata_channel ide_hwifs[MAX_HWIFS];	/* master data repository */
 
-#if (DISK_RECOVERY_TIME > 0)
-/*
- * For really screwed hardware (hey, at least it *can* be used with Linux)
- * we can enforce a minimum delay time between successive operations.
- */
-static unsigned long read_timer (void)
-{
-	unsigned long t, flags;
-	int i;
-
-	__save_flags(flags);	/* local CPU only */
-	__cli();		/* local CPU only */
-	t = jiffies * 11932;
-	outb_p(0, 0x43);
-	i = inb_p(0x40);
-	i |= inb(0x40) << 8;
-	__restore_flags(flags);	/* local CPU only */
-	return (t - i);
-}
-#endif
-
-static inline void set_recovery_timer(struct ata_channel *channel)
-{
-#if (DISK_RECOVERY_TIME > 0)
-	channel->last_time = read_timer();
-#endif
-}
-
 static void init_hwif_data(struct ata_channel *ch, unsigned int index)
 {
 	static const byte ide_major[] = {
@@ -986,11 +958,6 @@
 	 */
 	if (block == 0 && drive->remap_0_to_1 == 1)
 		block = 1;  /* redirect MBR access to EZ-Drive partn table */
-
-#if (DISK_RECOVERY_TIME > 0)
-	while ((read_timer() - ch->last_time) < DISK_RECOVERY_TIME);
-#endif
-
 	{
 		ide_startstop_t res;
 
@@ -1462,7 +1429,6 @@
 				} else
 					startstop = ide_error(drive, drive->rq, "irq timeout", GET_STAT());
 			}
-			set_recovery_timer(ch);
 			enable_irq(ch->irq);
 
 			spin_lock_irq(ch->lock);
@@ -1612,7 +1578,6 @@
 	 * same irq as is currently being serviced here, and Linux
 	 * won't allow another of the same (on any CPU) until we return.
 	 */
-	set_recovery_timer(drive->channel);
 	if (startstop == ide_stopped) {
 		if (!ch->handler) {	/* paranoia */
 			clear_bit(IDE_BUSY, &ch->active);
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Wed May 22 13:34:27 2002
+++ b/include/linux/ide.h	Wed May 22 13:34:27 2002
@@ -40,9 +40,6 @@
 
 /* Right now this is only needed by a promise controlled.
  */
-#ifndef DISK_RECOVERY_TIME		/* off=0; on=access_delay_time */
-# define DISK_RECOVERY_TIME	0	/*  for hardware that needs it */
-#endif
 #ifndef OK_TO_RESET_CONTROLLER		/* 1 needed for good error recovery */
 # define OK_TO_RESET_CONTROLLER	0	/* 0 for use with AH2372A/B interface */
 #endif
@@ -547,10 +544,6 @@
 	unsigned slow		: 1;	/* flag: slow data port */
 	unsigned io_32bit	: 1;	/* 0=16-bit, 1=32-bit */
 	unsigned char bus_state;	/* power state of the IDE bus */
-
-#if (DISK_RECOVERY_TIME > 0)
-	unsigned long last_time;	/* time when previous rq was done */
-#endif
 };
 
 /*

--IJpNTDwzlM2Ie8A6--
