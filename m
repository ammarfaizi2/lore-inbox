Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269724AbUICSRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269724AbUICSRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269710AbUICSPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:15:52 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:40551 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269705AbUICSDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:03:07 -0400
Subject: [PATCH] 2.6.9-rc-bk9 synclinkmp.c kernel janitor changes
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1094234585.4313.10.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Sep 2004 13:03:05 -0500
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

--- linux-2.6.9/drivers/char/synclinkmp.c	2004-09-02 11:23:59.000000000 -0500
+++ linux-2.6.9-mg/drivers/char/synclinkmp.c	2004-09-03 12:48:55.334247831 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.29 2004/08/27 20:06:41 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.30 2004/09/03 15:46:41 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -453,8 +453,6 @@
 #define CRCE	BIT2
 
 
-#define jiffies_from_ms(a) ((((a) * HZ)/1000)+1)
-
 /*
  * Global linked list of SyncLink devices
  */
@@ -489,7 +487,7 @@
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.29 $";
+static char *driver_version = "$Revision: 4.30 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -515,10 +513,6 @@
 /* number of characters left in xmit buffer before we ask for more */
 #define WAKEUP_CHARS 256
 
-#ifndef MIN
-#define MIN(a,b) ((a) < (b) ? (a) : (b))
-#endif
-
 
 /* tty callbacks */
 
@@ -1000,8 +994,8 @@
 	}
 
 	for (;;) {
-		c = MIN(count,
-			MIN(info->max_frame_size - info->tx_count - 1,
+		c = min_t(int, count,
+			min(info->max_frame_size - info->tx_count - 1,
 			    info->max_frame_size - info->tx_put));
 		if (c <= 0)
 			break;
@@ -1144,7 +1138,7 @@
 		char_time = 1;
 
 	if (timeout)
-		char_time = MIN(char_time, timeout);
+		char_time = min_t(unsigned long, char_time, timeout);
 
 	if ( info->params.mode == MGSL_MODE_HDLC ) {
 		while (info->tx_active) {
@@ -2763,7 +2757,7 @@
 
 	change_params(info);
 
-	info->status_timer.expires = jiffies + jiffies_from_ms(10);
+	info->status_timer.expires = jiffies + msecs_to_jiffies(10);
 	add_timer(&info->status_timer);
 
 	if (info->tty)
@@ -4321,7 +4315,7 @@
 			write_reg(info, TXDMA + DIR, 0x40);		/* enable Tx DMA interrupts (EOM) */
 			write_reg(info, TXDMA + DSR, 0xf2);		/* clear Tx DMA IRQs, enable Tx DMA */
 	
-			info->tx_timer.expires = jiffies + jiffies_from_ms(5000);
+			info->tx_timer.expires = jiffies + msecs_to_jiffies(5000);
 			add_timer(&info->tx_timer);
 		}
 		else {
@@ -5026,7 +5020,7 @@
 
 	if ( debug_level >= DEBUG_LEVEL_DATA )
 		trace_block(info,info->rx_buf_list_ex[StartIndex].virt_addr,
-			MIN(framesize,SCABUFSIZE),0);
+			min_t(int, framesize,SCABUFSIZE),0);
 
 	if (framesize) {
 		if (framesize > info->max_frame_size)
@@ -5041,7 +5035,7 @@
 			info->icount.rxok++;
 
 			while(copy_count) {
-				int partial_count = MIN(copy_count,SCABUFSIZE);
+				int partial_count = min(copy_count,SCABUFSIZE);
 				memcpy( ptmp,
 					info->rx_buf_list_ex[index].virt_addr,
 					partial_count );
@@ -5098,14 +5092,14 @@
 	SCADESC_EX *desc_ex;
 
 	if ( debug_level >= DEBUG_LEVEL_DATA )
-		trace_block(info,buf, MIN(count,SCABUFSIZE), 1);
+		trace_block(info,buf, min_t(int, count,SCABUFSIZE), 1);
 
 	/* Copy source buffer to one or more DMA buffers, starting with
 	 * the first transmit dma buffer.
 	 */
 	for(i=0;;)
 	{
-		copy_count = MIN(count,SCABUFSIZE);
+		copy_count = min_t(unsigned short,count,SCABUFSIZE);
 
 		desc = &info->tx_buf_list[i];
 		desc_ex = &info->tx_buf_list_ex[i];
@@ -5209,7 +5203,7 @@
 	timeout=100;
 	while( timeout-- && !info->irq_occurred ) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(jiffies_from_ms(10));
+		schedule_timeout(msecs_to_jiffies(10));
 	}
 
 	spin_lock_irqsave(&info->lock,flags);
@@ -5360,7 +5354,7 @@
 	/* Set a timeout for waiting for interrupt. */
 	for ( timeout = 100; timeout; --timeout ) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(jiffies_from_ms(10));
+		schedule_timeout(msecs_to_jiffies(10));
 
 		if (rx_get_frame(info)) {
 			rc = TRUE;
@@ -5616,7 +5610,7 @@
 
 	info->status_timer.data = (unsigned long)info;
 	info->status_timer.function = status_timeout;
-	info->status_timer.expires = jiffies + jiffies_from_ms(10);
+	info->status_timer.expires = jiffies + msecs_to_jiffies(10);
 	add_timer(&info->status_timer);
 }
 



