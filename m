Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTICP6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTICP6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:58:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33489 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263895AbTICP5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:57:34 -0400
Date: Wed, 3 Sep 2003 17:56:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Javier Achirica <achirica@users.sourceforge.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org,
       jgarzik@pobox.com
Subject: [patch] fix airo.c compile failure with gcc 2.95
Message-ID: <20030903155655.GB23729@fs.tum.de>
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva> <3F512F33.44537860@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F512F33.44537860@eyal.emu.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 09:11:47AM +1000, Eyal Lebedinsky wrote:
> Marcelo Tosatti wrote:
> > 
> > Hello,
> > 
> > Here goes -pre2. It contains an USB update, PPC merge, m68k merge, IDE
> 
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-pro
> totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer
>  -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
> -DMODULE -DM
> ODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions
> .h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=airo 
> -DEXPORT_SYMTAB -c ai
> ro.c
> airo.c: In function `airo_get_power':
> airo.c:5659: parse error before `int'
> airo.c:5660: `mode' undeclared (first use in this function)
> airo.c:5660: (Each undeclared identifier is reported only once
> airo.c:5660: for each function it appears in.)
> airo.c: In function `writerids':
> airo.c:6673: warning: unused variable `enabled'
> make[3]: *** [airo.o] Error 1
> make[3]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/net/wirel
> ess'
> 
> Cannot tell if it is a bad merge ('int mode =' line should be earlier?)
> or bad programming (declaration must come first).

I assume you are using gcc 2.95?

The patch below fixes it for both 2.6 and 2.4.

I've tested the compilation with 2.6.0-test4-mm5 and gcc 2.95.

cu
Adrian

--- linux-2.6.0-test4-mm5-modular-no-smp/drivers/net/wireless/airo.c.old	2003-09-03 17:41:16.000000000 +0200
+++ linux-2.6.0-test4-mm5-modular-no-smp/drivers/net/wireless/airo.c	2003-09-03 17:41:45.000000000 +0200
@@ -5662,9 +5662,10 @@
 			  char *extra)
 {
 	struct airo_info *local = dev->priv;
+	int mode;
 
 	readConfigRid(local, 1);
-	int mode = local->config.powerSaveMode;
+	mode = local->config.powerSaveMode;
 	if ((vwrq->disabled = (mode == POWERSAVE_CAM)))
 		return 0;
 	if ((vwrq->flags & IW_POWER_TYPE) == IW_POWER_TIMEOUT) {
