Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbTAOPFI>; Wed, 15 Jan 2003 10:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbTAOPFI>; Wed, 15 Jan 2003 10:05:08 -0500
Received: from [213.171.53.133] ([213.171.53.133]:42505 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S266622AbTAOPFH>;
	Wed, 15 Jan 2003 10:05:07 -0500
Date: Wed, 15 Jan 2003 18:16:11 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <1884972299.20030115181611@wr.miee.ru>
To: linux-kernel@vger.kernel.org
CC: Adam Belay <ambx1@neo.rr.com>, Jaroslav Kysela <perex@suse.cz>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: [2.5.58][PnP] Some small points.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All.
1) __pnp_remove_device(dev) call twice. First time in
pnpc_remove_device(dev). I think it's wrong.

--- drivers/pnp/card.c~ 2003-01-15 13:52:08.000000000 +0300
+++ drivers/pnp/card.c  2003-01-15 13:52:16.000000000 +0300
@@ -144,7 +144,6 @@
        list_for_each_safe(pos,temp,&card->devices){
                struct pnp_dev *dev = card_to_pnp_dev(pos);
                pnpc_remove_device(dev);
-               __pnp_remove_device(dev);
        }
 }

_______________________________
2) We've forgot to unreg driver on module unload in opl3sa2 driver.
--- sound/isa/opl3sa2.c~        2003-01-15 17:45:25.000000000 +0300
+++ sound/isa/opl3sa2.c 2003-01-15 17:47:00.000000000 +0300
@@ -881,6 +881,9 @@

        for (idx = 0; idx < SNDRV_CARDS; idx++)
                snd_card_free(snd_opl3sa2_cards[idx]);
+#ifdef CONFIG_PNP
+       pnpc_unregister_driver(&opl3sa2_pnpc_driver);
+#endif
 }

 module_init(alsa_card_opl3sa2_init)
_________________________________
3) Queston: Why we do free in this way?
static int snd_opl3sa2_free(opl3sa2_t *chip)
{
#ifdef CONFIG_PNP
        chip->dev = NULL;   -> Here. Why NULL? Who realy free resources and how?
#endif
#ifdef CONFIG_PM
        if (chip->pm_dev)
                pm_unregister(chip->pm_dev);
#endif
        if (chip->irq >= 0)
                free_irq(chip->irq, (void *)chip);
        if (chip->res_port) {
                release_resource(chip->res_port);
                kfree_nocheck(chip->res_port);
        }
        snd_magic_kfree(chip);
        return 0;
}
_______________________________________
4) Have we got ALSA driver that work absolutly and use PnP layer in
right ways?
Best regards. Ruslan.

