Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWI1Xpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWI1Xpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWI1Xpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:45:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:50622 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751209AbWI1Xpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:45:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ULEC3HBovT+pZFpcFe9hYObm2UHTgEAj36jM9m5wmSzKiN3zZaTP04oM7k3rIzUoqtKt/R/BTssvfX4Tp/1QoiWlp+MBeiJCZqpjqRhU8rn3i2Kgkv8VspKE2alebp6BSZMC4dNSb0HYd/CxNAuRMJr9tnTLudwtTLpJaA65ibA=
Message-ID: <451C5EAE.3050309@gmail.com>
Date: Thu, 28 Sep 2006 19:45:50 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: perex@suse.cz
CC: linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: [PATCH] Dereference after free in snd_hwdep_release()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

snd_card_file_remove() may free hw->card so we can't dereference
hw->card->module after that.

Coverity ID 1420.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 9aa9d94..46b4768 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -158,6 +158,7 @@ static int snd_hwdep_release(struct inod
 {
 	int err = -ENXIO;
 	struct snd_hwdep *hw = file->private_data;
+	struct module *mod = hw->card->module;
 	mutex_lock(&hw->open_mutex);
 	if (hw->ops.release) {
 		err = hw->ops.release(hw, file);
@@ -167,7 +168,7 @@ static int snd_hwdep_release(struct inod
 		hw->used--;
 	snd_card_file_remove(hw->card, file);
 	mutex_unlock(&hw->open_mutex);
-	module_put(hw->card->module);
+	module_put(mod);
 	return err;
 }
 


