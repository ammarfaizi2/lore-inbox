Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUCPOX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUCPOXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:23:45 -0500
Received: from styx.suse.cz ([82.208.2.94]:5762 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261964AbUCPOTu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:50 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467781850@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 44/44] Fixes in wacom.c: SLAB_ATOMIC->GFP_KERNEL and count bug in open()
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <1079446778675@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.98.2, 2004-03-12 13:51:14+01:00, oliver@neukum.org
  input: fixes in wacom.c
    -use GFP_KERNEL where SLAB_ATOMIC is not needed
    -fix count bug in open() error path


 wacom.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/wacom.c b/drivers/usb/input/wacom.c
--- a/drivers/usb/input/wacom.c	Tue Mar 16 13:17:23 2004
+++ b/drivers/usb/input/wacom.c	Tue Mar 16 13:17:23 2004
@@ -593,8 +593,10 @@
 		return 0;
 
 	wacom->irq->dev = wacom->usbdev;
-	if (usb_submit_urb(wacom->irq, GFP_KERNEL))
+	if (usb_submit_urb(wacom->irq, GFP_KERNEL)) {
+		wacom->open--;
 		return -EIO;
+	}
 
 	return 0;
 }
@@ -619,7 +621,7 @@
 		return -ENOMEM;
 	memset(wacom, 0, sizeof(struct wacom));
 
-	wacom->data = usb_buffer_alloc(dev, 10, SLAB_ATOMIC, &wacom->data_dma);
+	wacom->data = usb_buffer_alloc(dev, 10, GFP_KERNEL, &wacom->data_dma);
 	if (!wacom->data) {
 		kfree(wacom);
 		return -ENOMEM;

