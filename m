Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUHWPCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUHWPCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUHWPCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:02:19 -0400
Received: from [212.209.10.220] ([212.209.10.220]:50340 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264915AbUHWPB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:01:59 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] CRIS architecture update
Date: Mon, 23 Aug 2004 17:01:57 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668640E1C@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains changes related to configuration and building.

  * Include HOTPLUG menu

diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/Makefile
linux/arch/cris/Makefile
--- ../linux/arch/cris/Makefile	Mon Aug 25 13:44:39 2003
+++ linux/arch/cris/Makefile	Thu Aug 19 11:47:58 2004
@@ -106,7 +106,7 @@
 
 archclean:
 	@$(MAKEBOOT) clean
-	rm -f timage vmlinux.bin cramfs.img
+	rm -f timage vmlinux.bin decompress.bin rescue.bin cramfs.img
 	rm -rf $(LD_SCRIPT).tmp
 
 archmrproper:
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/config.in
linux/arch/cris/config.in
--- ../linux/arch/cris/config.in	Wed Feb 18 14:36:30 2004
+++ linux/arch/cris/config.in	Mon Mar 29 09:22:16 2004
@@ -26,11 +26,23 @@
 comment 'General setup'
 
 bool 'Networking support' CONFIG_NET
+
+bool 'Support for hot-pluggable devices' CONFIG_HOTPLUG
+
+if [ "$CONFIG_HOTPLUG" = "y" ] ; then
+   source drivers/pcmcia/Config.in
+   source drivers/hotplug/Config.in
+else
+   define_bool CONFIG_PCMCIA n
+   define_bool CONFIG_HOTPLUG_PCI n
+fi
+
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
 
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
 
 string 'Kernel command line' CONFIG_ETRAX_CMDLINE "root=/dev/mtdblock3"
 
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/defconfig
linux/arch/cris/defconfig
--- ../linux/arch/cris/defconfig	Wed Feb 18 14:36:30 2004
+++ linux/arch/cris/defconfig	Thu Feb 19 15:12:57 2004
@@ -18,6 +18,7 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
 CONFIG_BINFMT_ELF=y
+CONFIG_OOM_KILLER=y
 # CONFIG_ETRAX_KGDB is not set
 # CONFIG_ETRAX_WATCHDOG is not set
 
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/drivers/Config.in
linux/arch/cris/drivers/Config.in
--- ../linux/arch/cris/drivers/Config.in	Wed Feb 18 14:36:30 2004
+++ linux/arch/cris/drivers/Config.in	Mon Aug 23 16:04:40 2004
@@ -215,8 +215,17 @@
     if [ "$CONFIG_ETRAX_RS485_ON_PA" = "y" ]; then
       int '      RS-485 mode on PA bit' CONFIG_ETRAX_RS485_ON_PA_BIT 3
     fi
+    bool '    RS-485 mode on port G' CONFIG_ETRAX_RS485_ON_PORT_G
+    if [ "$CONFIG_ETRAX_RS485_ON_PORT_G" = "y" ]; then
+      int '      RS-485 mode on port G bit'
CONFIG_ETRAX_RS485_ON_PORT_G_BIT 1
+    fi
     bool '    Disable serial receiver' CONFIG_ETRAX_RS485_DISABLE_RECEIVER
   fi
+  bool '  LTC1387 support' CONFIG_ETRAX_LTC1387
+  if [ "$CONFIG_ETRAX_LTC1387" = "y" ]; then
+    int '      DXEN on port G bit' CONFIG_ETRAX_LTC1387_DXEN_PORT_G_BIT 0
+    int '      RXEN on port G bit' CONFIG_ETRAX_LTC1387_RXEN_PORT_G_BIT 12
+  fi	  
 fi
 
 bool 'Synchronous serial port support' CONFIG_ETRAX_SYNCHRONOUS_SERIAL
@@ -334,6 +343,14 @@
   hex  '  PB user changeable bits mask' CONFIG_ETRAX_PB_CHANGEABLE_BITS FF
 fi
 
+bool 'Port G Output' CONFIG_ETRAX_DEF_R_PORT_G_DIR
+if [ "$CONFIG_ETRAX_DEF_R_PORT_G_DIR" = "y" ]; then
+  bool '  G0' CONFIG_ETRAX_DEF_R_PORT_G0_DIR_OUT
+  bool '  G8-G15' CONFIG_ETRAX_DEF_R_PORT_G8_15_DIR_OUT
+  bool '  G16-G23' CONFIG_ETRAX_DEF_R_PORT_G16_23_DIR_OUT
+  bool '  G24' CONFIG_ETRAX_DEF_R_PORT_G24_DIR_OUT 
+fi
+
 bool 'ARTPEC-1 support' CONFIG_JULIETTE
 
 if [ "$CONFIG_JULIETTE" = "y" ]; then

