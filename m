Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266629AbUBQXDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUBQXBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:01:50 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42233 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266775AbUBQW7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:59:15 -0500
Date: Tue, 17 Feb 2004 23:59:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: zippel@linux-m68k.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       GCS <gcs@lsc.hu>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       vandrove@vc.cvut.cz
Subject: Re: Linux 2.6.3-rc4
Message-ID: <20040217225905.GQ1308@fs.tum.de>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org> <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org> <20040217200545.GP1308@fs.tum.de> <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 12:16:08PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 17 Feb 2004, Adrian Bunk wrote:
> > 
> > Most likely the problem is CONFIG_I2C=m and the fact that FB_RADEON_I2C
> > is a bool.
> > 
> > I don't know whether there's a better way to express this, but something 
> > like the following is required:
> 
> Argh. Yeah, that's ugly.
> 
> How about instead just removing the dependency on I2C, and making it just
> select it? (in fact, I'd assume that just selecing I2C_ALGOBIT should
> itself cause I2C to be selected, but I've not checked the dependency
> chain).

No, I2C_ALGOBIT depends on I2C.

> That's really what the true dependency is, logically.

Below is a suggested fix that lets FB_RADEON_I2C select I2C.

It also fixes FB_MATROX_I2C that has a similar problem.

> 		Linus

cu
Adrian

--- linux-2.6.3-rc4/drivers/video/Kconfig.old	2004-02-17 21:00:24.000000000 +0100
+++ linux-2.6.3-rc4/drivers/video/Kconfig	2004-02-17 23:54:56.000000000 +0100
@@ -505,10 +505,8 @@
 	  pixel and 32 bpp packed pixel. You can also use font widths
 	  different from 8.
 
-	  If you need support for G400 secondary head, you must first say Y to
-	  "I2C support" and "I2C bit-banging support" in the character devices
-	  section, and then to "Matrox I2C support" and "G400 second head
-	  support" here in the framebuffer section. G450/G550 secondary head
+	  If you need support for G400 secondary head, you must say Y to
+	  "G400 second head support" below. G450/G550 secondary head
 	  and digital output are supported without additional modules.
 
 	  The driver starts in monitor mode. You must use the matroxset tool 
@@ -537,9 +535,7 @@
 	  different from 8.
 
 	  If you need support for G400 secondary head, you must first say Y to
-	  "I2C support" and "I2C bit-banging support" in the character devices
-	  section, and then to "Matrox I2C support" and "G400 second head
-	  support" here in the framebuffer section.
+	  "G400 second head support" below.
 
 config FB_MATROX_G100
 	bool
@@ -548,7 +544,8 @@
 
 config FB_MATROX_I2C
 	tristate "Matrox I2C support"
-	depends on FB_MATROX && I2C
+	depends on FB_MATROX
+	select I2C
 	select I2C_ALGOBIT
 	---help---
 	  This drivers creates I2C buses which are needed for accessing the
@@ -632,19 +629,13 @@
 	  a framebuffer device.  There are both PCI and AGP versions.  You
 	  don't need to choose this to run the Radeon in plain VGA mode.
 
-	  If you say Y here and want DDC/I2C support you must first say Y to
-	  "I2C support" and "I2C bit-banging support" in the character devices
-	  section.
-
-	  If you say M here then "I2C support" and "I2C bit-banging support" 
-	  can be build either as modules or built-in.
-
 	  There is a product page at
 	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
 
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
-	depends on FB_RADEON && I2C
+	depends on FB_RADEON
+	select I2C
 	select I2C_ALGOBIT
 	default y
 	help
