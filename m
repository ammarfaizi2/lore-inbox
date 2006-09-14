Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWINMcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWINMcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 08:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWINMcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 08:32:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39816 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932067AbWINMcB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 08:32:01 -0400
Subject: [PATCH] zr36120: implement pcipci checks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mchehab@infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Sep 2006 13:55:40 +0100
Message-Id: <1158238540.21860.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again depends on the PCIAGP_FAIL patch for a define. Someone with more
card knowledge should look at the ALIMAGIK case and whether latency can
be safely to set to 0xA or so.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/zr36120.c linux-2.6.18-rc6-mm1/drivers/media/video/zr36120.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/zr36120.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/media/video/zr36120.c	2006-09-13 12:04:33.000000000 +0100
@@ -987,6 +987,8 @@
 			 VID_TYPE_SCALES;
 		if (ztv->have_tuner)
 			c.type |= VID_TYPE_TUNER;
+		if (pci_problems & (PCIPCI_FAIL|PCIAGP_FAIL))
+			c.type &= ~VID_TYPE_OVERLAY;
 		if (ztv->have_decoder) {
 			c.channels = ztv->card->video_inputs;
 			c.audios = ztv->card->audio_inputs;
@@ -1284,6 +1286,8 @@
 		struct video_buffer v;
 		if(!capable(CAP_SYS_ADMIN))
 			return -EPERM;
+		if (pcipci_problems & (PCIPCI_FAIL|PCIAGP_FAIL))
+			return -ENXIO;
 		if (copy_from_user(&v, arg,sizeof(v)))
 			return -EFAULT;
 		DEBUG(printk(CARD_DEBUG "VIDIOCSFBUF(%p,%d,%d,%d,%d)\n",CARD,v.base, v.width,v.height,v.depth,v.bytesperline));

