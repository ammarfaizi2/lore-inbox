Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbREUPzC>; Mon, 21 May 2001 11:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261500AbREUPyw>; Mon, 21 May 2001 11:54:52 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:58892
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S261482AbREUPyf>; Mon, 21 May 2001 11:54:35 -0400
Date: Mon, 21 May 2001 08:52:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: cort@fsmlabs.com, Linus Torvalds <torvalds@transmeta.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc xconfig 2.2.5-pre4
Message-ID: <20010521085236.D9965@opus.bloom.county>
In-Reply-To: <200105210129.DAA06203@green.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200105210129.DAA06203@green.mif.pg.gda.pl>; from ankry@green.mif.pg.gda.pl on Mon, May 21, 2001 at 03:29:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 03:29:31AM +0200, Andrzej Krzysztofowicz wrote:

> The following patch fixes ppc xconfig potential problem introduced in
> 2.4.5-pre4.

xconfig has other issues on PPC at the momement, if you select and 8xx or
8260 CPU.  See the inlined.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== drivers/net/Config.in 1.14 vs edited =====
--- 1.14/drivers/net/Config.in	Wed Apr 25 19:35:07 2001
+++ edited/drivers/net/Config.in	Wed May  2 14:44:24 2001
@@ -38,7 +38,31 @@
       tristate '  BMAC (G3 ethernet) support' CONFIG_BMAC
       tristate '  GMAC (G4/iBook ethernet) support' CONFIG_GMAC
       tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
-      tristate '  National DP83902AV (Oak ethernet) support' CONFIG_OAKNET
+      if [ "$CONFIG_4xx" = "y" ]; then
+         tristate '  National DP83902AV (Oak ethernet) support' CONFIG_OAKNET
+      fi
+      if [ "$CONFIG_8xx" = "y" -o "$CONFIG_8260" = "y" ]; then
+         bool 'CPM SCC Ethernet' CONFIG_SCC_ENET
+         if [ "$CONFIG_SCC_ENET" = "y" ]; then
+            choice 'SCC used for Ethernet (SCC3 valid only on 8xx)'	\
+               "SCC1	CONFIG_SCC1_ENET	\
+                SCC2	CONFIG_SCC2_ENET	\
+        	SCC3	CONFIG_SCC3_ENET"	SCC1
+         fi
+         bool 'FCC Ethernet' CONFIG_FEC_ENET
+         if [ "$CONFIG_FEC_ENET" = "y" -a "$CONFIG_8260" = "y" ]; then
+            bool 'Ethernet on FCC1' CONFIG_FCC1_ENET
+            bool 'Ethernet on FCC2' CONFIG_FCC2_ENET
+            bool 'Ethernet on FCC3' CONFIG_FCC3_ENET
+         fi
+         if [ "$CONFIG_FEC_ENET" = "y" -a "$CONFIG_8xx" = "y" ]; then
+            bool 'Use MDIO for PHY configuration' CONFIG_USE_MDIO
+         fi
+         if [ "$CONFIG_8xx" = "y" -a "$CONFIG_FEC_ENET" = "y" \
+        	-o "$CONFIG_SCC_ENET" = "y" ]; then
+            bool 'Use Big CPM Ethernet Buffers' CONFIG_ENET_BIG_BUFFERS
+         fi
+      fi
    fi
    if [ "$CONFIG_ZORRO" = "y" ]; then
       tristate '  Ariadne support' CONFIG_ARIADNE
===== arch/ppc/config.in 1.17 vs edited =====
--- 1.17/arch/ppc/config.in	Thu Apr 19 15:50:05 2001
+++ edited/arch/ppc/config.in	Wed May  2 14:44:42 2001
@@ -337,12 +337,13 @@
 endmenu
 
 if [ "$CONFIG_8xx" = "y" ]; then
-source arch/ppc/8xx_io/Config.in
+  source arch/ppc/8xx_io/Config.in
 fi
 
-if [ "$CONFIG_8260" = "y" ]; then
-source arch/ppc/8260_io/Config.in
-fi
+# Empty for now, but it will come back -- Tom
+#if [ "$CONFIG_8260" = "y" ]; then
+#  source arch/ppc/8260_io/Config.in
+#fi
 
 source drivers/usb/Config.in
 
===== arch/ppc/8xx_io/Config.in 1.4 vs edited =====
--- 1.4/arch/ppc/8xx_io/Config.in	Thu Apr 26 15:34:57 2001
+++ edited/arch/ppc/8xx_io/Config.in	Wed May  2 14:42:11 2001
@@ -4,20 +4,6 @@
 mainmenu_option next_comment
 comment 'MPC8xx CPM Options'
 
-if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
-  bool 'CPM SCC Ethernet' CONFIG_SCC_ENET
-  if [ "$CONFIG_SCC_ENET" = "y" ]; then
-    choice 'SCC used for Ethernet'	\
-  	"SCC1	CONFIG_SCC1_ENET	\
-	 SCC2	CONFIG_SCC2_ENET	\
-	 SCC3	CONFIG_SCC3_ENET"	SCC1
-  fi
-  bool '860T FEC Ethernet' CONFIG_FEC_ENET
-  if [ "$CONFIG_FEC_ENET" = "y" ]; then
-    bool 'Use MDIO for PHY configuration' CONFIG_USE_MDIO
-  fi
-  bool 'Use Big CPM Ethernet Buffers' CONFIG_ENET_BIG_BUFFERS
-fi
 bool 'Use SMC2 for UART' CONFIG_SMC2_UART
 if [ "$CONFIG_SMC2_UART" = "y" ]; then
   bool 'Use Alternate SMC2 I/O (823/850)' CONFIG_ALTSMC2
===== arch/ppc/8260_io/Config.in 1.1 vs edited =====
--- 1.1/arch/ppc/8260_io/Config.in	Sat Jan  6 00:30:23 2001
+++ edited/arch/ppc/8260_io/Config.in	Wed May  2 14:42:37 2001
@@ -3,23 +3,5 @@
 #
 if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
   mainmenu_option next_comment
-  comment 'MPC8260 Communication Options'
-  bool 'CPM SCC Ethernet' CONFIG_SCC_ENET
-  if [ "$CONFIG_SCC_ENET" = "y" ]; then
-  bool 'Ethernet on SCC1' CONFIG_SCC1_ENET
-    if [ "$CONFIG_SCC1_ENET" != "y" ]; then
-      bool 'Ethernet on SCC2' CONFIG_SCC2_ENET
-    fi
-  fi
-#
-#  CONFIG_FEC_ENET is only used to get netdevices to call our init
-#    function.  Any combination of FCC1,2,3 are supported.
-#
-  bool 'FCC Ethernet' CONFIG_FEC_ENET
-  if [ "$CONFIG_FEC_ENET" = "y" ]; then
-    bool 'Ethernet on FCC1' CONFIG_FCC1_ENET
-    bool 'Ethernet on FCC2' CONFIG_FCC2_ENET
-    bool 'Ethernet on FCC3' CONFIG_FCC3_ENET
-  fi
   endmenu
 fi
