Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbUKODhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbUKODhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUKODg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:36:29 -0500
Received: from ozlabs.org ([203.10.76.45]:9139 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261485AbUKOC7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:59:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16792.7267.321004.667834@cargo.ozlabs.ibm.com>
Date: Mon, 15 Nov 2004 14:02:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power_state and __iomem for mediabay.c
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does the power_state -> power.power_state conversion for
drivers/macintosh/mediabay.c and makes it use void __iomem * for
ioremap cookies.  Once the IDE code is converted to not use unsigned
long for MMIO register addresses, I will be able to remove a few casts
from here.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/macintosh/mediabay.c test-pmac/drivers/macintosh/mediabay.c
--- linux-2.5/drivers/macintosh/mediabay.c	2004-08-03 08:07:43.000000000 +1000
+++ test-pmac/drivers/macintosh/mediabay.c	2004-11-15 13:49:10.160443344 +1100
@@ -45,7 +45,7 @@
 #endif
 
 #define MB_FCR32(bay, r)	((bay)->base + ((r) >> 2))
-#define MB_FCR8(bay, r)		(((volatile u8*)((bay)->base)) + (r))
+#define MB_FCR8(bay, r)		(((volatile __iomem u8*)((bay)->base)) + (r))
 
 #define MB_IN32(bay,r)		(in_le32(MB_FCR32(bay,r)))
 #define MB_OUT32(bay,r,v)	(out_le32(MB_FCR32(bay,r), (v)))
@@ -67,7 +67,7 @@
 };
 
 struct media_bay_info {
-	volatile u32*			base;
+	u32 __iomem			*base;
 	int				content_id;
 	int				state;
 	int				last_value;
@@ -80,7 +80,7 @@
 	int				sleeping;
 	struct semaphore		lock;
 #ifdef CONFIG_BLK_DEV_IDE
-	unsigned long			cd_base;
+	void __iomem			*cd_base;
 	int 				cd_index;
 	int				cd_irq;
 	int				cd_retry;
@@ -443,7 +443,7 @@
 	int	i;
 
 	for (i=0; i<media_bay_count; i++)
-		if (media_bays[i].mdev && base == media_bays[i].cd_base) {
+		if (media_bays[i].mdev && base == (unsigned long) media_bays[i].cd_base) {
 			if ((what == media_bays[i].content_id) && media_bays[i].state == mb_up)
 				return 0;
 			media_bays[i].cd_index = -1;
@@ -468,7 +468,7 @@
 			
 			down(&bay->lock);
 
- 			bay->cd_base	= base;
+ 			bay->cd_base	= (void __iomem *) base;
 			bay->cd_irq	= irq;
 
 			if ((MB_CD != bay->content_id) || bay->state != mb_up) {
@@ -553,7 +553,7 @@
 	    	break;
 	    
 	case mb_ide_waiting:
-		if (bay->cd_base == 0) {
+		if (bay->cd_base == NULL) {
 			bay->timer = 0;
 			bay->state = mb_up;
 			MBDBG("mediabay%d: up before IDE init\n", i);
@@ -651,7 +651,7 @@
 static int __devinit media_bay_attach(struct macio_dev *mdev, const struct of_match *match)
 {
 	struct media_bay_info* bay;
-	volatile u32 *regbase;
+	u32 __iomem *regbase;
 	struct device_node *ofnode;
 	int i;
 
@@ -664,7 +664,8 @@
 	/* Media bay registers are located at the beginning of the
          * mac-io chip, we get the parent address for now (hrm...)
          */
-	regbase = (volatile u32 *)ioremap(ofnode->parent->addrs[0].address, 0x100);
+	regbase = (u32 __iomem *)
+		ioremap(ofnode->parent->addrs[0].address, 0x100);
 	if (regbase == NULL) {
 		macio_release_resources(mdev);
 		return -ENOMEM;
@@ -713,13 +714,13 @@
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (state != mdev->ofdev.dev.power_state && state >= 2) {
+	if (state != mdev->ofdev.dev.power.power_state && state == PM_SUSPEND_MEM) {
 		down(&bay->lock);
 		bay->sleeping = 1;
 		set_mb_power(bay, 0);
 		up(&bay->lock);
 		msleep(MB_POLL_DELAY);
-		mdev->ofdev.dev.power_state = state;
+		mdev->ofdev.dev.power.power_state = state;
 	}
 	return 0;
 }
@@ -728,8 +729,8 @@
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (mdev->ofdev.dev.power_state != 0) {
-		mdev->ofdev.dev.power_state = 0;
+	if (mdev->ofdev.dev.power.power_state != 0) {
+		mdev->ofdev.dev.power.power_state = 0;
 
 	       	/* We re-enable the bay using it's previous content
 	       	   only if it did not change. Note those bozo timings,
