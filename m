Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271472AbRHPEtG>; Thu, 16 Aug 2001 00:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271468AbRHPEs5>; Thu, 16 Aug 2001 00:48:57 -0400
Received: from trained-monkey.org ([209.217.122.11]:37624 "EHLO
	savage.trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271474AbRHPEsp>; Thu, 16 Aug 2001 00:48:45 -0400
Date: Thu, 16 Aug 2001 00:47:01 -0400
Message-Id: <200108160447.f7G4l1P19532@savage.trained-monkey.org>
From: <jes@trained-monkey.org>
To: Peter Schlaile <udbz@rz.uni-karlsruhe.de>
CC: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch] 64 bit bug in video1394.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

drivers/ieee1394/video1394.c has a couple of instances where it saved
cpu flags in 'int' which breaks on 64 bit boxes.

Here's a patch.

Jes

--- drivers/ieee1394/video1394.c~	Wed Aug  8 00:08:04 2001
+++ drivers/ieee1394/video1394.c	Thu Aug 16 00:46:13 2001
@@ -1283,7 +1283,8 @@
 {
 	struct video_card *video = NULL;
 	struct ti_ohci *ohci;
-	int res = -EINVAL, flags;
+	int res = -EINVAL;
+	unsigned long flags;
 	struct list_head *lh;
 
         spin_lock_irqsave(&video1394_cards_lock, flags);
@@ -1320,7 +1321,8 @@
 
 static int video1394_open(struct inode *inode, struct file *file)
 {
-	int i = MINOR(inode->i_rdev), flags;
+	int i = MINOR(inode->i_rdev);
+	unsigned long flags;
 	struct video_card *video = NULL;
 	struct list_head *lh;
 
@@ -1350,7 +1352,8 @@
 	struct video_card *video = NULL;
 	struct ti_ohci *ohci;
 	u64 mask;
-	int i, flags;
+	int i;
+	unsigned long flags;
 	struct list_head *lh;
 
         spin_lock_irqsave(&video1394_cards_lock, flags);
@@ -1416,7 +1419,8 @@
 void irq_handler(int card, quadlet_t isoRecvIntEvent, 
 		 quadlet_t isoXmitIntEvent)
 {
-	int i, flags;
+	int i;
+	unsigned long flags;
 	struct video_card *video = NULL;
 	struct list_head *lh;
 
@@ -1465,7 +1469,7 @@
 static int video1394_init(struct ti_ohci *ohci)
 {
 	struct video_card *video = kmalloc(sizeof(struct video_card), GFP_KERNEL);
-	int flags;
+	unsigned long flags;
 	char name[16];
 
 	if (video == NULL) {
@@ -1525,7 +1529,8 @@
 /* Must be called under spinlock */
 static void remove_card(struct video_card *video)
 {
-	int i, flags;
+	int i;
+	unsigned long flags;
 
 	ohci1394_unregister_video(video->ohci, &video_tmpl);
 
@@ -1556,7 +1561,7 @@
 static void video1394_remove_host (struct hpsb_host *host)
 {
 	struct ti_ohci *ohci;
-	int flags;
+	unsigned long flags;
 	struct list_head *lh;
 
 	/* We only work with the OHCI-1394 driver */
