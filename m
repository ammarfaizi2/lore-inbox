Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSLBSOx>; Mon, 2 Dec 2002 13:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSLBSOx>; Mon, 2 Dec 2002 13:14:53 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39632 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264666AbSLBSOv>; Mon, 2 Dec 2002 13:14:51 -0500
Date: Mon, 2 Dec 2002 19:22:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Bill Davidsen <davidsen@tmr.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [BUG]2.5.49-ac1 - more info on make error
Message-ID: <20021202182213.GC775@fs.tum.de>
References: <Pine.LNX.4.44.0211271540270.7715-201000@bilbo.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211271540270.7715-201000@bilbo.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 03:45:24PM -0500, Bill Davidsen wrote:

>...
Content-Description: config
>...
> CONFIG_HOTPLUG=y
>...
> #
> # Tulip family network device support
> #
> CONFIG_NET_TULIP=y
> CONFIG_DE2104X=y
>...

./drivers/net/tulip/de2104x.o(.data+0x74): undefined reference to `local 
symbols in discarded section .exit.text'


In drivers/net/tulip/de2104x.c the function de_remove_on is __exit but 
the pointer to it is __devexit_p.

Two possible solutions:

1. Make this driver hot-pluggable. Jeff Garzik vetoes against this 
   solution.

2. Change the __devexit_p to an #ifdef MODULE (it's ugly, but it lets
   the driver compiles with all combinations of config options without
   making it hot-pluggable):

--- drivers/net/tulip/de2104x.c.old	2002-12-02 19:16:24.000000000 +0100
+++ drivers/net/tulip/de2104x.c	2002-12-02 19:18:18.000000000 +0100
@@ -2217,8 +2217,9 @@
 	.name		= DRV_NAME,
 	.id_table	= de_pci_tbl,
 	.probe		= de_init_one,
-#warning only here to fix build.  should be __exit_p not __devexit_p.
-	.remove		= __devexit_p(de_remove_one),
+#ifdef MODULE
+	.remove		= de_remove_one,
+#endif
 #ifdef CONFIG_PM
 	.suspend	= de_suspend,
 	.resume		= de_resume,


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

