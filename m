Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268275AbTALLv4>; Sun, 12 Jan 2003 06:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268274AbTALLv4>; Sun, 12 Jan 2003 06:51:56 -0500
Received: from tag.witbe.net ([81.88.96.48]:7940 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S267423AbTALLvx>;
	Sun, 12 Jan 2003 06:51:53 -0500
From: "Paul Rolland" <rol@witbe.net>
To: <linux-kernel@vger.kernel.org>, <Perex@suze.cz>
Cc: <rol@as2917.net>
Subject: [PATCH 2.5.56] Sound core not compiling without /proc support
Date: Sun, 12 Jan 2003 13:00:40 +0100
Organization: Witbe.net
Message-ID: <008f01c2ba32$3aab6f40$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a quick patch to allow sound support to compile correctly
when not using /proc support.

Regards,
Paul Rolland, rol@as2917.net

15 [12:53] rol@donald:/kernels> diff -uN linux-2.5.56/sound/core/init.c
linux-2.5.56-work/sound/core/init.c 
--- linux-2.5.56/sound/core/init.c      2003-01-10 21:11:28.000000000
+0100
+++ linux-2.5.56-work/sound/core/init.c 2003-01-12 12:52:13.000000000
+0100
@@ -115,16 +115,20 @@
                snd_printd("unable to register control minors\n");
                goto __error;
        }
+#ifdef CONFIG_PROC_FS
        if ((err = snd_info_card_create(card)) < 0) {
                snd_printd("unable to create card info\n");
                goto __error_ctl;
        }
+#endif
        if (extra_size > 0)
                card->private_data = (char *)card + sizeof(snd_card_t);
        return card;
 
+#ifdef CONFIG_PROC_FS
       __error_ctl:
        snd_ctl_unregister(card);
+#endif
       __error:
        kfree(card);
        return NULL;
@@ -273,10 +277,12 @@
        if (card->private_free)
                card->private_free(card);
        snd_info_free_entry(card->proc_id);
+#ifdef CONFIG_PROC_FS
        if (snd_info_card_free(card) < 0) {
                snd_printk(KERN_WARNING "unable to free card info\n");
                /* Not fatal error */
        }
+#endif
        while (card->s_f_ops) {
                s_f_ops = card->s_f_ops;
                card->s_f_ops = s_f_ops->next;

