Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267274AbTG1Msi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 08:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbTG1Msi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 08:48:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30187 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267274AbTG1Mse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 08:48:34 -0400
Date: Mon, 28 Jul 2003 15:03:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, trivial@rustcorp.com.au
Subject: [patch 2.6.0-test2: com20020_cs.c doesn't compile
Message-ID: <20030728130344.GF25402@fs.tum.de>
References: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 10:08:40AM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.0-test1 to v2.6.0-test2
> ============================================
>...
> Christoph Hellwig:
>...
>   o [ARCNET]: Fix module refcounting
>...

drivers/net/pcmcia/com20020_cs.c wasn't changed, resulting in the 
following compile error:

<--  snip  -->

...
  CC      drivers/net/pcmcia/com20020_cs.o
drivers/net/pcmcia/com20020_cs.c: In function `com20020_attach':
drivers/net/pcmcia/com20020_cs.c:240: error: structure has no member 
named `open_close_ll'
make[3]: *** [drivers/net/pcmcia/com20020_cs.o] Error 1

<--  snip -->


The following patch fixes it:


--- linux-2.6.0-test2-full-no-smp/drivers/net/pcmcia/com20020_cs.c.tmp	2003-07-28 14:57:35.000000000 +0200
+++ linux-2.6.0-test2-full-no-smp/drivers/net/pcmcia/com20020_cs.c	2003-07-28 14:58:55.000000000 +0200
@@ -171,14 +171,6 @@
 
 ======================================================================*/
 
-static void com20020cs_open_close(struct net_device *dev, bool open)
-{
-    if (open)
-	MOD_INC_USE_COUNT;
-    else
-	MOD_DEC_USE_COUNT;
-}
-
 static dev_link_t *com20020_attach(void)
 {
     client_reg_t client_reg;
@@ -237,7 +229,7 @@
     lp->backplane = backplane;
     lp->clockp = clockp;
     lp->clockm = clockm & 3;
-    lp->hw.open_close_ll = com20020cs_open_close;
+    lp->hw.owner = THIS_MODULE;
 
     link->irq.Instance = info->dev = dev;
     link->priv = info;



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

