Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289738AbSBJTV7>; Sun, 10 Feb 2002 14:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289739AbSBJTVn>; Sun, 10 Feb 2002 14:21:43 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:47370 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S289738AbSBJTVd>; Sun, 10 Feb 2002 14:21:33 -0500
Date: Sun, 10 Feb 2002 20:21:32 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <linux-kernel@vger.kernel.org>
Subject: [patch][looking for maintainers] jiffies compare fixups
Message-ID: <Pine.LNX.4.33.0202102019370.30794-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of December, I made a patch to fix comparisons of the jiffies
counter that would break at jiffies wraparound.
I split it up and sent the pieces to what I believed to be the
respective maintainers. And while this is fairly low priority stuff,
quite a few of them answered, and most of these pieces already made it
into 2.4.18pre.
On the other hand, about the same fraction of the mails weren't replied
to, while these patches also haven't yet appeared in Marcelo's tree. Some
of the mail addresses even bounced (mschmitz@lbl.gov, fibrechannel@compaq.com,
compaqandlinux@cpqlin.van-dijk.net, Elmer.Joandi@ut.ee, ehm@cris.com,
scherr@net4you.net, asj@lanmedia.com).

If you know the current maintainers for some part of the following patch,
please drop me a note. If you feel close enough to maintainership to
approve the patch yourself, please go ahead.

Thanks,
Tim Schmielau (tim@physik3.uni-rostock.de)



These are the patches I sent: (I prefixed them with the excerpt of the
maintainers file or the patched file where I found the mail address)

sent to: achim@vortex.de

GDT SCSI DISK ARRAY CONTROLLER DRIVER
P:	Achim Leubner
M:	achim@vortex.de
L:	linux-scsi@vger.kernel.org
W:	http://www.icp-vortex.com/
S:	Supported

--- linux-2.4.18-pre1/drivers/scsi/gdth_proc.c	Fri Sep  7 18:28:37 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/scsi/gdth_proc.c	Fri Dec 28 12:52:05 2001
@@ -1464,7 +1464,7 @@
             timer_table[SCSI_TIMER].expires = jiffies + timeout;
             timer_active |= 1 << SCSI_TIMER;
         } else {
-            if (jiffies + timeout < timer_table[SCSI_TIMER].expires)
+            if (time_before(jiffies + timeout, timer_table[SCSI_TIMER].expires))
                 timer_table[SCSI_TIMER].expires = jiffies + timeout;
         }
     }

sent to: andre@linux-ide.org

IDE DRIVER [GENERAL]
P:	Andre Hedrick
M:	andre@linux-ide.org
M:	andre@aslab.com
M:	andre@suse.com
L:	linux-kernel@vger.kernel.org
W:	http://www.kernel.org/pub/linux/kernel/people/hedrick/
W:	http://www.linux-ide.org/
S:	Supported

--- linux-2.4.18-pre1/drivers/ide/ide-probe.c	Thu Nov 29 23:30:13 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/ide/ide-probe.c	Fri Dec 28 11:46:05 2001
@@ -370,7 +370,7 @@
 	OUT_BYTE(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
 	do {
-		if (jiffies > timeout) {
+		if (time_after(jiffies, timeout)) {
 			printk("failed (timeout)\n");
 			return;
 		}

sent to: arobinso@nyx.net

HAYES ESP SERIAL DRIVER
P:	Andrew J. Robinson
M:	arobinso@nyx.net
L:	linux-kernel@vger.kernel.org
W:	http://www.nyx.net/~arobinso
S:	Maintained

diff -u -r --exclude-from dontdiff linux-2.4.18-pre1/drivers/char/esp.c linux-2.4.18-pre1-jiffies64/drivers/char/esp.c
--- linux-2.4.18-pre1/drivers/char/esp.c	Fri Dec 28 10:53:53 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/char/esp.c	Fri Dec 28 10:53:34 2001
@@ -2162,7 +2162,7 @@
 		if (signal_pending(current))
 			break;

-		if (timeout && ((orig_jiffies + timeout) < jiffies))
+		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;

 		serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);

sent to: asj@lanmedia.com

LANMEDIA WAN CARD DRIVER
P:      Andrew Stanley-Jones
M:      asj@lanmedia.com
W:      http://www.lanmedia.com/
S:      Supported

--- linux-2.4.18-pre1/drivers/net/wan/lmc/lmc_debug.c	Sat Apr 22 01:08:45 2000
+++ linux-2.4.18-pre1-jiffies64/drivers/net/wan/lmc/lmc_debug.c	Fri Dec 28 15:45:08 2001
@@ -72,12 +72,12 @@

     if(in_interrupt()){
         printk("%s: * %s\n", dev->name, msg);
-//        while(jiffies < j+10)
+//        while(time_before(jiffies, j+10))
 //            ;
     }
     else {
         printk("%s: %s\n", dev->name, msg);
-        while(jiffies < j)
+        while(time_before(jiffies, j))
             schedule();
     }
 #endif

sent to: benthagemark@yahoo.com Cc: mingo@redhat.com

SGI VISUAL WORKSTATION 320 AND 540
P:	Bent Hagemark
M:	bh@sgi.com
P:	Ingo Molnar
M:	mingo@redhat.com
S:	Maintained

--- linux-2.4.18-pre1/drivers/sound/vwsnd.c	Thu Nov 29 23:30:00 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/sound/vwsnd.c	Fri Dec 28 14:11:21 2001
@@ -535,7 +535,7 @@
 {
 	unsigned long later = jiffies + 2;
 	while (li_readl(lith, LI_CODEC_COMMAND) & LI_CC_BUSY)
-		if (jiffies >= later)
+		if (time_after_eq(jiffies, later))
 			return -EBUSY;
 	return 0;
 }
@@ -1358,7 +1358,7 @@
 	later = jiffies + HZ / 2;	/* roughly half a second */
 	DBGDO(shut_up++);
 	while (ad1843_read_bits(lith, &ad1843_PDNO)) {
-		if (jiffies > later) {
+		if (time_after(jiffies, later)) {
 			printk(KERN_ERR
 			       "vwsnd audio: AD1843 won't power up\n");
 			return -EIO;
@@ -3250,7 +3250,7 @@
 	li_writel(&lith, LI_HOST_CONTROLLER, LI_HC_LINK_ENABLE);
 	do {
 		w = li_readl(&lith, LI_HOST_CONTROLLER);
-	} while (w == LI_HC_LINK_ENABLE && jiffies < later);
+	} while (w == LI_HC_LINK_ENABLE && time_before(jiffies, later));

 	li_destroy(&lith);

sent to: bjornw@axis.com Cc: dev-etrax@axis.com

CRIS PORT
P:	Bjorn Wesen
M:	bjornw@axis.com
L:	dev-etrax@axis.com
W:	http://developer.axis.com
S:	Maintained

--- linux-2.4.18-pre9/arch/cris/drivers/ethernet.c	Mon Oct  8 20:43:54 2001
+++ linux-2.4.18-pre9-jiffies64/arch/cris/drivers/ethernet.c	Fri Dec 28 15:16:22 2001
@@ -1005,7 +1005,7 @@
 	int i;
 #endif

-	if (!led_active && jiffies > led_next_time) {
+	if (!led_active && time_after(jiffies, led_next_time)) {
 		/* light the network leds depending on the current speed. */
 		e100_set_network_leds(NETWORK_ACTIVITY);

@@ -1297,7 +1297,7 @@
 {
 	D(printk("e100 send pack, buf 0x%x len %d\n", buf, length));

-	if (!led_active && jiffies > led_next_time) {
+	if (!led_active && time_after(jiffies, led_next_time)) {
 		/* light the network leds depending on the current speed. */
 		e100_set_network_leds(NETWORK_ACTIVITY);

@@ -1322,7 +1322,7 @@
 static void
 e100_clear_network_leds(unsigned long dummy)
 {
-	if (led_active && jiffies > led_next_time) {
+	if (led_active && jiffies > time_after(jiffies, led_next_time)) {
 		e100_set_network_leds(NO_NETWORK_ACTIVITY);

 		/* Set the earliest time we may set the LED */
--- linux-2.4.18-pre1/arch/cris/drivers/ide.c	Wed Jul  4 20:50:38 2001
+++ linux-2.4.18-pre1-jiffies64/arch/cris/drivers/ide.c	Fri Dec 28 15:21:24 2001
@@ -354,7 +354,7 @@
 	printk("ide: waiting %d seconds for drives to regain consciousness\n", CONFIG_ETRAX_IDE_DELAY);

 	h = jiffies + (CONFIG_ETRAX_IDE_DELAY * HZ);
-	while(jiffies < h) ;
+	while(time_before(jiffies, h)) ;

   /* reset the dma channels we will use */

--- linux-2.4.18-pre1/arch/cris/drivers/usb-host.c	Mon Oct  8 20:43:54 2001
+++ linux-2.4.18-pre1-jiffies64/arch/cris/drivers/usb-host.c	Fri Dec 28 15:24:24 2001
@@ -458,7 +458,7 @@
 	*R_DMA_CH8_SUB2_CMD = IO_STATE(R_DMA_CH8_SUB2_CMD, cmd, stop);
 	/* Somehow wait for the DMA to finish current activities */
 	i = jiffies + 100;
-	while (jiffies < i);
+	while (time_before(jiffies, i));

 	first_ep = &TxIntrEPList[0];
 	tmp_ep = first_ep;

sent to: ds@schleef.org

/*
 * MTD chip driver for pre-CFI Sharp flash chips
 *
 * Copyright 2000,2001 David A. Schleef <ds@schleef.org>
 *           2000,2001 Lineo, Inc.
 *


--- linux-2.4.18-pre1/drivers/mtd/chips/sharp.c	Fri Dec 28 14:48:07 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/mtd/chips/sharp.c	Fri Dec 28 14:48:28 2001
@@ -440,7 +440,7 @@

 	timeo = jiffies + HZ;

-	while(jiffies<timeo){
+	while(time_before(jiffies, timeo)){
 		map->write32(map,CMD_READ_STATUS,adr);
 		status = map->read32(map,adr);
 		if((status & SR_READY)==SR_READY){

sent to: elmer@ylenurme.ee Cc: akpm@zip.com.au,jgarzik@mandrakesoft.com

Elmer.Joandi@ut.ee (http://www.ylenurme.ee/~elmer/655/)

NETWORK DEVICE DRIVERS
P:	Andrew Morton
M:	akpm@zip.com.au
P:	Jeff Garzik
M:	jgarzik@mandrakesoft.com
L:	linux-net@vger.kernel.org
S:	Maintained

--- linux-2.4.18-pre1/drivers/net/arlan.c	Thu Nov 29 23:29:56 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/net/arlan.c	Fri Dec 28 12:07:56 2001
@@ -677,7 +677,7 @@
 		arlan_retransmit_now(dev);
 	}
 	if (!registrationBad(dev) &&
-		priv->tx_done_delayed < jiffies &&
+		time_after(jiffies, priv->tx_done_delayed) &&
 		priv->tx_done_delayed != 0)
 	{
 		TXLAST(dev).offset = 0;

sent to: fibrechannel@compaq.com Cc: compaqandlinux@cpqlin.van-dijk.net

COMPAQ FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
P:      Amy Vanzant-Hodge
M:      Amy Vanzant-Hodge (fibrechannel@compaq.com)
L:	compaqandlinux@cpqlin.van-dijk.net
W:	ftp.compaq.com/pub/products/drivers/linux
S:      Supported

--- linux-2.4.18-pre1/drivers/scsi/cpqfcTSstructs.h	Thu Oct 25 22:53:50 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/scsi/cpqfcTSstructs.h	Fri Dec 28 12:48:20 2001
@@ -27,7 +27,7 @@

 #define DbgDelay(secs) { int wait_time; printk( " DbgDelay %ds ", secs); \
                          for( wait_time=jiffies + (secs*HZ); \
-		         wait_time > jiffies ;) ; }
+		         time_before(jiffies, wait_time) ;) ; }

 #define CPQFCTS_DRIVER_VER(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
 // don't forget to also change MODULE_DESCRIPTION in cpqfcTSinit.c

sent to: gadio@netvision.net.il

IDE/ATAPI TAPE DRIVERS
P:	Gadi Oxman
M:	Gadi Oxman <gadio@netvision.net.il>
L:	linux-kernel@vger.kernel.org
S:	Maintained

--- linux-2.4.18-pre1/drivers/ide/ide-tape.c	Sat Dec 22 22:04:57 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/ide/ide-tape.c	Fri Dec 28 11:53:27 2001
@@ -2418,26 +2418,26 @@
 	idetape_tape_t *tape = drive->driver_data;
 	int full = 125, empty = 75;

-	if (jiffies > tape->controlled_pipeline_head_time + 120 * HZ) {
+	if (time_after(jiffies, tape->controlled_pipeline_head_time + 120 * HZ)) {
 		tape->controlled_previous_pipeline_head = tape->controlled_last_pipeline_head;
 		tape->controlled_previous_head_time = tape->controlled_pipeline_head_time;
 		tape->controlled_last_pipeline_head = tape->pipeline_head;
 		tape->controlled_pipeline_head_time = jiffies;
 	}
-	if (jiffies > tape->controlled_pipeline_head_time + 60 * HZ)
+	if (time_after(jiffies, tape->controlled_pipeline_head_time + 60 * HZ))
 		tape->controlled_pipeline_head_speed = (tape->pipeline_head - tape->controlled_last_pipeline_head) * 32 * HZ / (jiffies - tape->controlled_pipeline_head_time);
-	else if (jiffies > tape->controlled_previous_head_time)
+	else if (time_after(jiffies, tape->controlled_previous_head_time))
 		tape->controlled_pipeline_head_speed = (tape->pipeline_head - tape->controlled_previous_pipeline_head) * 32 * HZ / (jiffies - tape->controlled_previous_head_time);

 	if (tape->nr_pending_stages < tape->max_stages /*- 1 */) { /* -1 for read mode error recovery */
-		if (jiffies > tape->uncontrolled_previous_head_time + 10 * HZ) {
+		if (time_after(jiffies, tape->uncontrolled_previous_head_time + 10 * HZ)) {
 			tape->uncontrolled_pipeline_head_time = jiffies;
 			tape->uncontrolled_pipeline_head_speed = (tape->pipeline_head - tape->uncontrolled_previous_pipeline_head) * 32 * HZ / (jiffies - tape->uncontrolled_previous_head_time);
 		}
 	} else {
 		tape->uncontrolled_previous_head_time = jiffies;
 		tape->uncontrolled_previous_pipeline_head = tape->pipeline_head;
-		if (jiffies > tape->uncontrolled_pipeline_head_time + 30 * HZ) {
+		if (time_after(jiffies, tape->uncontrolled_pipeline_head_time + 30 * HZ)) {
 			tape->uncontrolled_pipeline_head_time = jiffies;
 		}
 	}
@@ -2500,7 +2500,7 @@
 		tape->insert_time = jiffies;
 		tape->insert_size = 0;
 	}
-	if (jiffies > tape->insert_time)
+	if (time_after(jiffies, tape->insert_time))
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 	if (jiffies - tape->avg_time >= HZ) {
 		tape->avg_speed = tape->avg_size * HZ / (jiffies - tape->avg_time) / 1024;
@@ -2680,11 +2680,11 @@
 		tape->reads_since_buffer_fill = 0;
 		tape->last_buffer_fill = jiffies;
 		idetape_queue_onstream_buffer_fill(drive);
-		if (jiffies > tape->insert_time)
+		if (time_after(jiffies, tape->insert_time))
 			tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 		return ide_stopped;
 	}
-	if (jiffies > tape->insert_time)
+	if (time_after(jiffies, tape->insert_time))
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 	calculate_speeds(drive);
 	if (tape->onstream && tape->max_frames &&
@@ -2740,7 +2740,7 @@
 			if (tape->onstream) {
 				if (tape->cur_frames - tape->reads_since_buffer_fill <= 0)
 					tape->req_buffer_fill = 1;
-				if (jiffies > tape->last_buffer_fill + 5 * HZ / 100)
+				if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
 					tape->req_buffer_fill = 1;
 			}
 			pc = idetape_next_pc_storage (drive);
@@ -2756,7 +2756,7 @@
 			if (tape->onstream) {
 				if (tape->cur_frames + tape->writes_since_buffer_fill >= tape->max_frames)
 					tape->req_buffer_fill = 1;
-				if (jiffies > tape->last_buffer_fill + 5 * HZ / 100)
+				if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
 					tape->req_buffer_fill = 1;
 				calculate_speeds(drive);
 			}
@@ -3214,7 +3214,7 @@
 	 * Wait for the tape to become ready
 	 */
 	timeout += jiffies;
-	while (jiffies < timeout) {
+	while (time_before(jiffies, timeout)) {
 		idetape_create_test_unit_ready_cmd(&pc);
 		if (!__idetape_queue_pc_tail(drive, &pc))
 			return 0;

sent to: gorgo@itc.hu

/*
 * Hardware-level driver for the COMX and HICOMX cards
 * for Linux kernel 2.2.X
 *
 * Original authors:  Arpad Bakay <bakay.arpad@synergon.hu>,
 *                    Peter Bajan <bajan.peter@synergon.hu>,
 * Rewritten by: Tivadar Szemethy <tiv@itc.hu>
 * Currently maintained by: Gergely Madarasz <gorgo@itc.hu>

/*
 * Hardware driver for the MixCom synchronous serial board
 *
 * Author: Gergely Madarasz <gorgo@itc.hu>
 *

--- linux-2.4.18-pre1/drivers/net/wan/comx-hw-comx.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/net/wan/comx-hw-comx.c	Fri Dec 28 15:38:29 2001
@@ -492,11 +492,11 @@

 	COMX_CMD(dev, COMX_CMD_INIT);
 	jiffs = jiffies;
-	while (COMX_readw(dev, OFF_A_L2_LINKUP) != 1 && jiffies < jiffs + HZ) {
+	while (COMX_readw(dev, OFF_A_L2_LINKUP) != 1 && time_before(jiffies, jiffs + HZ)) {
 		schedule_timeout(1);
 	}

-	if (jiffies >= jiffs + HZ) {
+	if (time_after_eq(jiffies, jiffs + HZ)) {
 		printk(KERN_ERR "%s: board timeout on INIT command\n", dev->name);
 		ch->HW_release_board(dev, savep);
 		retval=-EIO;
@@ -507,11 +507,11 @@
 	COMX_CMD(dev, COMX_CMD_OPEN);

 	jiffs = jiffies;
-	while (COMX_readw(dev, OFF_A_L2_LINKUP) != 3 && jiffies < jiffs + HZ) {
+	while (COMX_readw(dev, OFF_A_L2_LINKUP) != 3 && time_before(jiffies, jiffs + HZ)) {
 		schedule_timeout(1);
 	}

-	if (jiffies >= jiffs + HZ) {
+	if (time_after_eq(jiffies, jiffs + HZ)) {
 		printk(KERN_ERR "%s: board timeout on OPEN command\n", dev->name);
 		ch->HW_release_board(dev, savep);
 		retval=-EIO;
--- linux-2.4.18-pre1/drivers/net/wan/comx-hw-mixcom.c	Sat Dec 22 22:04:59 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/net/wan/comx-hw-mixcom.c	Fri Dec 28 15:42:25 2001
@@ -103,7 +103,7 @@
 	unsigned delay = 0;

 	while ((cec = (rd_hscx(dev, HSCX_STAR) & HSCX_CEC) != 0) &&
-	    (jiffs + HZ > jiffies)) {
+	    time_before(jiffies, jiffs + HZ)) {
 		udelay(1);
 		if (++delay > (100000 / HZ)) break;
 	}

sent to: grif@cs.ucr.edu

/*
 * QLogic ISP2x00 SCSI-FCP
 * Written by Erik H. Moe, ehm@cris.com
 * Copyright 1995, Erik H. Moe
 *
[...]
 */

/* Renamed and updated to 1.3.x by Michael Griffith <grif@cs.ucr.edu> */

--- linux-2.4.18-pre1/drivers/scsi/qlogicfc.c	Thu Oct 25 22:53:51 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/scsi/qlogicfc.c	Fri Dec 28 13:41:14 2001
@@ -803,7 +803,7 @@
 			outw(HCCR_CLEAR_RISC_INTR, host->io_port + HOST_HCCR);
 			isp2x00_enable_irqs(host);
 			/* wait for the loop to come up */
-			for (wait_time = jiffies + 10 * HZ; wait_time > jiffies && hostdata->adapter_state == AS_LOOP_DOWN;) {
+			for (wait_time = jiffies + 10 * HZ; time_before(jiffies, wait_time) && hostdata->adapter_state == AS_LOOP_DOWN;) {
 			        barrier();
 				cpu_relax();
 			}
@@ -820,7 +820,7 @@
 	   some time before recognizing it is attached to a fabric */

 #if ISP2x00_FABRIC
-	for (wait_time = jiffies + 5 * HZ; wait_time > jiffies;) {
+	for (wait_time = jiffies + 5 * HZ; time_before(jiffies, wait_time);) {
 		barrier();
 		cpu_relax();
 	}

sent to: jes@trained-monkey.org Cc: linux-hippi@sunsite.dk

HIPPI
P:	Jes Sorensen
M:	jes@trained-monkey.org
L:	linux-hippi@sunsite.dk
S:	Maintained

--- linux-2.4.18-pre1/drivers/net/rrunner.c	Thu Nov 29 23:29:57 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/net/rrunner.c	Fri Dec 28 12:15:34 2001
@@ -770,7 +770,7 @@
 	 * Give the FirmWare time to chew on the `get running' command.
 	 */
 	myjif = jiffies + 5 * HZ;
-	while ((jiffies < myjif) && !rrpriv->fw_running);
+	while (time_before(jiffies, myjif) && !rrpriv->fw_running);

 	netif_start_queue(dev);

sent to: lizzi@cnam.fr Cc: davem@redhat.com

/*
  $Id: fore200e.c,v 1.5 2000/04/14 10:10:34 davem Exp $

  A FORE Systems 200E-series driver for ATM on Linux.
  Christophe Lizzi (lizzi@cnam.fr), October 1999-March 2000.


--- linux-2.4.18-pre1/drivers/atm/fore200e.c	Fri Sep 14 00:21:32 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/atm/fore200e.c	Fri Dec 28 14:36:32 2001
@@ -252,7 +252,7 @@
 fore200e_spin(int msecs)
 {
     unsigned long timeout = jiffies + MSECS(msecs);
-    while (jiffies < timeout);
+    while (time_before(jiffies, timeout));
 }


@@ -267,7 +267,7 @@
 	if ((ok = (*addr == val)) || (*addr & STATUS_ERROR))
 	    break;

-    } while (jiffies < timeout);
+    } while (time_before(jiffies, timeout));

 #if 1
     if (!ok) {
@@ -290,7 +290,7 @@
 	if ((ok = (fore200e->bus->read(addr) == val)))
 	    break;

-    } while (jiffies < timeout);
+    } while (time_before(jiffies, timeout));

 #if 1
     if (!ok) {
@@ -2417,7 +2417,7 @@
     unsigned long      timeout = jiffies + MSECS(50);
     int                c;

-    while (jiffies < timeout) {
+    while (time_before(jiffies, timeout)) {

 	c = (int) fore200e->bus->read(&monitor->soft_uart.recv);

sent to: mirsev@cicese.mx Cc: scherr@net4you.net

/*
   Miro/Pinnacle Systems Inc. DC10/DC10plus and
   Linux Media Labs LML33 video capture boards driver
   now with IOMega BUZ support!

   Copyright (C) 2000 Serguei Miridonov <mirsev@cicese.mx>

   Changes for BUZ by Wolfgang Scherr <scherr@net4you.net>

--- linux-2.4.18-pre1/drivers/media/video/zr36067.c	Thu Nov 29 23:29:56 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/media/video/zr36067.c	Fri Dec 28 14:44:20 2001
@@ -4206,7 +4206,7 @@
 			/* sleep 1 second */

 			timeout = jiffies + 1 * HZ;
-			while (jiffies < timeout)
+			while (time_before(jiffies, timeout))
 				schedule();

 			/* Get status of video decoder */

sent to: pberger@brimson.com Cc: borchers@steinerpoint.com

/*
*  Digi AccelePort USB-4 and USB-2 Serial Converters
*
*  Copyright 2000 by Digi International
*
*  This program is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  Shamelessly based on Brian Warner's keyspan_pda.c and Greg Kroah-Hartman's
*  usb-serial driver.
*
*  Peter Berger (pberger@brimson.com)
*  Al Borchers (borchers@steinerpoint.com)
*

--- linux-2.4.18-pre1/drivers/usb/serial/digi_acceleport.c	Thu Oct 11 08:42:47 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/usb/serial/digi_acceleport.c	Fri Dec 28 14:25:04 2001
@@ -734,7 +734,7 @@
 	while( count > 0 && ret == 0 ) {

 		while( (port->write_urb->status == -EINPROGRESS
-		|| priv->dp_write_urb_in_use) && jiffies < timeout ) {
+		|| priv->dp_write_urb_in_use) && time_before(jiffies, timeout)) {
 			cond_wait_interruptible_timeout_irqrestore(
 				&port->write_wait, DIGI_RETRY_TIMEOUT,
 				&priv->dp_port_lock, flags );
@@ -899,7 +899,7 @@

 	spin_lock_irqsave( &priv->dp_port_lock, flags );

-	while( jiffies < timeout && !priv->dp_transmit_idle ) {
+	while( time_before(jiffies, timeout) && !priv->dp_transmit_idle ) {
 		cond_wait_interruptible_timeout_irqrestore(
 			&priv->dp_transmit_idle_wait, DIGI_RETRY_TIMEOUT,
 			&priv->dp_port_lock, flags );

sent to: ralf@gnu.org Cc: linux-mips@oss.sgi.com

MIPS
P:	Ralf Baechle
M:	ralf@gnu.org
W:	http://oss.sgi.com/mips/mips-howto.html
L:	linux-mips@oss.sgi.com
S:	Maintained

--- linux-2.4.18-pre1/arch/mips/baget/vacserial.c	Sun Sep  9 19:43:01 2001
+++ linux-2.4.18-pre1-jiffies64/arch/mips/baget/vacserial.c	Fri Dec 28 14:57:14 2001
@@ -1785,7 +1785,7 @@
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
-		if (timeout && ((orig_jiffies + timeout) < jiffies))
+		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
 	current->state = TASK_RUNNING;

sent to: simon@tk.uni-linz.ac.at Cc: frodol@dds.nl,linux-i2c@pelican.tk.uni-linz.ac.at

I2C DRIVERS
P:	Simon Vogl
M:	simon@tk.uni-linz.ac.at
P:	Frodo Looijaard
M:	frodol@dds.nl
L:	linux-i2c@pelican.tk.uni-linz.ac.at
W:	http://www.tk.uni-linz.ac.at/~simon/private/i2c
S:	Maintained

--- linux-2.4.18-pre1/drivers/i2c/i2c-adap-ite.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/i2c/i2c-adap-ite.c	Fri Dec 28 11:38:01 2001
@@ -82,7 +82,7 @@
         unsigned long j = jiffies + 10;

 	DEB3(printk(" Write 0x%02x to 0x%x\n",(unsigned short)val, ctl&0xff));
-	DEB3({while (jiffies < j) schedule();})
+	DEB3({while (time_before(jiffies, j)) schedule();})
 	outw(val,ctl);
 }

--- linux-2.4.18-pre1/drivers/i2c/i2c-algo-bit.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/i2c/i2c-algo-bit.c	Fri Dec 28 11:39:08 2001
@@ -49,7 +49,7 @@
 /* respectively. This makes sure that the algorithm works. Some chips   */
 /* might not like this, as they have an internal timeout of some mils	*/
 /*
-#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
+#define SLO_IO      jif=jiffies;while(time_before_eq(jiffies, jif+i2c_table[minor].veryslow))\
                         if (need_resched) schedule();
 */

@@ -117,7 +117,7 @@
  		 * while they are processing data internally.
  		 */
 		setscl(adap,1);
-		if (start+adap->timeout <= jiffies) {
+		if (time_after_eq(jiffies, start+adap->timeout)) {
 			return -ETIMEDOUT;
 		}
 		if (current->need_resched)

sent to: support@in-system.com Cc: bjorn@haxx.se

/* Transport & Protocol Driver for In-System Design, Inc. ISD200 ASIC
 *
 * First release
 *
 * Current development and maintenance by:
 *   (c) 2000 In-System Design, Inc. (support@in-system.com)
 *
[...]
 * History:
 *
 *  2001-02-24: Removed lots of duplicate code and simplified the structure.
 *              (bjorn@haxx.se)
 */

--- linux-2.4.18-pre1/drivers/usb/storage/isd200.c	Thu Nov 29 23:30:00 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/usb/storage/isd200.c	Fri Dec 28 14:28:34 2001
@@ -1179,7 +1179,7 @@
 		}

 		/* check for timeout on this request */
-		if (jiffies >= endTime) {
+		if (time_after_eq(jiffies, endTime)) {
 			if (!detect)
 				US_DEBUGP("   BSY check timeout, just continue with next operation...\n");
 			else

sent to: tz@execpc.com Cc: grif@cs.ucr.edu,linux-scsi@vger.kernel.org

/*----------------------------------------------------------------*/
/*
   Qlogic linux driver - work in progress. No Warranty express or implied.
   Use at your own risk.  Support Tort Reform so you won't have to read all
   these silly disclaimers.

   Copyright 1994, Tom Zerucha.
   tz@execpc.com

   Additional Code, and much appreciated help by
   Michael A. Griffith
   grif@cs.ucr.edu

SCSI SUBSYSTEM
L:	linux-scsi@vger.kernel.org
S:	Unmaintained

--- linux-2.4.18-pre1/drivers/scsi/qlogicfas.c	Thu Oct 25 22:53:51 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/scsi/qlogicfas.c	Fri Dec 28 13:05:45 2001
@@ -271,11 +271,11 @@
 int	i,k;
 	k = 0;
 	i = jiffies + WATCHDOG;
-	while ( i > jiffies && !qabort && !((k = inb(qbase + 4)) & 0xe0)) {
+	while (time_before(jiffies, i) && !qabort && !((k = inb(qbase + 4)) & 0xe0)) {
 		barrier();
 		cpu_relax();
 	}
-	if (i <= jiffies)
+	if (time_after_eq(jiffies, i))
 		return (DID_TIME_OUT);
 	if (qabort)
 		return (qabort == 1 ? DID_ABORT : DID_RESET);
@@ -405,8 +405,8 @@
 	}
 /*** Enter Status (and Message In) Phase ***/
 	k = jiffies + WATCHDOG;
-	while ( k > jiffies && !qabort && !(inb(qbase + 4) & 6));	/* wait for status phase */
-	if ( k <= jiffies ) {
+	while ( time_before(jiffies, k) && !qabort && !(inb(qbase + 4) & 6));	/* wait for status phase */
+	if ( time_after_eq(jiffies, k) ) {
 		ql_zap();
 		return (DID_TIME_OUT << 16);
 	}

sent to: vmabraham@hotmail.com

/**********************************************************************
 * iph5526.c: IP/SCSI driver for the Interphase 5526 PCI Fibre Channel
 *			  Card.
 * Copyright (C) 1999 Vineet M Abraham <vmabraham@hotmail.com>
 *

--- linux-2.4.18-pre1/drivers/net/fc/iph5526.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.18-pre1-jiffies64/drivers/net/fc/iph5526.c	Fri Dec 28 14:03:44 2001
@@ -3871,7 +3871,7 @@
 		/* Wait for the Link to come up and the login process
 		 * to complete.
 		 */
-		for(timeout = jiffies + 10*HZ; (timeout > jiffies) && ((fi->g.link_up == FALSE) || (fi->g.port_discovery == TRUE) || (fi->g.explore_fabric == TRUE) || (fi->g.perform_adisc == TRUE));)
+		for(timeout = jiffies + 10*HZ; time_before(jiffies, timeout) && ((fi->g.link_up == FALSE) || (fi->g.port_discovery == TRUE) || (fi->g.explore_fabric == TRUE) || (fi->g.perform_adisc == TRUE));)
 			barrier();

 		count++;

