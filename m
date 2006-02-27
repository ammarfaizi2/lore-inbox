Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWB0Weo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWB0Weo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWB0WcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:32:06 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:57729 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932358AbWB0Wb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:57 -0500
Message-Id: <20060227223352.699835000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:21 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, tiwai@suse.de, greg@kroah.com,
       jk@blackdown.de, perex@suse.cz, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 21/39] [PATCH] Fix snd-usb-audio in 32-bit compat environment
Content-Disposition: inline; filename=fix-snd-usb-audio-in-32-bit-compat-environment.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

I'm getting oopses with snd-usb-audio in 32-bit compat environments:
control_compat.c:get_ctl_type() doesn't initialize 'info', so
'itemlist[uinfo->value.enumerated.item]' in
usbmixer.c:mixer_ctl_selector_info() might access random memory (The 'if
((int)uinfo->value.enumerated.item >= cval->max)' doesn't fix all problems
because of the unsigned -> signed conversion.)

Signed-off-by: Juergen Kreileder <jk@blackdown.de>
Cc: Jaroslav Kysela <perex@suse.cz>
Acked-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 sound/core/control_compat.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

--- linux-2.6.15.4.orig/sound/core/control_compat.c
+++ linux-2.6.15.4/sound/core/control_compat.c
@@ -164,7 +164,7 @@ struct sndrv_ctl_elem_value32 {
 static int get_ctl_type(snd_card_t *card, snd_ctl_elem_id_t *id, int *countp)
 {
 	snd_kcontrol_t *kctl;
-	snd_ctl_elem_info_t info;
+	snd_ctl_elem_info_t *info;
 	int err;
 
 	down_read(&card->controls_rwsem);
@@ -173,13 +173,19 @@ static int get_ctl_type(snd_card_t *card
 		up_read(&card->controls_rwsem);
 		return -ENXIO;
 	}
-	info.id = *id;
-	err = kctl->info(kctl, &info);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (info == NULL) {
+		up_read(&card->controls_rwsem);
+		return -ENOMEM;
+	}
+	info->id = *id;
+	err = kctl->info(kctl, info);
 	up_read(&card->controls_rwsem);
 	if (err >= 0) {
-		err = info.type;
-		*countp = info.count;
+		err = info->type;
+		*countp = info->count;
 	}
+	kfree(info);
 	return err;
 }
 

--
