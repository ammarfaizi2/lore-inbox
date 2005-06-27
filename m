Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVF0N5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVF0N5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVF0N4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:56:02 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:31717 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262089AbVF0MRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:17:00 -0400
Message-Id: <20050627121410.749772000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:06 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Peter Beutner <p.beutner@gmx.net>
Content-Disposition: inline; filename=dvb-core-dmxdev-cleanups.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 06/51] core: dmxdev cleanups
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Beutner <p.beutner@gmx.net>

- remove void casts
- not necessary to set filter state twice to STATE_FREE during
  dvb_dmxdev_init()

Signed-off-by: Peter Beutner <p.beutner@gmx.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/dmxdev.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-core/dmxdev.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-core/dmxdev.c	2005-06-27 13:22:59.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-core/dmxdev.c	2005-06-27 13:23:00.000000000 +0200
@@ -42,12 +42,6 @@ MODULE_PARM_DESC(debug, "Turn on/off deb
 
 #define dprintk	if (debug) printk
 
-static inline struct dmxdev_filter *
-dvb_dmxdev_file_to_filter(struct file *file)
-{
-	return (struct dmxdev_filter *) file->private_data;
-}
-
 static inline void dvb_dmxdev_buffer_init(struct dmxdev_buffer *buffer)
 {
 	buffer->data=NULL;
@@ -844,7 +838,7 @@ static ssize_t dvb_dmxdev_read_sec(struc
 static ssize_t
 dvb_demux_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
-	struct dmxdev_filter *dmxdevfilter=dvb_dmxdev_file_to_filter(file);
+	struct dmxdev_filter *dmxdevfilter= file->private_data;
 	int ret=0;
 
 	if (down_interruptible(&dmxdevfilter->mutex))
@@ -865,7 +859,7 @@ dvb_demux_read(struct file *file, char _
 static int dvb_demux_do_ioctl(struct inode *inode, struct file *file,
 			      unsigned int cmd, void *parg)
 {
-	struct dmxdev_filter *dmxdevfilter=dvb_dmxdev_file_to_filter(file);
+	struct dmxdev_filter *dmxdevfilter = file->private_data;
 	struct dmxdev *dmxdev=dmxdevfilter->dev;
 	unsigned long arg=(unsigned long) parg;
 	int ret=0;
@@ -962,7 +956,7 @@ static int dvb_demux_ioctl(struct inode 
 
 static unsigned int dvb_demux_poll (struct file *file, poll_table *wait)
 {
-	struct dmxdev_filter *dmxdevfilter = dvb_dmxdev_file_to_filter(file);
+	struct dmxdev_filter *dmxdevfilter = file->private_data;
 	unsigned int mask = 0;
 
 	if (!dmxdevfilter)
@@ -987,7 +981,7 @@ static unsigned int dvb_demux_poll (stru
 
 static int dvb_demux_release(struct inode *inode, struct file *file)
 {
-	struct dmxdev_filter *dmxdevfilter = dvb_dmxdev_file_to_filter(file);
+	struct dmxdev_filter *dmxdevfilter = file->private_data;
 	struct dmxdev *dmxdev = dmxdevfilter->dev;
 
 	return dvb_dmxdev_filter_free(dmxdev, dmxdevfilter);
@@ -1111,7 +1105,6 @@ dvb_dmxdev_init(struct dmxdev *dmxdev, s
 		dvb_dmxdev_filter_state_set(&dmxdev->filter[i], DMXDEV_STATE_FREE);
 		dmxdev->dvr[i].dev=dmxdev;
 		dmxdev->dvr[i].buffer.data=NULL;
-		dvb_dmxdev_filter_state_set(&dmxdev->filter[i], DMXDEV_STATE_FREE);
 		dvb_dmxdev_dvr_state_set(&dmxdev->dvr[i], DMXDEV_STATE_FREE);
 	}
 

--

