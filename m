Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136758AbRECLM1>; Thu, 3 May 2001 07:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136760AbRECLMR>; Thu, 3 May 2001 07:12:17 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:14264 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S136758AbRECLMI>; Thu, 3 May 2001 07:12:08 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200105031111.NAA02616@sunrise.pg.gda.pl>
Subject: Re: xconfig is broken (example ppc 8xx) [PATCH]
To: george@mvista.com (george anzinger)
Date: Thu, 3 May 2001 13:11:57 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        paulus@samba.org
In-Reply-To: <3AF031DC.B8D793FE@mvista.com> from "george anzinger" at May 02, 2001 09:12:12 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"george anzinger wrote:"
> To show the problem do:
> 
> make xconfig ARCH=ppc
> 
> in the "Platform support" menu "Processor Type" select "8xx" then close
> the subminue with "MainMenu"
> 
> now select "Save and Exit"
> 
> This produces the following error messages:
> 
> ERROR - Attempting to write value for unconfigured variable
> (CONFIG_SCC_ENET).
> ERROR - Attempting to write value for unconfigured variable
> (CONFIG_FEC_ENET).

The following patch shold fix it. It is against 2.4.3-ac14, but should
cleanly apply to the Linus's tree also.

Andrzej

***********************************************************************
diff -ur linux-2.4.3-ac14/arch/ppc/8260_io/Config.in linux/arch/ppc/8260_io/Config.in
--- linux-2.4.3-ac14/arch/ppc/8260_io/Config.in	Mon Nov 13 23:13:15 2000
+++ linux/arch/ppc/8260_io/Config.in	Thu May  3 12:51:28 2001
@@ -4,18 +4,22 @@
 if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
   mainmenu_option next_comment
   comment 'MPC8260 Communication Options'
-  bool 'CPM SCC Ethernet' CONFIG_SCC_ENET
+  bool 'CPM SCC Ethernet' CONFIG_SCC_ENET_8260
+  define_bool CONFIG_SCC_ENET $CONFIG_SCC_ENET_8260
   if [ "$CONFIG_SCC_ENET" = "y" ]; then
-  bool 'Ethernet on SCC1' CONFIG_SCC1_ENET
+    bool 'Ethernet on SCC1' CONFIG_SCC1_ENET_8260
+    define_bool CONFIG_SCC1_ENET $CONFIG_SCC1_ENET_8260
     if [ "$CONFIG_SCC1_ENET" != "y" ]; then
-      bool 'Ethernet on SCC2' CONFIG_SCC2_ENET
+	 bool 'Ethernet on SCC2' CONFIG_SCC2_ENET_8260
+	 define_bool CONFIG_SCC2_ENET $CONFIG_SCC2_ENET_8260
     fi
   fi
 #
 #  CONFIG_FEC_ENET is only used to get netdevices to call our init
 #    function.  Any combination of FCC1,2,3 are supported.
 #
-  bool 'FCC Ethernet' CONFIG_FEC_ENET
+  bool 'FCC Ethernet' CONFIG_FEC_ENET_8260
+  define_bool CONFIG_FEC_ENET $CONFIG_FEC_ENET_8260
   if [ "$CONFIG_FEC_ENET" = "y" ]; then
     bool 'Ethernet on FCC1' CONFIG_FCC1_ENET
     bool 'Ethernet on FCC2' CONFIG_FCC2_ENET
diff -ur linux-2.4.3-ac14/arch/ppc/8xx_io/Config.in linux/arch/ppc/8xx_io/Config.in
--- linux-2.4.3-ac14/arch/ppc/8xx_io/Config.in	Wed Apr  4 00:18:05 2001
+++ linux/arch/ppc/8xx_io/Config.in	Thu May  3 13:00:29 2001
@@ -5,14 +5,19 @@
 comment 'MPC8xx CPM Options'
 
 if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
-  bool 'CPM SCC Ethernet' CONFIG_SCC_ENET
+   bool 'CPM SCC Ethernet' CONFIG_SCC_ENET_8xx
+   define_bool CONFIG_SCC_ENET $CONFIG_SCC_ENET_8xx
   if [ "$CONFIG_SCC_ENET" = "y" ]; then
     choice 'SCC used for Ethernet'	\
-  	"SCC1	CONFIG_SCC1_ENET	\
-	 SCC2	CONFIG_SCC2_ENET	\
-	 SCC3	CONFIG_SCC3_ENET"	SCC1
+	"SCC1	CONFIG_SCC1_ENET_8xx	\
+	 SCC2	CONFIG_SCC2_ENET_8xx	\
+	 SCC3	CONFIG_SCC3_ENET_8xx"	SCC1
+      define_bool CONFIG_SCC1_ENET $CONFIG_SCC1_ENET_8xx
+      define_bool CONFIG_SCC2_ENET $CONFIG_SCC2_ENET_8xx
+      define_bool CONFIG_SCC3_ENET $CONFIG_SCC3_ENET_8xx
   fi
-  bool '860T FEC Ethernet' CONFIG_FEC_ENET
+  bool '860T FEC Ethernet' CONFIG_FEC_ENET_8xx
+  define_bool CONFIG_FEC_ENET $CONFIG_FEC_ENET_8xx
   if [ "$CONFIG_FEC_ENET" = "y" ]; then
     bool 'Use MDIO for PHY configuration' CONFIG_USE_MDIO
   fi
diff -ur linux-2.4.3-ac14/arch/ppc/config.in linux/arch/ppc/config.in
--- linux-2.4.3-ac14/arch/ppc/config.in	Sun Apr 22 14:48:28 2001
+++ linux/arch/ppc/config.in	Thu May  3 13:03:03 2001
@@ -34,6 +34,8 @@
 
 if [ "$CONFIG_6xx" = "y" ]; then
   bool 'MPC8260 CPM Support' CONFIG_8260
+else
+   define_bool CONFIG_8260 n
 fi
 
 if [ "$CONFIG_POWER3" = "y" -o "$CONFIG_POWER4" = "y" ]; then
***********************************************************************

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
