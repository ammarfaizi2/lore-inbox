Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUAZU6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 15:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUAZU6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 15:58:44 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34795 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265118AbUAZU6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 15:58:37 -0500
Date: Mon, 26 Jan 2004 21:58:29 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: [patch] 2.6.2-rc2: link error with IrDA drivers
Message-ID: <20040126205829.GF513@fs.tum.de>
References: <Pine.LNX.4.58.0401251844440.32583@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401251844440.32583@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 06:48:24PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.2-rc1 to v2.6.2-rc2
> ============================================
>...
> Jean Tourrilhes:
>   o [IRDA]: Update dongle api
>   o [IRDA]: Update actisys-sir driver
>   o [IRDA]: Update esr-sir driver
>   o [IRDA]: Update tekram-sir driver
>   o [IRDA]: Add litelink-sir driver
>   o [IRDA]: Add act200l-sir driver
>   o [IRDA]: Add girbil-sir driver
>   o [IRDA]: Add ma600-sir driver
>   o [IRDA]: Add mcp2120-sir driver
>   o [IRDA]: Add old_belkin-sir driver
>   o [IRDA]: Kconfig changes to enable new drivers into the build, from
>     Martin Diehl
>...

This change causes the following compile error when trying to compile 
an old plus a new version of one driver statically into the kernel:

<--  snip  -->

...
  LD      drivers/net/irda/built-in.o
drivers/net/irda/girbil-sir.o(.init.text+0x0): In function `girbil_init':
: multiple definition of `girbil_init'
drivers/net/irda/girbil.o(.init.text+0x0): first defined here
drivers/net/irda/girbil-sir.o(.exit.text+0x0): In function `girbil_cleanup':
: multiple definition of `girbil_cleanup'
drivers/net/irda/girbil.o(.exit.text+0x0): first defined here
drivers/net/irda/old_belkin-sir.o(.init.text+0x0): In function `old_belkin_init':
: multiple definition of `old_belkin_init'
drivers/net/irda/old_belkin.o(.init.text+0x0): first defined here
drivers/net/irda/old_belkin-sir.o(.exit.text+0x0): In function 
`old_belkin_cleanup':
: multiple definition of `old_belkin_cleanup'
drivers/net/irda/old_belkin.o(.exit.text+0x0): first defined here
drivers/net/irda/mcp2120-sir.o(.init.text+0x0): In function `mcp2120_init':
: multiple definition of `mcp2120_init'
drivers/net/irda/mcp2120.o(.init.text+0x0): first defined here
drivers/net/irda/mcp2120-sir.o(.exit.text+0x0): In function `mcp2120_cleanup':
: multiple definition of `mcp2120_cleanup'
drivers/net/irda/mcp2120.o(.exit.text+0x0): first defined here
drivers/net/irda/act200l-sir.o(.init.text+0x0): In function `act200l_init':
: multiple definition of `act200l_init'
drivers/net/irda/act200l.o(.init.text+0x0): first defined here
drivers/net/irda/act200l-sir.o(.exit.text+0x0): In function `act200l_cleanup':
: multiple definition of `act200l_cleanup'
drivers/net/irda/act200l.o(.exit.text+0x0): first defined here
make[3]: *** [drivers/net/irda/built-in.o] Error 1

<--  snip  -->

The patch below fixes this issue by disallowing building an old driver 
if the new driver was included staticallly.


Please apply
Adrian


--- linux-2.6.2-rc2-full/drivers/net/irda/Kconfig.old	2004-01-26 19:40:41.000000000 +0100
+++ linux-2.6.2-rc2-full/drivers/net/irda/Kconfig	2004-01-26 19:46:43.000000000 +0100
@@ -201,7 +201,7 @@
 
 config GIRBIL_DONGLE_OLD
 	tristate "Greenwich GIrBIL dongle"
-	depends on DONGLE_OLD && IRDA
+	depends on DONGLE_OLD && IRDA && GIRBIL_DONGLE!=y
 	help
 	  Say Y here if you want to build support for the Greenwich GIrBIL
 	  dongle.  To compile it as a module, choose M here.  The Greenwich
@@ -223,7 +223,7 @@
 
 config MCP2120_DONGLE_OLD
 	tristate "Microchip MCP2120"
-	depends on DONGLE_OLD && IRDA
+	depends on DONGLE_OLD && IRDA && MCP2120_DONGLE!=y
 	help
 	  Say Y here if you want to build support for the Microchip MCP2120
 	  dongle.  To compile it as a module, choose M here.  The MCP2120 dongle
@@ -237,7 +237,7 @@
 
 config OLD_BELKIN_DONGLE_OLD
 	tristate "Old Belkin dongle"
-	depends on DONGLE_OLD && IRDA
+	depends on DONGLE_OLD && IRDA && OLD_BELKIN_DONGLE!=y
 	help
 	  Say Y here if you want to build support for the Adaptec Airport 1000
 	  and 2000 dongles.  To compile it as a module, choose M here: the module
@@ -246,7 +246,7 @@
 
 config ACT200L_DONGLE_OLD
 	tristate "ACTiSYS IR-200L dongle (EXPERIMENTAL)"
-	depends on DONGLE_OLD && EXPERIMENTAL && IRDA
+	depends on DONGLE_OLD && EXPERIMENTAL && IRDA && ACT200L_DONGLE!=y
 	help
 	  Say Y here if you want to build support for the ACTiSYS IR-200L
 	  dongle.  To compile it as a module, choose M here.  The ACTiSYS
