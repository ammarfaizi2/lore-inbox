Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbSKKHba>; Mon, 11 Nov 2002 02:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265641AbSKKHba>; Mon, 11 Nov 2002 02:31:30 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:63140 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S265636AbSKKHb2>; Mon, 11 Nov 2002 02:31:28 -0500
Message-ID: <3DCF5E5D.3030808@nortelnetworks.com>
Date: Mon, 11 Nov 2002 02:38:05 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: perez@suze.cz
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: patch for cs46xx driver on 2.5.47 to fix compilation error
Content-Type: multipart/mixed;
 boundary="------------020108040405000604040007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020108040405000604040007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The attached patch fixes compilation when the CONFIG_SND_CS46XX_NEW_DSP 
  option is not enabled.

The patch wraps _cs46xx_adjust_sample_rate() in #ifdefs since it is only 
used when the above option is defined, and moves an up() call back to 
the procedure that did the down() where it conceptually belongs.

Chris





-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

--------------020108040405000604040007
Content-Type: text/plain;
 name="soundcard.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="soundcard.patch"

diff -Nur linus-2.5/sound/pci/cs46xx/cs46xx_lib.c localtree/sound/pci/cs46xx/cs46xx_lib.c
--- linus-2.5/sound/pci/cs46xx/cs46xx_lib.c	2002-11-11 02:30:03.000000000 -0500
+++ localtree/sound/pci/cs46xx/cs46xx_lib.c	2002-11-11 02:23:16.000000000 -0500
@@ -1023,6 +1023,7 @@
 	return result;
 }
 
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
 static int _cs46xx_adjust_sample_rate (cs46xx_t *chip, cs46xx_pcm_t *cpcm,
 				       int sample_rate) 
 {
@@ -1051,7 +1052,6 @@
 									 cpcm->hw_addr,
 									 cpcm->pcm_channel->pcm_channel_id)) == NULL) {
 			snd_printk(KERN_ERR "cs46xx: failed to re-create virtual PCM channel\n");
-			up (&chip->spos_mutex);
 			return -ENXIO;
 		}
 
@@ -1061,6 +1061,8 @@
 
 	return 0;
 }
+#endif
+
 static int snd_cs46xx_playback_hw_params(snd_pcm_substream_t * substream,
 					 snd_pcm_hw_params_t * hw_params)
 {
@@ -1083,6 +1085,7 @@
 	if (cpcm->pcm_channel->pcm_channel_id != DSP_IEC958_CHANNEL ||
 	    !(chip->dsp_spos_instance->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE)) {
 		if (_cs46xx_adjust_sample_rate (chip,cpcm,sample_rate)) {
+			up (&chip->spos_mutex);
 			return -ENXIO;
 		}
 	}

--------------020108040405000604040007--

