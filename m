Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287886AbSBDAQo>; Sun, 3 Feb 2002 19:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSBDAQZ>; Sun, 3 Feb 2002 19:16:25 -0500
Received: from harddata.com ([216.123.194.198]:50694 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S287279AbSBDAQT>;
	Sun, 3 Feb 2002 19:16:19 -0500
Date: Sun, 3 Feb 2002 17:16:15 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Symbol troubles in 2.4.18pre... kernels
Message-ID: <20020203171615.A12981@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   
Compiling 2.4.18pre7, and also 2.4.18pre7ac, runs into various troubles
with symbols.  Here is what I got more or less accidentally. :-)


A module drivers/char/drm/sis.o ends up with unresolved symbols

depmod: 	sis_free
depmod: 	sis_malloc

The trouble is that these modules are exported by drivers/video/sis/sis_main.c
so depmod has valid complaints if the first was configured and the other
not.  So this is a source error or a configuration error depending if
these two are supposed to be independent or not.


'isa_eth_io_copy_and_sum' is defined only for some architectures but
assorted modules, like drivers/net/3c503.o and few others, can be
configured, say, for Alpha and 'depmod' once again complains about
unresolved symbols.  I do not think that anybody will really miss that
on Alpha but maybe configuring them in should be disallowed?


Some sound modules are using 'mdelay', defined in linux/delay.h,
but are not including this header.  Here, at last, the patch is trivial. :-)

--- linux-2.4.18p7/drivers/sound/ymfpci.c~	Fri Dec 21 10:41:55 2001
+++ linux-2.4.18p7/drivers/sound/ymfpci.c	Sun Feb  3 16:39:51 2002
@@ -46,6 +46,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
--- linux-2.4.18p7/drivers/sound/opl3sa2.c~	Thu Jan 31 15:29:51 2002
+++ linux-2.4.18p7/drivers/sound/opl3sa2.c	Sun Feb  3 16:40:50 2002
@@ -64,6 +64,7 @@
 #include <linux/module.h>
 #include <linux/isapnp.h>
 #include <linux/pm.h>
+#include <linux/delay.h>
 #include "sound_config.h"
 
 #include "ad1848.h"

   Michal
   
