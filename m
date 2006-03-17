Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932886AbWCQXHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbWCQXHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879AbWCQXHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:07:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17841 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932883AbWCQXHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:07:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Duncan Sands <duncan.sands@math.u-psud.fr>,
       Duncan Sands <baldrick@free.fr>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 11/21] Snd_cx88_create: don't dereference NULL core
Date: Fri, 17 Mar 2006 17:54:35 -0300
Message-id: <20060317205435.PS81205700011@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Duncan Sands <duncan.sands@math.u-psud.fr>
Date: 1142349159 \-0300

If the call to cx88_core_get returns a NULL value, it is dereferenced
by cx88_reset, and perhaps by cx88_core_put.  Spotted by the Coverity
checker.

Signed-off-by: Duncan Sands <baldrick@free.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-alsa.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-alsa.c b/drivers/media/video/cx88/cx88-alsa.c
index 2acccd6..bffef1d 100644
--- a/drivers/media/video/cx88/cx88-alsa.c
+++ b/drivers/media/video/cx88/cx88-alsa.c
@@ -672,6 +672,11 @@ static int __devinit snd_cx88_create(snd
 	chip = (snd_cx88_card_t *) card->private_data;
 
 	core = cx88_core_get(pci);
+	if (NULL == core) {
+		err = -EINVAL;
+		kfree (chip);
+		return err;
+	}
 
 	if (!pci_dma_supported(pci,0xffffffff)) {
 		dprintk(0, "%s/1: Oops: no 32bit PCI DMA ???\n",core->name);
@@ -688,11 +693,6 @@ static int __devinit snd_cx88_create(snd
 	spin_lock_init(&chip->reg_lock);
 
 	cx88_reset(core);
-	if (NULL == core) {
-		err = -EINVAL;
-		kfree (chip);
-		return err;
-	}
 	chip->core = core;
 
 	/* get irq */

