Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUJTPSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUJTPSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUJTPOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:14:45 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:21935 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261232AbUJTPIM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:08:12 -0400
To: video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix mmap access of transport stream from saa7134
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Date: Wed, 20 Oct 2004 17:07:53 +0200
Message-ID: <yw1xacuh4ed2.fsf@mru.ath.cx>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes mmap access of transport stream from saa7134/saa6752hs.
It causes the encoder to be initialized when the device is opened,
instead of on the first call to read().

The patch is against 2.6.9.

Signed-off-by: Måns Rullgård <mru@mru.ath.cx>

===== drivers/media/video/saa7134/saa7134-ts.c 1.13 vs edited =====
--- 1.13/drivers/media/video/saa7134/saa7134-ts.c	2004-07-12 10:01:15 +02:00
+++ edited/drivers/media/video/saa7134/saa7134-ts.c	2004-10-20 17:02:08 +02:00
@@ -211,10 +211,10 @@
 	if (dev->ts.users)
 		goto done;
 
-	dev->ts.started = 0;
 	dev->ts.users++;
 	file->private_data = dev;
 	err = 0;
+	ts_init_encoder(dev, NULL);
 
  done:
 	up(&dev->ts.ts.lock);
@@ -233,8 +233,7 @@
 	dev->ts.users--;
 
 	/* stop the encoder */
-	if (dev->ts.started)
-	      	ts_reset_encoder(dev);
+	ts_reset_encoder(dev);
   
 	up(&dev->ts.ts.lock);
 	return 0;
@@ -245,11 +244,6 @@
 {
 	struct saa7134_dev *dev = file->private_data;
 
-	if (!dev->ts.started) {
-		ts_init_encoder(dev, NULL);
-		dev->ts.started = 1;
-	}
-  
 	return videobuf_read_stream(file, &dev->ts.ts, data, count, ppos, 0);
 }
 


-- 
Måns Rullgård
mru@mru.ath.cx
