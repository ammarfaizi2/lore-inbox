Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbSKCPc7>; Sun, 3 Nov 2002 10:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSKCPc7>; Sun, 3 Nov 2002 10:32:59 -0500
Received: from [212.104.37.2] ([212.104.37.2]:60427 "EHLO
	actnetweb.activenetwork.it") by vger.kernel.org with ESMTP
	id <S262042AbSKCPc6>; Sun, 3 Nov 2002 10:32:58 -0500
Date: Sun, 3 Nov 2002 16:39:35 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.45] CDRW not working
Message-ID: <20021103153935.GA1695@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
References: <20021102152143.GA515@dreamland.darkstar.net> <20021102152725.GD1922@suse.de> <20021102174727.GA294@dreamland.darkstar.net> <20021102213529.GB3612@suse.de> <20021103145352.GA1083@dreamland.darkstar.net> <20021103150150.GO3612@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103150150.GO3612@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sun, Nov 03, 2002 at 04:01:50PM +0100, Jens Axboe ha scritto: 
> > > Does 2.5.42 work or not? 
> > 
> > If I don't use hdparm 2.5.42 works. On 2.5.45 it's random.
> 
> 2.5.45 with attached patch, how does that compare?

The first patch doesn't apply to 2.5.45. cmd_len was removed in 2.5.45.
This one should be ok, right?

--- ide-cd.c.orig	Sun Nov  3 16:34:38 2002
+++ ide-cd.c	Sun Nov  3 16:36:52 2002
@@ -884,6 +884,7 @@
 {
 	struct cdrom_info *info = drive->driver_data;
 	ide_startstop_t startstop;
+	unsigned int cmd_len;
 
 	if (CDROM_CONFIG_FLAGS(drive)->drq_interrupt) {
 		/* Here we should have been called after receiving an interrupt
@@ -905,8 +906,12 @@
 	/* Arm the interrupt handler. */
 	ide_set_handler(drive, handler, rq->timeout, cdrom_timer_expiry);
 
+	cmd_len = COMMAND_SIZE(rq->cmd[0]);
+	if (cmd_len < ATAPI_MIN_CDB_BYTES)
+		cmd_len = ATAPI_MIN_CDB_BYTES;
+
 	/* Send the command to the device. */
-	HWIF(drive)->atapi_output_bytes(drive, rq->cmd, sizeof(rq->cmd));
+	HWIF(drive)->atapi_output_bytes(drive, rq->cmd, cmd_len);
 
 	/* Start the DMA if need be */
 	if (info->dma)


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Carpe diem, quam minimum credula postero. (Q. Horatius Flaccus)
