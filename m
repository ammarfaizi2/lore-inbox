Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTKSJh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 04:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTKSJh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 04:37:57 -0500
Received: from witte.sonytel.be ([80.88.33.193]:27814 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263927AbTKSJhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 04:37:55 -0500
Date: Wed, 19 Nov 2003 10:37:35 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Creasey <sammy@sammy.net>
cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [BK PATCHES] 2.6.x experimental net driver queue
In-Reply-To: <Pine.LNX.4.40.0311191703120.6278-100000@sun3>
Message-ID: <Pine.GSO.4.21.0311191035500.7852-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Nov 2003, Sam Creasey wrote:
> On Tue, 18 Nov 2003, Geert Uytterhoeven wrote:
> > On Mon, 17 Nov 2003, Geert Uytterhoeven wrote:
> > > On Sun, 16 Nov 2003, Jeff Garzik wrote:
> > > > Yet more updates.  Syncing with Andrew Morton, and more syncing with Al
> > > > Viro.
> > > >
> > > > No users of init_etherdev remain in the tree.  (yay!)
> > >
> > > Here are some (untested, except for cross-gcc) fixes for the m68k-related
> > > drivers:
> >
> > I forget to test the Sun-3 drivers:
> >   - sun3_82586.c:
> >       o add missing casts to iounmap() calls
> >       o fix parameter of free_netdev()
> >   - sun3lance.c: add missing casts to iounmap() calls
> >
> > Note that sun3_82586.c no longer compiles since SUN3_82586_TOTAL_SIZE is not
> > defined. Sammy, is it OK to use PAGE_SIZE for that, since that's what's passed
> > to ioremap()?
> 
> Should be...  I looked back through a few versions of the code, and I'm
> not even sure what SUN3_82586_TOTAL_SIZE even was (appears I commented
> that line out long ago anyway).  (I'm also amazed just how much of that
> driver I've forgotten in the last year or two :)

OK, so here's a additional patch that fixes that:

--- linux/drivers/net/sun3_82586.c.orig	2003-11-19 10:32:09.000000000 +0100
+++ linux/drivers/net/sun3_82586.c	2003-11-19 10:33:44.000000000 +0100
@@ -55,6 +55,7 @@
 
 #define DEBUG       /* debug on */
 #define SYSBUSVAL 0 /* 16 Bit */
+#define SUN3_82586_TOTAL_SIZE	PAGE_SIZE
 
 #define sun3_attn586()  {*(volatile unsigned char *)(dev->base_addr) |= IEOB_ATTEN; *(volatile unsigned char *)(dev->base_addr) &= ~IEOB_ATTEN;}
 #define sun3_reset586() {*(volatile unsigned char *)(dev->base_addr) = 0; udelay(100); *(volatile unsigned char *)(dev->base_addr) = IEOB_NORSET;}
@@ -298,7 +299,7 @@
 	if (found)
 		return ERR_PTR(-ENODEV);
 	
-	ioaddr = (unsigned long)ioremap(IE_OBIO, PAGE_SIZE);
+	ioaddr = (unsigned long)ioremap(IE_OBIO, SUN3_82586_TOTAL_SIZE);
 	if (!ioaddr)
 		return ERR_PTR(-ENOMEM);
 	found = 1;


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

