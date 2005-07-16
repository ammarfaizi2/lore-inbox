Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVGPBJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVGPBJG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 21:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVGPBJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 21:09:06 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:12753 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262050AbVGPBJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 21:09:00 -0400
Date: Sat, 16 Jul 2005 10:08:40 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, adaplas@hotpop.com
Subject: Re: 2.6.13-rc3-mm1
Message-Id: <20050716100840.608e2b99.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050715162349.731ca00d.akpm@osdl.org>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050716075242.24aed0bd.yuasa@hh.iij4u.or.jp>
	<20050715162349.731ca00d.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Jul 2005 16:23:49 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
> >
> > Hi Andrew
> > 
> > I got the following error.
> > 
> > make ARCH=mips oldconfig
> > scripts/kconfig/conf -o arch/mips/Kconfig
> > drivers/video/Kconfig:7:warning: type of 'FB' redefined from 'boolean' to 'tristate'
> > 
> > file drivers/char/speakup/Kconfig already scanned?
> > make[1]: *** [oldconfig] Error 1
> > make: *** [oldconfig] Error 2
> > 
> 
> Well arch/mips/Kconfig is defining CONFIG_FB as bool and
> drivers/video/Kconfig was changed a while ago to define it as tristate.  I
> assume this failure also happens in linus's current tree.  
> 
> It seems odd that mips is privately duplicating the generic code's
> definition.  Maybe that needs to be taken out of there.

Yes, It can be removed.

> I'll cc the fbdev guys - could someone please come up with fix?  It's a
> showstopper for the MIPS architecture.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/arch/mips/Kconfig mm1/arch/mips/Kconfig
--- mm1-orig/arch/mips/Kconfig	2005-07-15 21:44:53.000000000 +0900
+++ mm1/arch/mips/Kconfig	2005-07-16 10:01:29.000000000 +0900
@@ -1090,41 +1090,6 @@
 	depends on MACH_JAZZ || SNI_RM200_PCI || SGI_IP22 || SGI_IP32
 	default y
 
-config FB
-	bool
-	depends on MIPS_MAGNUM_4000 || OLIVETTI_M700
-	default y
-	---help---
-	  The frame buffer device provides an abstraction for the graphics
-	  hardware. It represents the frame buffer of some video hardware and
-	  allows application software to access the graphics hardware through
-	  a well-defined interface, so the software doesn't need to know
-	  anything about the low-level (hardware register) stuff.
-
-	  Frame buffer devices work identically across the different
-	  architectures supported by Linux and make the implementation of
-	  application programs easier and more portable; at this point, an X
-	  server exists which uses the frame buffer device exclusively.
-	  On several non-X86 architectures, the frame buffer device is the
-	  only way to use the graphics hardware.
-
-	  The device is accessed through special device nodes, usually located
-	  in the /dev directory, i.e. /dev/fb*.
-
-	  You need an utility program called fbset to make full use of frame
-	  buffer devices. Please read <file:Documentation/fb/framebuffer.txt>
-	  and the Framebuffer-HOWTO at <http://www.tldp.org/docs.html#howto>
-	  for more information.
-
-	  Say Y here and to the driver for your graphics board below if you
-	  are compiling a kernel for a non-x86 architecture.
-
-	  If you are compiling for the x86 architecture, you can say Y if you
-	  want to play with it, but it is not essential. Please note that
-	  running graphical applications that directly touch the hardware
-	  (e.g. an accelerated X server) and that are not frame buffer
-	  device-aware may cause unexpected results. If unsure, say N.
-
 config HAVE_STD_PC_SERIAL_PORT
 	bool
 
diff -urN -X dontdiff mm1-orig/drivers/video/Kconfig mm1/drivers/video/Kconfig
--- mm1-orig/drivers/video/Kconfig	2005-07-13 13:46:46.000000000 +0900
+++ mm1/drivers/video/Kconfig	2005-07-16 09:56:59.000000000 +0900
@@ -1399,8 +1399,8 @@
 	  Say Y here to enable kernel support for the on-board framebuffer.
 
 config FB_G364
-	bool
-	depends on MIPS_MAGNUM_4000 || OLIVETTI_M700
+	bool "G364 frame buffer support"
+	depends on (FB = y) && (MIPS_MAGNUM_4000 || OLIVETTI_M700)
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
