Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSKCJgJ>; Sun, 3 Nov 2002 04:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSKCJgJ>; Sun, 3 Nov 2002 04:36:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5033 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261721AbSKCJgI>;
	Sun, 3 Nov 2002 04:36:08 -0500
Date: Sun, 3 Nov 2002 10:42:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Matt Reppert <arashi@arashi.yi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Working ide-cd burn/rip, 2.5.44
Message-ID: <20021103094229.GJ3612@suse.de>
References: <20021102184357.7091fd4d.arashi@arashi.yi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20021102184357.7091fd4d.arashi@arashi.yi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 02 2002, Matt Reppert wrote:
> Just FYI. I tested the ide-cd based CD burning and reading with the
> cdrtools alpha ... kernel 2.5.44-mm6, cdrtools-1.11a39. If I boot
> into a clean system, only load ide-cd (none of the ide-scsi-related
> bits), and "do it", it works well.

You definitely don't want anything _less_ than 2.5.45 at all, it's a
miracle it appears to work :-)

Please retest 2.5.45, thanks, and you should probably add this patch to
fix the cdb output length issue.

-- 
Jens Axboe


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=idecd-cdb-size-2

===== drivers/ide/ide-cd.c 1.27 vs edited =====
--- 1.27/drivers/ide/ide-cd.c	Fri Oct 18 20:02:55 2002
+++ edited/drivers/ide/ide-cd.c	Sun Nov  3 10:33:17 2002
@@ -310,6 +310,7 @@
 #include <linux/completion.h>
 
 #include <scsi/scsi.h>	/* For SCSI -> ATAPI command conversion */
+#include "../scsi/scsi.h"
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -877,10 +878,10 @@
 					  ide_handler_t *handler)
 {
 	unsigned char *cmd_buf	= rq->cmd;
-	int cmd_len		= sizeof(rq->cmd);
 	unsigned int timeout	= rq->timeout;
 	struct cdrom_info *info = drive->driver_data;
 	ide_startstop_t startstop;
+	unsigned int cmd_len;
 
 	if (CDROM_CONFIG_FLAGS(drive)->drq_interrupt) {
 		/* Here we should have been called after receiving an interrupt
@@ -902,6 +903,11 @@
 
 	/* Arm the interrupt handler. */
 	ide_set_handler(drive, handler, timeout, cdrom_timer_expiry);
+
+	/* cdb length, pad upto the 12th byte if necessary */
+	cmd_len = COMMAND_SIZE(rq->cmd[0]);
+	if (cmd_len < 12)
+		cmd_len = 12;
 
 	/* Send the command to the device. */
 	HWIF(drive)->atapi_output_bytes(drive, cmd_buf, cmd_len);

--ikeVEW9yuYc//A+q--
