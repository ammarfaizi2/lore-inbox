Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263887AbSITWkT>; Fri, 20 Sep 2002 18:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263888AbSITWkT>; Fri, 20 Sep 2002 18:40:19 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:60921 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S263887AbSITWkR>;
	Fri, 20 Sep 2002 18:40:17 -0400
Date: Fri, 20 Sep 2002 15:45:23 -0700
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.37 wavelan_cs compile error, warning fix
Message-ID: <20020920224523.GB9283@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <200209201914.43965.l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200209201914.43965.l.s.r@web.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 07:14:43PM +0200, Ren? Scharfe wrote:
> Hi,
> 
> this patch fixes a compile error and a warning about an unused
> function in wavelan_cs.c. Compiles, untested.
> 
> René

	Your patch was not correct. I've just sent the proper patch to
Jeff. See below ;-)

	Jean

---------------------------------------------------------------------

diff -u -p linux/drivers/net/wireless/wavelan_cs.b1.p.h linux/drivers/net/wireless/wavelan_cs.p.h
--- linux/drivers/net/wireless/wavelan_cs.b1.p.h	Fri Sep 20 14:29:14 2002
+++ linux/drivers/net/wireless/wavelan_cs.p.h	Fri Sep 20 14:29:46 2002
@@ -439,6 +439,7 @@
 #include <linux/if_arp.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
+#include <linux/ethtool.h>
 
 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Wireless extensions */
diff -u -p linux/drivers/net/wireless/wavelan_cs.b1.c linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net/wireless/wavelan_cs.b1.c	Fri Sep 20 14:28:54 2002
+++ linux/drivers/net/wireless/wavelan_cs.c	Fri Sep 20 14:34:00 2002
@@ -56,8 +56,7 @@
  *
  */
 
-#include <linux/ethtool.h>
-#include <asm/uaccess.h>
+/* Do *NOT* add other headers here, you are guaranteed to be wrong - Jean II */
 #include "wavelan_cs.p.h"		/* Private header */
 
 /************************* MISC SUBROUTINES **************************/
@@ -2890,8 +2889,8 @@ static const struct iw_handler_def	wavel
 	.private	= (iw_handler *) wavelan_private_handler,
 	.private_args	= (struct iw_priv_args *) wavelan_private_args,
 };
+#endif /* WIRELESS_EXT > 12 */
 
-#else /* WIRELESS_EXT > 12 */
 /*------------------------------------------------------------------*/
 /*
  * Perform ioctl : config & info stuff
@@ -2916,8 +2915,9 @@ wavelan_ioctl(struct net_device *	dev,	/
       ret = netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
       break;
 
+#if WIRELESS_EXT <= 12
       /* --------------- WIRELESS EXTENSIONS --------------- */
-
+      /* Now done as iw_handler - Jean II */
     case SIOCGIWNAME:
       wavelan_get_name(dev, NULL, &(wrq->u), NULL);
       break;
@@ -3191,6 +3191,7 @@ wavelan_ioctl(struct net_device *	dev,	/
       }
       break;
 #endif	/* HISTOGRAM */
+#endif /* WIRELESS_EXT <= 12 */
 
       /* ------------------- OTHER IOCTL ------------------- */
 
@@ -3203,7 +3204,6 @@ wavelan_ioctl(struct net_device *	dev,	/
 #endif
   return ret;
 }
-#endif /* WIRELESS_EXT > 12 */
 
 /*------------------------------------------------------------------*/
 /*
@@ -5199,9 +5199,8 @@ wavelan_attach(void)
 #ifdef WIRELESS_EXT	/* If wireless extension exist in the kernel */
 #if WIRELESS_EXT > 12
   dev->wireless_handlers = (struct iw_handler_def *)&wavelan_handler_def;
-#else /* WIRELESS_EXT > 12 */
-  dev->do_ioctl = wavelan_ioctl;	/* wireless extensions */
 #endif /* WIRELESS_EXT > 12 */
+  dev->do_ioctl = wavelan_ioctl;	/* old wireless extensions */
   dev->get_wireless_stats = wavelan_get_wireless_stats;
 #endif
 

