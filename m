Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946155AbWKAFgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946155AbWKAFgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946274AbWKAFgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:36:45 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44487 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946221AbWKAFgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:36:32 -0500
Message-Id: <20061101053645.058617000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:51 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Florin Malita <fmalita@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/61] ALSA: Dereference after free in snd_hwdep_release()
Content-Disposition: inline; filename=alsa-dereference-after-free-in-snd_hwdep_release.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Florin Malita <fmalita@gmail.com>

[PATCH] ALSA: Dereference after free in snd_hwdep_release()

snd_card_file_remove() may free hw->card so we can't dereference
hw->card->module after that.

Coverity ID 1420.

This bug actually causes an Oops at usb-disconnection, especially
with CONFIG_PREEMPT.

From: Florin Malita <fmalita@gmail.com>
Signed-off-by: Florin Malita <fmalita@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 sound/core/hwdep.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.18.1.orig/sound/core/hwdep.c
+++ linux-2.6.18.1/sound/core/hwdep.c
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
 

--
