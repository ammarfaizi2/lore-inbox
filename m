Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbTGLQro (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbTGLQro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:47:44 -0400
Received: from 213-84-203-196.adsl.xs4all.nl ([213.84.203.196]:57860 "EHLO
	gateway.bencastricum.nl") by vger.kernel.org with ESMTP
	id S266205AbTGLQrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:47:40 -0400
Message-ID: <001501c34896$baddd3e0$0802a8c0@pc>
From: "Ben Castricum" <lk@bencastricum.nl>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <000901c343df$9165ed10$0802a8c0@pc> <1057578275.2749.11.camel@dhcp22.swansea.linux.org.uk>
Subject: Re: 2.4.22-pre3 : SoundBlaster IDE interface missing
Date: Sat, 12 Jul 2003 18:57:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sul, 2003-07-06 at 17:56, Ben Castricum wrote:
> > I have one of those ancients ISA-PNP SoundBlaster cards with an
additional
> > IDE interface on it. It all worked perfectly up till 2.4.22-pre2 but
with
> > pre3 the IDE interface is no longer detected.
>
> Oops. I have redone the initialization for the ISAPnP IDE devices so its
> quite possible I got this bit wrong. I'll take a look at it
> today/tomorrow see why its vanished.

I took a look at it myself as well and it seems that the code was just
removed. This patch restores a couple of line from pre2 and fixes the
problem for me. It's diffed againts the current bk-2.4 tree.

Hope this helps,
Ben


diff -u linux/drivers/ide/ide-pnp.c linux-fix/drivers/ide/ide-pnp.c
--- linux/drivers/ide/ide-pnp.c 2003-07-12 18:03:05.000000000 +0200
+++ linux-fix/drivers/ide/ide-pnp.c     2003-07-12 18:26:13.000000000 +0200
@@ -99,7 +99,7 @@
  * Probe for ISA PnP IDE interfaces.
  */

-static void pnpide_init(int enable)
+void __init pnpide_init(int enable)
 {
        struct pci_dev *dev = NULL;
        struct pnp_dev_t *dev_type;
diff -u linux/drivers/ide/ide.c linux-fix/drivers/ide/ide.c
--- linux/drivers/ide/ide.c     2003-07-12 18:03:01.000000000 +0200
+++ linux-fix/drivers/ide/ide.c 2003-07-12 18:25:11.000000000 +0200
@@ -2318,6 +2318,12 @@
                buddha_init();
        }
 #endif /* CONFIG_BLK_DEV_BUDDHA */
+#if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_ISAPNP)
+       {
+               extern void pnpide_init(int enable);
+               pnpide_init(1);
+       }
+#endif /* CONFIG_BLK_DEV_ISAPNP */
 }

 void __init ide_init_builtin_subdrivers (void)

