Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbTBKUlD>; Tue, 11 Feb 2003 15:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbTBKUlD>; Tue, 11 Feb 2003 15:41:03 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:23010 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S266043AbTBKUk7>; Tue, 11 Feb 2003 15:40:59 -0500
Date: Tue, 11 Feb 2003 21:50:39 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [patch] jiffies wrap fixes for 2.5.60
In-Reply-To: <200302040643.h146gps10473@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0302112145290.15563-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Denis Vlasenko wrote:

> However, this is a bit cosmetic. There is a much more serious problem:
>
> 		Jiffy Wrap Bugs
>
> There were reports of machines hanging on jiffy wrap.
> This is typically a result of incorrect jiffy use in some driver.
> Ask Tim - he is hunting those problems regularly, but he is outnumbered
> by buggy driver authors. :(

Speaking of which - here are my fixes for 2.5.60.
Will take some sleep (and maybe even try to compile them) before feeding
the patch monkey.

Tim


--- linux-2.5.60/arch/cris/drivers/usb-host.c	Fri Jan 17 03:21:51 2003
+++ linux-2.5.60-jfix/arch/cris/drivers/usb-host.c	Mon Feb 10 23:07:11 2003
@@ -459,7 +459,7 @@
 	*R_DMA_CH8_SUB2_CMD = IO_STATE(R_DMA_CH8_SUB2_CMD, cmd, stop);
 	/* Somehow wait for the DMA to finish current activities */
 	i = jiffies + 100;
-	while (jiffies < i);
+	while (time_before(jiffies, i));

 	first_ep = &TxIntrEPList[0];
 	tmp_ep = first_ep;

--- linux-2.5.60/arch/mips/baget/vacserial.c	Fri Jan 17 03:22:22 2003
+++ linux-2.5.60-jfix/arch/mips/baget/vacserial.c	Mon Feb 10 23:09:26 2003
@@ -1785,7 +1785,7 @@
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
-		if (timeout && ((orig_jiffies + timeout) < jiffies))
+		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
 	current->state = TASK_RUNNING;

--- linux-2.5.60/drivers/char/moxa.c	Fri Jan 17 03:22:44 2003
+++ linux-2.5.60-jfix/drivers/char/moxa.c	Mon Feb 10 23:01:59 2003
@@ -2832,7 +2832,7 @@

 	st = jiffies;
 	et = st + tick;
-	while (jiffies < et);
+	while (time_before(jiffies, et));
 }

 static void moxafunc(unsigned long ofsAddr, int cmd, ushort arg)

--- linux-2.5.60/drivers/char/mxser.c	Fri Jan 17 03:22:23 2003
+++ linux-2.5.60-jfix/drivers/char/mxser.c	Mon Feb 10 23:01:02 2003
@@ -857,7 +857,7 @@
 		while (!(inb(info->base + UART_LSR) & UART_LSR_TEMT)) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(5);
-			if (jiffies > timeout)
+			if (time_after(jiffies, timeout))
 				break;
 		}
 	}

--- linux-2.5.60/drivers/i2c/i2c-adap-ite.c	Fri Jan 17 03:21:44 2003
+++ linux-2.5.60-jfix/drivers/i2c/i2c-adap-ite.c	Mon Feb 10 23:04:16 2003
@@ -78,7 +78,7 @@
         unsigned long j = jiffies + 10;

 	DEB3(printk(" Write 0x%02x to 0x%x\n",(unsigned short)val, ctl&0xff));
-	DEB3({while (jiffies < j) schedule();})
+	DEB3({while (time_before(jiffies, j)) schedule();})
 	outw(val,ctl);
 }


--- linux-2.5.60/drivers/i2c/i2c-algo-ibm_ocp.c	Fri Jan 17 03:22:22 2003
+++ linux-2.5.60-jfix/drivers/i2c/i2c-algo-ibm_ocp.c	Mon Feb 10 23:05:06 2003
@@ -84,7 +84,7 @@
 /* respectively. This makes sure that the algorithm works. Some chips   */
 /* might not like this, as they have an internal timeout of some mils	*/
 /*
-#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
+#define SLO_IO      jif=jiffies;while(time_before_eq(jiffies,jif+i2c_table[minor].veryslow))\
                         if (need_resched) schedule();
 */

--- linux-2.5.60/drivers/isdn/hardware/eicon/i4l_idi.c	Fri Jan 17 03:22:09 2003
+++ linux-2.5.60-jfix/drivers/isdn/hardware/eicon/i4l_idi.c	Mon Feb 10 22:56:22 2003
@@ -3057,7 +3057,7 @@
 		}

 	        timeout = jiffies + 50;
-        	while (timeout > jiffies) {
+        	while (time_before(jiffies, timeout)) {
 	                if (chan->e.B2Id) break;
         	        SLEEP(10);
 	        }
@@ -3119,7 +3119,7 @@
         eicon_tx_request(card);

         timeout = jiffies + 50;
-        while (timeout > jiffies) {
+        while (time_before(jiffies, timeout)) {
                 if (chan->fsm_state) break;
                 SLEEP(10);
         }

--- linux-2.5.60/drivers/net/hamradio/yam.c	Tue Feb 11 21:28:17 2003
+++ linux-2.5.60-jfix/drivers/net/hamradio/yam.c	Mon Feb 10 22:52:09 2003
@@ -350,7 +350,7 @@
 		wrd <<= 1;
 		outb(0xfc, THR(iobase));
 		while ((inb(LSR(iobase)) & LSR_TSRE) == 0)
-			if (jiffies > timeout)
+			if (time_after(jiffies, timeout))
 				return -1;
 	}


--- linux-2.5.60/drivers/net/pcmcia/xirc2ps_cs.c	Tue Feb 11 21:28:18 2003
+++ linux-2.5.60-jfix/drivers/net/pcmcia/xirc2ps_cs.c	Mon Feb 10 22:42:28 2003
@@ -447,7 +447,7 @@
 	u_long flags;
 	save_flags(flags);
 	sti();
-	while (timeout >= jiffies)
+	while (time_before_eq(jiffies, timeout))
 	    ;
 	restore_flags(flags);
     } else {

--- linux-2.5.60/drivers/net/sis900.c	Tue Feb 11 21:28:18 2003
+++ linux-2.5.60-jfix/drivers/net/sis900.c	Mon Feb 10 22:54:50 2003
@@ -591,7 +591,7 @@
 			yield();

 			poll_bit ^= (mdio_read(net_dev, sis_priv->cur_phy, MII_STATUS) & poll_bit);
-			if (jiffies >= timeout) {
+			if (time_after_eq(jiffies, timeout)) {
 				printk(KERN_WARNING "%s: reset phy and link down now\n", net_dev->name);
 				return -ETIME;
 			}

--- linux-2.5.60/drivers/net/wan/comx-hw-comx.c	Fri Jan 17 03:21:38 2003
+++ linux-2.5.60-jfix/drivers/net/wan/comx-hw-comx.c	Mon Feb 10 22:46:08 2003
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

--- linux-2.5.60/drivers/net/wan/comx-hw-mixcom.c	Fri Jan 17 03:22:49 2003
+++ linux-2.5.60-jfix/drivers/net/wan/comx-hw-mixcom.c	Mon Feb 10 22:46:53 2003
@@ -104,7 +104,7 @@
 	unsigned delay = 0;

 	while ((cec = (rd_hscx(dev, HSCX_STAR) & HSCX_CEC) != 0) &&
-	    (jiffs + HZ > jiffies)) {
+	    time_before(jiffies, jiffs + HZ)) {
 		udelay(1);
 		if (++delay > (100000 / HZ)) break;
 	}

--- linux-2.5.60/drivers/scsi/sym53c416.c	Fri Jan 17 03:21:39 2003
+++ linux-2.5.60-jfix/drivers/scsi/sym53c416.c	Mon Feb 10 23:06:31 2003
@@ -272,7 +272,7 @@
 		{
 			i = jiffies + timeout;
 			spin_unlock_irqrestore(&sym53c416_lock, flags);
-			while(jiffies < i && (inb(base + PIO_INT_REG) & EMPTY) && timeout)
+			while(time_before(jiffies, i) && (inb(base + PIO_INT_REG) & EMPTY) && timeout)
 				if(inb(base + PIO_INT_REG) & SCI)
 					timeout = 0;
 			spin_lock_irqsave(&sym53c416_lock, flags);
@@ -316,7 +316,7 @@
 		{
 			i = jiffies + timeout;
 			spin_unlock_irqrestore(&sym53c416_lock, flags);
-			while(jiffies < i && (inb(base + PIO_INT_REG) & FULL) && timeout)
+			while(time_before(jiffies, i) && (inb(base + PIO_INT_REG) & FULL) && timeout)
 				;
 			spin_lock_irqsave(&sym53c416_lock, flags);
 			if(inb(base + PIO_INT_REG) & FULL)
@@ -552,7 +552,7 @@
 	outb(0x00, base + DEST_BUS_ID);
 	/* Wait for interrupt to occur */
 	i = jiffies + 20;
-	while(i > jiffies && !(inb(base + STATUS_REG) & SCI))
+	while(time_before(jiffies, i) && !(inb(base + STATUS_REG) & SCI))
 		barrier();
 	if(time_before_eq(i, jiffies))	/* timed out */
 		return 0;

--- linux-2.5.60/sound/oss/vwsnd.c	Fri Jan 17 03:22:16 2003
+++ linux-2.5.60-jfix/sound/oss/vwsnd.c	Mon Feb 10 23:10:57 2003
@@ -3260,7 +3260,7 @@
 	li_writel(&lith, LI_HOST_CONTROLLER, LI_HC_LINK_ENABLE);
 	do {
 		w = li_readl(&lith, LI_HOST_CONTROLLER);
-	} while (w == LI_HC_LINK_ENABLE && jiffies < later);
+	} while (w == LI_HC_LINK_ENABLE && time_before(jiffies, later));

 	li_destroy(&lith);


--- linux-2.5.60/sound/pci/ens1370.c	Tue Feb 11 21:28:31 2003
+++ linux-2.5.60-jfix/sound/pci/ens1370.c	Mon Feb 10 23:12:38 2003
@@ -1664,7 +1664,7 @@
 	if (!request_region(ensoniq->gameport.io, 8, "ens137x: gameport")) {
 #define ES___GAMEPORT_LOG_DELAY (30*HZ)
 		// avoid log pollution: limit to 2 infos per minute
-		if (jiffies > last_jiffies + ES___GAMEPORT_LOG_DELAY) {
+		if (time_after(jiffies, last_jiffies + ES___GAMEPORT_LOG_DELAY)) {
 			last_jiffies = jiffies;
 			snd_printk("gameport io port 0x%03x in use", ensoniq->gameport.io);
 		}

--- linux-2.5.60/sound/pci/korg1212/korg1212.c	Tue Feb 11 21:28:31 2003
+++ linux-2.5.60-jfix/sound/pci/korg1212/korg1212.c	Mon Feb 10 23:11:33 2003
@@ -598,7 +598,7 @@
                         return;
                 if (!korg1212->inIRQ)
                         schedule();
-        } while (jiffies < endtime);
+        } while (time_before(jiffies, endtime));

         writel(0, &korg1212->sharedBufferPtr->cardCommand);
 }

