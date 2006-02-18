Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWBRSum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWBRSum (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 13:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWBRSum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 13:50:42 -0500
Received: from smtp.blackdown.de ([213.239.206.42]:15497 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S932117AbWBRSul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 13:50:41 -0500
From: Juergen Kreileder <jk@blackdown.de>
To: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [patch] Fix snd-usb-audio in 32-bit compat environemt
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: alsa-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Date: Sat, 18 Feb 2006 19:50:37 +0100
Message-ID: <878xs85wn6.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting oopses with snd-usb-audio in 32-bit compat environments:
control_compat.c:get_ctl_type() doesn't initialize 'info', so
'itemlist[uinfo->value.enumerated.item]' in
usbmixer.c:mixer_ctl_selector_info() might access random memory
(The 'if ((int)uinfo->value.enumerated.item >= cval->max)' doesn't fix
all problems because of the unsigned -> signed conversion.)

Here's a fix:

Signed-off-by: Juergen Kreileder <jk@blackdown.de>

--- linux-mm-vanilla/sound/core/control_compat.c	2006-02-18 17:00:17.000000000 +0100
+++ linux-mm/sound/core/control_compat.c	2006-02-18 19:17:45.000000000 +0100
@@ -167,7 +167,7 @@ static int get_ctl_type(struct snd_card 
 			int *countp)
 {
 	struct snd_kcontrol *kctl;
-	struct snd_ctl_elem_info info;
+	struct snd_ctl_elem_info *info;
 	int err;
 
 	down_read(&card->controls_rwsem);
@@ -176,13 +176,19 @@ static int get_ctl_type(struct snd_card 
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
 
=

Tested on ppc64.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
