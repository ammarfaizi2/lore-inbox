Return-Path: <linux-kernel-owner+w=401wt.eu-S933001AbWL0RLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001AbWL0RLX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932991AbWL0RKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:10:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41425 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932993AbWL0RKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:10:07 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Amit Choudhary <amit2030@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 18/28] V4L/DVB (4990): Cpia2/cpia2_usb.c: fix error-path
	leak
Date: Wed, 27 Dec 2006 14:57:30 -0200
Message-id: <20061227165730.PS80878600018@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Amit Choudhary <amit2030@gmail.com>

Free previously allocated memory (in array elements) if kmalloc() returns
NULL in submit_urbs().

Signed-off-by: Amit Choudhary <amit2030@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cpia2/cpia2_usb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/cpia2/cpia2_usb.c b/drivers/media/video/cpia2/cpia2_usb.c
index 28dc6a1..d8e9298 100644
--- a/drivers/media/video/cpia2/cpia2_usb.c
+++ b/drivers/media/video/cpia2/cpia2_usb.c
@@ -640,6 +640,10 @@ static int submit_urbs(struct camera_dat
 		cam->sbuf[i].data =
 		    kmalloc(FRAMES_PER_DESC * FRAME_SIZE_PER_DESC, GFP_KERNEL);
 		if (!cam->sbuf[i].data) {
+			while (--i >= 0) {
+				kfree(cam->sbuf[i].data);
+				cam->sbuf[i].data = NULL;
+			}
 			return -ENOMEM;
 		}
 	}

