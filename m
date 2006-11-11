Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754881AbWKKWk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbWKKWk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 17:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbWKKWk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 17:40:26 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:60092 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S1754881AbWKKWkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 17:40:25 -0500
Message-id: <30973309282550314198@wsc.cz>
Subject: [PATCH 1/4] Char: cyclades, save indent levels
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <support@cyclades.com>
Date: Sat, 11 Nov 2006 23:40:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cyclades, save indent levels

Save 3 indent levels in interrupt routine by moving the code to a separate
function. This needs to be done to allow Lindent do its work, since only 4
columns are used for indenting now and hence Lindent makes a big mess in
the code, when moves it 4*5 columns to the right.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 304c38fb121d969b3c0dd5fdd1d3c1bc9fa5d5e7
tree 45ec01982559a562b45214f9a89f134dfefa110f
parent ed7e6d6767a62758ff7de164953a4342dd820938
author Jiri Slaby <jirislaby@gmail.com> Mon, 06 Nov 2006 14:55:45 +0100
committer Jiri Slaby <jirislaby@gmail.com> Thu, 09 Nov 2006 17:30:26 +0100

 drivers/char/cyclades.c |  675 ++++++++++++++++++++++++-----------------------
 1 files changed, 340 insertions(+), 335 deletions(-)

diff --git a/drivers/char/cyclades.c b/drivers/char/cyclades.c
index 858a0b0..fc6d8da 100644
--- a/drivers/char/cyclades.c
+++ b/drivers/char/cyclades.c
@@ -1052,6 +1052,341 @@ detect_isa_irq(void __iomem *address)
 }
 #endif /* CONFIG_ISA */
 
+static void cyy_intr_chip(struct cyclades_card *cinfo, int chip,
+		void __iomem *base_addr, int status, int index)
+{
+	struct cyclades_port *info;
+	struct tty_struct *tty;
+	volatile int char_count;
+	int i, j, len, mdm_change, mdm_status, outch;
+	int save_xir, channel, save_car;
+	char data;
+
+	if (status & CySRReceive) { /* reception interrupt */
+#ifdef CY_DEBUG_INTERRUPTS
+	    printk("cyy_interrupt: rcvd intr, chip %d\n\r", chip);
+#endif
+	    /* determine the channel & change to that context */
+	    spin_lock(&cinfo->card_lock);
+	    save_xir = (u_char) cy_readb(base_addr+(CyRIR<<index));
+	    channel = (u_short ) (save_xir & CyIRChannel);
+	    i = channel + chip * 4 + cinfo->first_line;
+	    info = &cy_port[i];
+	    info->last_active = jiffies;
+	    save_car = cy_readb(base_addr+(CyCAR<<index));
+	    cy_writeb(base_addr+(CyCAR<<index), save_xir);
+
+	    /* if there is nowhere to put the data, discard it */
+	    if(info->tty == 0){
+		j = (cy_readb(base_addr+(CyRIVR<<index)) & CyIVRMask);
+		if ( j == CyIVRRxEx ) { /* exception */
+		    data = cy_readb(base_addr+(CyRDSR<<index));
+		} else { /* normal character reception */
+		    char_count = cy_readb(base_addr+(CyRDCR<<index));
+		    while(char_count--){
+			data = cy_readb(base_addr+(CyRDSR<<index));
+		    }
+		}
+	    }else{ /* there is an open port for this data */
+		tty = info->tty;
+		j = (cy_readb(base_addr+(CyRIVR<<index)) & CyIVRMask);
+		if ( j == CyIVRRxEx ) { /* exception */
+		    data = cy_readb(base_addr+(CyRDSR<<index));
+
+		    /* For statistics only */
+		    if (data & CyBREAK)
+			info->icount.brk++;
+		    else if(data & CyFRAME)
+			info->icount.frame++;
+		    else if(data & CyPARITY)
+			info->icount.parity++;
+		    else if(data & CyOVERRUN)
+			info->icount.overrun++;
+
+		    if(data & info->ignore_status_mask){
+			info->icount.rx++;
+			return;
+		    }
+		    if (tty_buffer_request_room(tty, 1)) {
+			if (data & info->read_status_mask){
+			    if(data & CyBREAK){
+				tty_insert_flip_char(tty, cy_readb(base_addr+(CyRDSR<<index)), TTY_BREAK);
+				info->icount.rx++;
+				if (info->flags & ASYNC_SAK){
+				    do_SAK(tty);
+				}
+			    }else if(data & CyFRAME){
+				tty_insert_flip_char(tty, cy_readb(base_addr+(CyRDSR<<index)), TTY_FRAME);
+				info->icount.rx++;
+				info->idle_stats.frame_errs++;
+			    }else if(data & CyPARITY){
+				/* Pieces of seven... */
+				tty_insert_flip_char(tty, cy_readb(base_addr+(CyRDSR<<index)), TTY_PARITY);
+				info->icount.rx++;
+				info->idle_stats.parity_errs++;
+			    }else if(data & CyOVERRUN){
+				tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+				info->icount.rx++;
+				/* If the flip buffer itself is
+				   overflowing, we still lose
+				   the next incoming character.
+				 */
+				tty_insert_flip_char(tty, cy_readb(base_addr+(CyRDSR<<index)), TTY_FRAME);
+				info->icount.rx++;
+				info->idle_stats.overruns++;
+			    /* These two conditions may imply */
+			    /* a normal read should be done. */
+			    /* }else if(data & CyTIMEOUT){ */
+			    /* }else if(data & CySPECHAR){ */
+			    }else {
+				tty_insert_flip_char(tty, 0, TTY_NORMAL);
+				info->icount.rx++;
+			    }
+			}else{
+			    tty_insert_flip_char(tty, 0, TTY_NORMAL);
+			    info->icount.rx++;
+			}
+		    }else{
+			/* there was a software buffer
+			   overrun and nothing could be
+			   done about it!!! */
+			info->icount.buf_overrun++;
+			info->idle_stats.overruns++;
+		    }
+		} else { /* normal character reception */
+		    /* load # chars available from the chip */
+		    char_count = cy_readb(base_addr+(CyRDCR<<index));
+
+#ifdef CY_ENABLE_MONITORING
+		    ++info->mon.int_count;
+		    info->mon.char_count += char_count;
+		    if (char_count > info->mon.char_max)
+		       info->mon.char_max = char_count;
+		    info->mon.char_last = char_count;
+#endif
+		    len = tty_buffer_request_room(tty, char_count);
+		    while(len--){
+			data = cy_readb(base_addr+(CyRDSR<<index));
+			tty_insert_flip_char(tty, data, TTY_NORMAL);
+			info->idle_stats.recv_bytes++;
+			info->icount.rx++;
+#ifdef CY_16Y_HACK
+			udelay(10L);
+#endif
+		    }
+		     info->idle_stats.recv_idle = jiffies;
+		}
+		tty_schedule_flip(tty);
+	    }
+	    /* end of service */
+	    cy_writeb(base_addr+(CyRIR<<index), (save_xir & 0x3f));
+	    cy_writeb(base_addr+(CyCAR<<index), (save_car));
+	    spin_unlock(&cinfo->card_lock);
+	}
+
+
+	if (status & CySRTransmit) { /* transmission interrupt */
+	    /* Since we only get here when the transmit buffer
+	       is empty, we know we can always stuff a dozen
+	       characters. */
+#ifdef CY_DEBUG_INTERRUPTS
+	    printk("cyy_interrupt: xmit intr, chip %d\n\r", chip);
+#endif
+
+	    /* determine the channel & change to that context */
+	    spin_lock(&cinfo->card_lock);
+	    save_xir = (u_char) cy_readb(base_addr+(CyTIR<<index));
+	    channel = (u_short ) (save_xir & CyIRChannel);
+	    i = channel + chip * 4 + cinfo->first_line;
+	    save_car = cy_readb(base_addr+(CyCAR<<index));
+	    cy_writeb(base_addr+(CyCAR<<index), save_xir);
+
+	    /* validate the port# (as configured and open) */
+	    if( (i < 0) || (NR_PORTS <= i) ){
+		cy_writeb(base_addr+(CySRER<<index),
+		     cy_readb(base_addr+(CySRER<<index)) & ~CyTxRdy);
+		goto txend;
+	    }
+	    info = &cy_port[i];
+	    info->last_active = jiffies;
+	    if(info->tty == 0){
+		cy_writeb(base_addr+(CySRER<<index),
+		     cy_readb(base_addr+(CySRER<<index)) & ~CyTxRdy);
+		goto txdone;
+	    }
+
+	    /* load the on-chip space for outbound data */
+	    char_count = info->xmit_fifo_size;
+
+	    if(info->x_char) { /* send special char */
+		outch = info->x_char;
+		cy_writeb(base_addr+(CyTDR<<index), outch);
+		char_count--;
+		info->icount.tx++;
+		info->x_char = 0;
+	    }
+
+	    if (info->breakon || info->breakoff) {
+		if (info->breakon) {
+		    cy_writeb(base_addr + (CyTDR<<index), 0); 
+		    cy_writeb(base_addr + (CyTDR<<index), 0x81);
+		    info->breakon = 0;
+		    char_count -= 2;
+		}
+		if (info->breakoff) {
+		    cy_writeb(base_addr + (CyTDR<<index), 0); 
+		    cy_writeb(base_addr + (CyTDR<<index), 0x83);
+		    info->breakoff = 0;
+		    char_count -= 2;
+		}
+	    }
+
+	    while (char_count-- > 0){
+		if (!info->xmit_cnt){
+		    if (cy_readb(base_addr+(CySRER<<index))&CyTxMpty) {
+			cy_writeb(base_addr+(CySRER<<index),
+				  cy_readb(base_addr+(CySRER<<index)) &
+				  ~CyTxMpty);
+		    } else {
+			cy_writeb(base_addr+(CySRER<<index),
+				  ((cy_readb(base_addr+(CySRER<<index))
+				    & ~CyTxRdy)
+				   | CyTxMpty));
+		    }
+		    goto txdone;
+		}
+		if (info->xmit_buf == 0){
+		    cy_writeb(base_addr+(CySRER<<index),
+			cy_readb(base_addr+(CySRER<<index)) & 
+				~CyTxRdy);
+		    goto txdone;
+		}
+		if (info->tty->stopped || info->tty->hw_stopped){
+		    cy_writeb(base_addr+(CySRER<<index),
+			cy_readb(base_addr+(CySRER<<index)) & 
+				~CyTxRdy);
+		    goto txdone;
+		}
+		/* Because the Embedded Transmit Commands have
+		   been enabled, we must check to see if the
+		   escape character, NULL, is being sent.  If it
+		   is, we must ensure that there is room for it
+		   to be doubled in the output stream.  Therefore
+		   we no longer advance the pointer when the
+		   character is fetched, but rather wait until
+		   after the check for a NULL output character.
+		   This is necessary because there may not be
+		   room for the two chars needed to send a NULL.)
+		 */
+		outch = info->xmit_buf[info->xmit_tail];
+		if( outch ){
+		    info->xmit_cnt--;
+		    info->xmit_tail = (info->xmit_tail + 1)
+					      & (SERIAL_XMIT_SIZE - 1);
+		    cy_writeb(base_addr+(CyTDR<<index), outch);
+		    info->icount.tx++;
+		}else{
+		    if(char_count > 1){
+			info->xmit_cnt--;
+			info->xmit_tail = (info->xmit_tail + 1)
+					      & (SERIAL_XMIT_SIZE - 1);
+			cy_writeb(base_addr+(CyTDR<<index), 
+				  outch);
+			cy_writeb(base_addr+(CyTDR<<index), 0);
+			info->icount.tx++;
+			char_count--;
+		    }else{
+		    }
+		}
+	    }
+
+txdone:
+	    if (info->xmit_cnt < WAKEUP_CHARS) {
+		cy_sched_event(info, Cy_EVENT_WRITE_WAKEUP);
+	    }
+txend:
+	    /* end of service */
+	    cy_writeb(base_addr+(CyTIR<<index), 
+		      (save_xir & 0x3f));
+	    cy_writeb(base_addr+(CyCAR<<index), (save_car));
+	    spin_unlock(&cinfo->card_lock);
+	}
+
+	if (status & CySRModem) {        /* modem interrupt */
+
+	    /* determine the channel & change to that context */
+	    spin_lock(&cinfo->card_lock);
+	    save_xir = (u_char) cy_readb(base_addr+(CyMIR<<index));
+	    channel = (u_short ) (save_xir & CyIRChannel);
+	    info = &cy_port[channel + chip * 4
+				   + cinfo->first_line];
+	    info->last_active = jiffies;
+	    save_car = cy_readb(base_addr+(CyCAR<<index));
+	    cy_writeb(base_addr+(CyCAR<<index), save_xir);
+
+	    mdm_change = cy_readb(base_addr+(CyMISR<<index));
+	    mdm_status = cy_readb(base_addr+(CyMSVR1<<index));
+
+	    if(info->tty == 0){/* no place for data, ignore it*/
+		;
+	    }else{
+		if (mdm_change & CyANY_DELTA) {
+		    /* For statistics only */
+		    if (mdm_change & CyDCD)	info->icount.dcd++;
+		    if (mdm_change & CyCTS)	info->icount.cts++;
+		    if (mdm_change & CyDSR)	info->icount.dsr++;
+		    if (mdm_change & CyRI)	info->icount.rng++;
+
+		    cy_sched_event(info, Cy_EVENT_DELTA_WAKEUP);
+		}
+
+		if((mdm_change & CyDCD)
+		&& (info->flags & ASYNC_CHECK_CD)){
+		    if(mdm_status & CyDCD){
+			cy_sched_event(info,
+			    Cy_EVENT_OPEN_WAKEUP);
+		    }else{
+			cy_sched_event(info,
+			    Cy_EVENT_HANGUP);
+		    }
+		}
+		if((mdm_change & CyCTS)
+		&& (info->flags & ASYNC_CTS_FLOW)){
+		    if(info->tty->hw_stopped){
+			if(mdm_status & CyCTS){
+			    /* cy_start isn't used
+				 because... !!! */
+			    info->tty->hw_stopped = 0;
+			  cy_writeb(base_addr+(CySRER<<index),
+			       cy_readb(base_addr+(CySRER<<index)) | 
+			       CyTxRdy);
+			    cy_sched_event(info,
+				Cy_EVENT_WRITE_WAKEUP);
+			}
+		    }else{
+			if(!(mdm_status & CyCTS)){
+			    /* cy_stop isn't used
+				 because ... !!! */
+			    info->tty->hw_stopped = 1;
+			  cy_writeb(base_addr+(CySRER<<index),
+			       cy_readb(base_addr+(CySRER<<index)) & 
+			       ~CyTxRdy);
+			}
+		    }
+		}
+		if(mdm_change & CyDSR){
+		}
+		if(mdm_change & CyRI){
+		}
+	    }
+	    /* end of service */
+	    cy_writeb(base_addr+(CyMIR<<index), 
+		      (save_xir & 0x3f));
+	    cy_writeb(base_addr+(CyCAR<<index), save_car);
+	    spin_unlock(&cinfo->card_lock);
+	}
+}
+
 /* The real interrupt service routine is called
    whenever the card wants its hand held--chars
    received, out buffer empty, modem change, etc.
@@ -1059,22 +1394,14 @@ #endif /* CONFIG_ISA */
 static irqreturn_t
 cyy_interrupt(int irq, void *dev_id)
 {
-  struct tty_struct *tty;
   int status;
   struct cyclades_card *cinfo;
-  struct cyclades_port *info;
   void __iomem *base_addr, *card_base_addr;
   int chip;
-  int save_xir, channel, save_car;
-  char data;
-  volatile int char_count;
-  int outch;
-  int i,j,index;
+  int index;
   int too_many;
   int had_work;
-  int mdm_change;
-  int mdm_status;
-  int len;
+
     if((cinfo = (struct cyclades_card *)dev_id) == 0){
 #ifdef CY_DEBUG_INTERRUPTS
 	printk("cyy_interrupt: spurious interrupt %d\n\r", irq);
@@ -1106,331 +1433,9 @@ #endif
                 if(1000<too_many++){
                     break;
                 }
-                if (status & CySRReceive) { /* reception interrupt */
-#ifdef CY_DEBUG_INTERRUPTS
-		    printk("cyy_interrupt: rcvd intr, chip %d\n\r", chip);
-#endif
-                    /* determine the channel & change to that context */
-		    spin_lock(&cinfo->card_lock);
-                    save_xir = (u_char) cy_readb(base_addr+(CyRIR<<index));
-                    channel = (u_short ) (save_xir & CyIRChannel);
-                    i = channel + chip * 4 + cinfo->first_line;
-                    info = &cy_port[i];
-                    info->last_active = jiffies;
-                    save_car = cy_readb(base_addr+(CyCAR<<index));
-                    cy_writeb(base_addr+(CyCAR<<index), save_xir);
-
-                    /* if there is nowhere to put the data, discard it */
-                    if(info->tty == 0){
-                        j = (cy_readb(base_addr+(CyRIVR<<index)) & CyIVRMask);
-                        if ( j == CyIVRRxEx ) { /* exception */
-                            data = cy_readb(base_addr+(CyRDSR<<index));
-                        } else { /* normal character reception */
-                            char_count = cy_readb(base_addr+(CyRDCR<<index));
-                            while(char_count--){
-                                data = cy_readb(base_addr+(CyRDSR<<index));
-                            }
-                        }
-                    }else{ /* there is an open port for this data */
-                        tty = info->tty;
-                        j = (cy_readb(base_addr+(CyRIVR<<index)) & CyIVRMask);
-                        if ( j == CyIVRRxEx ) { /* exception */
-                            data = cy_readb(base_addr+(CyRDSR<<index));
-
-			    /* For statistics only */
-			    if (data & CyBREAK)
-				info->icount.brk++;
-			    else if(data & CyFRAME)
-				info->icount.frame++;
-			    else if(data & CyPARITY)
-				info->icount.parity++;
-			    else if(data & CyOVERRUN)
-				info->icount.overrun++;
-
-                            if(data & info->ignore_status_mask){
-				info->icount.rx++;
-                                continue;
-                            }
-                            if (tty_buffer_request_room(tty, 1)) {
-                                if (data & info->read_status_mask){
-                                    if(data & CyBREAK){
-                                        tty_insert_flip_char(tty, cy_readb(base_addr+(CyRDSR<<index)), TTY_BREAK);
-					info->icount.rx++;
-                                        if (info->flags & ASYNC_SAK){
-                                            do_SAK(tty);
-                                        }
-                                    }else if(data & CyFRAME){
-                                        tty_insert_flip_char(tty, cy_readb(base_addr+(CyRDSR<<index)), TTY_FRAME);
-					info->icount.rx++;
-					info->idle_stats.frame_errs++;
-                                    }else if(data & CyPARITY){
-					/* Pieces of seven... */
-                                        tty_insert_flip_char(tty, cy_readb(base_addr+(CyRDSR<<index)), TTY_PARITY);
-					info->icount.rx++;
-					info->idle_stats.parity_errs++;
-                                    }else if(data & CyOVERRUN){
-                                        tty_insert_flip_char(tty, 0, TTY_OVERRUN);
-					info->icount.rx++;
-                                        /* If the flip buffer itself is
-                                           overflowing, we still lose
-                                           the next incoming character.
-                                         */
-                                        tty_insert_flip_char(tty, cy_readb(base_addr+(CyRDSR<<index)), TTY_FRAME);
-				        info->icount.rx++;
-					info->idle_stats.overruns++;
-                                    /* These two conditions may imply */
-                                    /* a normal read should be done. */
-                                    /* }else if(data & CyTIMEOUT){ */
-                                    /* }else if(data & CySPECHAR){ */
-                                    }else {
-					tty_insert_flip_char(tty, 0, TTY_NORMAL);
-				        info->icount.rx++;
-                                    }
-                                }else{
-				    tty_insert_flip_char(tty, 0, TTY_NORMAL);
-				    info->icount.rx++;
-                                }
-                            }else{
-                                /* there was a software buffer
-				   overrun and nothing could be
-				   done about it!!! */
-				info->icount.buf_overrun++;
-				info->idle_stats.overruns++;
-                            }
-                        } else { /* normal character reception */
-                            /* load # chars available from the chip */
-                            char_count = cy_readb(base_addr+(CyRDCR<<index));
-
-#ifdef CY_ENABLE_MONITORING
-                            ++info->mon.int_count;
-                            info->mon.char_count += char_count;
-                            if (char_count > info->mon.char_max)
-                               info->mon.char_max = char_count;
-                            info->mon.char_last = char_count;
-#endif
-			    len = tty_buffer_request_room(tty, char_count);
-                            while(len--){
-                                data = cy_readb(base_addr+(CyRDSR<<index));
-				tty_insert_flip_char(tty, data, TTY_NORMAL);
-				info->idle_stats.recv_bytes++;
-				info->icount.rx++;
-#ifdef CY_16Y_HACK
-                                udelay(10L);
-#endif
-                            }
-                             info->idle_stats.recv_idle = jiffies;
-                        }
-			tty_schedule_flip(tty);
-                    }
-                    /* end of service */
-                    cy_writeb(base_addr+(CyRIR<<index), (save_xir & 0x3f));
-                    cy_writeb(base_addr+(CyCAR<<index), (save_car));
-		    spin_unlock(&cinfo->card_lock);
-                }
-
-
-                if (status & CySRTransmit) { /* transmission interrupt */
-                    /* Since we only get here when the transmit buffer
-                       is empty, we know we can always stuff a dozen
-                       characters. */
-#ifdef CY_DEBUG_INTERRUPTS
-		    printk("cyy_interrupt: xmit intr, chip %d\n\r", chip);
-#endif
-
-                    /* determine the channel & change to that context */
-		    spin_lock(&cinfo->card_lock);
-                    save_xir = (u_char) cy_readb(base_addr+(CyTIR<<index));
-                    channel = (u_short ) (save_xir & CyIRChannel);
-                    i = channel + chip * 4 + cinfo->first_line;
-                    save_car = cy_readb(base_addr+(CyCAR<<index));
-                    cy_writeb(base_addr+(CyCAR<<index), save_xir);
-
-                    /* validate the port# (as configured and open) */
-                    if( (i < 0) || (NR_PORTS <= i) ){
-                        cy_writeb(base_addr+(CySRER<<index),
-                             cy_readb(base_addr+(CySRER<<index)) & ~CyTxRdy);
-                        goto txend;
-                    }
-                    info = &cy_port[i];
-                    info->last_active = jiffies;
-                    if(info->tty == 0){
-                        cy_writeb(base_addr+(CySRER<<index),
-                             cy_readb(base_addr+(CySRER<<index)) & ~CyTxRdy);
-                        goto txdone;
-                    }
-
-                    /* load the on-chip space for outbound data */
-                    char_count = info->xmit_fifo_size;
-
-                    if(info->x_char) { /* send special char */
-                        outch = info->x_char;
-                        cy_writeb(base_addr+(CyTDR<<index), outch);
-                        char_count--;
-			info->icount.tx++;
-                        info->x_char = 0;
-                    }
-
-                    if (info->breakon || info->breakoff) {
-			if (info->breakon) {
-			    cy_writeb(base_addr + (CyTDR<<index), 0); 
-			    cy_writeb(base_addr + (CyTDR<<index), 0x81);
-			    info->breakon = 0;
-                            char_count -= 2;
-			}
-			if (info->breakoff) {
-			    cy_writeb(base_addr + (CyTDR<<index), 0); 
-			    cy_writeb(base_addr + (CyTDR<<index), 0x83);
-			    info->breakoff = 0;
-                            char_count -= 2;
-			}
-                    }
-
-                    while (char_count-- > 0){
-			if (!info->xmit_cnt){
-			    if (cy_readb(base_addr+(CySRER<<index))&CyTxMpty) {
-				cy_writeb(base_addr+(CySRER<<index),
-					  cy_readb(base_addr+(CySRER<<index)) &
-					  ~CyTxMpty);
-			    } else {
-				cy_writeb(base_addr+(CySRER<<index),
-					  ((cy_readb(base_addr+(CySRER<<index))
-					    & ~CyTxRdy)
-					   | CyTxMpty));
-			    }
-			    goto txdone;
-			}
-			if (info->xmit_buf == 0){
-                            cy_writeb(base_addr+(CySRER<<index),
-				cy_readb(base_addr+(CySRER<<index)) & 
-					~CyTxRdy);
-                            goto txdone;
-			}
-			if (info->tty->stopped || info->tty->hw_stopped){
-                            cy_writeb(base_addr+(CySRER<<index),
-				cy_readb(base_addr+(CySRER<<index)) & 
-					~CyTxRdy);
-                            goto txdone;
-			}
-                        /* Because the Embedded Transmit Commands have
-                           been enabled, we must check to see if the
-			   escape character, NULL, is being sent.  If it
-			   is, we must ensure that there is room for it
-			   to be doubled in the output stream.  Therefore
-			   we no longer advance the pointer when the
-			   character is fetched, but rather wait until
-			   after the check for a NULL output character.
-			   This is necessary because there may not be
-			   room for the two chars needed to send a NULL.)
-                         */
-                        outch = info->xmit_buf[info->xmit_tail];
-                        if( outch ){
-                            info->xmit_cnt--;
-                            info->xmit_tail = (info->xmit_tail + 1)
-                                                      & (SERIAL_XMIT_SIZE - 1);
-                            cy_writeb(base_addr+(CyTDR<<index), outch);
-			    info->icount.tx++;
-                        }else{
-                            if(char_count > 1){
-                                info->xmit_cnt--;
-                                info->xmit_tail = (info->xmit_tail + 1)
-						      & (SERIAL_XMIT_SIZE - 1);
-                                cy_writeb(base_addr+(CyTDR<<index), 
-					  outch);
-                                cy_writeb(base_addr+(CyTDR<<index), 0);
-				info->icount.tx++;
-                                char_count--;
-                            }else{
-                            }
-                        }
-                    }
-
-        txdone:
-                    if (info->xmit_cnt < WAKEUP_CHARS) {
-                        cy_sched_event(info, Cy_EVENT_WRITE_WAKEUP);
-                    }
-        txend:
-                    /* end of service */
-                    cy_writeb(base_addr+(CyTIR<<index), 
-			      (save_xir & 0x3f));
-                    cy_writeb(base_addr+(CyCAR<<index), (save_car));
-		    spin_unlock(&cinfo->card_lock);
-                }
-
-                if (status & CySRModem) {        /* modem interrupt */
-
-                    /* determine the channel & change to that context */
-		    spin_lock(&cinfo->card_lock);
-                    save_xir = (u_char) cy_readb(base_addr+(CyMIR<<index));
-                    channel = (u_short ) (save_xir & CyIRChannel);
-                    info = &cy_port[channel + chip * 4
-		                           + cinfo->first_line];
-                    info->last_active = jiffies;
-                    save_car = cy_readb(base_addr+(CyCAR<<index));
-                    cy_writeb(base_addr+(CyCAR<<index), save_xir);
-
-                    mdm_change = cy_readb(base_addr+(CyMISR<<index));
-                    mdm_status = cy_readb(base_addr+(CyMSVR1<<index));
-
-                    if(info->tty == 0){/* no place for data, ignore it*/
-                        ;
-                    }else{
-			if (mdm_change & CyANY_DELTA) {
-			    /* For statistics only */
-			    if (mdm_change & CyDCD)	info->icount.dcd++;
-			    if (mdm_change & CyCTS)	info->icount.cts++;
-			    if (mdm_change & CyDSR)	info->icount.dsr++;
-			    if (mdm_change & CyRI)	info->icount.rng++;
-
-			    cy_sched_event(info, Cy_EVENT_DELTA_WAKEUP);
-			}
-
-                        if((mdm_change & CyDCD)
-                        && (info->flags & ASYNC_CHECK_CD)){
-                            if(mdm_status & CyDCD){
-                                cy_sched_event(info,
-				    Cy_EVENT_OPEN_WAKEUP);
-                            }else{
-                                cy_sched_event(info,
-				    Cy_EVENT_HANGUP);
-                            }
-                        }
-                        if((mdm_change & CyCTS)
-                        && (info->flags & ASYNC_CTS_FLOW)){
-                            if(info->tty->hw_stopped){
-                                if(mdm_status & CyCTS){
-                                    /* cy_start isn't used
-				         because... !!! */
-                                    info->tty->hw_stopped = 0;
-                                  cy_writeb(base_addr+(CySRER<<index),
-                                       cy_readb(base_addr+(CySRER<<index)) | 
-                                       CyTxRdy);
-                                    cy_sched_event(info,
-				        Cy_EVENT_WRITE_WAKEUP);
-                                }
-                            }else{
-                                if(!(mdm_status & CyCTS)){
-                                    /* cy_stop isn't used
-				         because ... !!! */
-                                    info->tty->hw_stopped = 1;
-                                  cy_writeb(base_addr+(CySRER<<index),
-                                       cy_readb(base_addr+(CySRER<<index)) & 
-                                       ~CyTxRdy);
-                                }
-                            }
-                        }
-                        if(mdm_change & CyDSR){
-                        }
-                        if(mdm_change & CyRI){
-                        }
-                    }
-                    /* end of service */
-                    cy_writeb(base_addr+(CyMIR<<index), 
-			      (save_xir & 0x3f));
-                    cy_writeb(base_addr+(CyCAR<<index), save_car);
-		    spin_unlock(&cinfo->card_lock);
-                }
-            }          /* end while status != 0 */
-        }            /* end loop for chips... */
+		cyy_intr_chip(cinfo, chip, base_addr, status, index);
+            }
+        }
     } while(had_work);
 
    /* clear interrupts */
