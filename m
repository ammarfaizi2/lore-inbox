Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTKRR2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 12:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbTKRR2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 12:28:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47073 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263769AbTKRR2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 12:28:14 -0500
Date: Tue, 18 Nov 2003 18:28:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: [2.4 patch] fix USB Gadget Config.in
Message-ID: <20031118172807.GN326@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following link error in 2.4.23-rc1:

<--  snip  -->

...
ld -m elf_i386  -r -o built-in.o net2280.o g_zero.o g_ether.o
g_ether.o(.text+0x1bc0): In function `usb_gadget_get_string':
: multiple definition of `usb_gadget_get_string'
g_zero.o(.text+0x1100): first defined here
make[3]: *** [built-in.o] Error 1
make[3]: Leaving directory 
`/home/bunk/linux/kernel-2.4/linux-2.4.23-rc1-full/drivers/usb/gadget'

<--  snip  -->


.config contained the following:

<--  snip  -->

...
#
# Support for USB gadgets
#
CONFIG_USB_GADGET=y

#
# USB Peripheral Controller Drivers
#
# CONFIG_USB_GADGET_CONTROLLER is not set
CONFIG_USB_NET2280=y
CONFIG_USB_GADGET_CONTROLLER=y

#
# USB Gadget Drivers
#
CONFIG_USB_ZERO=y
CONFIG_USB_ZERO_NET2280=y
CONFIG_USB_ETH=y
CONFIG_USB_ETH_NET2280=y
...

<--  snip  -->


The patch below fixes this issue.

The main change is to remove the problematic

  define_tristate CONFIG_USB_GADGET_CONTROLLER n

and solving it different, and allowing a statically CONFIG_USB_ETH only 
when CONFIG_USB_ZERO isn't statically.

cu
Adrian


--- linux-2.4.23-rc1-full/drivers/usb/gadget/Config.in.old	2003-11-18 02:39:48.000000000 +0100
+++ linux-2.4.23-rc1-full/drivers/usb/gadget/Config.in	2003-11-18 12:06:12.000000000 +0100
@@ -5,8 +5,7 @@
 # Long term, this likely doesn't all belong in one directory
 # Plan to split it up eventually.
 #
-# CAREFUL!  Some versions of "xconfig" don't execute this correctly.
-#
+
 mainmenu_option next_comment
 comment 'Support for USB gadgets'
 
@@ -19,16 +18,15 @@
   #
   comment 'USB Peripheral Controller Drivers'
   
-  # assume all the dependencies may be undefined ("== true", yeech)
-  define_tristate CONFIG_USB_GADGET_CONTROLLER n
-  if [ "$CONFIG_PCI" = "y" ] ; then
-    tristate '  NetChip 2280 support' CONFIG_USB_NET2280
+  dep_tristate '  NetChip 2280 support' CONFIG_USB_NET2280 $CONFIG_PCI
+
+  if [ "$CONFIG_USB_NET2280" = "y" -o "$CONFIG_USB_NET2280" = "m" ]; then
     define_tristate CONFIG_USB_GADGET_CONTROLLER $CONFIG_USB_NET2280
+  else
+    define_tristate CONFIG_USB_GADGET_CONTROLLER n
   fi
 
-  # pxa2xx_udc, goku_udc, and others also work on 2.4 ...
-
-  if [ "$CONFIG_USB_GADGET_CONTROLLER" = "y" -o "$CONFIG_USB_GADGET_CONTROLLER" = "m" ] ; then
+  if [ "$CONFIG_USB_GADGET_CONTROLLER" != "n" ]; then
 
   #
   # no reason not to enable more than one gadget driver module, but
@@ -43,9 +41,20 @@
   #
   # (b) specific hardware features like iso endpoints may be required
   #
+  # at most one gadget driver is allowed to be compiled statically
+  # into the kernel
+  #
+
   comment 'USB Gadget Drivers'
 
-  dep_tristate '  Gadget Zero (DEVELOPMENT)' CONFIG_USB_ZERO $CONFIG_USB_GADGET_CONTROLLER
+    dep_tristate '  Gadget Zero (DEVELOPMENT)' CONFIG_USB_ZERO $CONFIG_USB_GADGET_CONTROLLER
+
+    if [ "$CONFIG_USB_ZERO" != "y" ]; then 
+      dep_tristate '  Ethernet Gadget (EXPERIMENTAL)' CONFIG_USB_ETH $CONFIG_USB_GADGET_CONTROLLER $CONFIG_NET $CONFIG_EXPERIMENTAL
+    else
+      dep_tristate '  Ethernet Gadget (EXPERIMENTAL)' CONFIG_USB_ETH $CONFIG_NET $CONFIG_EXPERIMENTAL m
+    fi
+
   if [ "$CONFIG_USB_ZERO" = "y" -o "$CONFIG_USB_ZERO" = "m" ]; then
       if [ "$CONFIG_USB_NET2280" = "y" -o "$CONFIG_USB_NET2280" = "m" ]; then
   	define_bool CONFIG_USB_ZERO_NET2280 y
@@ -56,8 +65,7 @@
       fi fi fi
       # ...
   fi
-  
-  dep_tristate '  Ethernet Gadget (EXPERIMENTAL)' CONFIG_USB_ETH $CONFIG_USB_GADGET_CONTROLLER $CONFIG_NET
+
   if [ "$CONFIG_USB_ETH" = "y" -o "$CONFIG_USB_ETH" = "m" ]; then
       if [ "$CONFIG_USB_NET2280" = "y" -o "$CONFIG_USB_NET2280" = "m" ]; then
   	define_bool CONFIG_USB_ETH_NET2280 y
