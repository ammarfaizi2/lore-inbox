Return-Path: <linux-kernel-owner+w=401wt.eu-S1751314AbXAOTL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXAOTL5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXAOTL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:11:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51478 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbXAOTL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:11:56 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Robert Hancock <hancockr@shaw.ca>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 3/9] V4L/DVB (5021): Cx88xx: Fix lockup on suspend
Date: Mon, 15 Jan 2007 16:37:05 -0200
Message-id: <20070115183705.PS7841950003@infradead.org>
In-Reply-To: <20070115183647.PS0588920000@infradead.org>
References: <20070115183647.PS0588920000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Robert Hancock <hancockr@shaw.ca>

Suspending with the cx88xx module loaded causes the system to lock up
because the cx88_audio_thread kthread was missing a try_to_freeze()
call, which caused it to go into a tight loop and result in softlockup
when suspending. Fix that.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-tvaudio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-tvaudio.c b/drivers/media/video/cx88/cx88-tvaudio.c
index 3482e01..2bd84d3 100644
--- a/drivers/media/video/cx88/cx88-tvaudio.c
+++ b/drivers/media/video/cx88/cx88-tvaudio.c
@@ -38,6 +38,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/errno.h>
+#include <linux/freezer.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -961,6 +962,7 @@ int cx88_audio_thread(void *data)
 		msleep_interruptible(1000);
 		if (kthread_should_stop())
 			break;
+		try_to_freeze();
 
 		/* just monitor the audio status for now ... */
 		memset(&t, 0, sizeof(t));

