Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291854AbSBHV2F>; Fri, 8 Feb 2002 16:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291840AbSBHVOj>; Fri, 8 Feb 2002 16:14:39 -0500
Received: from playa.onespot.com ([64.41.197.68]:30904 "EHLO playa.onespot.com")
	by vger.kernel.org with ESMTP id <S291841AbSBHVNs>;
	Fri, 8 Feb 2002 16:13:48 -0500
From: "Christopher Hoover" <ch@murgatroid.com>
To: <mtd@infradead.org>, <Linux-kernel@vger.kernel.org>
Subject: [PATCH] New Lock and Unlock Code for Intel FLASH parts
Date: Fri, 8 Feb 2002 13:13:41 -0800
Message-ID: <002001c1b0e5$7bda7bc0$7b00000a@SNAGGLE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3311
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Christopher Hoover [mailto:ch@hpl.hp.com] 
Sent: Friday, February 08, 2002 12:45 PM
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: dwmw2@redhat.com; Jeroen.Roose@chess.nl; ch@murgatroid.com
Subject: New Lock and Unlock Code for Intel FLASH parts


Folks,

I rewrote some of the locking and unlocking support for Intel parts in
drivers/mtd/chips/cfi_cmdset_0001.c because it seemed completely broken
for parts with variable block sizes, such as the Intel C3 flash I am
using.

An added benefit of this code is the removal of some cut-and-pasted code
in the driver.  (Another pass could be made to unify erase support with
locking and unlocking ...)

I don't have a wide variety of hardware to test this on, so if folks
code give this a try and give me some feedback, I'd appreciate that.

Thanks,
Christopher.
mailto:ch@murgatroid.com
mailto:ch@hpl.hp.com


PATCH FOLLOWS
KernelVersion: 2.4.17-rmk5
--- linux-2.4.17-rmk5/drivers/mtd/chips/cfi_cmdset_0001.c	Tue Feb
5 17:42:22 2002
+++ linux-2.4.17-rmk5-badge4-ch1/drivers/mtd/chips/cfi_cmdset_0001.c
Tue Feb  5 22:58:30 2002
@@ -13,6 +13,8 @@
  * 	- scalability vs code size is completely set at compile-time
  * 	  (see include/linux/mtd/cfi.h for selection)
  *	- optimized write buffer method
+ * 02/05/2002	Christopher Hoover <ch@hpl.hp.com>/<ch@murgatroid.com>
+ *	- reworked lock and unlock support
  */
 
 #include <linux/module.h>
@@ -61,6 +63,8 @@
 #ifdef DEBUG_CFI_FEATURES
 static void cfi_tell_features(struct cfi_pri_intelext *extp)
 {
+	int i;
+
 	printk("  Feature/Command Support: %4.4X\n",
extp->FeatureSupport);
 	printk("     - Chip Erase:         %s\n",
extp->FeatureSupport&1?"supported":"unsupported");
 	printk("     - Suspend Erase:      %s\n",
extp->FeatureSupport&2?"supported":"unsupported");
@@ -1050,8 +1054,99 @@
 	return 0;
 }
 
+typedef int (*varsize_frob_t)(struct map_info *map, struct flchip
*chip,
+			      unsigned long adr);
+
+static int cfi_intelext_varsize_frob(struct mtd_info *mtd,
varsize_frob_t frob,
+				     loff_t ofs, size_t len)
+{
+	struct map_info *map = mtd->priv;
+	struct cfi_private *cfi = map->fldrv_priv;
+	unsigned long adr;
+	int chipnum, ret = 0;
+	int i, first;
+	struct mtd_erase_region_info *regions = mtd->eraseregions;
+
+	if (ofs > mtd->size)
+		return -EINVAL;
+
+	if ((len + ofs) > mtd->size)
+		return -EINVAL;
+
+	/* Check that both start and end of the requested erase are
+	 * aligned with the erasesize at the appropriate addresses.
+	 */
+
+	i = 0;
+
+	/* Skip all erase regions which are ended before the start of 
+	   the requested erase. Actually, to save on the calculations,
+	   we skip to the first erase region which starts after the
+	   start of the requested erase, and then go back one.
+	*/
+	
+	while (i < mtd->numeraseregions && ofs >= regions[i].offset)
+	       i++;
+	i--;
+
+	/* OK, now i is pointing at the erase region in which this 
+	   erase request starts. Check the start of the requested
+	   erase range is aligned with the erase size which is in
+	   effect here.
+	*/
+
+	if (ofs & (regions[i].erasesize-1))
+		return -EINVAL;
+
+	/* Remember the erase region we start on */
+	first = i;
+
+	/* Next, check that the end of the requested erase is aligned
+	 * with the erase region at that address.
+	 */
+
+	while (i<mtd->numeraseregions && (ofs + len) >=
regions[i].offset)
+		i++;
+
+	/* As before, drop back one to point at the region in which
+	   the address actually falls
+	*/
+	i--;
+	
+	if ((ofs + len) & (regions[i].erasesize-1))
+		return -EINVAL;
+
+	chipnum = ofs >> cfi->chipshift;
+	adr = ofs - (chipnum << cfi->chipshift);
+
+	i=first;
+
+	while(len) {
+		ret = (*frob)(map, &cfi->chips[chipnum], adr);
+		
+		if (ret)
+			return ret;
+
+		adr += regions[i].erasesize;
+		len -= regions[i].erasesize;
+
+		if (adr % (1<< cfi->chipshift) == ((regions[i].offset +
(regions[i].erasesize * regions[i].numblocks)) %( 1<< cfi->chipshift)))
+			i++;
+
+		if (adr >> cfi->chipshift) {
+			adr = 0;
+			chipnum++;
+			
+			if (chipnum >= cfi->numchips)
+			break;
+		}
+	}
+
+	return 0;
+}
+
 
-static inline int do_erase_oneblock(struct map_info *map, struct flchip
*chip, unsigned long adr)
+static int do_erase_oneblock(struct map_info *map, struct flchip *chip,

+unsigned long adr)
 {
 	struct cfi_private *cfi = map->fldrv_priv;
 	__u32 status, status_OK;
@@ -1214,91 +1309,18 @@
 	spin_unlock_bh(chip->mutex);
 	return ret;
 }
-
 int cfi_intelext_erase_varsize(struct mtd_info *mtd, struct erase_info
*instr)
-{	struct map_info *map = mtd->priv;
-	struct cfi_private *cfi = map->fldrv_priv;
-	unsigned long adr, len;
-	int chipnum, ret = 0;
-	int i, first;
-	struct mtd_erase_region_info *regions = mtd->eraseregions;
-
-	if (instr->addr > mtd->size)
-		return -EINVAL;
-
-	if ((instr->len + instr->addr) > mtd->size)
-		return -EINVAL;
-
-	/* Check that both start and end of the requested erase are
-	 * aligned with the erasesize at the appropriate addresses.
-	 */
-
-	i = 0;
-
-	/* Skip all erase regions which are ended before the start of 
-	   the requested erase. Actually, to save on the calculations,
-	   we skip to the first erase region which starts after the
-	   start of the requested erase, and then go back one.
-	*/
-	
-	while (i < mtd->numeraseregions && instr->addr >=
regions[i].offset)
-	       i++;
-	i--;
-
-	/* OK, now i is pointing at the erase region in which this 
-	   erase request starts. Check the start of the requested
-	   erase range is aligned with the erase size which is in
-	   effect here.
-	*/
-
-	if (instr->addr & (regions[i].erasesize-1))
-		return -EINVAL;
-
-	/* Remember the erase region we start on */
-	first = i;
-
-	/* Next, check that the end of the requested erase is aligned
-	 * with the erase region at that address.
-	 */
-
-	while (i<mtd->numeraseregions && (instr->addr + instr->len) >=
regions[i].offset)
-		i++;
-
-	/* As before, drop back one to point at the region in which
-	   the address actually falls
-	*/
-	i--;
-	
-	if ((instr->addr + instr->len) & (regions[i].erasesize-1))
-		return -EINVAL;
+{
+	unsigned long ofs, len;
+	int ret;
 
-	chipnum = instr->addr >> cfi->chipshift;
-	adr = instr->addr - (chipnum << cfi->chipshift);
+	ofs = instr->addr;
 	len = instr->len;
 
-	i=first;
-
-	while(len) {
-		ret = do_erase_oneblock(map, &cfi->chips[chipnum], adr);
-		
-		if (ret)
-			return ret;
-
-		adr += regions[i].erasesize;
-		len -= regions[i].erasesize;
-
-		if (adr % (1<< cfi->chipshift) == ((regions[i].offset +
(regions[i].erasesize * regions[i].numblocks)) %( 1<< cfi->chipshift)))
-			i++;
+	ret = cfi_intelext_varsize_frob(mtd, do_erase_oneblock, ofs,
len);
+	if (ret)
+		return ret;
 
-		if (adr >> cfi->chipshift) {
-			adr = 0;
-			chipnum++;
-			
-			if (chipnum >= cfi->numchips)
-			break;
-		}
-	}
-		
 	instr->state = MTD_ERASE_DONE;
 	if (instr->callback)
 		instr->callback(instr);
@@ -1363,11 +1385,26 @@
 	}
 }
 
-static inline int do_lock_oneblock(struct map_info *map, struct flchip
*chip, unsigned long adr)
+#ifdef DEBUG_LOCK_BITS
+static int do_printlockstatus_oneblock(struct map_info *map, struct 
+flchip *chip, unsigned long adr) {
+	struct cfi_private *cfi = map->fldrv_priv;
+	int ofs_factor = cfi->interleave * cfi->device_type;
+
+	cfi_send_gen_cmd(0x90, 0x55, 0, map, cfi, cfi->device_type,
NULL);
+	printk(KERN_DEBUG "block status register for 0x%08lx is %x\n",
+	       adr, cfi_read_query(map, adr+(2*ofs_factor)));
+	cfi_send_gen_cmd(0xff, 0x55, 0, map, cfi, cfi->device_type,
NULL);
+	
+	return 0;
+}
+#endif
+
+static int do_lock_oneblock(struct map_info *map, struct flchip *chip, 
+unsigned long adr)
 {
 	struct cfi_private *cfi = map->fldrv_priv;
 	__u32 status, status_OK;
-	unsigned long timeo = jiffies + HZ;
+	unsigned long timeo;
 	DECLARE_WAITQUEUE(wait, current);
 
 	adr += chip->start;
@@ -1428,7 +1465,7 @@
 	/* FIXME. Use a timer to check this, and return immediately. */
 	/* Once the state machine's known to be working I'll do that */
 
-	timeo = jiffies + (HZ*2);
+	timeo = jiffies + (HZ*20);
 	for (;;) {
 
 		status = cfi_read(map, adr);
@@ -1460,63 +1497,31 @@
 }
 static int cfi_intelext_lock(struct mtd_info *mtd, loff_t ofs, size_t
len)  {
-	struct map_info *map = mtd->priv;
-	struct cfi_private *cfi = map->fldrv_priv;
-	unsigned long adr;
-	int chipnum, ret = 0;
-#ifdef DEBUG_LOCK_BITS
-	int ofs_factor = cfi->interleave * cfi->device_type;
-#endif
-
-	if (ofs & (mtd->erasesize - 1))
-		return -EINVAL;
-
-	if (len & (mtd->erasesize -1))
-		return -EINVAL;
-
-	if ((len + ofs) > mtd->size)
-		return -EINVAL;
-
-	chipnum = ofs >> cfi->chipshift;
-	adr = ofs - (chipnum << cfi->chipshift);
-
-	while(len) {
+	int ret;
 
 #ifdef DEBUG_LOCK_BITS
-		cfi_send_gen_cmd(0x90, 0x55, 0, map, cfi,
cfi->device_type, NULL);
-		printk("before lock: block status register is
%x\n",cfi_read_query(map, adr+(2*ofs_factor)));
-		cfi_send_gen_cmd(0xff, 0x55, 0, map, cfi,
cfi->device_type, NULL);
+	printk(KERN_DEBUG __FUNCTION__ 
+	       ": before locking ofs=0x%08x, len=0x%08lx\n",
+	       ofs, len);
+	cfi_intelext_varsize_frob(mtd, do_printlockstatus_oneblock, ofs,
len);
 #endif
 
-		ret = do_lock_oneblock(map, &cfi->chips[chipnum], adr);
-
+	ret = cfi_intelext_varsize_frob(mtd, do_lock_oneblock, ofs,
len);
+	
 #ifdef DEBUG_LOCK_BITS
-		cfi_send_gen_cmd(0x90, 0x55, 0, map, cfi,
cfi->device_type, NULL);
-		printk("after lock: block status register is
%x\n",cfi_read_query(map, adr+(2*ofs_factor)));
-		cfi_send_gen_cmd(0xff, 0x55, 0, map, cfi,
cfi->device_type, NULL);
-#endif	
-		
-		if (ret)
-			return ret;
-
-		adr += mtd->erasesize;
-		len -= mtd->erasesize;
+	printk(KERN_DEBUG __FUNCTION__
+	       ": after locking, ret=%d\n", ret);
+	cfi_intelext_varsize_frob(mtd, do_printlockstatus_oneblock, ofs,
len); 
+#endif
 
-		if (adr >> cfi->chipshift) {
-			adr = 0;
-			chipnum++;
-			
-			if (chipnum >= cfi->numchips)
-			break;
-		}
-	}
-	return 0;
+	return ret;
 }
-static inline int do_unlock_oneblock(struct map_info *map, struct
flchip *chip, unsigned long adr)
+
+static int do_unlock_oneblock(struct map_info *map, struct flchip 
+*chip, unsigned long adr)
 {
 	struct cfi_private *cfi = map->fldrv_priv;
 	__u32 status, status_OK;
-	unsigned long timeo = jiffies + HZ;
+	unsigned long timeo;
 	DECLARE_WAITQUEUE(wait, current);
 
 	adr += chip->start;
@@ -1577,7 +1582,7 @@
 	/* FIXME. Use a timer to check this, and return immediately. */
 	/* Once the state machine's known to be working I'll do that */
 
-	timeo = jiffies + (HZ*2);
+	timeo = jiffies + (HZ*20);
 	for (;;) {
 
 		status = cfi_read(map, adr);
@@ -1594,7 +1599,7 @@
 			return -EIO;
 		}
 		
-		/* Latency issues. Drop the unlock, wait a while and
retry */
+		/* Latency issues. Drop the lock, wait a while and retry
*/
 		spin_unlock_bh(chip->mutex);
 		cfi_udelay(1);
 		spin_lock_bh(chip->mutex);
@@ -1609,38 +1614,21 @@
 }
 static int cfi_intelext_unlock(struct mtd_info *mtd, loff_t ofs, size_t
len)  {
-	struct map_info *map = mtd->priv;
-	struct cfi_private *cfi = map->fldrv_priv;
-	unsigned long adr;
-	int chipnum, ret = 0;
-#ifdef DEBUG_LOCK_BITS
-	int ofs_factor = cfi->interleave * cfi->device_type;
-#endif
-
-	chipnum = ofs >> cfi->chipshift;
-	adr = ofs - (chipnum << cfi->chipshift);
+	int ret;
 
 #ifdef DEBUG_LOCK_BITS
-	{
-		unsigned long temp_adr = adr;
-		unsigned long temp_len = len;
-                 
-		cfi_send_gen_cmd(0x90, 0x55, 0, map, cfi,
cfi->device_type, NULL);
-                while (temp_len) {
-			printk("before unlock %x: block status register
is %x\n",temp_adr,cfi_read_query(map, temp_adr+(2*ofs_factor)));
-			temp_adr += mtd->erasesize;
-			temp_len -= mtd->erasesize;
-		}
-		cfi_send_gen_cmd(0xff, 0x55, 0, map, cfi,
cfi->device_type, NULL);
-	}
+	printk(KERN_DEBUG __FUNCTION__ 
+	       ": before locking ofs=0x%08x, len=0x%08lx\n",
+	       ofs, len);
+	cfi_intelext_varsize_frob(mtd, do_printlockstatus_oneblock, ofs,
len);
 #endif
 
-	ret = do_unlock_oneblock(map, &cfi->chips[chipnum], adr);
-
+	ret = cfi_intelext_varsize_frob(mtd, do_unlock_oneblock, ofs,
len);
+	
 #ifdef DEBUG_LOCK_BITS
-	cfi_send_gen_cmd(0x90, 0x55, 0, map, cfi, cfi->device_type,
NULL);
-	printk("after unlock: block status register is
%x\n",cfi_read_query(map, adr+(2*ofs_factor)));
-	cfi_send_gen_cmd(0xff, 0x55, 0, map, cfi, cfi->device_type,
NULL);
+	printk(KERN_DEBUG __FUNCTION__
+	       ": after locking, ret=%d\n", ret);
+	cfi_intelext_varsize_frob(mtd, do_printlockstatus_oneblock, ofs,
len);
 #endif
 	
 	return ret;

