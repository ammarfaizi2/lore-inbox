Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSFZJWi>; Wed, 26 Jun 2002 05:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316490AbSFZJWh>; Wed, 26 Jun 2002 05:22:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:36849 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316390AbSFZJWg>; Wed, 26 Jun 2002 05:22:36 -0400
Date: Wed, 26 Jun 2002 11:22:33 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Paul Vojta <vojta@Math.Berkeley.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] fix .text.exit error in dmfe.c
In-Reply-To: <200206260418.VAA10648@blue3.math.Berkeley.EDU>
Message-ID: <Pine.NEB.4.44.0206261119460.4790-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002, Paul Vojta wrote:

> Folks:
>
> When I compile dmfe.o statically into the 2.5.24 kernel, I get:
>
> drivers/built-in.o(.data+0xba34): undefined reference to `local symbols in discarded section .text.exit'
>
> The following patch seems to fix the problem:
>
> --- drivers/net/tulip/dmfe.c	Thu Jun 20 15:53:56 2002
> +++ drivers/net/tulip/dmfe.c.new	Tue Jun 25 20:50:57 2002
> @@ -461,7 +461,7 @@
>  }
>
>
> -static void __exit dmfe_remove_one (struct pci_dev *pdev)
> +static void __devexit dmfe_remove_one (struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
>  	struct dmfe_board_info *db = dev->priv;
>
>
> I'm not (usually) a kernel hacker; I'm just mimicking what others are doing
> to fix similar errors.  However, it is working for me right now.


Your patch works, but as long as tulip hasn't become a hotpluggable driver
the following patch (that also fixes a similar .text.exit error in
de2104x.c)  should be more correct:


--- drivers/net/tulip/de2104x.c.old	Sun May 12 13:55:28 2002
+++ drivers/net/tulip/de2104x.c	Sun May 12 13:56:09 2002
@@ -2216,7 +2216,9 @@
 	name:		DRV_NAME,
 	id_table:	de_pci_tbl,
 	probe:		de_init_one,
+#ifdef MODULE
 	remove:		de_remove_one,
+#endif
 #ifdef CONFIG_PM
 	suspend:	de_suspend,
 	resume:		de_resume,
--- drivers/net/tulip/dmfe.c.old	Sun May 12 13:47:59 2002
+++ drivers/net/tulip/dmfe.c	Sun May 12 13:54:54 2002
@@ -1986,7 +1986,9 @@
 	name:		"dmfe",
 	id_table:	dmfe_pci_tbl,
 	probe:		dmfe_init_one,
-	remove:		__devexit_p(dmfe_remove_one),
+#ifdef MODULE
+	remove:		dmfe_remove_one,
+#endif
 };

 MODULE_AUTHOR("Sten Wang, sten_wang@davicom.com.tw");


> --Paul Vojta, vojta@math.berkeley.edu

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

