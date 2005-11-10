Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVKJA57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVKJA57 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVKJA56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:57:58 -0500
Received: from tim.rpsys.net ([194.106.48.114]:40415 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751170AbVKJA55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:57:57 -0500
Subject: [MTD patch] Make sharp.c compile
From: Richard Purdie <rpurdie@rpsys.net>
To: dwmw2@infradead.org, Andrew Morton <akpm@osdl.org>
Cc: Josh Boyer <jwboyer@gmail.com>, Russell King <rmk@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
In-Reply-To: <20051013190724.GC1876@elf.ucw.cz>
References: <20051012223036.GA3610@elf.ucw.cz>
	 <1129158864.8340.20.camel@localhost.localdomain>
	 <20051012233917.GA2890@elf.ucw.cz>
	 <1129194049.8238.26.camel@localhost.localdomain>
	 <20051013190724.GC1876@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 00:57:10 +0000
Message-Id: <1131584230.8506.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[MTD] Update the pre-CFI Sharp driver sharps.c so it compiles.
map_read32 / map_write32 no longer exist in the kernel so the driver is
totally broken as it stands. The replacement functions use different
parameters resulting in the other changes.

Change collie to use this driver until someone works out why the cfi
driver fails on that machine.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Tested-by: Pavel Machek <pavel@suse.cz>

Index: linux-2.6.14/arch/arm/mach-sa1100/collie.c
===================================================================
--- linux-2.6.14.orig/arch/arm/mach-sa1100/collie.c	2005-11-09 19:20:08.000000000 +0000
+++ linux-2.6.14/arch/arm/mach-sa1100/collie.c	2005-11-09 19:25:40.000000000 +0000
@@ -119,7 +119,7 @@
 }
 
 static struct flash_platform_data collie_flash_data = {
-	.map_name	= "cfi_probe",
+	.map_name	= "sharp",
 	.set_vpp	= collie_set_vpp,
 	.parts		= collie_partitions,
 	.nr_parts	= ARRAY_SIZE(collie_partitions),
Index: linux-2.6.14/drivers/mtd/chips/sharp.c
===================================================================
--- linux-2.6.14.orig/drivers/mtd/chips/sharp.c	2005-11-09 19:20:10.000000000 +0000
+++ linux-2.6.14/drivers/mtd/chips/sharp.c	2005-11-09 20:26:15.000000000 +0000
@@ -160,22 +160,28 @@
 	return mtd;
 }
 
+static inline void sharp_send_cmd(struct map_info *map, unsigned long cmd, unsigned long adr)
+{
+	map_word map_cmd;
+	map_cmd.x[0] = cmd;
+	map_write(map, map_cmd, adr);
+}
+
 static int sharp_probe_map(struct map_info *map,struct mtd_info *mtd)
 {
-	unsigned long tmp;
+	map_word tmp, read0, read4;
 	unsigned long base = 0;
-	u32 read0, read4;
 	int width = 4;
 
-	tmp = map_read32(map, base+0);
+	tmp = map_read(map, base+0);
 
-	map_write32(map, CMD_READ_ID, base+0);
+	sharp_send_cmd(map, CMD_READ_ID, base+0);
 
-	read0=map_read32(map, base+0);
-	read4=map_read32(map, base+4);
-	if(read0 == 0x89898989){
+	read0 = map_read(map, base+0);
+	read4 = map_read(map, base+4);
+	if(read0.x[0] == 0x89898989){
 		printk("Looks like sharp flash\n");
-		switch(read4){
+		switch(read4.x[0]){
 		case 0xaaaaaaaa:
 		case 0xa0a0a0a0:
 			/* aa - LH28F016SCT-L95 2Mx8, 32 64k blocks*/
@@ -197,16 +203,16 @@
 			return width;
 #endif
 		default:
-			printk("Sort-of looks like sharp flash, 0x%08x 0x%08x\n",
-				read0,read4);
+			printk("Sort-of looks like sharp flash, 0x%08lx 0x%08lx\n",
+				read0.x[0], read4.x[0]);
 		}
-	}else if((map_read32(map, base+0) == CMD_READ_ID)){
+	}else if((map_read(map, base+0).x[0] == CMD_READ_ID)){
 		/* RAM, probably */
 		printk("Looks like RAM\n");
-		map_write32(map, tmp, base+0);
+		map_write(map, tmp, base+0);
 	}else{
-		printk("Doesn't look like sharp flash, 0x%08x 0x%08x\n",
-			read0,read4);
+		printk("Doesn't look like sharp flash, 0x%08lx 0x%08lx\n",
+			read0.x[0], read4.x[0]);
 	}
 
 	return 0;
@@ -215,7 +221,8 @@
 /* This function returns with the chip->mutex lock held. */
 static int sharp_wait(struct map_info *map, struct flchip *chip)
 {
-	int status, i;
+	int i;
+	map_word status;
 	unsigned long timeo = jiffies + HZ;
 	DECLARE_WAITQUEUE(wait, current);
 	int adr = 0;
@@ -225,12 +232,12 @@
 
 	switch(chip->state){
 	case FL_READY:
-		map_write32(map,CMD_READ_STATUS,adr);
+		sharp_send_cmd(map, CMD_READ_STATUS, adr);
 		chip->state = FL_STATUS;
 	case FL_STATUS:
 		for(i=0;i<100;i++){
-			status = map_read32(map,adr);
-			if((status & SR_READY)==SR_READY)
+			status = map_read(map, adr);
+			if((status.x[0] & SR_READY)==SR_READY)
 				break;
 			udelay(1);
 		}
@@ -254,7 +261,7 @@
 		goto retry;
 	}
 
-	map_write32(map,CMD_RESET, adr);
+	sharp_send_cmd(map, CMD_RESET, adr);
 
 	chip->state = FL_READY;
 
@@ -351,37 +358,39 @@
 	int timeo;
 	int try;
 	int i;
-	int status = 0;
+	map_word data, status;
 
+	status.x[0] = 0;
 	ret = sharp_wait(map,chip);
 
 	for(try=0;try<10;try++){
-		map_write32(map,CMD_BYTE_WRITE,adr);
+		sharp_send_cmd(map, CMD_BYTE_WRITE, adr);
 		/* cpu_to_le32 -> hack to fix the writel be->le conversion */
-		map_write32(map,cpu_to_le32(datum),adr);
+		data.x[0] = cpu_to_le32(datum);
+		map_write(map, data, adr);
 
 		chip->state = FL_WRITING;
 
 		timeo = jiffies + (HZ/2);
 
-		map_write32(map,CMD_READ_STATUS,adr);
+		sharp_send_cmd(map, CMD_READ_STATUS, adr);
 		for(i=0;i<100;i++){
-			status = map_read32(map,adr);
-			if((status & SR_READY)==SR_READY)
+			status = map_read(map, adr);
+			if((status.x[0] & SR_READY) == SR_READY)
 				break;
 		}
 		if(i==100){
 			printk("sharp: timed out writing\n");
 		}
 
-		if(!(status&SR_ERRORS))
+		if(!(status.x[0] & SR_ERRORS))
 			break;
 
-		printk("sharp: error writing byte at addr=%08lx status=%08x\n",adr,status);
+		printk("sharp: error writing byte at addr=%08lx status=%08lx\n", adr, status.x[0]);
 
-		map_write32(map,CMD_CLEAR_STATUS,adr);
+		sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);
 	}
-	map_write32(map,CMD_RESET,adr);
+	sharp_send_cmd(map, CMD_RESET, adr);
 	chip->state = FL_READY;
 
 	wake_up(&chip->wq);
@@ -434,18 +443,18 @@
 {
 	int ret;
 	unsigned long timeo;
-	int status;
+	map_word status;
 	DECLARE_WAITQUEUE(wait, current);
 
-	map_write32(map,CMD_READ_STATUS,adr);
-	status = map_read32(map,adr);
+	sharp_send_cmd(map, CMD_READ_STATUS, adr);
+	status = map_read(map, adr);
 
 	timeo = jiffies + HZ;
 
 	while(time_before(jiffies, timeo)){
-		map_write32(map,CMD_READ_STATUS,adr);
-		status = map_read32(map,adr);
-		if((status & SR_READY)==SR_READY){
+		sharp_send_cmd(map, CMD_READ_STATUS, adr);
+		status = map_read(map, adr);
+		if((status.x[0] & SR_READY)==SR_READY){
 			ret = 0;
 			goto out;
 		}
@@ -476,7 +485,7 @@
 {
 	int ret;
 	//int timeo;
-	int status;
+	map_word status;
 	//int i;
 
 //printk("sharp_erase_oneblock()\n");
@@ -486,26 +495,26 @@
 	sharp_unlock_oneblock(map,chip,adr);
 #endif
 
-	map_write32(map,CMD_BLOCK_ERASE_1,adr);
-	map_write32(map,CMD_BLOCK_ERASE_2,adr);
+	sharp_send_cmd(map, CMD_BLOCK_ERASE_1, adr);
+	sharp_send_cmd(map, CMD_BLOCK_ERASE_2, adr);
 
 	chip->state = FL_ERASING;
 
 	ret = sharp_do_wait_for_ready(map,chip,adr);
 	if(ret<0)return ret;
 
-	map_write32(map,CMD_READ_STATUS,adr);
-	status = map_read32(map,adr);
+	sharp_send_cmd(map, CMD_READ_STATUS, adr);
+	status = map_read(map, adr);
 
-	if(!(status&SR_ERRORS)){
-		map_write32(map,CMD_RESET,adr);
+	if(!(status.x[0] & SR_ERRORS)){
+		sharp_send_cmd(map, CMD_RESET, adr);
 		chip->state = FL_READY;
 		//spin_unlock_bh(chip->mutex);
 		return 0;
 	}
 
-	printk("sharp: error erasing block at addr=%08lx status=%08x\n",adr,status);
-	map_write32(map,CMD_CLEAR_STATUS,adr);
+	printk("sharp: error erasing block at addr=%08lx status=%08lx\n", adr, status.x[0]);
+	sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);
 
 	//spin_unlock_bh(chip->mutex);
 
@@ -517,20 +526,20 @@
 	unsigned long adr)
 {
 	int i;
-	int status;
+	map_word status;
 
-	map_write32(map,CMD_CLEAR_BLOCK_LOCKS_1,adr);
-	map_write32(map,CMD_CLEAR_BLOCK_LOCKS_2,adr);
+	sharp_send_cmd(map, CMD_CLEAR_BLOCK_LOCKS_1, adr);
+	sharp_send_cmd(map, CMD_CLEAR_BLOCK_LOCKS_2, adr);
 
 	udelay(100);
 
-	status = map_read32(map,adr);
-	printk("status=%08x\n",status);
+	status = map_read(map, adr);
+	printk("status=%08lx\n", status.x[0]);
 
 	for(i=0;i<1000;i++){
-		//map_write32(map,CMD_READ_STATUS,adr);
-		status = map_read32(map,adr);
-		if((status & SR_READY)==SR_READY)
+		//sharp_send_cmd(map, CMD_READ_STATUS, adr);
+		status = map_read(map, adr);
+		if((status.x[0] & SR_READY) == SR_READY)
 			break;
 		udelay(100);
 	}
@@ -538,14 +547,14 @@
 		printk("sharp: timed out unlocking block\n");
 	}
 
-	if(!(status&SR_ERRORS)){
-		map_write32(map,CMD_RESET,adr);
+	if(!(status.x[0] & SR_ERRORS)){
+		sharp_send_cmd(map, CMD_RESET, adr);
 		chip->state = FL_READY;
 		return;
 	}
 
-	printk("sharp: error unlocking block at addr=%08lx status=%08x\n",adr,status);
-	map_write32(map,CMD_CLEAR_STATUS,adr);
+	printk("sharp: error unlocking block at addr=%08lx status=%08lx\n", adr, status.x[0]);
+	sharp_send_cmd(map, CMD_CLEAR_STATUS, adr);
 }
 #endif
 


