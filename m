Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUFURa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUFURa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 13:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266346AbUFURa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 13:30:56 -0400
Received: from baikonur.stro.at ([213.239.196.228]:49595 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266345AbUFURa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 13:30:28 -0400
Date: Mon, 21 Jun 2004 19:30:28 +0200
From: maximilian attems <janitor@sternwelten.at>
To: arobinso@nyx.net
Cc: linux-kernel@vger.kernel.org
Subject: [patch-kj] removing check_region from drivers/char/esp.c
Message-ID: <20040621173028.GG1545@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



From: Kristen Carlson <kristenc@cs.pdx.edu>
use request_region, check it's return value

please apply
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.7-max/drivers/char/esp.c |   49 +++++++------------------------------
 1 files changed, 10 insertions(+), 39 deletions(-)

diff -puN drivers/char/esp.c~fix-check_region-esp drivers/char/esp.c
--- linux-2.6.7/drivers/char/esp.c~fix-check_region-esp	2004-06-18 10:13:29.000000000 +0200
+++ linux-2.6.7-max/drivers/char/esp.c	2004-06-18 10:13:29.000000000 +0200
@@ -70,6 +70,7 @@
 
 #define NR_PORTS 64	/* maximum number of ports */
 #define NR_PRIMARY 8	/* maximum number of primary ports */
+#define REGION_SIZE 8   /* size of io region to request */
 
 /* The following variables can be set by giving module options */
 static int irq[NR_PRIMARY];	/* IRQ for each base port */
@@ -2359,19 +2360,21 @@ static _INLINE_ void show_serial_version
  * This routine is called by espserial_init() to initialize a specific serial
  * port.
  */
-static _INLINE_ int autoconfig(struct esp_struct * info, int *region_start)
+static _INLINE_ int autoconfig(struct esp_struct * info)
 {
 	int port_detected = 0;
 	unsigned long flags;
 
+	if (!request_region(info->port, REGION_SIZE, "esp serial"))
+		return -EIO;
+
 	save_flags(flags); cli();
 	
 	/*
 	 * Check for ESP card
 	 */
 
-	if (!check_region(info->port, 8) && 
-	    serial_in(info, UART_ESI_BASE) == 0xf3) {
+	if (serial_in(info, UART_ESI_BASE) == 0xf3) {
 		serial_out(info, UART_ESI_CMD1, 0x00);
 		serial_out(info, UART_ESI_CMD1, 0x01);
 
@@ -2387,19 +2390,6 @@ static _INLINE_ int autoconfig(struct es
 					info->irq = 4;
 			}
 
-			if (ports && (ports->port == (info->port - 8))) {
-				release_region(*region_start,
-					       info->port - *region_start);
-			} else
-				*region_start = info->port;
-
-			if (!request_region(*region_start,
-				       info->port - *region_start + 8,
-				       "esp serial"))
-			{
-				restore_flags(flags);
-				return -EIO;
-			}
 
 			/* put card in enhanced mode */
 			/* this prevents access through */
@@ -2412,6 +2402,8 @@ static _INLINE_ int autoconfig(struct es
 			serial_out(info, UART_ESI_CMD2, 0x00);
 		}
 	}
+	if (!port_detected)
+		release_region(info->port, REGION_SIZE);
 
 	restore_flags(flags);
 	return (port_detected);
@@ -2445,7 +2437,6 @@ static struct tty_operations esp_ops = {
 int __init espserial_init(void)
 {
 	int i, offset;
-	int region_start;
 	struct esp_struct * info;
 	struct esp_struct *last_primary = 0;
 	int esp[] = {0x100,0x140,0x180,0x200,0x240,0x280,0x300,0x380};
@@ -2531,7 +2522,7 @@ int __init espserial_init(void)
 		info->irq = irq[i];
 		info->line = (i * 8) + (offset / 8);
 
-		if (!autoconfig(info, &region_start)) {
+		if (!autoconfig(info)) {
 			i++;
 			offset = 0;
 			continue;
@@ -2607,7 +2598,6 @@ static void __exit espserial_exit(void) 
 {
 	unsigned long flags;
 	int e1;
-	unsigned int region_start, region_end;
 	struct esp_struct *temp_async;
 	struct esp_pio_buffer *pio_buf;
 
@@ -2622,27 +2612,8 @@ static void __exit espserial_exit(void) 
 
 	while (ports) {
 		if (ports->port) {
-			region_start = region_end = ports->port;
-			temp_async = ports;
-
-			while (temp_async) {
-				if ((region_start - temp_async->port) == 8) {
-					region_start = temp_async->port;
-					temp_async->port = 0;
-					temp_async = ports;
-				} else if ((temp_async->port - region_end)
-					   == 8) {
-					region_end = temp_async->port;
-					temp_async->port = 0;
-					temp_async = ports;
-				} else
-					temp_async = temp_async->next_port;
-			}
-			
-			release_region(region_start,
-				       region_end - region_start + 8);
+			release_region(ports->port, REGION_SIZE);
 		}
-
 		temp_async = ports->next_port;
 		kfree(ports);
 		ports = temp_async;
