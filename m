Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVDILvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVDILvk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 07:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVDILvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 07:51:40 -0400
Received: from merke.itea.ntnu.no ([129.241.7.61]:12953 "EHLO
	merke.itea.ntnu.no") by vger.kernel.org with ESMTP id S261336AbVDILvg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 07:51:36 -0400
From: Per Christian Henden <perchrh@pvv.org>
To: benh@kernel.crashing.org
Subject: [PATCH] Add Mac mini sound support
Date: Sat, 9 Apr 2005 13:51:27 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 3215
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200504091351.27430.perchrh@pvv.org>
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds sound support on the Mac Mini by making a small change to the PowerMac sound card detection code.

Details: 

Original code:
>From sound/ppc/pmac.c  __init snd_pmac_detect(pmac_t *chip) :

 chip->model = PMAC_AWACS;
 ...
 if (device_is_compatible(sound, "AOAKeylargo")) {
  ...
  chip->model = PMAC_SNAPPER;
  ...
 }

The chip model is first set to AWACS, then because the check above returns true, it gets set to SNAPPER.
Using AWACS gives perfect sound, using SNAPPER gives no sound at all, so it should use AWACS instead.
Note that the mixer still doesn't work.

My simple patch makes the mentioned check return false on a Mac Mini.

Patch against 2.6.12-rc2:

diff -urpN -X dontdiff linux-2.6.12-rc2.orig/sound/ppc/pmac.c linux-2.6.12-rc2/sound/ppc/pmac.c
--- linux-2.6.12-rc2.orig/sound/ppc/pmac.c      2005-04-09 11:59:18.000000000 +0200
+++ linux-2.6.12-rc2/sound/ppc/pmac.c   2005-04-09 12:35:50.000000000 +0200
@@ -904,6 +904,8 @@ static int __init snd_pmac_detect(pmac_t
        else if (machine_is_compatible("PowerBook1,1")
                 || machine_is_compatible("AAPL,PowerBook1998"))
                chip->is_pbook_G3 = 1;
+       else if (machine_is_compatible("PowerMac10,1"))
+               chip->is_macmini = 1;
        chip->node = find_devices("awacs");
        if (chip->node)
                return 0; /* ok */
@@ -961,7 +963,7 @@ static int __init snd_pmac_detect(pmac_t
                chip->freq_table = tumbler_freqs;
                chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
        }
-       if (device_is_compatible(sound, "AOAKeylargo")) {
+       if (device_is_compatible(sound, "AOAKeylargo") && chip->is_macmini!=1) {
                /* Seems to support the stock AWACS frequencies, but has
                   a snapper mixer */
                chip->model = PMAC_SNAPPER;
diff -urpN -X dontdiff linux-2.6.12-rc2.orig/sound/ppc/pmac.h linux-2.6.12-rc2/sound/ppc/pmac.h
--- linux-2.6.12-rc2.orig/sound/ppc/pmac.h      2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6.12-rc2/sound/ppc/pmac.h   2005-04-09 12:04:42.000000000 +0200
@@ -110,6 +110,7 @@ struct snd_pmac {
        unsigned int has_iic : 1;
        unsigned int is_pbook_3400 : 1;
        unsigned int is_pbook_G3 : 1;
+       unsigned int is_macmini : 1;

        unsigned int can_byte_swap : 1;
        unsigned int can_duplex : 1;


-------------

The patch was tested by checking if I got sound support with the patch applied on my Mac Mini.

Thanks to Owen Stampflee at Yellowdog Linux for discovering that sound works when setting chip->model=PMAC_AWACS on the mini.

Please CC replies.

Cheers,
Per Christian Henden
