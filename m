Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbTA2I2i>; Wed, 29 Jan 2003 03:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTA2I2i>; Wed, 29 Jan 2003 03:28:38 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:9856 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S265196AbTA2I2h>;
	Wed, 29 Jan 2003 03:28:37 -0500
Date: Wed, 29 Jan 2003 00:37:52 -0800
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, aratnaweera@virtusa.com
Subject: Re: Where are the matroxfb updates?
Message-ID: <20030129083752.GD4950@vana.vc.cvut.cz>
References: <20030129020639.GA10213@aratnaweera.virtusa.com> <20030129053159.GA5999@platan.vc.cvut.cz> <20030129073629.GA26091@aratnaweera.virtusa.com> <20030129080420.GB4950@vana.vc.cvut.cz> <20030129082226.GA668@aratnaweera.virtusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129082226.GA668@aratnaweera.virtusa.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 02:22:26PM +0600, Anuradha Ratnaweera wrote:
> On Wed, Jan 29, 2003 at 12:04:20AM -0800, Petr Vandrovec wrote:
> >
> > On Wed, Jan 29, 2003 at 01:36:29PM +0600, Anuradha Ratnaweera wrote:
> > > 
> > > -pre3 and -pre4 don't build matroxfb_g450 and matroxfb_crtc2 as
> > > modules.  I have FB_MATROX_G450 set to "m", so these modules don't
> > > get added to obj-m.  The "ifeq"s in the Makefile now check only for
> > > the value "y" of this symbol, not for "m".
> > 
> > You did not run 'make oldconfig', did you?
> 
> I did.  (I use make-kpkg on Debian, so it does another superfluous make
> oldconfig, too).  But I tried many other variations before looking at
> the Makefile and Config.in itself.

Oops. See below, Config.in patch disappeared when patch was travelling
from Alan to Marcelo.
 
> > By default people use secondary output on g550 and they were
> > complaining that they see nothing.
> 
> Then isn't it then sane to make FB_MATROX_G450 to "bool" and not
> "tristate", because selecting "m" does _nothing_ !

Yes, it is...
 
> > So you do not have choice to screw up things now.
> 
> Only for 550 owners, though :-(
> 
> BTW, now I _have_ g450 built into the kernel (see signature below) and
> both monitors display the same screen.  /dev/fb1 gets registered, and
> ttys get moved to it with con2fb, but not to any of the monitors.  Both
> monitors still seem to act as /dev/fb0.  The moved tty no longer exist.

What about using matroxset to set things up? It was always mandatory to
use matroxset to set fb<->outputs relation, and now just default changed
because of there is more people who want same picture on both outputs
than people who want different outputs... And with introducing DVI support
there was no other sane alternative.

Marcelo,
  Alan missed this chunk when sending you matroxfb updates and I did not
notice. Please apply...
								Petr


--- linux-2.4.21-pre4.dist/drivers/video/Config.in	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.21-pre4/drivers/video/Config.in	2003-01-29 09:30:30.000000000 +0100
@@ -124,14 +124,20 @@
 	 if [ "$CONFIG_FB_MATROX" != "n" ]; then
 	    bool '    Millennium I/II support' CONFIG_FB_MATROX_MILLENIUM
 	    bool '    Mystique support' CONFIG_FB_MATROX_MYSTIQUE
-	    bool '    G100/G200/G400/G450/G550 support' CONFIG_FB_MATROX_G100
+ 	    bool '    G100/G200/G400/G450/G550 support' CONFIG_FB_MATROX_G450
+ 	    if [ "$CONFIG_FB_MATROX_G450" = "n" ]; then
+ 	       bool '    G100/G200/G400 support' CONFIG_FB_MATROX_G100A
+ 	    fi
+ 	    if [ "$CONFIG_FB_MATROX_G450" = "y" -o "$CONFIG_FB_MATROX_G100A" = "y" ]; then
+ 	       define_bool CONFIG_FB_MATROX_G100 y
+ 	    fi
             if [ "$CONFIG_I2C" != "n" ]; then
 	       dep_tristate '      Matrox I2C support' CONFIG_FB_MATROX_I2C $CONFIG_FB_MATROX $CONFIG_I2C_ALGOBIT
 	       if [ "$CONFIG_FB_MATROX_G100" = "y" ]; then
 	          dep_tristate '      G400 second head support' CONFIG_FB_MATROX_MAVEN $CONFIG_FB_MATROX_I2C
 	       fi
             fi
-            dep_tristate '      G450/G550 second head support (mandatory for G550)' CONFIG_FB_MATROX_G450 $CONFIG_FB_MATROX_G100
+            dep_tristate '    Matrox /proc interface' CONFIG_FB_MATROX_PROC $CONFIG_FB_MATROX
 	    bool '    Multihead support' CONFIG_FB_MATROX_MULTIHEAD
 	 fi
 	 tristate '  ATI Mach64 display support (EXPERIMENTAL)' CONFIG_FB_ATY
