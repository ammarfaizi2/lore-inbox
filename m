Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965663AbWKGSDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965663AbWKGSDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965664AbWKGSDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:03:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28944 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965663AbWKGSDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:03:22 -0500
Date: Tue, 7 Nov 2006 19:03:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: sound/pci/ac97/ac97_patch.c: possible negative array index
Message-ID: <20061107180323.GI4729@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noted the following in sound/pci/ac97/ac97_patch.c:

<--  snip  -->

...
static int patch_ad1881_chained1(struct snd_ac97 * ac97, int idx, unsigned short codec_bits)
{
        static int cfg_bits[3] = { 1<<12, 1<<14, 1<<13 };
        unsigned short val;
        
        snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000, cfg_bits[idx]);
        snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0004);  // SDIE
        val = snd_ac97_read(ac97, AC97_VENDOR_ID2);
        if ((val & 0xff40) != 0x5340)
                return 0;
        if (codec_bits)
                snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, codec_bits);
        ac97->spec.ad18xx.chained[idx] = cfg_bits[idx];
        ac97->spec.ad18xx.id[idx] = val;
        ac97->spec.ad18xx.codec_cfg[idx] = codec_bits ? codec_bits : 0x0004;
        return 1;
}

static void patch_ad1881_chained(struct snd_ac97 * ac97, int unchained_idx, int cidx1, int cidx2)
{
        // already detected?
        if (ac97->spec.ad18xx.unchained[cidx1] || ac97->spec.ad18xx.chained[cidx1])
                cidx1 = -1;
        if (ac97->spec.ad18xx.unchained[cidx2] || ac97->spec.ad18xx.chained[cidx2])
                cidx2 = -1;
        if (cidx1 < 0 && cidx2 < 0)
                return;
        // test for chained codecs
        snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x7000,
                             ac97->spec.ad18xx.unchained[unchained_idx]);
        snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0002);          // ID1C
        ac97->spec.ad18xx.codec_cfg[unchained_idx] = 0x0002;
        if (cidx1 >= 0) {
                if (patch_ad1881_chained1(ac97, cidx1, 0x0006))         // SDIE | ID1C
                        patch_ad1881_chained1(ac97, cidx2, 0);
                else if (patch_ad1881_chained1(ac97, cidx2, 0x0006))    // SDIE | ID1C
                        patch_ad1881_chained1(ac97, cidx1, 0);
        } else if (cidx2 >= 0) {
                patch_ad1881_chained1(ac97, cidx2, 0);
        }
}
...

<--  snip  -->

If there are in patch_ad1881_chained() (cidx2 == -1) and (cidx1 >= 0), 
-1 will be used as array index in patch_ad1881_chained1().

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

