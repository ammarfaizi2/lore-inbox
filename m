Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbRE3Aos>; Tue, 29 May 2001 20:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbRE3Aoi>; Tue, 29 May 2001 20:44:38 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:2063 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262500AbRE3AoY>; Tue, 29 May 2001 20:44:24 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300042.CAA04518@green.mif.pg.gda.pl>
Subject: [PATCH] net #4
To: elmer@ylenurme.ee, alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 30 May 2001 02:42:10 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes network drivers configuration in some points:

- make sb1000 dependent on CONFIG_ISAPNP. It compiles without CONFIG_ISAPNP,
  but will not work as the driver relies on ISA PnP board detection
- de620 does not support build-in configuration (dependency on "m" now).
  It compiles, but requires io/irq module parameters for board detection
  (even ether= is not supported by this driver)
- Aironet fixes:
  -- Aironet PnP requires CONFIG_ISAPNP (y or m) to work; of course, when
     CONFIG_ISAPNP=m CONFIG_AIRONET4500_NONCS also should be "m", but
     this is not supported by CML1; to be fixed in CML2 or in another way
  -- Aironet I365 and ISA detection for built-in driver is not supported
     currently, so disable these options if CONFIG_AIRONET4500_NONCS=y

Andrzej

************************* PATCH 5 ***********************************
diff -uNr linux-2.4.5-ac4/drivers/net/Config.in linux/drivers/net/Config.in
--- linux-2.4.5-ac4/drivers/net/Config.in	Mon May 28 01:34:54 2001
+++ linux/drivers/net/Config.in	Wed May 30 01:11:56 2001
@@ -15,7 +15,7 @@
    fi
 fi
 
-tristate 'General Instruments Surfboard 1000' CONFIG_NET_SB1000
+dep_tristate 'General Instruments Surfboard 1000' CONFIG_NET_SB1000 $CONFIG_ISAPNP
 
 #
 #	Ethernet
@@ -180,7 +180,7 @@
    if [ "$CONFIG_NET_POCKET" = "y" ]; then
       dep_tristate '    AT-LAN-TEC/RealTek pocket adapter support' CONFIG_ATP $CONFIG_ISA
       tristate '    D-Link DE600 pocket adapter support' CONFIG_DE600
-      tristate '    D-Link DE620 pocket adapter support' CONFIG_DE620
+      dep_tristate '    D-Link DE620 pocket adapter support' CONFIG_DE620 m
    fi
 fi
 
@@ -264,10 +264,14 @@
    tristate '  Aironet 4500/4800 series adapters' CONFIG_AIRONET4500
    dep_tristate '   Aironet 4500/4800 ISA/PCI/PNP/365 support ' CONFIG_AIRONET4500_NONCS $CONFIG_AIRONET4500
    if [ "$CONFIG_AIRONET4500" != "n" -a "$CONFIG_AIRONET4500_NONCS" != "n" ]; then
-      bool '     Aironet 4500/4800 PNP support ' CONFIG_AIRONET4500_PNP
+      if [ "$CONFIG_AIRONET4500_NONCS" = "m" -a "$CONFIG_ISAPNP" = "m" -o "$CONFIG_ISAPNP" = "y" ]; then
+	 bool '     Aironet 4500/4800 PNP support ' CONFIG_AIRONET4500_PNP
+      fi
       dep_bool '     Aironet 4500/4800 PCI support ' CONFIG_AIRONET4500_PCI $CONFIG_PCI
-      dep_bool '     Aironet 4500/4800 ISA broken support (EXPERIMENTAL)' CONFIG_AIRONET4500_ISA $CONFIG_EXPERIMENTAL
-      dep_bool '     Aironet 4500/4800 I365 broken support (EXPERIMENTAL)' CONFIG_AIRONET4500_I365 $CONFIG_EXPERIMENTAL
+      if [ "$CONFIG_AIRONET4500_NONCS" = "m" ]; then
+	 dep_bool '     Aironet 4500/4800 ISA broken support (EXPERIMENTAL)' CONFIG_AIRONET4500_ISA $CONFIG_EXPERIMENTAL
+	 dep_bool '     Aironet 4500/4800 I365 broken support (EXPERIMENTAL)' CONFIG_AIRONET4500_I365 $CONFIG_EXPERIMENTAL
+      fi
    fi
    dep_tristate '   Aironet 4500/4800 PROC interface ' CONFIG_AIRONET4500_PROC $CONFIG_AIRONET4500 m
 


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
