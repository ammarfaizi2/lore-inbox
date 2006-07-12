Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWGLDv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWGLDv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWGLDv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:51:58 -0400
Received: from xenotime.net ([66.160.160.81]:8166 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932391AbWGLDv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:51:57 -0400
Date: Tue, 11 Jul 2006 20:44:21 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: mchehab@infradead.org, akpm <akpm@osdl.org>
Subject: [PATCH -mm] bttv: must_check fixes
Message-Id: <20060711204421.be13dec9.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check all __must_check warnings in bttv.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/media/video/bt8xx/bttv-driver.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

--- linux-2618-rc1mm1.orig/drivers/media/video/bt8xx/bttv-driver.c
+++ linux-2618-rc1mm1/drivers/media/video/bt8xx/bttv-driver.c
@@ -3909,6 +3909,8 @@ static void bttv_unregister_video(struct
 /* register video4linux devices */
 static int __devinit bttv_register_video(struct bttv *btv)
 {
+	int ret;
+
 	if (no_overlay <= 0) {
 		bttv_video_template.type |= VID_TYPE_OVERLAY;
 	} else {
@@ -3923,7 +3925,10 @@ static int __devinit bttv_register_video
 		goto err;
 	printk(KERN_INFO "bttv%d: registered device video%d\n",
 	       btv->c.nr,btv->video_dev->minor & 0x1f);
-	video_device_create_file(btv->video_dev, &class_device_attr_card);
+	ret = video_device_create_file(btv->video_dev, &class_device_attr_card);
+	if (ret < 0)
+		printk(KERN_WARNING "bttv: video_device_create_file error: "
+			"%d\n", ret);
 
 	/* vbi */
 	btv->vbi_dev = vdev_init(btv, &bttv_vbi_template, "vbi");
@@ -4287,6 +4292,8 @@ static struct pci_driver bttv_pci_driver
 
 static int bttv_init_module(void)
 {
+	int ret;
+
 	bttv_num = 0;
 
 	printk(KERN_INFO "bttv: driver version %d.%d.%d loaded\n",
@@ -4308,7 +4315,12 @@ static int bttv_init_module(void)
 
 	bttv_check_chipset();
 
-	bus_register(&bttv_sub_bus_type);
+	ret = bus_register(&bttv_sub_bus_type);
+	if (ret < 0) {
+		printk(KERN_WARNING "bttv: bus_register error: %d\n", ret);
+		return ret;
+	}
+
 	return pci_register_driver(&bttv_pci_driver);
 }
 


---
