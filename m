Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVDMLXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVDMLXi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVDMLXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:23:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:49070 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261314AbVDMLXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:23:30 -0400
Subject: [PATCH] ppc64: improve g5 sound headphone mute
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <jefyxvruip.fsf@sykes.suse.de>
References: <1113282436.21548.42.camel@gaston>
	 <jell7nu6yk.fsf@sykes.suse.de> <1113344225.21548.108.camel@gaston>
	 <jey8bnk4lj.fsf@sykes.suse.de> <1113345561.5387.114.camel@gaston>
	 <jed5szk3gh.fsf@sykes.suse.de> <1113347296.5388.121.camel@gaston>
	 <je8y3nk117.fsf@sykes.suse.de> <1113350355.5387.129.camel@gaston>
	 <jefyxvruip.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 21:23:02 +1000
Message-Id: <1113391382.5463.20.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes a couple more issues with the management of the GPIOs
dealing with headphone and line out mute on the G5. It should fix the
remaining problems of people not getting any sound out of the headphone
jack.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/sound/ppc/tumbler.c
===================================================================
--- linux-work.orig/sound/ppc/tumbler.c	2005-04-12 18:07:50.000000000 +1000
+++ linux-work/sound/ppc/tumbler.c	2005-04-13 18:02:26.000000000 +1000
@@ -177,11 +177,22 @@
 	if (! gp->addr)
 		return;
 	active = active ? gp->active_val : gp->inactive_val;
-
 	do_gpio_write(gp, active);
 	DBG("(I) gpio %x write %d\n", gp->addr, active);
 }
 
+static int check_audio_gpio(pmac_gpio_t *gp)
+{
+	int ret;
+
+	if (! gp->addr)
+		return 0;
+
+	ret = do_gpio_read(gp);
+
+	return (ret & 0xd) == (gp->active_val & 0xd);
+}
+
 static int read_audio_gpio(pmac_gpio_t *gp)
 {
 	int ret;
@@ -683,7 +694,7 @@
 	}
 	if (gp == NULL)
 		return -EINVAL;
-	ucontrol->value.integer.value[0] = ! read_audio_gpio(gp);
+	ucontrol->value.integer.value[0] = !check_audio_gpio(gp);
 	return 0;
 }
 
@@ -711,7 +722,7 @@
 	}
 	if (gp == NULL)
 		return -EINVAL;
-	val = ! read_audio_gpio(gp);
+	val = ! check_audio_gpio(gp);
 	if (val != ucontrol->value.integer.value[0]) {
 		write_audio_gpio(gp, ! ucontrol->value.integer.value[0]);
 		return 1;
@@ -897,11 +908,11 @@
 
 static void check_mute(pmac_t *chip, pmac_gpio_t *gp, int val, int do_notify, snd_kcontrol_t *sw)
 {
-	//pmac_tumbler_t *mix = chip->mixer_data;
-	if (val != read_audio_gpio(gp)) {
+	if (check_audio_gpio(gp) != val) {
 		write_audio_gpio(gp, val);
 		if (do_notify)
-			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE, &sw->id);
+			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &sw->id);
 	}
 }
 


