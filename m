Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUIWUhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUIWUhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUIWUg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:36:27 -0400
Received: from baikonur.stro.at ([213.239.196.228]:5787 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S266895AbUIWU2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:28:30 -0400
Subject: [patch 1/4]  removing check_region from drivers/char/esp.c
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, kristenc@cs.pdx.edu
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:28:26 +0200
Message-ID: <E1CAaCY-0000ZR-DC@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



use request_region, check it's return value
remove check_region
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/char/esp.c |   49 +++++------------------------
 1 files changed, 10 insertions(+), 39 deletions(-)

diff -puN drivers/char/esp.c~fix-check_region-esp drivers/char/esp.c
--- linux-2.6.9-rc2-bk7/drivers/char/esp.c~fix-check_region-esp	2004-09-21 20:47:49.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/esp.c	2004-09-21 20:47:49.000000000 +0200
@@ -70,6 +70,7 @@
 
 #define NR_PORTS 64	/* maximum number of ports */
 #define NR_PRIMARY 8	/* maximum number of primary ports */
+#define REGION_SIZE 8   /* size of io region to request */
 
 /* The following variables can be set by giving module options */
 static int irq[NR_PRIMARY];	/* IRQ for each base port */
@@ -2351,19 +2352,21 @@ static _INLINE_ void show_serial_version
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
 
@@ -2379,19 +2382,6 @@ static _INLINE_ int autoconfig(struct es
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
@@ -2404,6 +2394,8 @@ static _INLINE_ int autoconfig(struct es
 			serial_out(info, UART_ESI_CMD2, 0x00);
 		}
 	}
+	if (!port_detected)
+		release_region(info->port, REGION_SIZE);
 
 	restore_flags(flags);
 	return (port_detected);
@@ -2437,7 +2429,6 @@ static struct tty_operations esp_ops = {
 int __init espserial_init(void)
 {
 	int i, offset;
-	int region_start;
 	struct esp_struct * info;
 	struct esp_struct *last_primary = NULL;
 	int esp[] = {0x100,0x140,0x180,0x200,0x240,0x280,0x300,0x380};
@@ -2523,7 +2514,7 @@ int __init espserial_init(void)
 		info->irq = irq[i];
 		info->line = (i * 8) + (offset / 8);
 
-		if (!autoconfig(info, &region_start)) {
+		if (!autoconfig(info)) {
 			i++;
 			offset = 0;
 			continue;
@@ -2599,7 +2590,6 @@ static void __exit espserial_exit(void) 
 {
 	unsigned long flags;
 	int e1;
-	unsigned int region_start, region_end;
 	struct esp_struct *temp_async;
 	struct esp_pio_buffer *pio_buf;
 
@@ -2614,27 +2604,8 @@ static void __exit espserial_exit(void) 
 
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
_
