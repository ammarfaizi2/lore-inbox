Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWGQQqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWGQQqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWGQQcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:33978 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750941AbWGQQcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:01 -0400
Date: Mon, 17 Jul 2006 09:28:46 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 35/45] ALSA: Fix workaround for AD1988A rev2 codec
Message-ID: <20060717162846.GJ4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-fix-workaround-for-ad1988a-rev2-codec.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix workaround for AD1988A rev2 codec

Fix the workaround for AD1988A rev2 codec not to apply to AD1988B codec
chips.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/hda/patch_analog.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- linux-2.6.17.6.orig/sound/pci/hda/patch_analog.c
+++ linux-2.6.17.6/sound/pci/hda/patch_analog.c
@@ -1488,6 +1488,9 @@ enum {
 /* reivision id to check workarounds */
 #define AD1988A_REV2		0x100200
 
+#define is_rev2(codec) \
+	((codec)->vendor_id == 0x11d41988 && \
+	 (codec)->revision_id == AD1988A_REV2)
 
 /*
  * mixers
@@ -2138,7 +2141,7 @@ static inline hda_nid_t ad1988_idx_to_da
 		/* A     B     C     D     E     F     G     H */
 		0x04, 0x05, 0x0a, 0x04, 0x06, 0x05, 0x0a, 0x06
 	};
-	if (codec->revision_id == AD1988A_REV2)
+	if (is_rev2(codec))
 		return idx_to_dac_rev2[idx];
 	else
 		return idx_to_dac[idx];
@@ -2507,7 +2510,7 @@ static int patch_ad1988(struct hda_codec
 	mutex_init(&spec->amp_mutex);
 	codec->spec = spec;
 
-	if (codec->revision_id == AD1988A_REV2)
+	if (is_rev2(codec))
 		snd_printk(KERN_INFO "patch_analog: AD1988A rev.2 is detected, enable workarounds\n");
 
 	board_config = snd_hda_check_board_config(codec, ad1988_cfg_tbl);
@@ -2533,13 +2536,13 @@ static int patch_ad1988(struct hda_codec
 	case AD1988_6STACK_DIG:
 		spec->multiout.max_channels = 8;
 		spec->multiout.num_dacs = 4;
-		if (codec->revision_id == AD1988A_REV2)
+		if (is_rev2(codec))
 			spec->multiout.dac_nids = ad1988_6stack_dac_nids_rev2;
 		else
 			spec->multiout.dac_nids = ad1988_6stack_dac_nids;
 		spec->input_mux = &ad1988_6stack_capture_source;
 		spec->num_mixers = 2;
-		if (codec->revision_id == AD1988A_REV2)
+		if (is_rev2(codec))
 			spec->mixers[0] = ad1988_6stack_mixers1_rev2;
 		else
 			spec->mixers[0] = ad1988_6stack_mixers1;
@@ -2555,7 +2558,7 @@ static int patch_ad1988(struct hda_codec
 	case AD1988_3STACK_DIG:
 		spec->multiout.max_channels = 6;
 		spec->multiout.num_dacs = 3;
-		if (codec->revision_id == AD1988A_REV2)
+		if (is_rev2(codec))
 			spec->multiout.dac_nids = ad1988_3stack_dac_nids_rev2;
 		else
 			spec->multiout.dac_nids = ad1988_3stack_dac_nids;
@@ -2563,7 +2566,7 @@ static int patch_ad1988(struct hda_codec
 		spec->channel_mode = ad1988_3stack_modes;
 		spec->num_channel_mode = ARRAY_SIZE(ad1988_3stack_modes);
 		spec->num_mixers = 2;
-		if (codec->revision_id == AD1988A_REV2)
+		if (is_rev2(codec))
 			spec->mixers[0] = ad1988_3stack_mixers1_rev2;
 		else
 			spec->mixers[0] = ad1988_3stack_mixers1;

--
