Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264160AbUFUP3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUFUP3T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266261AbUFUP3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:29:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60634 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264160AbUFUP3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:29:12 -0400
Date: Mon, 21 Jun 2004 17:29:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [patch] Re: 2.6.7-mm1 linker trouble with CONFIG_FB_RIVA_I2C=y and modular I2C
Message-ID: <20040621152905.GC28607@fs.tum.de>
References: <20040620174632.74e08e09.akpm@osdl.org> <20040621020627.GA10824@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621020627.GA10824@merlin.emma.line.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 04:06:27AM +0200, Matthias Andree wrote:
> On Sun, 20 Jun 2004, Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm1/
> 
> This version causes linker trouble with
> CONFIG_I2C=m
> CONFIG_I2C_ALGOBIT=m
> CONFIG_FB_RIVA_I2C=y
> 
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0xda101): In function `riva_setup_i2c_bus':
> : undefined reference to `i2c_bit_add_bus'
> drivers/built-in.o(.text+0xda218): In function `riva_delete_i2c_busses':
> : undefined reference to `i2c_bit_del_bus'
> drivers/built-in.o(.text+0xda237): In function `riva_delete_i2c_busses':
> : undefined reference to `i2c_bit_del_bus'
> drivers/built-in.o(.text+0xda2c9): In function `riva_do_probe_i2c_edid':
> : undefined reference to `i2c_transfer'
> make: *** [.tmp_vmlinux1] Error 1
>...

Thanks for this report.

The problem is:
FB_RIVA=y
FB_RIVA_I2C=y
I2C=m
I2C_ALGOBIT=m

The patch below fixes this.

Besides this, it contains:
- help text by Antonino A. Daplas
- converted spaces to tabs
- it was forgotten that FB_RIVA_I2C requires I2C_ALGOBIT

> Matthias Andree

cu
Adrian

--- linux-2.6.7-mm1-modular/drivers/video/Kconfig.old	2004-06-21 17:09:57.000000000 +0200
+++ linux-2.6.7-mm1-modular/drivers/video/Kconfig	2004-06-21 17:26:57.000000000 +0200
@@ -424,6 +424,8 @@
 config FB_RIVA
 	tristate "nVidia Riva support"
 	depends on FB && PCI
+	select I2C_ALGOBIT if FB_RIVA_I2C
+	select I2C if FB_RIVA_I2C
 	help
 	  This driver supports graphics boards with the nVidia Riva/Geforce
 	  chips.
@@ -433,9 +435,17 @@
 	  module will be called rivafb.
 
 config FB_RIVA_I2C
-       bool "Enable DDC Support"
-       depends on FB_RIVA && I2C
-       help
+	bool "Enable DDC Support"
+	depends on FB_RIVA
+	help
+	  This enables I2C support for nVidia Chipsets.  This is used
+	  only for getting EDID information from the attached display
+	  allowing for robust video mode handling and switching.
+
+	  Because fbdev-2.6 requires that drivers must be able to
+	  independently validate video mode parameters, you should say Y
+	  here.
+
 
 config FB_I810
 	tristate "Intel 810/815 support (EXPERIMENTAL)"
