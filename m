Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283786AbRK3U7y>; Fri, 30 Nov 2001 15:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283737AbRK3U7D>; Fri, 30 Nov 2001 15:59:03 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:63427 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S283783AbRK3U6v>;
	Fri, 30 Nov 2001 15:58:51 -0500
Date: Fri, 30 Nov 2001 12:58:35 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no, "Eric S. Raymond" <esr@thyrsus.com>,
        Steven Cole <elenstev@mesatop.com>
Subject: [PATCH] : ir247_config-2.diff
Message-ID: <20011130125835.F3938@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	This patch also sent to Configure.help maitainers to make sure
they are in sync ;-)

	Jean

ir247_config-2.diff :
-------------------
	o [FEATURE] Remove CONFIG_IRDA_OPTIONS. A menu for only 3 items !
	o [FEATURE] Set various CONFIG_IRDA options default to YES
	o [FEATURE] Advertise more aggressively usage of those options
	  in Configure.help. Too many bug reports of people not using those.
	o [FEATURE] Remove obsolete Configure.help entries

diff -u -p linux/net/irda/Config.d3.in linux/net/irda/Config.in
--- linux/net/irda/Config.d3.in	Fri Nov 30 10:06:25 2001
+++ linux/net/irda/Config.in	Fri Nov 30 10:07:31 2001
@@ -14,13 +14,10 @@ if [ "$CONFIG_NET" != "n" ]; then
       source net/irda/irnet/Config.in
       source net/irda/ircomm/Config.in
       bool '  Ultra (connectionless) protocol' CONFIG_IRDA_ULTRA
-      bool '  IrDA protocol options' CONFIG_IRDA_OPTIONS
-      if [ "$CONFIG_IRDA_OPTIONS" != "n" ]; then
-	 comment '  IrDA options'
-	 bool '    Cache last LSAP' CONFIG_IRDA_CACHE_LAST_LSAP
-	 bool '    Fast RRs' CONFIG_IRDA_FAST_RR
-	 bool '    Debug information' CONFIG_IRDA_DEBUG
-      fi
+      comment 'IrDA options'
+      bool '  Cache last LSAP' CONFIG_IRDA_CACHE_LAST_LSAP
+      bool '  Fast RRs (low latency)' CONFIG_IRDA_FAST_RR
+      bool '  Debug information' CONFIG_IRDA_DEBUG
    fi
 
    if [ "$CONFIG_IRDA" != "n" ]; then
diff -u -p linux/arch/i386/defconfig.d3 linux/arch/i386/defconfig
--- linux/arch/i386/defconfig.d3	Fri Nov 30 10:06:54 2001
+++ linux/arch/i386/defconfig	Fri Nov 30 10:07:31 2001
@@ -496,6 +496,9 @@ CONFIG_PCMCIA_RAYCS=y
 # IrDA (infrared) support
 #
 # CONFIG_IRDA is not set
+CONFIG_IRDA_CACHE_LAST_LSAP=y
+CONFIG_IRDA_FAST_RR=y
+CONFIG_IRDA_DEBUG=y
 
 #
 # ISDN subsystem
diff -u -p linux/Documentation/Configure.d3.help linux/Documentation/Configure.help
--- linux/Documentation/Configure.d3.help	Fri Nov 30 10:07:06 2001
+++ linux/Documentation/Configure.help	Fri Nov 30 10:07:31 2001
@@ -22285,11 +22285,6 @@ CONFIG_IRDA_ULTRA
   no management frames, simple fixed header).
   Ultra is available as a special socket : socket(AF_IRDA, SOCK_DGRAM, 1);
 
-IrDA protocol options
-CONFIG_IRDA_OPTIONS
-  Say Y here if you want to configure any of the following IrDA
-  options.
-
 IrDA cache last LSAP
 CONFIG_IRDA_CACHE_LAST_LSAP
   Say Y here if you want IrLMP to cache the last LSAP used.  This
@@ -22301,46 +22296,34 @@ CONFIG_IRDA_CACHE_LAST_LSAP
 IrDA Fast RRs
 CONFIG_IRDA_FAST_RR
   Say Y here is you want IrLAP to send fast RR (Receive Ready) frames
-  when acting as a primary station. This will make IrLAP send out a RR
-  frame immediately when receiving a frame if its own transmit queue
-  is currently empty. This will give a lot of speed improvement when
-  receiving much data since the secondary station will not have to
-  wait the max. turn around time before it is allowed to transmit the
-  next time. If the transmit queue of the secondary is also empty the
-  primary will back off waiting longer for sending out the RR frame
-  until the timeout reaches the normal value. Enabling this option
-  will make the IR-diode burn more power and thus reduce your battery
-  life.
+  when acting as a primary station.
+  Disabling this option will make latency over IrDA very bad. Enabling
+  this option will make the IrDA stack send more packet than strictly
+  necessary, thus reduce your battery life (but not that much).
+
+  Fast RR will make IrLAP send out a RR frame immediately when
+  receiving a frame if its own transmit queue is currently empty. This
+  will give a lot of speed improvement when receiving much data since
+  the secondary station will not have to wait the max. turn around
+  time (usually 500ms) before it is allowed to transmit the next time.
+  If the transmit queue of the secondary is also empty, the primary will
+  start backing-off before sending another RR frame, waiting longer
+  each time until the back-off reaches the max. turn around time.
+  This back-off increase in controlled via
+  /proc/sys/net/irda/fast_poll_increase
 
-  If unsure, say N.
+  If unsure, say Y.
 
 IrDA debugging information
 CONFIG_IRDA_DEBUG
   Say Y here if you want the IrDA subsystem to write debug information
   to your syslog. You can change the debug level in
   /proc/sys/net/irda/debug .
+  When this option is enabled, the IrDA also perform many extra internal
+  verifications which will usually prevent the kernel to crash in case of
+  bugs.
 
   If unsure, say Y (since it makes it easier to find the bugs).
-
-IrLAP compression support
-CONFIG_IRDA_COMPRESSION
-  Compression is _not_ part of the IrDA(tm) protocol specification,
-  but it's working great! Linux is the first to try out compression
-  support at the IrLAP layer. This means that you will only benefit
-  from compression if you are running a Linux <-> Linux configuration.
-
-  If you say Y here, you also need to say Y or M to a compression
-  protocol below.
-
-IrLAP Deflate compression
-CONFIG_IRDA_DEFLATE
-  Say Y here if you want to build support for the Deflate compression
-  protocol. The deflate compression (GZIP) is exactly
-  the same as the one used by the PPP protocol.
-
-  If you want to compile this compression support as a module, say M
-  here and read <file:Documentation/modules.txt>.  The module will be
-  called irda_deflate.o.
 
 IrLAN protocol
 CONFIG_IRLAN

