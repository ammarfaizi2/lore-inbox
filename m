Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbVKAXfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVKAXfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVKAXfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:35:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29588 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751440AbVKAXfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:35:13 -0500
Date: Wed, 2 Nov 2005 00:33:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org
Subject: [patch] collie: fixup mtd a bit
Message-ID: <20051101233320.GA31263@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get collie mtd support closer to working/clean state.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 3fe09bee0821649805849b89c3329d3f05874cae
tree b089cb58a8d4af8480ed08a3f772ad47753946e7
parent 8ab89cd19ec120410f6d259348d4ce8a5848fd7f
author <pavel@amd.(none)> Wed, 02 Nov 2005 00:31:50 +0100
committer <pavel@amd.(none)> Wed, 02 Nov 2005 00:31:50 +0100

 drivers/mtd/chips/sharp.c |  192 ++++++++++++++++++++++++++-------------------
 drivers/mtd/maps/Kconfig  |    2 
 2 files changed, 113 insertions(+), 81 deletions(-)

diff --git a/drivers/mtd/chips/sharp.c b/drivers/mtd/chips/sharp.c
--- a/drivers/mtd/chips/sharp.c
+++ b/drivers/mtd/chips/sharp.c
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
@@ -59,9 +60,11 @@
 
 #define SR_ERRORS (SR_ERROR_ERASE|SR_ERROR_WRITE|SR_VPP|SR_PROTECT)
 
+#define BLOCK_MASK		0xfffe0000
+
 /* Configuration options */
 
-#undef AUTOUNLOCK  /* automatically unlocks blocks before erasing */
+#define AUTOUNLOCK  /* automatically unlocks blocks before erasing */
 
 struct mtd_info *sharp_probe(struct map_info *);
 
@@ -82,7 +85,7 @@ static int sharp_write_oneword(struct ma
 static int sharp_erase_oneblock(struct map_info *map, struct flchip *chip,
 	unsigned long adr);
 #ifdef AUTOUNLOCK
-static void sharp_unlock_oneblock(struct map_info *map, struct flchip *chip,
+static inline void sharp_unlock_oneblock(struct map_info *map, struct flchip *chip,
 	unsigned long adr);
 #endif
 
@@ -143,7 +146,7 @@ struct mtd_info *sharp_probe(struct map_
 	mtd->name = map->name;
 
 	memset(sharp, 0, sizeof(*sharp));
-	sharp->chipshift = 23;
+	sharp->chipshift = 24;
 	sharp->numchips = 1;
 	sharp->chips[0].start = 0;
 	sharp->chips[0].state = FL_READY;
@@ -170,10 +173,9 @@ static int sharp_probe_map(struct map_in
 
 	map_write32(map, CMD_READ_ID, base+0);
 
-	read0=map_read32(map, base+0);
-	read4=map_read32(map, base+4);
-	if(read0 == 0x89898989){
-		printk("Looks like sharp flash\n");
+	read0 = map_read32(map, base+0);
+	read4 = map_read32(map, base+4);
+	if (read0 == 0x00b000b0) {
 		switch(read4){
 		case 0xaaaaaaaa:
 		case 0xa0a0a0a0:
@@ -188,22 +190,20 @@ static int sharp_probe_map(struct map_in
 			mtd->erasesize = 0x10000 * width;
 			mtd->size = 0x100000 * width;
 			return width;
-#if 0
-		case 0x00000000: /* unknown */
-			/* XX - LH28F004SCT 512kx8, 8 64k blocks*/
-			mtd->erasesize = 0x10000 * width;
-			mtd->size = 0x80000 * width;
+		case 0x00b000b0:
+			/* a6 - LH28F640BFHE 8 64k * 2 chip blocks*/
+			mtd->erasesize = 0x10000 * width / 2;
+			mtd->size = 0x800000 * width / 2;
 			return width;
-#endif
 		default:
 			printk("Sort-of looks like sharp flash, 0x%08x 0x%08x\n",
 				read0,read4);
 		}
-	}else if((map_read32(map, base+0) == CMD_READ_ID)){
+	} else if ((map_read32(map, base+0) == CMD_READ_ID)){
 		/* RAM, probably */
 		printk("Looks like RAM\n");
 		map_write32(map, tmp, base+0);
-	}else{
+	} else {
 		printk("Doesn't look like sharp flash, 0x%08x 0x%08x\n",
 			read0,read4);
 	}
@@ -214,7 +214,7 @@ static int sharp_probe_map(struct map_in
 /* This function returns with the chip->mutex lock held. */
 static int sharp_wait(struct map_info *map, struct flchip *chip)
 {
-	__u16 status;
+	__u32 status;
 	unsigned long timeo = jiffies + HZ;
 	DECLARE_WAITQUEUE(wait, current);
 	int adr = 0;
@@ -222,29 +222,30 @@ static int sharp_wait(struct map_info *m
 retry:
 	spin_lock_bh(chip->mutex);
 
-	switch(chip->state){
+	switch (chip->state) {
 	case FL_READY:
-		map_write32(map,CMD_READ_STATUS,adr);
+		map_write32(map, CMD_READ_STATUS, adr);
 		chip->state = FL_STATUS;
 	case FL_STATUS:
 		status = map_read32(map,adr);
-//printk("status=%08x\n",status);
-
-		udelay(100);
-		if((status & SR_READY)!=SR_READY){
-//printk(".status=%08x\n",status);
-			udelay(100);
+		if ((status & SR_READY) == SR_READY)
+			break;
+		spin_unlock_bh(chip->mutex);
+		if (time_after(jiffies, timeo)) {
+			printk("Waiting for chip to be ready timed out in erase\n");
+			return -EIO;
 		}
-		break;
+		udelay(1);
+		goto retry;
 	default:
-		printk("Waiting for chip\n");
-
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&chip->wq, &wait);
 
 		spin_unlock_bh(chip->mutex);
 
-		schedule();
+		udelay(1);
+
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&chip->wq, &wait);
 
 		if(signal_pending(current))
@@ -255,7 +256,7 @@ retry:
 		goto retry;
 	}
 
-	map_write32(map,CMD_RESET, adr);
+	map_write32(map, CMD_RESET, adr);
 
 	chip->state = FL_READY;
 
@@ -349,12 +350,13 @@ static int sharp_write_oneword(struct ma
 	unsigned long adr, __u32 datum)
 {
 	int ret;
-	int timeo;
 	int try;
 	int i;
-	int status = 0;
+	u32 status = 0;
 
 	ret = sharp_wait(map,chip);
+	if (ret < 0)
+		return ret;
 
 	for(try=0;try<10;try++){
 		map_write32(map,CMD_BYTE_WRITE,adr);
@@ -363,14 +365,21 @@ static int sharp_write_oneword(struct ma
 
 		chip->state = FL_WRITING;
 
-		timeo = jiffies + (HZ/2);
-
 		map_write32(map,CMD_READ_STATUS,adr);
 		for(i=0;i<100;i++){
 			status = map_read32(map,adr);
 			if((status & SR_READY)==SR_READY)
 				break;
 		}
+#ifdef AUTOUNLOCK
+		if (status & SR_PROTECT) { /* lock block */
+			map_write32(map, CMD_CLEAR_STATUS, adr);
+			sharp_unlock_oneblock(map,chip,adr);
+			map_write32(map, CMD_CLEAR_STATUS, adr);
+			map_write32(map, CMD_RESET, adr);
+			continue;
+		}
+#endif
 		if(i==100){
 			printk("sharp: timed out writing\n");
 		}
@@ -385,8 +394,7 @@ static int sharp_write_oneword(struct ma
 	map_write32(map,CMD_RESET,adr);
 	chip->state = FL_READY;
 
-	wake_up(&chip->wq);
-	spin_unlock_bh(chip->mutex);
+	sharp_release(chip);
 
 	return 0;
 }
@@ -398,7 +406,6 @@ static int sharp_erase(struct mtd_info *
 	unsigned long adr,len;
 	int chipnum, ret=0;
 
-//printk("sharp_erase()\n");
 	if(instr->addr & (mtd->erasesize - 1))
 		return -EINVAL;
 	if(instr->len & (mtd->erasesize - 1))
@@ -414,8 +421,13 @@ static int sharp_erase(struct mtd_info *
 		ret = sharp_erase_oneblock(map, &sharp->chips[chipnum], adr);
 		if(ret)return ret;
 
-		adr += mtd->erasesize;
-		len -= mtd->erasesize;
+		if (adr >= 0xfe0000) {
+			adr += mtd->erasesize / 8;
+			len -= mtd->erasesize / 8;
+		} else {
+			adr += mtd->erasesize;
+			len -= mtd->erasesize;
+		}
 		if(adr >> sharp->chipshift){
 			adr = 0;
 			chipnum++;
@@ -430,7 +442,7 @@ static int sharp_erase(struct mtd_info *
 	return 0;
 }
 
-static int sharp_do_wait_for_ready(struct map_info *map, struct flchip *chip,
+static inline int sharp_do_wait_for_ready(struct map_info *map, struct flchip *chip,
 	unsigned long adr)
 {
 	int ret;
@@ -441,7 +453,7 @@ static int sharp_do_wait_for_ready(struc
 	map_write32(map,CMD_READ_STATUS,adr);
 	status = map_read32(map,adr);
 
-	timeo = jiffies + HZ;
+	timeo = jiffies + HZ * 10;
 
 	while(time_before(jiffies, timeo)){
 		map_write32(map,CMD_READ_STATUS,adr);
@@ -453,19 +465,15 @@ static int sharp_do_wait_for_ready(struc
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&chip->wq, &wait);
 
-		//spin_unlock_bh(chip->mutex);
+		spin_unlock_bh(chip->mutex);
 
 		schedule_timeout(1);
 		schedule();
-		remove_wait_queue(&chip->wq, &wait);
 
-		//spin_lock_bh(chip->mutex);
-		
-		if (signal_pending(current)){
-			ret = -EINTR;
-			goto out;
-		}
-		
+		spin_lock_bh(chip->mutex);
+
+		remove_wait_queue(&chip->wq, &wait);
+		set_current_state(TASK_RUNNING);
 	}
 	ret = -ETIME;
 out:
@@ -476,11 +484,11 @@ static int sharp_erase_oneblock(struct m
 	unsigned long adr)
 {
 	int ret;
-	//int timeo;
-	int status;
-	//int i;
+	u32 status;
 
-//printk("sharp_erase_oneblock()\n");
+	ret = sharp_wait(map,chip);
+	if (ret < 0)
+		return ret;
 
 #ifdef AUTOUNLOCK
 	/* This seems like a good place to do an unlock */
@@ -493,7 +501,10 @@ static int sharp_erase_oneblock(struct m
 	chip->state = FL_ERASING;
 
 	ret = sharp_do_wait_for_ready(map,chip,adr);
-	if(ret<0)return ret;
+	if(ret<0) {
+		spin_unlock_bh(chip->mutex);
+		return ret;
+	}
 
 	map_write32(map,CMD_READ_STATUS,adr);
 	status = map_read32(map,adr);
@@ -501,43 +512,30 @@ static int sharp_erase_oneblock(struct m
 	if(!(status&SR_ERRORS)){
 		map_write32(map,CMD_RESET,adr);
 		chip->state = FL_READY;
-		//spin_unlock_bh(chip->mutex);
+		spin_unlock_bh(chip->mutex);
 		return 0;
 	}
 
 	printk("sharp: error erasing block at addr=%08lx status=%08x\n",adr,status);
 	map_write32(map,CMD_CLEAR_STATUS,adr);
 
-	//spin_unlock_bh(chip->mutex);
+	sharp_release(chip);
 
 	return -EIO;
 }
 
 #ifdef AUTOUNLOCK
-static void sharp_unlock_oneblock(struct map_info *map, struct flchip *chip,
+static inline void sharp_unlock_oneblock(struct map_info *map, struct flchip *chip,
 	unsigned long adr)
 {
-	int i;
-	int status;
+	u32 status;
 
-	map_write32(map,CMD_CLEAR_BLOCK_LOCKS_1,adr);
-	map_write32(map,CMD_CLEAR_BLOCK_LOCKS_2,adr);
+	map_write32(map,CMD_CLEAR_BLOCK_LOCKS_1,adr & BLOCK_MASK);
+	map_write32(map,CMD_CLEAR_BLOCK_LOCKS_2,adr & BLOCK_MASK);
 
-	udelay(100);
+	sharp_do_wait_for_ready(map,chip,adr);
 
 	status = map_read32(map,adr);
-	printk("status=%08x\n",status);
-
-	for(i=0;i<1000;i++){
-		//map_write32(map,CMD_READ_STATUS,adr);
-		status = map_read32(map,adr);
-		if((status & SR_READY)==SR_READY)
-			break;
-		udelay(100);
-	}
-	if(i==1000){
-		printk("sharp: timed out unlocking block\n");
-	}
 
 	if(!(status&SR_ERRORS)){
 		map_write32(map,CMD_RESET,adr);
@@ -552,25 +550,59 @@ static void sharp_unlock_oneblock(struct
 
 static void sharp_sync(struct mtd_info *mtd)
 {
-	//printk("sharp_sync()\n");
 }
 
 static int sharp_suspend(struct mtd_info *mtd)
 {
-	printk("sharp_suspend()\n");
-	return -EINVAL;
+	struct map_info *map = mtd->priv;
+	struct sharp_info *sharp = map->fldrv_priv;
+	int i;
+	struct flchip *chip;
+	int ret = 0;
+
+	for (i = 0; !ret && i < sharp->numchips; i++) {
+		chip = &sharp->chips[i];
+		ret = sharp_wait(map,chip);
+
+		if (ret) {
+			ret = -EAGAIN;
+		} else {
+			chip->state = FL_PM_SUSPENDED;
+			spin_unlock_bh(chip->mutex);
+		}
+	}
+	return ret;
 }
 
 static void sharp_resume(struct mtd_info *mtd)
 {
-	printk("sharp_resume()\n");
-	
+	struct map_info *map = mtd->priv;
+	struct sharp_info *sharp = map->fldrv_priv;
+	int i;
+	struct flchip *chip;
+
+	for (i = 0; i < sharp->numchips; i++) {
+		chip = &sharp->chips[i];
+
+		spin_lock_bh(chip->mutex);
+
+		if (chip->state == FL_PM_SUSPENDED) {
+			/* We need to force it back to a known state */
+			map_write32(map, CMD_RESET, chip->start);
+			chip->state = FL_READY;
+			wake_up(&chip->wq);
+		}
+
+		spin_unlock_bh(chip->mutex);
+	}
 }
 
 static void sharp_destroy(struct mtd_info *mtd)
 {
-	printk("sharp_destroy()\n");
+	struct map_info *map = mtd->priv;
+	struct sharp_info *sharp = map->fldrv_priv;
 
+	kfree(sharp);
 }
 
 int __init sharp_probe_init(void)
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -412,7 +412,7 @@ config MTD_CDB89712
 
 config MTD_SA1100
 	tristate "CFI Flash device mapped on StrongARM SA11x0"
-	depends on ARM && MTD_CFI && ARCH_SA1100 && MTD_PARTITIONS
+	depends on ARM && (MTD_CFI || MTD_SHARP) && ARCH_SA1100 && MTD_PARTITIONS
 	help
 	  This enables access to the flash chips on most platforms based on
 	  the SA1100 and SA1110, including the Assabet and the Compaq iPAQ.

-- 
Thanks, Sharp!
