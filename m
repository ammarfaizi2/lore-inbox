Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269680AbUICSNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269680AbUICSNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269706AbUICSDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:03:40 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:22631 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269680AbUICSAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:00:12 -0400
Subject: [PATCH] 2.6.9-rc1-bk9 synclink.c kernel janitor changes
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1094234410.4313.6.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Sep 2004 13:00:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel janitor changes:

* use kernel provided min/max
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Paul Fulghum <paulkf@microgate.com>

* use kernel provided msecs_to_jiffies
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Paul Fulghum <paulkf@microgate.com>

Please apply.
 
--
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.9/drivers/char/synclink.c	2004-09-02 11:23:59.000000000 -0500
+++ linux-2.6.9-mg/drivers/char/synclink.c	2004-09-03 12:49:12.952860120 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.28 2004/08/11 19:30:01 paulkf Exp $
+ * $Id: synclink.c,v 4.30 2004/09/03 15:46:40 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -851,8 +851,6 @@
 static int mgsl_wait_event(struct mgsl_struct * info, int __user *mask);
 static int mgsl_loopmode_send_done( struct mgsl_struct * info );
 
-#define jiffies_from_ms(a) ((((a) * HZ)/1000)+1)
-
 /* set non-zero on successful registration with PCI subsystem */
 static int pci_registered;
 
@@ -899,7 +897,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.28 $";
+static char *driver_version = "$Revision: 4.30 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -930,10 +928,6 @@
 static void mgsl_change_params(struct mgsl_struct *info);
 static void mgsl_wait_until_sent(struct tty_struct *tty, int timeout);
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /*
  * 1st function defined in .text section. Calling this function in
  * init_module() followed by a breakpoint allows a remote debugger
@@ -2246,8 +2240,8 @@
 		if (from_user) {
 			down(&tmp_buf_sem);
 			while (1) {
-				c = MIN(count,
-					MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+				c = min_t(int, count,
+					min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 					    SERIAL_XMIT_SIZE - info->xmit_head));
 				if (c <= 0)
 					break;
@@ -2260,7 +2254,7 @@
 					break;
 				}
 				spin_lock_irqsave(&info->irq_spinlock,flags);
-				c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+				c = min_t(int, c, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 					       SERIAL_XMIT_SIZE - info->xmit_head));
 				memcpy(info->xmit_buf + info->xmit_head, tmp_buf, c);
 				info->xmit_head = ((info->xmit_head + c) &
@@ -2275,8 +2269,8 @@
 		} else {
 			while (1) {
 				spin_lock_irqsave(&info->irq_spinlock,flags);
-				c = MIN(count,
-					MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+				c = min_t(int, count,
+					min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 					    SERIAL_XMIT_SIZE - info->xmit_head));
 				if (c <= 0) {
 					spin_unlock_irqrestore(&info->irq_spinlock,flags);
@@ -3314,7 +3308,7 @@
 		char_time = 1;
 		
 	if (timeout)
-		char_time = MIN(char_time, timeout);
+		char_time = min_t(unsigned long, char_time, timeout);
 		
 	if ( info->params.mode == MGSL_MODE_HDLC ||
 		info->params.mode == MGSL_MODE_RAW ) {
@@ -4175,7 +4169,7 @@
 				info->get_tx_holding_index=0;
 
 			/* restart transmit timer */
-			mod_timer(&info->tx_timer, jiffies + jiffies_from_ms(5000));
+			mod_timer(&info->tx_timer, jiffies + msecs_to_jiffies(5000));
 
 			ret = 1;
 		}
@@ -5804,7 +5798,7 @@
 			
 			usc_TCmd( info, TCmd_SendFrame );
 			
-			info->tx_timer.expires = jiffies + jiffies_from_ms(5000);
+			info->tx_timer.expires = jiffies + msecs_to_jiffies(5000);
 			add_timer(&info->tx_timer);	
 		}
 		info->tx_active = 1;
@@ -6767,7 +6761,7 @@
 			
 	if ( debug_level >= DEBUG_LEVEL_DATA )
 		mgsl_trace_block(info,info->rx_buffer_list[StartIndex].virt_addr,
-			MIN(framesize,DMABUFFERSIZE),0);	
+			min_t(int, framesize, DMABUFFERSIZE),0);
 		
 	if (framesize) {
 		if ( ( (info->params.crc_type & HDLC_CRC_RETURN_EX) &&
@@ -6982,7 +6976,7 @@
 
 		if ( debug_level >= DEBUG_LEVEL_DATA )
 			mgsl_trace_block(info,info->rx_buffer_list[CurrentIndex].virt_addr,
-				MIN(framesize,DMABUFFERSIZE),0);
+				min_t(int, framesize, DMABUFFERSIZE),0);
 
 		if (framesize) {
 			/* copy dma buffer(s) to contiguous intermediate buffer */
@@ -7042,7 +7036,7 @@
 	DMABUFFERENTRY *pBufEntry;
 	
 	if ( debug_level >= DEBUG_LEVEL_DATA )
-		mgsl_trace_block(info,Buffer, MIN(BufferSize,DMABUFFERSIZE), 1);	
+		mgsl_trace_block(info,Buffer, min_t(int, BufferSize, DMABUFFERSIZE), 1);
 
 	if (info->params.flags & HDLC_FLAG_HDLC_LOOPMODE) {
 		/* set CMR:13 to start transmit when
@@ -7200,7 +7194,7 @@
 	EndTime=100;
 	while( EndTime-- && !info->irq_occurred ) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(jiffies_from_ms(10));
+		schedule_timeout(msecs_to_jiffies(10));
 	}
 	
 	spin_lock_irqsave(&info->irq_spinlock,flags);
@@ -7339,7 +7333,7 @@
 	/*************************************************************/
 
 	/* Wait 100ms for interrupt. */
-	EndTime = jiffies + jiffies_from_ms(100);
+	EndTime = jiffies + msecs_to_jiffies(100);
 
 	for(;;) {
 		if (time_after(jiffies, EndTime)) {
@@ -7395,7 +7389,7 @@
 	/**********************************/
 	
 	/* Wait 100ms */
-	EndTime = jiffies + jiffies_from_ms(100);
+	EndTime = jiffies + msecs_to_jiffies(100);
 
 	for(;;) {
 		if (time_after(jiffies, EndTime)) {
@@ -7437,7 +7431,7 @@
 		/******************************/
 
 		/* Wait 100ms */
-		EndTime = jiffies + jiffies_from_ms(100);
+		EndTime = jiffies + msecs_to_jiffies(100);
 
 		/* While timer not expired wait for transmit complete */
 
@@ -7468,7 +7462,7 @@
 		/* WAIT FOR RECEIVE COMPLETE */
 
 		/* Wait 100ms */
-		EndTime = jiffies + jiffies_from_ms(100);
+		EndTime = jiffies + msecs_to_jiffies(100);
 
 		/* Wait for 16C32 to write receive status to buffer entry. */
 		status=info->rx_buffer_list[0].status;



