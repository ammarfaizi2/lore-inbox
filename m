Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUBZUT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbUBZUS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:18:27 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:7312 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262838AbUBZUQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:16:14 -0500
Date: Thu, 26 Feb 2004 18:01:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58L.0402261746280.8840@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Subject: [PATCH] cyclades async driver update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following patch is the first of several planned fixes for the cyclades
multiserial cards driver.

Its mostly a sync with in-house driver:

- Prevent users from opening non-existing Z ports
- Implement special XON/XOFF character handling in Z cards
- Prevent data-loss on Z cards
- Throttling fix for Z card
- Only throttle if CTS/RTS are set
- Fix accounting of received data

Kudos to Cyclades R&D

Please apply.

--- linux-2.6.3/drivers/char/cyclades.c.orig	2004-02-25 17:48:13.000000000 -0300
+++ linux-2.6.3/drivers/char/cyclades.c	2004-02-26 17:54:33.765209440 -0300
@@ -2,7 +2,7 @@
 #define	Z_WAKE
 #undef	Z_EXT_CHARS_IN_BUFFER
 static char rcsid[] =
-"$Revision: 2.3.2.8 $$Date: 2000/07/06 18:14:16 $";
+"$Revision: 2.3.2.20 $$Date: 2004/02/25 18:14:16 $";

 /*
  *  linux/drivers/char/cyclades.c
@@ -12,7 +12,7 @@
  *
  * Initially written by Randolph Bentson <bentson@grieg.seaslug.org>.
  * Modified and maintained by Marcio Saito <marcio@cyclades.com>.
- * Currently maintained by Henrique Gobbi <henrique.gobbi@cyclades.com>.
+ * Currently maintained by Cyclades team <async@cyclades.com>.
  *
  * For Technical support and installation problems, please send e-mail
  * to support@cyclades.com.
@@ -25,6 +25,8 @@
  * This version supports shared IRQ's (only for PCI boards).
  *
  * $Log: cyclades.c,v $
+ * Prevent users from opening non-existing Z ports.
+ *
  * Revision 2.3.2.8   2000/07/06 18:14:16 ivan
  * Fixed the PCI detection function to work properly on Alpha systems.
  * Implemented support for TIOCSERGETLSR ioctl.
@@ -676,6 +678,9 @@

 #define cy_put_user	put_user

+static void cy_throttle (struct tty_struct *tty);
+static void cy_send_xchar (struct tty_struct *tty, char ch);
+
 static unsigned long
 cy_get_user(unsigned long *addr)
 {
@@ -1256,8 +1261,6 @@
                                info->mon.char_max = char_count;
                             info->mon.char_last = char_count;
 #endif
-			    info->idle_stats.recv_bytes += char_count;
-			    info->idle_stats.recv_idle   = jiffies;
                             while(char_count--){
                                 if (tty->flip.count >= TTY_FLIPBUF_SIZE){
                                         break;
@@ -1266,11 +1269,13 @@
                                 data = cy_readb(base_addr+(CyRDSR<<index));
                                 *tty->flip.flag_buf_ptr++ = TTY_NORMAL;
                                 *tty->flip.char_buf_ptr++ = data;
+				info->idle_stats.recv_bytes++;
 				info->icount.rx++;
 #ifdef CY_16Y_HACK
                                 udelay(10L);
 #endif
                             }
+                             info->idle_stats.recv_idle = jiffies;
                         }
                         schedule_delayed_work(&tty->flip.work, 1);
                     }
@@ -1627,9 +1632,12 @@
 	    }
 #else
 	    while(char_count--){
-		if (tty->flip.count >= TTY_FLIPBUF_SIZE){
+		if (tty->flip.count >= N_TTY_BUF_SIZE - tty->read_cnt)
+                    break;
+
+		if (tty->flip.count >= TTY_FLIPBUF_SIZE)
 		    break;
-		}
+
 		data = cy_readb(cinfo->base_addr + rx_bufaddr + new_rx_get);
 		new_rx_get = (new_rx_get + 1) & (rx_bufsize - 1);
 		tty->flip.count++;
@@ -1768,10 +1776,6 @@
     fw_ver = cy_readl(&board_ctrl->fw_version);
     hw_ver = cy_readl(&((struct RUNTIME_9060 *)(cinfo->ctl_addr))->mail_box_0);

-#ifdef CONFIG_CYZ_INTR
-    if (!cinfo->nports)
-	cinfo->nports = (int) cy_readl(&board_ctrl->n_channel);
-#endif

     while(cyz_fetch_msg(cinfo, &channel, &cmd, &param) == 1) {
 	special_count = 0;
@@ -1958,7 +1962,8 @@
 	    ch_ctrl = &(zfw_ctrl->ch_ctrl[port]);
 	    buf_ctrl = &(zfw_ctrl->buf_ctrl[port]);

-	    cyz_handle_rx(info, ch_ctrl, buf_ctrl);
+	    if (!info->throttle)
+	        cyz_handle_rx(info, ch_ctrl, buf_ctrl);
 	    cyz_handle_tx(info, ch_ctrl, buf_ctrl);
 	}
 	/* poll every 'cyz_polling_cycle' period */
@@ -2553,12 +2558,15 @@
        will make the user pay attention.
     */
     if (IS_CYC_Z(cy_card[info->card])) {
-        if (!ISZLOADED(cy_card[info->card])) {
+	struct cyclades_card *cinfo = &cy_card[info->card];
+	struct FIRM_ID *firm_id = (struct FIRM_ID *)
+        	(cinfo->base_addr + ID_ADDRESS);
+
+        if (!ISZLOADED(*cinfo)) {
 	    if (((ZE_V1 ==cy_readl(&((struct RUNTIME_9060 *)
-		((cy_card[info->card]).ctl_addr))->mail_box_0)) &&
-		Z_FPGA_CHECK(cy_card[info->card])) &&
-		(ZFIRM_HLT==cy_readl(&((struct FIRM_ID *)
-		((cy_card[info->card]).base_addr+ID_ADDRESS))->signature)))
+		(cinfo->ctl_addr))->mail_box_0)) &&
+		Z_FPGA_CHECK (*cinfo)) &&
+		(ZFIRM_HLT == cy_readl (&firm_id->signature)))
 	    {
 		printk ("cyc:Cyclades-Z Error: you need an external power supply for this number of ports.\n\rFirmware halted.\r\n");
 	    } else {
@@ -2571,20 +2579,33 @@
 	    /* In case this Z board is operating in interrupt mode, its
 	       interrupts should be enabled as soon as the first open happens
 	       to one of its ports. */
-	    if (!cy_card[info->card].intr_enabled) {
+            if (!cinfo->intr_enabled) {
+		struct ZFW_CTRL *zfw_ctrl;
+		struct BOARD_CTRL *board_ctrl;
+
+		zfw_ctrl = (struct ZFW_CTRL *)
+		 (cinfo->base_addr +
+		  (cy_readl (&firm_id->zfwctrl_addr) & 0xfffff));
+
+		board_ctrl = &zfw_ctrl->board_ctrl;
+
 		/* Enable interrupts on the PLX chip */
-		cy_writew(cy_card[info->card].ctl_addr+0x68,
-			cy_readw(cy_card[info->card].ctl_addr+0x68)|0x0900);
+		cy_writew(cinfo->ctl_addr+0x68,
+			cy_readw(cinfo->ctl_addr+0x68)|0x0900);
 		/* Enable interrupts on the FW */
-		retval = cyz_issue_cmd(&cy_card[info->card],
+		retval = cyz_issue_cmd(cinfo,
 					0, C_CM_IRQ_ENBL, 0L);
 		if (retval != 0){
 		    printk("cyc:IRQ enable retval was %x\n", retval);
 		}
-		cy_card[info->card].intr_enabled = 1;
+		cinfo->nports = (int) cy_readl (&board_ctrl->n_channel);
+		cinfo->intr_enabled = 1;
 	    }
 	}
 #endif /* CONFIG_CYZ_INTR */
+	/* Make sure this Z port really exists in hardware */
+	if (info->line > (cinfo->first_line + cinfo->nports - 1))
+		return -ENODEV;
     }
 #ifdef CY_DEBUG_OTHER
     printk("cyc:cy_open ttyC%d\n", info->line); /* */
@@ -2639,6 +2660,8 @@
         return retval;
     }

+    info->throttle = 0;
+
 #ifdef CY_DEBUG_OPEN
     printk(" cyc:cy_open done\n");/**/
 #endif
@@ -4283,6 +4306,34 @@
     return;
 } /* cy_set_termios */

+/* This function is used to send a high-priority XON/XOFF character to
+   the device.
+*/
+static void
+cy_send_xchar (struct tty_struct *tty, char ch)
+{
+	struct cyclades_port *info = (struct cyclades_port *) tty->driver_data;
+	int card, channel;
+
+	if (serial_paranoia_check (info, tty->name, "cy_send_xchar"))
+		return;
+
+  	info->x_char = ch;
+
+	if (ch)
+		cy_start (tty);
+
+	card = info->card;
+	channel = info->line - cy_card[card].first_line;
+
+	if (IS_CYC_Z (cy_card[card])) {
+		if (ch == STOP_CHAR (tty))
+	  		cyz_issue_cmd (&cy_card[card], channel, C_CM_SENDXOFF, 0L);
+		else if (ch == START_CHAR (tty))
+			cyz_issue_cmd (&cy_card[card], channel, C_CM_SENDXON, 0L);
+	}
+}
+
 /* This routine is called by the upper-layer tty layer to signal
    that incoming characters should be throttled because the input
    buffers are close to full.
@@ -4307,31 +4358,36 @@
             return;
     }

-    if (I_IXOFF(tty)) {
-        info->x_char = STOP_CHAR(tty);
-            /* Should use the "Send Special Character" feature!!! */
-    }
-
     card = info->card;
-    channel = info->line - cy_card[card].first_line;
-    if (!IS_CYC_Z(cy_card[card])) {
-	chip = channel>>2;
-	channel &= 0x03;
-	index = cy_card[card].bus_index;
-	base_addr = (unsigned char*)
-		       (cy_card[card].base_addr
-		       + (cy_chip_offset[chip]<<index));

-	CY_LOCK(info, flags);
-	cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
-	if (info->rtsdtr_inv) {
-		cy_writeb((u_long)base_addr+(CyMSVR2<<index), ~CyDTR);
+    if (I_IXOFF(tty)) {
+        if (!IS_CYC_Z (cy_card[card]))
+            cy_send_xchar (tty, STOP_CHAR (tty));
+        else
+            info->throttle = 1;
+    }
+
+    if (tty->termios->c_cflag & CRTSCTS) {
+        channel = info->line - cy_card[card].first_line;
+        if (!IS_CYC_Z(cy_card[card])) {
+            chip = channel>>2;
+            channel &= 0x03;
+            index = cy_card[card].bus_index;
+            base_addr = (unsigned char*)
+             (cy_card[card].base_addr
+               + (cy_chip_offset[chip]<<index));
+
+            CY_LOCK(info, flags);
+            cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
+            if (info->rtsdtr_inv) {
+                cy_writeb((u_long)base_addr+(CyMSVR2<<index), ~CyDTR);
+             } else {
+                cy_writeb((u_long)base_addr+(CyMSVR1<<index), ~CyRTS);
+	     }
+	    CY_UNLOCK(info, flags);
 	} else {
-		cy_writeb((u_long)base_addr+(CyMSVR1<<index), ~CyRTS);
-	}
-	CY_UNLOCK(info, flags);
-    } else {
-	// Nothing to do!
+	    info->throttle = 1;
+        }
     }

     return;
@@ -4367,30 +4423,31 @@
 	if (info->x_char)
 	    info->x_char = 0;
 	else
-	    info->x_char = START_CHAR(tty);
-            /* Should use the "Send Special Character" feature!!! */
+	    cy_send_xchar (tty, START_CHAR (tty));
     }

-    card = info->card;
-    channel = info->line - cy_card[card].first_line;
-    if (!IS_CYC_Z(cy_card[card])) {
-	chip = channel>>2;
-	channel &= 0x03;
-	index = cy_card[card].bus_index;
-	base_addr = (unsigned char*)
-		       (cy_card[card].base_addr
+    if (tty->termios->c_cflag & CRTSCTS) {
+        card = info->card;
+        channel = info->line - cy_card[card].first_line;
+        if (!IS_CYC_Z(cy_card[card])) {
+	    chip = channel>>2;
+	    channel &= 0x03;
+	    index = cy_card[card].bus_index;
+	    base_addr = (unsigned char*)
+         	       (cy_card[card].base_addr
 		       + (cy_chip_offset[chip]<<index));

-	CY_LOCK(info, flags);
-	cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
-	if (info->rtsdtr_inv) {
-		cy_writeb((u_long)base_addr+(CyMSVR2<<index), CyDTR);
-	} else {
-		cy_writeb((u_long)base_addr+(CyMSVR1<<index), CyRTS);
+	    CY_LOCK(info, flags);
+	    cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
+	    if (info->rtsdtr_inv) {
+		    cy_writeb((u_long)base_addr+(CyMSVR2<<index), CyDTR);
+	    } else {
+		    cy_writeb((u_long)base_addr+(CyMSVR1<<index), CyRTS);
+	    }
+	    CY_UNLOCK(info, flags);
+        } else {
+	    info->throttle = 0;
 	}
-	CY_UNLOCK(info, flags);
-    }else{
-	// Nothing to do!
     }

     return;
--- linux-2.6.3/include/linux/cyclades.h.orig	2004-02-25 17:18:33.000000000 -0300
+++ linux-2.6.3/include/linux/cyclades.h	2004-02-26 17:21:38.088557944 -0300
@@ -7,6 +7,10 @@
  *
  * This file contains the general definitions for the cyclades.c driver
  *$Log: cyclades.h,v $
+ *Revision 3.1  2002/01/29 11:36:16  henrique
+ *added throttle field on struct cyclades_port to indicate whether the
+ *port is throttled or not
+ *
  *Revision 3.1  2000/04/19 18:52:52  ivan
  *converted address fields to unsigned long and added fields for physical
  *addresses on cyclades_card structure;
@@ -107,6 +111,9 @@
 #define CYGETCARDINFO		0x435911
 #define	CYSETWAIT		0x435912
 #define	CYGETWAIT		0x435913
+#define CYSETHIGHWATERMARK      0x435914
+#define CYGETHIGHWATERMARK      0x435915
+

 /*************** CYCLOM-Z ADDITIONS ***************/

@@ -141,7 +148,7 @@
 /****************** ****************** *******************/
 /*
  *	The data types defined below are used in all ZFIRM interface
- *	data structures. They accommodate differences between HW
+ *	data structures. They accomodate differences between HW
  *	architectures and compilers.
  */

@@ -604,6 +611,7 @@
 	wait_queue_head_t       close_wait;
 	wait_queue_head_t       shutdown_wait;
 	wait_queue_head_t       delta_msr_wait;
+	int throttle;
 };

 /*
