Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133088AbQL3Ko0>; Sat, 30 Dec 2000 05:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133115AbQL3KoH>; Sat, 30 Dec 2000 05:44:07 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:49118 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S133088AbQL3KoD>; Sat, 30 Dec 2000 05:44:03 -0500
Message-ID: <3A4DB6B0.F5037661@uow.edu.au>
Date: Sat, 30 Dec 2000 21:19:28 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Davis <fdavis112@juno.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: test13-pre6 compile error..network.o
In-Reply-To: <20001230.030356.-209335.1.fdavis112@juno.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>      I received the following error while compiling test13-pre6 . 
> 
> net/network.o: In function `lecd_attach':
> net/network.o(.text+0x5ce78): undefined reference to `prepare_trdev'
> net/network.o(.text+0x5ce88): undefined reference to `prepare_etherdev'
> net/network.o(.text+0x5cee3): undefined reference to `publish_netdev'
> make: *** [vmlinux] Error 1

This is caused by some cross-patch leakage between Alan and Linus.

This should fix it:

--- linux-2.4.0-test13-pre6/net/atm/lec.c	Sat Dec 30 18:38:55 2000
+++ linux-akpm/net/atm/lec.c	Sat Dec 30 21:17:11 2000
@@ -772,10 +772,10 @@
                 size = sizeof(struct lec_priv);
 #ifdef CONFIG_TR
                 if (is_trdev)
-                        dev_lec[i] = prepare_trdev(NULL, size);
+                        dev_lec[i] = init_trdev(NULL, size);
                 else
 #endif
-                dev_lec[i] = prepare_etherdev(NULL, size);
+                dev_lec[i] = init_etherdev(NULL, size);
                 if (!dev_lec[i])
                         return -ENOMEM;
 
@@ -783,7 +783,6 @@
                 priv->is_trdev = is_trdev;
                 sprintf(dev_lec[i]->name, "lec%d", i);
                 lec_init(dev_lec[i]);
-		publish_netdev(dev_lec[i]);
         } else {
                 priv = dev_lec[i]->priv;
                 if (priv->lecd)
@@ -858,7 +857,7 @@
         for (i = 0; i < MAX_LEC_ITF; i++) {
                 if (dev_lec[i] != NULL) {
                         priv = (struct lec_priv *)dev_lec[i]->priv;
-                        unregister_netdev(dev_lec[i]);
+                        unregister_trdev(dev_lec[i]);
                         kfree(dev_lec[i]);
                         dev_lec[i] = NULL;
                 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
