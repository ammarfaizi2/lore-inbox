Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTKRM2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 07:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTKRM2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 07:28:14 -0500
Received: from witte.sonytel.be ([80.88.33.193]:59532 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262327AbTKRM2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 07:28:10 -0500
Date: Tue, 18 Nov 2003 13:27:52 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>, Sam Creasey <sammy@sammy.net>
cc: netdev@oss.sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [BK PATCHES] 2.6.x experimental net driver queue
In-Reply-To: <Pine.GSO.4.21.0311171812000.5421-100000@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.21.0311181205460.6448-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Geert Uytterhoeven wrote:
> On Sun, 16 Nov 2003, Jeff Garzik wrote:
> > Yet more updates.  Syncing with Andrew Morton, and more syncing with Al 
> > Viro.
> > 
> > No users of init_etherdev remain in the tree.  (yay!)
> 
> Here are some (untested, except for cross-gcc) fixes for the m68k-related
> drivers:

I forget to test the Sun-3 drivers:
  - sun3_82586.c:
      o add missing casts to iounmap() calls
      o fix parameter of free_netdev()
  - sun3lance.c: add missing casts to iounmap() calls
      
Note that sun3_82586.c no longer compiles since SUN3_82586_TOTAL_SIZE is not
defined. Sammy, is it OK to use PAGE_SIZE for that, since that's what's passed
to ioremap()?

--- linux-net2-2.6.0-test9/drivers/net/sun3_82586.c	2003-11-17 11:06:18.000000000 +0100
+++ linux-net2-2.6.0-test9/drivers/net/sun3_82586.c	2003-11-18 13:03:01.000000000 +0100
@@ -327,7 +327,7 @@
 out1:
 	free_netdev(dev);
 out:
-	iounmap(ioaddr);
+	iounmap((void *)ioaddr);
 	return ERR_PTR(err);
 }
 
@@ -1163,8 +1163,8 @@
 	unsigned long ioaddr = dev_sun3_82586->base_addr;
 	unregister_netdev(dev_sun3_82586);
 	release_region(ioaddr, SUN3_82586_TOTAL_SIZE);
-	iounmap(ioaddr);
-	free_netdev(dev);
+	iounmap((void *)ioaddr);
+	free_netdev(dev_sun3_82586);
 }
 #endif /* MODULE */
 
--- linux-net2-2.6.0-test9/drivers/net/sun3lance.c	2003-11-17 11:06:18.000000000 +0100
+++ linux-net2-2.6.0-test9/drivers/net/sun3lance.c	2003-11-18 13:02:32.000000000 +0100
@@ -287,7 +287,7 @@
 
 out1:
 #ifdef CONFIG_SUN3
-	iounmap(dev->base_addr);
+	iounmap((void *)dev->base_addr);
 #endif
 out:
 	free_netdev(dev);
@@ -327,7 +327,7 @@
 		ioaddr_probe[1] = tmp2;
 
 #ifdef CONFIG_SUN3
-		iounmap(ioaddr);
+		iounmap((void *)ioaddr);
 #endif
 		return 0;
 	}
@@ -957,7 +957,7 @@
 {
 	unregister_netdev(sun3lance_dev);
 #ifdef CONFIG_SUN3
-	iounmap(sun3lance_dev->base_addr);
+	iounmap((void *)sun3lance_dev->base_addr);
 #endif
 	free_netdev(sun3lance_dev);
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

