Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUAMRgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUAMRgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:36:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20755 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264441AbUAMReN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:34:13 -0500
Date: Tue, 13 Jan 2004 17:33:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, henrique.gobbi@cyclades.com,
       support@stallion.oz.au, R.E.Wolff@BitWizard.nl, paulus@samba.org,
       elfert@de.ibm.com, felfert@millenux.com, gerg@snapgear.com,
       kuba@mareimbrium.org
Subject: [2/3]
Message-ID: <20040113173352.D7256@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, henrique.gobbi@cyclades.com,
	support@stallion.oz.au, R.E.Wolff@BitWizard.nl, paulus@samba.org,
	elfert@de.ibm.com, felfert@millenux.com, gerg@snapgear.com,
	kuba@mareimbrium.org
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth> <20040113113650.A2975@flint.arm.linux.org.uk> <20040113114948.B2975@flint.arm.linux.org.uk> <20040113171544.B7256@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040113171544.B7256@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jan 13, 2004 at 05:15:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are patches to drivers in the 2.6 kernel which have not been tested
to correct the tiocmset/tiocmget problem.

You can find the full thread at the following URL:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&threadm=1dvnl-5Pr-1%40gated-at.bofh.it&rnum=1&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DISO-8859-1%26q%3DOutstanding%2Bfixups%26btnG%3DGoogle%2BSearch%26meta%3Dgroup%253Dlinux.kernel

===== drivers/char/cyclades.c 1.32 vs edited =====
--- 1.32/drivers/char/cyclades.c	Tue Sep 30 01:34:28 2003
+++ edited/drivers/char/cyclades.c	Tue Jan 13 14:01:24 2004
@@ -3632,8 +3632,9 @@
 }
 
 static int
-get_modem_info(struct cyclades_port * info, unsigned int *value)
+cy_tiocmget(struct tty_struct *tty, struct file *file)
 {
+  struct cyclades_port * info = (struct cyclades_port *)tty->driver_data;
   int card,chip,channel,index;
   unsigned char *base_addr;
   unsigned long flags;
@@ -3645,6 +3646,9 @@
   struct BOARD_CTRL *board_ctrl;
   struct CH_CTRL *ch_ctrl;
 
+    if (serial_paranoia_check(info, tty->name, __FUNCTION__))
+	return -ENODEV;
+
     card = info->card;
     channel = (info->line) - (cy_card[card].first_line);
     if (!IS_CYC_Z(cy_card[card])) {
@@ -3700,14 +3704,15 @@
 	}
 
     }
-    return cy_put_user(result, value);
-} /* get_modem_info */
+    return result;
+} /* cy_tiomget */
 
 
 static int
-set_modem_info(struct cyclades_port * info, unsigned int cmd,
-                          unsigned int *value)
+cy_tiocmset(struct tty_struct *tty, struct file *file,
+            unsigned int set, unsigned int clear)
 {
+  struct cyclades_port * info = (struct cyclades_port *)tty->driver_data;
   int card,chip,channel,index;
   unsigned char *base_addr;
   unsigned long flags;
@@ -3718,6 +3723,9 @@
   struct CH_CTRL *ch_ctrl;
   int retval;
 
+    if (serial_paranoia_check(info, tty->name, __FUNCTION__))
+	return -ENODEV;
+
     card = info->card;
     channel = (info->line) - (cy_card[card].first_line);
     if (!IS_CYC_Z(cy_card[card])) {
@@ -3728,66 +3736,7 @@
 		       (cy_card[card].base_addr
 		       + (cy_chip_offset[chip]<<index));
 
-	switch (cmd) {
-	case TIOCMBIS:
-	    if (arg & TIOCM_RTS){
-		CY_LOCK(info, flags);
-		cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
-                if (info->rtsdtr_inv) {
-		    cy_writeb((u_long)base_addr+(CyMSVR2<<index), CyDTR);
-                } else {
-		    cy_writeb((u_long)base_addr+(CyMSVR1<<index), CyRTS);
-                }
-		CY_UNLOCK(info, flags);
-	    }
-	    if (arg & TIOCM_DTR){
-		CY_LOCK(info, flags);
-		cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
-                if (info->rtsdtr_inv) {
-		    cy_writeb((u_long)base_addr+(CyMSVR1<<index), CyRTS);
-                } else {
-		    cy_writeb((u_long)base_addr+(CyMSVR2<<index), CyDTR);
-                }
-#ifdef CY_DEBUG_DTR
-		printk("cyc:set_modem_info raising DTR\n");
-		printk("     status: 0x%x, 0x%x\n",
-		    cy_readb(base_addr+(CyMSVR1<<index)), 
-                    cy_readb(base_addr+(CyMSVR2<<index)));
-#endif
-		CY_UNLOCK(info, flags);
-	    }
-	    break;
-	case TIOCMBIC:
-	    if (arg & TIOCM_RTS){
-		CY_LOCK(info, flags);
-		cy_writeb((u_long)base_addr+(CyCAR<<index), 
-                          (u_char)channel);
-                if (info->rtsdtr_inv) {
-		    	cy_writeb((u_long)base_addr+(CyMSVR2<<index), ~CyDTR);
-                } else {
-		    	cy_writeb((u_long)base_addr+(CyMSVR1<<index), ~CyRTS);
-                }
-		CY_UNLOCK(info, flags);
-	    }
-	    if (arg & TIOCM_DTR){
-		CY_LOCK(info, flags);
-		cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
-                if (info->rtsdtr_inv) {
-			cy_writeb((u_long)base_addr+(CyMSVR1<<index), ~CyRTS);
-                } else {
-			cy_writeb((u_long)base_addr+(CyMSVR2<<index), ~CyDTR);
-                }
-#ifdef CY_DEBUG_DTR
-		printk("cyc:set_modem_info dropping DTR\n");
-		printk("     status: 0x%x, 0x%x\n",
-		    cy_readb(base_addr+(CyMSVR1<<index)), 
-                    cy_readb(base_addr+(CyMSVR2<<index)));
-#endif
-		CY_UNLOCK(info, flags);
-	    }
-	    break;
-	case TIOCMSET:
-	    if (arg & TIOCM_RTS){
+	if (set & TIOCM_RTS){
 		CY_LOCK(info, flags);
 	        cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
                 if (info->rtsdtr_inv) {
@@ -3796,7 +3745,8 @@
 			cy_writeb((u_long)base_addr+(CyMSVR1<<index), CyRTS);
                 }
 		CY_UNLOCK(info, flags);
-	    }else{
+	}
+	if (clear & TIOCM_RTS) {
 		CY_LOCK(info, flags);
 		cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
                 if (info->rtsdtr_inv) {
@@ -3805,8 +3755,8 @@
 			cy_writeb((u_long)base_addr+(CyMSVR1<<index), ~CyRTS);
                 }
 		CY_UNLOCK(info, flags);
-	    }
-	    if (arg & TIOCM_DTR){
+	}
+	if (set & TIOCM_DTR){
 		CY_LOCK(info, flags);
 		cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
                 if (info->rtsdtr_inv) {
@@ -3821,7 +3771,8 @@
                     cy_readb(base_addr+(CyMSVR2<<index)));
 #endif
 		CY_UNLOCK(info, flags);
-	    }else{
+	}
+	if (clear & TIOCM_DTR) {
 		CY_LOCK(info, flags);
 		cy_writeb((u_long)base_addr+(CyCAR<<index), (u_char)channel);
                 if (info->rtsdtr_inv) {
@@ -3837,10 +3788,6 @@
                     cy_readb(base_addr+(CyMSVR2<<index)));
 #endif
 		CY_UNLOCK(info, flags);
-	    }
-	    break;
-	default:
-	    return -EINVAL;
 	}
     } else {
 	base_addr = (unsigned char*) (cy_card[card].base_addr);
@@ -3854,54 +3801,19 @@
 	    board_ctrl = &zfw_ctrl->board_ctrl;
 	    ch_ctrl = zfw_ctrl->ch_ctrl;
 
-	    switch (cmd) {
-	    case TIOCMBIS:
-		if (arg & TIOCM_RTS){
-		    CY_LOCK(info, flags);
-		    cy_writel(&ch_ctrl[channel].rs_control,
-                       cy_readl(&ch_ctrl[channel].rs_control) | C_RS_RTS);
-		    CY_UNLOCK(info, flags);
-		}
-		if (arg & TIOCM_DTR){
-		    CY_LOCK(info, flags);
-		    cy_writel(&ch_ctrl[channel].rs_control,
-                       cy_readl(&ch_ctrl[channel].rs_control) | C_RS_DTR);
-#ifdef CY_DEBUG_DTR
-		    printk("cyc:set_modem_info raising Z DTR\n");
-#endif
-		    CY_UNLOCK(info, flags);
-		}
-		break;
-	    case TIOCMBIC:
-		if (arg & TIOCM_RTS){
-		    CY_LOCK(info, flags);
-		    cy_writel(&ch_ctrl[channel].rs_control,
-                       cy_readl(&ch_ctrl[channel].rs_control) & ~C_RS_RTS);
-		    CY_UNLOCK(info, flags);
-		}
-		if (arg & TIOCM_DTR){
-		    CY_LOCK(info, flags);
-		    cy_writel(&ch_ctrl[channel].rs_control,
-                       cy_readl(&ch_ctrl[channel].rs_control) & ~C_RS_DTR);
-#ifdef CY_DEBUG_DTR
-		    printk("cyc:set_modem_info clearing Z DTR\n");
-#endif
-		    CY_UNLOCK(info, flags);
-		}
-		break;
-	    case TIOCMSET:
-		if (arg & TIOCM_RTS){
+	    if (set & TIOCM_RTS){
 		    CY_LOCK(info, flags);
 		    cy_writel(&ch_ctrl[channel].rs_control,
                        cy_readl(&ch_ctrl[channel].rs_control) | C_RS_RTS);
 		    CY_UNLOCK(info, flags);
-		}else{
+	    }
+	    if (clear & TIOCM_RTS) {
 		    CY_LOCK(info, flags);
 		    cy_writel(&ch_ctrl[channel].rs_control,
                        cy_readl(&ch_ctrl[channel].rs_control) & ~C_RS_RTS);
 		    CY_UNLOCK(info, flags);
-		}
-		if (arg & TIOCM_DTR){
+	    }
+	    if (set & TIOCM_DTR){
 		    CY_LOCK(info, flags);
 		    cy_writel(&ch_ctrl[channel].rs_control,
                        cy_readl(&ch_ctrl[channel].rs_control) | C_RS_DTR);
@@ -3909,7 +3821,8 @@
 		    printk("cyc:set_modem_info raising Z DTR\n");
 #endif
 		    CY_UNLOCK(info, flags);
-		}else{
+	    }
+	    if (clear & TIOCM_DTR) {
 		    CY_LOCK(info, flags);
 		    cy_writel(&ch_ctrl[channel].rs_control,
                        cy_readl(&ch_ctrl[channel].rs_control) & ~C_RS_DTR);
@@ -3917,10 +3830,6 @@
 		    printk("cyc:set_modem_info clearing Z DTR\n");
 #endif
 		    CY_UNLOCK(info, flags);
-		}
-		break;
-	    default:
-		return -EINVAL;
 	    }
 	}else{
 	    return -ENODEV;
@@ -3935,7 +3844,7 @@
 	CY_UNLOCK(info, flags);
     }
     return 0;
-} /* set_modem_info */
+} /* cy_tiocmset */
 
 /*
  * cy_break() --- routine which turns the break handling on or off
@@ -4242,14 +4151,6 @@
 	case CYGETWAIT:
 	    ret_val = info->closing_wait / (HZ/100);
 	    break;
-        case TIOCMGET:
-            ret_val = get_modem_info(info, (unsigned int *) arg);
-            break;
-        case TIOCMBIS:
-        case TIOCMBIC:
-        case TIOCMSET:
-            ret_val = set_modem_info(info, cmd, (unsigned int *) arg);
-            break;
         case TIOCGSERIAL:
             ret_val = get_serial_info(info, (struct serial_struct *) arg);
             break;
@@ -5429,6 +5330,8 @@
     .break_ctl = cy_break,
     .wait_until_sent = cy_wait_until_sent,
     .read_proc = cyclades_get_proc_info,
+    .tiocmget = cy_tiocmget,
+    .tiocmset = cy_tiocmset,
 };
 
 static int __init
===== drivers/char/ip2main.c 1.42 vs edited =====
--- 1.42/drivers/char/ip2main.c	Tue Sep 30 01:23:52 2003
+++ edited/drivers/char/ip2main.c	Tue Jan 13 16:06:56 2004
@@ -186,6 +186,9 @@
 static void ip2_stop(PTTY);
 static void ip2_start(PTTY);
 static void ip2_hangup(PTTY);
+static int  ip2_tiocmget(struct tty_struct *tty, struct file *file);
+static int  ip2_tiocmset(struct tty_struct *tty, struct file *file,
+			 unsigned int set, unsigned int clear);
 
 static void set_irq(int, int);
 static void ip2_interrupt_bh(i2eBordStrPtr pB);
@@ -466,6 +469,8 @@
 	.start           = ip2_start,
 	.hangup          = ip2_hangup,
 	.read_proc       = ip2_read_proc,
+	.tiocmget	 = ip2_tiocmget,
+	.tiocmset	 = ip2_tiocmset,
 };
 
 /******************************************************************************/
@@ -1951,6 +1956,80 @@
 /* Device Ioctl Section                                                       */
 /******************************************************************************/
 
+static int ip2_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	i2ChanStrPtr pCh = DevTable[tty->index];
+	wait_queue_t wait;
+
+	if (pCh == NULL)
+		return -ENODEV;
+
+/*
+	FIXME - the following code is causing a NULL pointer dereference in
+	2.3.51 in an interrupt handler.  It's suppose to prompt the board
+	to return the DSS signal status immediately.  Why doesn't it do
+	the same thing in 2.2.14?
+*/
+
+/*	This thing is still busted in the 1.2.12 driver on 2.4.x
+	and even hoses the serial console so the oops can be trapped.
+		/\/\|=mhw=|\/\/			*/
+
+#ifdef	ENABLE_DSSNOW
+	i2QueueCommands(PTYPE_BYPASS, pCh, 100, 1, CMD_DSS_NOW);
+
+	init_waitqueue_entry(&wait, current);
+	add_wait_queue(&pCh->dss_now_wait, &wait);
+	set_current_state( TASK_INTERRUPTIBLE );
+
+	serviceOutgoingFifo( pCh->pMyBord );
+
+	schedule();
+
+	set_current_state( TASK_RUNNING );
+	remove_wait_queue(&pCh->dss_now_wait, &wait);
+
+	if (signal_pending(current)) {
+		return -EINTR;
+	}
+#endif
+	return  ((pCh->dataSetOut & I2_RTS) ? TIOCM_RTS : 0)
+	      | ((pCh->dataSetOut & I2_DTR) ? TIOCM_DTR : 0)
+	      | ((pCh->dataSetIn  & I2_DCD) ? TIOCM_CAR : 0)
+	      | ((pCh->dataSetIn  & I2_RI)  ? TIOCM_RNG : 0)
+	      | ((pCh->dataSetIn  & I2_DSR) ? TIOCM_DSR : 0)
+	      | ((pCh->dataSetIn  & I2_CTS) ? TIOCM_CTS : 0);
+}
+
+static int ip2_tiocmset(struct tty_struct *tty, struct file *file,
+			unsigned int set, unsigned int clear)
+{
+	i2ChanStrPtr pCh = DevTable[tty->index];
+
+	if (pCh == NULL)
+		return -ENODEV;
+
+	if (set & TIOCM_RTS) {
+		i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_RTSUP);
+		pCh->dataSetOut |= I2_RTS;
+	}
+	if (set & TIOCM_DTR) {
+		i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_DTRUP);
+		pCh->dataSetOut |= I2_DTR;
+	}
+
+	if (clear & TIOCM_RTS) {
+		i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_RTSDN);
+		pCh->dataSetOut &= ~I2_RTS;
+	}
+	if (clear & TIOCM_DTR) {
+		i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_DTRDN);
+		pCh->dataSetOut &= ~I2_DTR;
+	}
+	serviceOutgoingFifo( pCh->pMyBord );
+	return 0;
+}
+
 /******************************************************************************/
 /* Function:   ip2_ioctl()                                                    */
 /* Parameters: Pointer to tty structure                                       */
@@ -2078,57 +2157,6 @@
 		
 		break;
 
-	case TIOCMGET:
-
-		ip2trace (CHANN, ITRC_IOCTL, 8, 1, rc );
-
-/*
-	FIXME - the following code is causing a NULL pointer dereference in
-	2.3.51 in an interrupt handler.  It's suppose to prompt the board
-	to return the DSS signal status immediately.  Why doesn't it do
-	the same thing in 2.2.14?
-*/
-
-/*	This thing is still busted in the 1.2.12 driver on 2.4.x
-	and even hoses the serial console so the oops can be trapped.
-		/\/\|=mhw=|\/\/			*/
-
-#ifdef	ENABLE_DSSNOW
-		i2QueueCommands(PTYPE_BYPASS, pCh, 100, 1, CMD_DSS_NOW);
-
-		init_waitqueue_entry(&wait, current);
-		add_wait_queue(&pCh->dss_now_wait, &wait);
-		set_current_state( TASK_INTERRUPTIBLE );
-
-		serviceOutgoingFifo( pCh->pMyBord );
-
-		schedule();
-
-		set_current_state( TASK_RUNNING );
-		remove_wait_queue(&pCh->dss_now_wait, &wait);
-
-		if (signal_pending(current)) {
-			return -EINTR;
-		}
-#endif
-		rc = put_user(
-				    ((pCh->dataSetOut & I2_RTS) ? TIOCM_RTS : 0)
-				  | ((pCh->dataSetOut & I2_DTR) ? TIOCM_DTR : 0)
-				  | ((pCh->dataSetIn  & I2_DCD) ? TIOCM_CAR : 0)
-				  | ((pCh->dataSetIn  & I2_RI)  ? TIOCM_RNG : 0)
-				  | ((pCh->dataSetIn  & I2_DSR) ? TIOCM_DSR : 0)
-				  | ((pCh->dataSetIn  & I2_CTS) ? TIOCM_CTS : 0),
-				(unsigned int *) arg);
-		break;
-
-	case TIOCMBIS:
-	case TIOCMBIC:
-	case TIOCMSET:
-		ip2trace (CHANN, ITRC_IOCTL, 9, 0 );
-
-		rc = set_modem_info(pCh, cmd, (unsigned int *) arg);
-		break;
-
 	/*
 	 * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change - mask
 	 * passed in arg for lines of interest (use |'ed TIOCM_RNG/DSR/CD/CTS
@@ -2239,70 +2267,6 @@
 }
 
 /******************************************************************************/
-/* Function:   set_modem_info()                                               */
-/* Parameters: Pointer to channel structure                                   */
-/*             Specific ioctl command                                         */
-/*             Pointer to source for new settings                             */
-/* Returns:    Nothing                                                        */
-/*                                                                            */
-/* Description:                                                               */
-/* This returns the current settings of the dataset signal inputs to the user */
-/* program.                                                                   */
-/******************************************************************************/
-static int
-set_modem_info(i2ChanStrPtr pCh, unsigned cmd, unsigned int *value)
-{
-	int rc;
-	unsigned int arg;
-
-	rc = get_user(arg,value);
-	if (rc)
-		return rc;
-	switch(cmd) {
-	case TIOCMBIS:
-		if (arg & TIOCM_RTS) {
-			i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_RTSUP);
-			pCh->dataSetOut |= I2_RTS;
-		}
-		if (arg & TIOCM_DTR) {
-			i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_DTRUP);
-			pCh->dataSetOut |= I2_DTR;
-		}
-		break;
-	case TIOCMBIC:
-		if (arg & TIOCM_RTS) {
-			i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_RTSDN);
-			pCh->dataSetOut &= ~I2_RTS;
-		}
-		if (arg & TIOCM_DTR) {
-			i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_DTRDN);
-			pCh->dataSetOut &= ~I2_DTR;
-		}
-		break;
-	case TIOCMSET:
-		if ( (arg & TIOCM_RTS) && !(pCh->dataSetOut & I2_RTS) ) {
-			i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_RTSUP);
-			pCh->dataSetOut |= I2_RTS;
-		} else if ( !(arg & TIOCM_RTS) && (pCh->dataSetOut & I2_RTS) ) {
-			i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_RTSDN);
-			pCh->dataSetOut &= ~I2_RTS;
-		}
-		if ( (arg & TIOCM_DTR) && !(pCh->dataSetOut & I2_DTR) ) {
-			i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_DTRUP);
-			pCh->dataSetOut |= I2_DTR;
-		} else if ( !(arg & TIOCM_DTR) && (pCh->dataSetOut & I2_DTR) ) {
-			i2QueueCommands(PTYPE_INLINE, pCh, 100, 1, CMD_DTRDN);
-			pCh->dataSetOut &= ~I2_DTR;
-		}
-		break;
-	default:
-		return -EINVAL;
-	}
-	serviceOutgoingFifo( pCh->pMyBord );
-	return 0;
-}
-
-/******************************************************************************/
 /* Function:   GetSerialInfo()                                                */
 /* Parameters: Pointer to channel structure                                   */
 /*             Pointer to old termios structure                               */
@@ -2964,7 +2928,7 @@
 			rc = put_user(ip2_throttle, pIndex++ );
 			rc = put_user(ip2_unthrottle, pIndex++ );
 			rc = put_user(ip2_ioctl, pIndex++ );
-			rc = put_user(set_modem_info, pIndex++ );
+			rc = put_user(0, pIndex++ );
 			rc = put_user(get_serial_info, pIndex++ );
 			rc = put_user(set_serial_info, pIndex++ );
 			rc = put_user(ip2_set_termios, pIndex++ );
===== drivers/char/istallion.c 1.34 vs edited =====
--- 1.34/drivers/char/istallion.c	Tue Sep 30 01:34:28 2003
+++ edited/drivers/char/istallion.c	Tue Jan 13 16:12:50 2004
@@ -1990,6 +1990,61 @@
 
 /*****************************************************************************/
 
+static int stli_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	stliport_t *portp = tty->driver_data;
+	stlibrd_t *brdp;
+	int rc;
+
+	if (portp == (stliport_t *) NULL)
+		return(-ENODEV);
+	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+		return(0);
+	brdp = stli_brds[portp->brdnr];
+	if (brdp == (stlibrd_t *) NULL)
+		return(0);
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return(-EIO);
+
+	if ((rc = stli_cmdwait(brdp, portp, A_GETSIGNALS,
+			       &portp->asig, sizeof(asysigs_t), 1)) < 0)
+		return(rc);
+
+	return stli_mktiocm(portp->asig.sigvalue);
+}
+
+static int stli_tiocmset(struct tty_struct *tty, struct file *file,
+			 unsigned int set, unsigned int clear)
+{
+	stliport_t *portp = tty->driver_data;
+	stlibrd_t *brdp;
+	int rts = -1, dtr = -1;
+
+	if (portp == (stliport_t *) NULL)
+		return(-ENODEV);
+	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+		return(0);
+	brdp = stli_brds[portp->brdnr];
+	if (brdp == (stlibrd_t *) NULL)
+		return(0);
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return(-EIO);
+
+	if (set & TIOCM_RTS)
+		rts = 1;
+	if (set & TIOCM_DTR)
+		dtr = 1;
+	if (clear & TIOCM_RTS)
+		rts = 0;
+	if (clear & TIOCM_DTR)
+		dtr = 0;
+
+	stli_mkasysigs(&portp->asig, dtr, rts);
+
+	return stli_cmdwait(brdp, portp, A_SETSIGNALS, &portp->asig,
+			    sizeof(asysigs_t), 0);
+}
+
 static int stli_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	stliport_t	*portp;
@@ -2033,43 +2088,6 @@
 				(tty->termios->c_cflag & ~CLOCAL) |
 				(ival ? CLOCAL : 0);
 		break;
-	case TIOCMGET:
-		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
-		    sizeof(unsigned int))) == 0) {
-			if ((rc = stli_cmdwait(brdp, portp, A_GETSIGNALS,
-			    &portp->asig, sizeof(asysigs_t), 1)) < 0)
-				return(rc);
-			lval = stli_mktiocm(portp->asig.sigvalue);
-			put_user(lval, (unsigned int *) arg);
-		}
-		break;
-	case TIOCMBIS:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0) {
-			stli_mkasysigs(&portp->asig,
-				((ival & TIOCM_DTR) ? 1 : -1),
-				((ival & TIOCM_RTS) ? 1 : -1));
-			rc = stli_cmdwait(brdp, portp, A_SETSIGNALS,
-				&portp->asig, sizeof(asysigs_t), 0);
-		}
-		break;
-	case TIOCMBIC:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0) {
-			stli_mkasysigs(&portp->asig,
-				((ival & TIOCM_DTR) ? 0 : -1),
-				((ival & TIOCM_RTS) ? 0 : -1));
-			rc = stli_cmdwait(brdp, portp, A_SETSIGNALS,
-				&portp->asig, sizeof(asysigs_t), 0);
-		}
-		break;
-	case TIOCMSET:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0) {
-			stli_mkasysigs(&portp->asig,
-				((ival & TIOCM_DTR) ? 1 : 0),
-				((ival & TIOCM_RTS) ? 1 : 0));
-			rc = stli_cmdwait(brdp, portp, A_SETSIGNALS,
-				&portp->asig, sizeof(asysigs_t), 0);
-		}
-		break;
 	case TIOCGSERIAL:
 		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
 		    sizeof(struct serial_struct))) == 0)
@@ -5254,6 +5272,8 @@
 	.wait_until_sent = stli_waituntilsent,
 	.send_xchar = stli_sendxchar,
 	.read_proc = stli_readproc,
+	.tiocmget = stli_tiocmget,
+	.tiocmset = stli_tiocmset,
 };
 
 /*****************************************************************************/
===== drivers/char/rio/rio_linux.c 1.32 vs edited =====
--- 1.32/drivers/char/rio/rio_linux.c	Tue Sep 30 01:34:28 2003
+++ edited/drivers/char/rio/rio_linux.c	Tue Jan 13 15:01:40 2004
@@ -728,6 +728,11 @@
       rc = gs_setserial(&PortP->gs, (struct serial_struct *) arg);
     break;
 #if 0
+  /*
+   * note: these IOCTLs no longer reach here.  Use
+   * tiocmset/tiocmget driver methods instead.  The
+   * #if 0 disablement predates this comment.
+   */
   case TIOCMGET:
     if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
                           sizeof(unsigned int))) == 0) {
===== drivers/char/rocket.c 1.36 vs edited =====
--- 1.36/drivers/char/rocket.c	Thu Oct  9 23:13:53 2003
+++ edited/drivers/char/rocket.c	Tue Jan 13 16:28:49 2004
@@ -1216,59 +1216,6 @@
 /********************************************************************************************/
 /*  Here are the routines used by rp_ioctl.  These are all called from exception handlers.  */
 
-static int get_modem_info(struct r_port *info, unsigned int *value)
-{
-	unsigned int control, result, ChanStatus;
-
-	ChanStatus = sGetChanStatusLo(&info->channel);
-
-	control = info->channel.TxControl[3];
-	result = ((control & SET_RTS) ? TIOCM_RTS : 0) | 
-		((control & SET_DTR) ?  TIOCM_DTR : 0) |
-		((ChanStatus & CD_ACT) ? TIOCM_CAR : 0) |
-		(sGetChanRI(&info->channel) ? TIOCM_RNG : 0) |
-		((ChanStatus & DSR_ACT) ? TIOCM_DSR : 0) |
-		((ChanStatus & CTS_ACT) ? TIOCM_CTS : 0);
-
-	if (copy_to_user(value, &result, sizeof (int)))
-		return -EFAULT;
-	return 0;
-}
-
-static int set_modem_info(struct r_port *info, unsigned int cmd,
-			  unsigned int *value)
-{
-	unsigned int arg;
-
-	if (copy_from_user(&arg, value, sizeof (int)))
-		return -EFAULT;
-
-	switch (cmd) {
-	case TIOCMBIS:
-		if (arg & TIOCM_RTS)
-			info->channel.TxControl[3] |= SET_RTS;
-		if (arg & TIOCM_DTR)
-			info->channel.TxControl[3] |= SET_DTR;
-		break;
-	case TIOCMBIC:
-		if (arg & TIOCM_RTS)
-			info->channel.TxControl[3] &= ~SET_RTS;
-		if (arg & TIOCM_DTR)
-			info->channel.TxControl[3] &= ~SET_DTR;
-		break;
-	case TIOCMSET:
-		info->channel.TxControl[3] = ((info->channel.TxControl[3] & ~(SET_RTS | SET_DTR)) | 
-					      ((arg & TIOCM_RTS) ? SET_RTS : 0) | 
-					      ((arg & TIOCM_DTR) ? SET_DTR : 0));
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	sOutDW(info->channel.IndexAddr, *(DWord_t *) & (info->channel.TxControl[0]));
-	return 0;
-}
-
 /*
  *  Returns the state of the serial modem control lines.  These next 2 functions 
  *  are the way kernel versions > 2.5 handle modem control lines rather than IOCTLs.
@@ -1432,12 +1379,6 @@
 		return -ENXIO;
 
 	switch (cmd) {
-	case TIOCMGET:
-		return get_modem_info(info, (unsigned int *) arg);
-	case TIOCMBIS:
-	case TIOCMBIC:
-	case TIOCMSET:
-		return set_modem_info(info, cmd, (unsigned int *) arg);
 	case RCKP_GET_STRUCT:
 		if (copy_to_user((void *) arg, info, sizeof (struct r_port)))
 			return -EFAULT;
===== drivers/char/sh-sci.c 1.25 vs edited =====
--- 1.25/drivers/char/sh-sci.c	Wed Jun 11 20:32:39 2003
+++ edited/drivers/char/sh-sci.c	Tue Jan 13 15:17:23 2004
@@ -859,6 +859,31 @@
 	return retval;
 }
 
+static int sci_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct sci_port *port = tty->driver_data;
+	return sci_getsignals(port);
+}
+
+static int sci_tiocmset(struct tty_struct *tty, struct file *file,
+			unsigned int set, unsigned int clear)
+{
+	struct sci_port *port = tty->driver_data;
+	int rts = -1, dtr = -1;
+
+	if (set & TIOCM_RTS)
+		rts = 1;
+	if (set & TIOCM_DTR)
+		dtr = 1;
+	if (clear & TIOCM_RTS)
+		rts = 0;
+	if (clear & TIOCM_DTR)
+		dtr = 0;
+
+	sci_setsignals(port, dtr, rts);
+	return 0;
+}
+
 static int sci_ioctl(struct tty_struct * tty, struct file * filp, 
                      unsigned int cmd, unsigned long arg)
 {
@@ -889,25 +914,6 @@
 			rc = gs_setserial(&port->gs,
 					  (struct serial_struct *) arg);
 		break;
-	case TIOCMGET:
-		ival = sci_getsignals(port);
-		rc = put_user(ival, (unsigned int *) arg);
-		break;
-	case TIOCMBIS:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0)
-			sci_setsignals(port, ((ival & TIOCM_DTR) ? 1 : -1),
-			                     ((ival & TIOCM_RTS) ? 1 : -1));
-		break;
-	case TIOCMBIC:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0)
-			sci_setsignals(port, ((ival & TIOCM_DTR) ? 0 : -1),
-			                     ((ival & TIOCM_RTS) ? 0 : -1));
-		break;
-	case TIOCMSET:
-		if ((rc = get_user(ival, (unsigned int *)arg)) == 0)
-			sci_setsignals(port, ((ival & TIOCM_DTR) ? 1 : 0),
-			                     ((ival & TIOCM_RTS) ? 1 : 0));
-		break;
 
 	default:
 		rc = -ENOIOCTLCMD;
@@ -991,6 +997,8 @@
 #ifdef CONFIG_PROC_FS
 	.read_proc = sci_read_proc,
 #endif
+	.tiocmget = sci_tiocmget,
+	.tiocmset = sci_tiocmset,
 };
 
 /* ********************************************************************** *
===== drivers/char/stallion.c 1.37 vs edited =====
--- 1.37/drivers/char/stallion.c	Tue Sep 30 01:34:28 2003
+++ edited/drivers/char/stallion.c	Tue Jan 13 15:10:39 2004
@@ -1514,6 +1514,48 @@
 
 /*****************************************************************************/
 
+static int stl_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	stlport_t	*portp;
+
+	if (tty == (struct tty_struct *) NULL)
+		return(-ENODEV);
+	portp = tty->driver_data;
+	if (portp == (stlport_t *) NULL)
+		return(-ENODEV);
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return(-EIO);
+
+	return stl_getsignals(portp);
+}
+
+static int stl_tiocmset(struct tty_struct *tty, struct file *file,
+			unsigned int set, unsigned int clear)
+{
+	stlport_t	*portp;
+	int rts = -1, dtr = -1;
+
+	if (tty == (struct tty_struct *) NULL)
+		return(-ENODEV);
+	portp = tty->driver_data;
+	if (portp == (stlport_t *) NULL)
+		return(-ENODEV);
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return(-EIO);
+
+	if (set & TIOCM_RTS)
+		rts = 1;
+	if (set & TIOCM_DTR)
+		dtr = 1;
+	if (clear & TIOCM_RTS)
+		rts = 0;
+	if (clear & TIOCM_DTR)
+		dtr = 0;
+
+	stl_setsignals(portp, dtr, rts);
+	return 0;
+}
+
 static int stl_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	stlport_t	*portp;
@@ -1553,37 +1595,6 @@
 				(ival ? CLOCAL : 0);
 		}
 		break;
-	case TIOCMGET:
-		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
-		    sizeof(unsigned int))) == 0) {
-			ival = stl_getsignals(portp);
-			put_user(ival, (unsigned int *) arg);
-		}
-		break;
-	case TIOCMBIS:
-		if ((rc = verify_area(VERIFY_READ, (void *) arg,
-		    sizeof(unsigned int))) == 0) {
-			get_user(ival, (unsigned int *) arg);
-			stl_setsignals(portp, ((ival & TIOCM_DTR) ? 1 : -1),
-				((ival & TIOCM_RTS) ? 1 : -1));
-		}
-		break;
-	case TIOCMBIC:
-		if ((rc = verify_area(VERIFY_READ, (void *) arg,
-		    sizeof(unsigned int))) == 0) {
-			get_user(ival, (unsigned int *) arg);
-			stl_setsignals(portp, ((ival & TIOCM_DTR) ? 0 : -1),
-				((ival & TIOCM_RTS) ? 0 : -1));
-		}
-		break;
-	case TIOCMSET:
-		if ((rc = verify_area(VERIFY_READ, (void *) arg,
-		    sizeof(unsigned int))) == 0) {
-			get_user(ival, (unsigned int *) arg);
-			stl_setsignals(portp, ((ival & TIOCM_DTR) ? 1 : 0),
-				((ival & TIOCM_RTS) ? 1 : 0));
-		}
-		break;
 	case TIOCGSERIAL:
 		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
 		    sizeof(struct serial_struct))) == 0)
@@ -3137,6 +3148,8 @@
 	.wait_until_sent = stl_waituntilsent,
 	.send_xchar = stl_sendxchar,
 	.read_proc = stl_readproc,
+	.tiocmget = stl_tiocmget,
+	.tiocmset = stl_tiocmset,
 };
 
 /*****************************************************************************/
===== drivers/char/sx.c 1.42 vs edited =====
--- 1.42/drivers/char/sx.c	Tue Dec 30 08:41:41 2003
+++ edited/drivers/char/sx.c	Tue Jan 13 14:59:30 2004
@@ -1743,6 +1743,32 @@
 }
 
 
+static int sx_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct sx_port *port = tty->driver_data;
+	return sx_getsignals(port);
+}
+
+static int sx_tiocmset(struct tty_struct *tty, struct file *file,
+		       unsigned int set, unsigned int clear)
+{
+	struct sx_port *port = tty->driver_data;
+	int rts = -1, cts = -1;
+
+	if (set & TIOCM_RTS)
+		rts = 1;
+	if (set & TIOCM_DTR)
+		dtr = 1;
+	if (clear & TIOCM_RTS)
+		rts = 0;
+	if (clear & TIOCM_DTR)
+		dtr = 0;
+
+	sx_setsignals(port, dtr, rts);
+	sx_reconfigure_port(port);
+	return 0;
+}
+
 static int sx_ioctl (struct tty_struct * tty, struct file * filp, 
                      unsigned int cmd, unsigned long arg)
 {
@@ -1775,34 +1801,6 @@
 		                      sizeof(struct serial_struct))) == 0)
 			rc = gs_setserial(&port->gs, (struct serial_struct *) arg);
 		break;
-	case TIOCMGET:
-		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
-		                      sizeof(unsigned int))) == 0) {
-			ival = sx_getsignals(port);
-			put_user(ival, (unsigned int *) arg);
-		}
-		break;
-	case TIOCMBIS:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0) {
-			sx_setsignals(port, ((ival & TIOCM_DTR) ? 1 : -1),
-			                     ((ival & TIOCM_RTS) ? 1 : -1));
-			sx_reconfigure_port(port);
-		}
-		break;
-	case TIOCMBIC:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0) {
-			sx_setsignals(port, ((ival & TIOCM_DTR) ? 0 : -1),
-			                     ((ival & TIOCM_RTS) ? 0 : -1));
-			sx_reconfigure_port(port);
-		}
-		break;
-	case TIOCMSET:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0) {
-			sx_setsignals(port, ((ival & TIOCM_DTR) ? 1 : 0),
-			                     ((ival & TIOCM_RTS) ? 1 : 0));
-			sx_reconfigure_port(port);
-		}
-		break;
 	default:
 		rc = -ENOIOCTLCMD;
 		break;
@@ -2217,6 +2215,8 @@
 	.stop = gs_stop,
 	.start = gs_start,
 	.hangup = gs_hangup,
+	.tiocmget = sx_tiocmget,
+	.tiocmset = sx_tiocmset,
 };
 
 static int sx_init_drivers(void)
===== drivers/macintosh/macserial.c 1.30 vs edited =====
--- 1.30/drivers/macintosh/macserial.c	Wed Sep 24 07:15:15 2003
+++ edited/drivers/macintosh/macserial.c	Tue Jan 13 14:55:37 2004
@@ -1777,47 +1777,65 @@
 	return put_user(status,value);
 }
 
-static int get_modem_info(struct mac_serial *info, unsigned int *value)
+static int rs_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	struct mac_serial * info = (struct mac_serial *)tty->driver_data;
 	unsigned char control, status;
-	unsigned int result;
 	unsigned long flags;
 
+#ifdef CONFIG_KGDB
+	if (info->kgdb_channel)
+		return -ENODEV;
+#endif
+	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
+		return -ENODEV;
+
+	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
+	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT)) {
+		if (tty->flags & (1 << TTY_IO_ERROR))
+		    return -EIO;
+	}
+
 	spin_lock_irqsave(&info->lock, flags);
 	control = info->curregs[5];
 	status = read_zsreg(info->zs_channel, 0);
 	spin_unlock_irqrestore(&info->lock, flags);
-	result =  ((control & RTS) ? TIOCM_RTS: 0)
+	return    ((control & RTS) ? TIOCM_RTS: 0)
 		| ((control & DTR) ? TIOCM_DTR: 0)
 		| ((status  & DCD) ? TIOCM_CAR: 0)
 		| ((status  & CTS) ? 0: TIOCM_CTS);
-	return put_user(result,value);
 }
 
-static int set_modem_info(struct mac_serial *info, unsigned int cmd,
-			  unsigned int *value)
+static int rs_tiocmset(struct tty_struct *tty, struct file *file,
+		       unsigned int set, unsigned int clear)
 {
+	struct mac_serial * info = (struct mac_serial *)tty->driver_data;
 	unsigned int arg, bits;
 	unsigned long flags;
 
-	if (get_user(arg, value))
-		return -EFAULT;
-	bits = (arg & TIOCM_RTS? RTS: 0) + (arg & TIOCM_DTR? DTR: 0);
-	spin_lock_irqsave(&info->lock, flags);
-	switch (cmd) {
-	case TIOCMBIS:
-		info->curregs[5] |= bits;
-		break;
-	case TIOCMBIC:
-		info->curregs[5] &= ~bits;
-		break;
-	case TIOCMSET:
-		info->curregs[5] = (info->curregs[5] & ~(DTR | RTS)) | bits;
-		break;
-	default:
-		spin_unlock_irqrestore(&info->lock, flags);
-		return -EINVAL;
+#ifdef CONFIG_KGDB
+	if (info->kgdb_channel)
+		return -ENODEV;
+#endif
+	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
+		return -ENODEV;
+
+	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
+	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT)) {
+		if (tty->flags & (1 << TTY_IO_ERROR))
+		    return -EIO;
 	}
+
+	spin_lock_irqsave(&info->lock, flags);
+	if (set & TIOCM_RTS)
+		info->curregs[5] |= RTS;
+	if (set & TIOCM_DTR)
+		info->curregs[5] |= DTR;
+	if (clear & TIOCM_RTS)
+		info->curregs[5] &= ~RTS;
+	if (clear & TIOCM_DTR)
+		info->curregs[5] &= ~DTR;
+
 	info->pendregs[5] = info->curregs[5];
 	write_zsreg(info->zs_channel, 5, info->curregs[5]);
 	spin_unlock_irqrestore(&info->lock, flags);
@@ -1863,12 +1881,6 @@
 	}
 
 	switch (cmd) {
-		case TIOCMGET:
-			return get_modem_info(info, (unsigned int *) arg);
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			return set_modem_info(info, cmd, (unsigned int *) arg);
 		case TIOCGSERIAL:
 			return get_serial_info(info,
 					(struct serial_struct __user *) arg);
@@ -2488,6 +2500,8 @@
 	.break_ctl = rs_break,
 	.wait_until_sent = rs_wait_until_sent,
 	.read_proc = macserial_read_proc,
+	.tiocmget = rs_tiocmget,
+	.tiocmset = rs_tiocmset,
 };
 
 static int macserial_init(void)
===== drivers/s390/net/ctctty.c 1.20 vs edited =====
--- 1.20/drivers/s390/net/ctctty.c	Mon Oct  6 11:59:26 2003
+++ edited/drivers/s390/net/ctctty.c	Tue Jan 13 14:51:50 2004
@@ -655,14 +655,19 @@
 }
 
 
-static int
-ctc_tty_get_ctc_tty_info(ctc_tty_info * info, uint * value)
+static int ctc_tty_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 	u_char control,
 	 status;
 	uint result;
 	ulong flags;
 
+	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_ioctl"))
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+
 	control = info->mcr;
 	spin_lock_irqsave(&ctc_tty_lock, flags);
 	status = info->msr;
@@ -673,51 +678,31 @@
 	    | ((status & UART_MSR_RI) ? TIOCM_RNG : 0)
 	    | ((status & UART_MSR_DSR) ? TIOCM_DSR : 0)
 	    | ((status & UART_MSR_CTS) ? TIOCM_CTS : 0);
-	put_user(result, (uint *) value);
-	return 0;
+	return result;
 }
 
 static int
-ctc_tty_set_ctc_tty_info(ctc_tty_info * info, uint cmd, uint * value)
+ctc_tty_tiocmset(struct tty_struct *tty, struct file *file,
+		 unsigned int set, unsigned int clear)
 {
-	uint arg;
-	int old_mcr = info->mcr & (UART_MCR_RTS | UART_MCR_DTR);
+	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 
-	get_user(arg, (uint *) value);
-	switch (cmd) {
-		case TIOCMBIS:
-#ifdef CTC_DEBUG_MODEM_IOCTL
-			printk(KERN_DEBUG "%s%d ioctl TIOCMBIS\n", CTC_TTY_NAME,
-			       info->line);
-#endif
-			if (arg & TIOCM_RTS)
-				info->mcr |= UART_MCR_RTS;
-			if (arg & TIOCM_DTR)
-				info->mcr |= UART_MCR_DTR;
-			break;
-		case TIOCMBIC:
-#ifdef CTC_DEBUG_MODEM_IOCTL
-			printk(KERN_DEBUG "%s%d ioctl TIOCMBIC\n", CTC_TTY_NAME,
-			       info->line);
-#endif
-			if (arg & TIOCM_RTS)
-				info->mcr &= ~UART_MCR_RTS;
-			if (arg & TIOCM_DTR)
-				info->mcr &= ~UART_MCR_DTR;
-			break;
-		case TIOCMSET:
-#ifdef CTC_DEBUG_MODEM_IOCTL
-			printk(KERN_DEBUG "%s%d ioctl TIOCMSET\n", CTC_TTY_NAME,
-			       info->line);
-#endif
-			info->mcr = ((info->mcr & ~(UART_MCR_RTS | UART_MCR_DTR))
-				 | ((arg & TIOCM_RTS) ? UART_MCR_RTS : 0)
-			       | ((arg & TIOCM_DTR) ? UART_MCR_DTR : 0));
-			break;
-		default:
-			return -EINVAL;
-	}
-	if ((info->mcr  & (UART_MCR_RTS | UART_MCR_DTR)) != old_mcr)
+	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_ioctl"))
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+
+	if (set & TIOCM_RTS)
+		info->mcr |= UART_MCR_RTS;
+	if (set & TIOCM_DTR)
+		info->mcr |= UART_MCR_DTR;
+
+	if (clear & TIOCM_RTS)
+		info->mcr &= ~UART_MCR_RTS;
+	if (clear & TIOCM_DTR)
+		info->mcr &= ~UART_MCR_DTR;
+
+	if ((set | clear) & (TIOCM_RTS|TIOCM_DTR))
 		ctc_tty_transmit_status(info);
 	return 0;
 }
@@ -775,22 +760,6 @@
 			    ((tty->termios->c_cflag & ~CLOCAL) |
 			     (arg ? CLOCAL : 0));
 			return 0;
-		case TIOCMGET:
-#ifdef CTC_DEBUG_MODEM_IOCTL
-			printk(KERN_DEBUG "%s%d ioctl TIOCMGET\n", CTC_TTY_NAME,
-			       info->line);
-#endif
-			error = verify_area(VERIFY_WRITE, (void *) arg, sizeof(uint));
-			if (error)
-				return error;
-			return ctc_tty_get_ctc_tty_info(info, (uint *) arg);
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			error = verify_area(VERIFY_READ, (void *) arg, sizeof(uint));
-			if (error)
-				return error;
-			return ctc_tty_set_ctc_tty_info(info, cmd, (uint *) arg);
 		case TIOCSERGETLSR:	/* Get line status register */
 #ifdef CTC_DEBUG_MODEM_IOCTL
 			printk(KERN_DEBUG "%s%d ioctl TIOCSERGETLSR\n", CTC_TTY_NAME,
@@ -1142,6 +1111,8 @@
 	.unthrottle = ctc_tty_unthrottle,
 	.set_termios = ctc_tty_set_termios,
 	.hangup = ctc_tty_hangup,
+	.tiocmget = ctc_tty_tiocmget,
+	.tiocmset = ctc_tty_tiocmset,
 };
 
 int
===== drivers/serial/mcfserial.c 1.17 vs edited =====
--- 1.17/drivers/serial/mcfserial.c	Thu Jul  3 02:18:07 2003
+++ edited/drivers/serial/mcfserial.c	Tue Jan 13 13:22:09 2004
@@ -985,6 +985,43 @@
 	local_irq_restore(flags);
 }
 
+static int mcfrs_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct mcf_serial * info = (struct mcf_serial *)tty->driver_data;
+
+	if (serial_paranoia_check(info, tty->name, "mcfrs_ioctl"))
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+
+	return mcfrs_getsignals(info);
+}
+
+static int mcfrs_tiocmset(struct tty_struct *tty, struct file *file,
+			  unsigned int set, unsigned int clear)
+{
+	struct mcf_serial * info = (struct mcf_serial *)tty->driver_data;
+	int rts = -1, dtr = -1;
+
+	if (serial_paranoia_check(info, tty->name, "mcfrs_ioctl"))
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+
+	if (set & TIOCM_RTS)
+		rts = 1;
+	if (set & TIOCM_DTR)
+		dtr = 1;
+	if (clear & TIOCM_RTS)
+		rts = 0;
+	if (clear & TIOCM_DTR)
+		dtr = 0;
+
+	mcfrs_setsignals(info, dtr, rts);
+
+	return 0;
+}
+
 static int mcfrs_ioctl(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg)
 {
@@ -1059,45 +1096,6 @@
 				    info, sizeof(struct mcf_serial));
 			return 0;
 			
-		case TIOCMGET:
-			if ((error = verify_area(VERIFY_WRITE, (void *) arg,
-                            sizeof(unsigned int))))
-                                return(error);
-			val = mcfrs_getsignals(info);
-			put_user(val, (unsigned int *) arg);
-			break;
-
-                case TIOCMBIS:
-			if ((error = verify_area(VERIFY_WRITE, (void *) arg,
-                            sizeof(unsigned int))))
-				return(error);
-
-			get_user(val, (unsigned int *) arg);
-			rts = (val & TIOCM_RTS) ? 1 : -1;
-			dtr = (val & TIOCM_DTR) ? 1 : -1;
-			mcfrs_setsignals(info, dtr, rts);
-			break;
-
-                case TIOCMBIC:
-			if ((error = verify_area(VERIFY_WRITE, (void *) arg,
-                            sizeof(unsigned int))))
-				return(error);
-			get_user(val, (unsigned int *) arg);
-			rts = (val & TIOCM_RTS) ? 0 : -1;
-			dtr = (val & TIOCM_DTR) ? 0 : -1;
-			mcfrs_setsignals(info, dtr, rts);
-			break;
-
-                case TIOCMSET:
-			if ((error = verify_area(VERIFY_WRITE, (void *) arg,
-                            sizeof(unsigned int))))
-				return(error);
-			get_user(val, (unsigned int *) arg);
-			rts = (val & TIOCM_RTS) ? 1 : 0;
-			dtr = (val & TIOCM_DTR) ? 1 : 0;
-			mcfrs_setsignals(info, dtr, rts);
-			break;
-
 #ifdef TIOCSET422
 		case TIOCSET422:
 			get_user(val, (unsigned int *) arg);
@@ -1563,6 +1561,8 @@
 	.start = mcfrs_start,
 	.hangup = mcfrs_hangup,
 	.read_proc = mcfrs_readproc,
+	.tiocmget = mcfrs_tiocmget,
+	.tiocmset = mcfrs_tiocmset,
 };
 
 /* mcfrs_init inits the driver */
===== drivers/usb/serial/ftdi_sio.c 1.55 vs edited =====
--- 1.55/drivers/usb/serial/ftdi_sio.c	Tue Oct 28 13:44:01 2003
+++ edited/drivers/usb/serial/ftdi_sio.c	Tue Jan 13 14:16:51 2004
@@ -580,6 +580,8 @@
 static void ftdi_break_ctl		(struct usb_serial_port *port, int break_state );
 static void ftdi_throttle		(struct usb_serial_port *port);
 static void ftdi_unthrottle		(struct usb_serial_port *port);
+static int  ftdi_tiocmget		(struct usb_serial_port *port, struct file * file);
+static int  ftdi_tiocmset		(struct usb_serial_port *port, struct file * file, unsigned int set, unsigned int clear);
 
 static unsigned short int ftdi_232am_baud_base_to_divisor (int baud, int base);
 static unsigned short int ftdi_232am_baud_to_divisor (int baud);
@@ -608,6 +610,8 @@
 	.break_ctl =		ftdi_break_ctl,
 	.attach =		ftdi_SIO_startup,
 	.shutdown =		ftdi_shutdown,
+	.tiocmget =		ftdi_tiocmget,
+	.tiocmset =		ftdi_tiocmset,
 };
 
 static struct usb_serial_device_type ftdi_8U232AM_device = {
@@ -632,6 +636,8 @@
 	.break_ctl =		ftdi_break_ctl,
 	.attach =		ftdi_8U232AM_startup,
 	.shutdown =		ftdi_shutdown,
+	.tiocmget =		ftdi_tiocmget,
+	.tiocmset =		ftdi_tiocmset,
 };
 
 static struct usb_serial_device_type ftdi_FT232BM_device = {
@@ -656,6 +662,8 @@
 	.break_ctl =		ftdi_break_ctl,
 	.attach =		ftdi_FT232BM_startup,
 	.shutdown =		ftdi_shutdown,
+	.tiocmget =		ftdi_tiocmget,
+	.tiocmset =		ftdi_tiocmset,
 };
 
 static struct usb_serial_device_type ftdi_USB_UIRT_device = {
@@ -680,6 +688,8 @@
 	.break_ctl =		ftdi_break_ctl,
 	.attach =		ftdi_USB_UIRT_startup,
 	.shutdown =		ftdi_shutdown,
+	.tiocmget =		ftdi_tiocmget,
+	.tiocmset =		ftdi_tiocmset,
 };
 
 /* The TIRA1 is based on a  FT232BM which requires a fixed baud rate of 100000
@@ -706,6 +716,8 @@
 	.break_ctl =		ftdi_break_ctl,
 	.attach =		ftdi_HE_TIRA1_startup,
 	.shutdown =		ftdi_shutdown,
+	.tiocmget =		ftdi_tiocmget,
+	.tiocmset =		ftdi_tiocmset,
 };
 
 
@@ -1808,119 +1820,94 @@
 } /* ftdi_termios */
 
 
-static int ftdi_ioctl (struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg)
+static int ftdi_tiocmget (struct usb_serial_port *port, struct file * file)
 {
 	struct usb_serial *serial = port->serial;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
-
-	__u16 urb_value=0; /* Will hold the new flags */
 	char buf[2];
-	int  ret, mask;
-	
-	dbg("%s cmd 0x%04x", __FUNCTION__, cmd);
-
-	/* Based on code from acm.c and others */
-	switch (cmd) {
+	int  ret;
 
-	case TIOCMGET:
-		dbg("%s TIOCMGET", __FUNCTION__);
-		switch (priv->chip_type) {
-		case SIO:
-			/* Request the status from the device */
-			if ((ret = usb_control_msg(serial->dev, 
-						   usb_rcvctrlpipe(serial->dev, 0),
-						   FTDI_SIO_GET_MODEM_STATUS_REQUEST, 
-						   FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE,
-						   0, 0, 
-						   buf, 1, WDR_TIMEOUT)) < 0 ) {
-				err("%s Could not get modem status of device - err: %d", __FUNCTION__,
-				    ret);
-				return(ret);
-			}
-			break;
-		case FT8U232AM:
-		case FT232BM:
-			/* the 8U232AM returns a two byte value (the sio is a 1 byte value) - in the same
-			   format as the data returned from the in point */
-			if ((ret = usb_control_msg(serial->dev, 
-						   usb_rcvctrlpipe(serial->dev, 0),
-						   FTDI_SIO_GET_MODEM_STATUS_REQUEST, 
-						   FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE,
-						   0, 0, 
-						   buf, 2, WDR_TIMEOUT)) < 0 ) {
-				err("%s Could not get modem status of device - err: %d", __FUNCTION__,
-				    ret);
-				return(ret);
-			}
-			break;
-		default:
-			return -EFAULT;
-			break;
+	dbg("%s TIOCMGET", __FUNCTION__);
+	switch (priv->chip_type) {
+	case SIO:
+		/* Request the status from the device */
+		if ((ret = usb_control_msg(serial->dev, 
+					   usb_rcvctrlpipe(serial->dev, 0),
+					   FTDI_SIO_GET_MODEM_STATUS_REQUEST, 
+					   FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE,
+					   0, 0, 
+					   buf, 1, WDR_TIMEOUT)) < 0 ) {
+			err("%s Could not get modem status of device - err: %d", __FUNCTION__,
+			    ret);
+			return(ret);
 		}
-
-		return put_user((buf[0] & FTDI_SIO_DSR_MASK ? TIOCM_DSR : 0) |
-				(buf[0] & FTDI_SIO_CTS_MASK ? TIOCM_CTS : 0) |
-				(buf[0]  & FTDI_SIO_RI_MASK  ? TIOCM_RI  : 0) |
-				(buf[0]  & FTDI_SIO_RLSD_MASK ? TIOCM_CD  : 0) |
-				priv->last_dtr_rts,
-				(unsigned long *) arg);
 		break;
+	case FT8U232AM:
+	case FT232BM:
+		/* the 8U232AM returns a two byte value (the sio is a 1 byte value) - in the same
+		   format as the data returned from the in point */
+		if ((ret = usb_control_msg(serial->dev, 
+					   usb_rcvctrlpipe(serial->dev, 0),
+					   FTDI_SIO_GET_MODEM_STATUS_REQUEST, 
+					   FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE,
+					   0, 0, 
+					   buf, 2, WDR_TIMEOUT)) < 0 ) {
+			err("%s Could not get modem status of device - err: %d", __FUNCTION__,
+			    ret);
+			return(ret);
+		}
+		break;
+	default:
+		return -EFAULT;
+		break;
+	}
+
+	return (buf[0] & FTDI_SIO_DSR_MASK ? TIOCM_DSR : 0) |
+	       (buf[0] & FTDI_SIO_CTS_MASK ? TIOCM_CTS : 0) |
+	       (buf[0] & FTDI_SIO_RI_MASK  ? TIOCM_RI  : 0) |
+	       (buf[0] & FTDI_SIO_RLSD_MASK ? TIOCM_CD  : 0) |
+	       priv->last_dtr_rts;
+}
+
+static int ftdi_tiocmset (struct usb_serial_port *port, struct file * file, unsigned int set, unsigned int clear)
+{
+	struct usb_serial *serial = port->serial;
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	__u16 urb_value;
+	int  ret;
+
+	dbg("%s TIOCMSET/BIC/BIS", __FUNCTION__);
 
-	case TIOCMSET: /* Turns on and off the lines as specified by the mask */
-		dbg("%s TIOCMSET", __FUNCTION__);
-		if (get_user(mask, (unsigned long *) arg))
-			return -EFAULT;
-		urb_value = ((mask & TIOCM_DTR) ? HIGH : LOW);
+	if ((set | clear) & TIOCM_DTR) {
+		urb_value = (set & TIOCM_DTR) ? HIGH : LOW;
 		if ((ret = set_dtr(port, urb_value)) < 0){
-			err("Error from DTR set urb (TIOCMSET)");
+			err("Error from DTR set urb (TIOCM)");
 			return(ret);
 		}
-		urb_value = ((mask & TIOCM_RTS) ? HIGH : LOW);
+	}
+	if ((set | clear) & TIOCM_RTS) {
+		urb_value = (set & TIOCM_RTS) ? HIGH : LOW;
 		if ((ret = set_rts(port, urb_value)) < 0){
-			err("Error from RTS set urb (TIOCMSET)");
+			err("Error from RTS set urb (TIOCM)");
 			return(ret);
 		}
-		return(0);
-		break;
-					
-	case TIOCMBIS: /* turns on (Sets) the lines as specified by the mask */
-		dbg("%s TIOCMBIS", __FUNCTION__);
- 	        if (get_user(mask, (unsigned long *) arg))
-			return -EFAULT;
-  	        if (mask & TIOCM_DTR){
-			if ((ret = set_dtr(port, HIGH)) < 0) {
-				err("Urb to set DTR failed");
-				return(ret);
-			}
-		}
-		if (mask & TIOCM_RTS) {
-			if ((ret = set_rts(port, HIGH)) < 0){
-				err("Urb to set RTS failed");
-				return(ret);
-			}
-		}
-		return(0);
-		break;
+	}
+	return(0);
+}
 
-	case TIOCMBIC: /* turns off (Clears) the lines as specified by the mask */
-		dbg("%s TIOCMBIC", __FUNCTION__);
- 	        if (get_user(mask, (unsigned long *) arg))
-			return -EFAULT;
-  	        if (mask & TIOCM_DTR){
-			if ((ret = set_dtr(port, LOW)) < 0){
-				err("Urb to unset DTR failed");
-				return(ret);
-			}
-		}	
-		if (mask & TIOCM_RTS) {
-			if ((ret = set_rts(port, LOW)) < 0){
-				err("Urb to unset RTS failed");
-				return(ret);
-			}
-		}
-		return(0);
-		break;
+static int ftdi_ioctl (struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg)
+{
+	struct usb_serial *serial = port->serial;
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
+	__u16 urb_value=0; /* Will hold the new flags */
+	char buf[2];
+	int  ret, mask;
+	
+	dbg("%s cmd 0x%04x", __FUNCTION__, cmd);
+
+	/* Based on code from acm.c and others */
+	switch (cmd) {
 		/*
 		 * I had originally implemented TCSET{A,S}{,F,W} and
 		 * TCGET{A,S} here separately, however when testing I

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
