Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUBYUib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUBYUib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:38:31 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:25359 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261431AbUBYUiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:38:19 -0500
Date: Thu, 26 Feb 2004 07:38:05 +1100
To: Olivier Berger <olberger@club-internet.fr>, 234631@bugs.debian.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Bug#234631: kernel-source-2.6.3: kernel fails to compile : radeon_setup_i2c_bus etc.
Message-ID: <20040225203805.GA14879@gondor.apana.org.au>
References: <E1AvlK2-00060c-00@rms> <20040225100458.GC3535@gondor.apana.org.au> <20040225104621.GA7893@gondor.apana.org.au> <87r7wj5mu4.fsf@club-internet.fr> <878yirgc54.fsf@club-internet.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <878yirgc54.fsf@club-internet.fr>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2004 at 09:03:19PM +0100, Olivier Berger wrote:
>
> >> Never mind, I've found the problem.  RADEON is selecting I2C_ALGOBIT
> >> but as kconfig currently does not propagate selects up the dependency
> >> chain (that is according to Roman), this can leave I2C as m while
> >> I2C_ALGOBIT is y.
> >>
> >> This patch fixes it by explicitly selecting I2C.
> >
> > That seems to solve the problem.
> >
> 
> Hmm... having checked again, there are some warnings left after make
> menuconfig execution though :
> 
> rms:/usr/src/kernel-source-2.6.3# make menuconfig
> make[1]: `scripts/fixdep' is up to date.
> scripts/kconfig/mconf arch/i386/Kconfig
> Warning! Found recursive dependency: I2C FB_MATROX_I2C I2C I2C_ELV

OK, this patch should get rid of those warnings by removing the now
redundant dependency of FB_RADEON_I2C on I2C.  Also, since FB_MATROX_I2C
is a tristate, we can move the select back to it.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-2.5/drivers/video/Kconfig
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/Kconfig,v
retrieving revision 1.11
diff -u -r1.11 Kconfig
--- kernel-2.5/drivers/video/Kconfig	19 Feb 2004 09:55:58 -0000	1.11
+++ kernel-2.5/drivers/video/Kconfig	25 Feb 2004 20:30:42 -0000
@@ -462,7 +462,6 @@
 config FB_MATROX
 	tristate "Matrox acceleration"
 	depends on FB && PCI
-	select I2C_ALGOBIT if FB_MATROX_I2C
 	---help---
 	  Say Y here if you have a Matrox Millennium, Matrox Millennium II,
 	  Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
@@ -550,6 +549,7 @@
 config FB_MATROX_I2C
 	tristate "Matrox I2C support"
 	depends on FB_MATROX && I2C
+	select I2C_ALGOBIT
 	---help---
 	  This drivers creates I2C buses which are needed for accessing the
 	  DDC (I2C) bus present on all Matroxes, an I2C bus which
@@ -628,6 +628,7 @@
 	tristate "ATI Radeon display support"
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_RADEON_I2C
+	select I2C if FB_RADEON_I2C
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
 	  a framebuffer device.  There are both PCI and AGP versions.  You
@@ -645,7 +646,7 @@
 
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
-	depends on FB_RADEON && I2C
+	depends on FB_RADEON
 	default y
 	help
 	  Say Y here if you want DDC/I2C support for your Radeon board. 

--cWoXeonUoKmBZSoM--
