Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTCDW74>; Tue, 4 Mar 2003 17:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTCDW74>; Tue, 4 Mar 2003 17:59:56 -0500
Received: from intra.cyclades.com ([64.186.161.6]:35850 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP
	id <S266114AbTCDW7x>; Tue, 4 Mar 2003 17:59:53 -0500
Message-ID: <3E64C196.9070105@cyclades.com>
Date: Tue, 04 Mar 2003 15:09:10 +0000
From: Henrique Gobbi <henrique2.gobbi@cyclades.com>
Reply-To: henrique.gobbi@cyclades.com
Organization: Cyclades Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - PC300 driver for kernel 2.4 (1/6)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo !!!

Please apply this patch that includes support to all Cyclades-PC300 
cards on the kernel 2.4. The patch was made against the kernel 
2.4.21-pre5 (2.4.20 with the 2.4.21-pre5 patch). If you have any doubt 
or problem regarding this patch please let me know. If you're not the 
one who should be receiving this patch I'm sorry, please refer me to 
whoever takes care of the wan driver.

As the patch is big it's split into 6 e-mails.

This is the part 1/6

diff -ruN linux-2.4.21-pre5.orig/Documentation/Configure.help 
linux-2.4.21-pre5/Documentation/Configure.help
--- linux-2.4.21-pre5.orig/Documentation/Configure.help	Thu Feb 27 09:21:21 2003
+++ linux-2.4.21-pre5/Documentation/Configure.help	Thu Feb 27 09:08:33 2003
@@ -17279,6 +17279,27 @@
    If you want to compile this driver as a module, say M here and read
    <file:Documentation/modules.txt>. The module will be called pcxx.o.

+Cyclades-PC300 support
+CONFIG_PC300
+  This is a driver for the Cyclades-PC300 synchronous communication
+  boards. These boards provide synchronous serial interfaces to your
+  Linux box (interfaces currently available are RS-232/V.35, X.21 and
+  T1/E1). If you wish to support Multilink PPP, please select the
+  option below this one and read the file README.mlppp provided by PC300
+  package.
+
+  If you want to compile this as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want),
+  say M here and read Documentation/modules.txt. The module will be
+  called pc300.o.
+
+  If you haven't heard about it, it's safe to say N.
+
+Cyclades-PC300 Sync TTY (to MLPPP) support
+CONFIG_PC300_MLPPP
+  Say 'Y' to this option if you are planning to use Multilink PPP over the
+  PC300 synchronous communication boards.
+
  SDL RISCom/8 card support
  CONFIG_RISCOM8
    This is a driver for the SDL Communications RISCom/8 multiport card,
diff -ruN linux-2.4.21-pre5.orig/drivers/net/wan/Config.in 
linux-2.4.21-pre5/drivers/net/wan/Config.in
--- linux-2.4.21-pre5.orig/drivers/net/wan/Config.in	Thu Feb 27 09:21:31 2003
+++ linux-2.4.21-pre5/drivers/net/wan/Config.in	Thu Feb 27 09:08:33 2003
@@ -76,6 +76,18 @@
        else
  	 comment '    X.25/LAPB support is disabled'
        fi
+      if [ "$CONFIG_PCI" != "n" ]; then
+ 
dep_tristate '    Cyclades-PC300 support (RS-232/V.35, X.21, T1/E1 
boards)' CONFIG_PC300 $CONFIG_HDLC
+ 
if [ "$CONFIG_PC300" != "n" ]; then
+ 
	if ["$CONFIG_PPP" != "n" -a "$CONFIG_PPP_MULTLINK" != "n" -a 
"$CONFIG_PPP_SYNCTTY" != "n" -a "$CONFIG_HDLC_PPP" = "y"];
+ 
	then
+ 
		bool '      Cyclades-PC300 MLPPP support' CONFIG_PC300_MLPPP
+ 
	else
+ 
		comment '     Cyclades-PC300 MLPPP support is disabled. You have to enable 
PPP, PPP_MULTILINK'
+ 
		comment '     PPP_SYNCTTY and HDLC_PPP to use this package.'
+ 
	fi
+ 
fi
+      fi
        dep_tristate '    SDL RISCom/N2 support' CONFIG_N2 $CONFIG_HDLC
        dep_tristate '    Moxa C101 support' CONFIG_C101 $CONFIG_HDLC
        dep_tristate '    FarSync T-Series support' CONFIG_FARSYNC 
$CONFIG_HDLC
diff -ruN linux-2.4.21-pre5.orig/drivers/net/wan/Makefile 
linux-2.4.21-pre5/drivers/net/wan/Makefile
--- linux-2.4.21-pre5.orig/drivers/net/wan/Makefile	Thu Feb 27 09:21:31 2003
+++ linux-2.4.21-pre5/drivers/net/wan/Makefile	Thu Feb 27 09:08:33 2003
@@ -9,7 +9,7 @@

  O_TARGET := wan.o

-export-objs =	z85230.o syncppp.o comx.o sdladrv.o cycx_drv.o hdlc_generic.o
+export-objs =	z85230.o syncppp.o comx.o sdladrv.o cycx_drv.o 
hdlc_generic.o pc300_drv.o
  list-multi =	wanpipe.o cyclomx.o

  wanpipe-objs = sdlamain.o sdla_ft1.o $(wanpipe-y)
@@ -30,6 +30,8 @@
  hdlc-$(CONFIG_HDLC_X25)		+= hdlc_x25.o
  hdlc-objs	 
	:= $(hdlc-y)

+pc300-$(CONFIG_PC300_MLPPP) 
+= pc300_tty.o
+
  obj-$(CONFIG_HOSTESS_SV11)	+= z85230.o	syncppp.o	hostess_sv11.o
  obj-$(CONFIG_SEALEVEL_4021)	+= z85230.o	syncppp.o	sealevel.o
  obj-$(CONFIG_COMX)		+= 		 
	comx.o
@@ -70,6 +72,7 @@
  obj-$(CONFIG_CYCLADES_SYNC)	+= cycx_drv.o cyclomx.o
  obj-$(CONFIG_LAPBETHER)		+= lapbether.o
  obj-$(CONFIG_SBNI)		+= sbni.o
+obj-$(CONFIG_PC300) 
	+= pc300.o
  obj-$(CONFIG_HDLC)		+= hdlc.o
  ifeq ($(CONFIG_HDLC_PPP),y)
    obj-$(CONFIG_HDLC)		+= syncppp.o
@@ -79,6 +82,9 @@

  include $(TOPDIR)/Rules.make

+pc300.o: pc300_drv.o $(pc300-y)
+ 
$(LD) -r -o $@ pc300_drv.o $(pc300-y)
+
  hdlc.o: $(hdlc-objs)
  	$(LD) -r -o $@ $(hdlc-objs)


