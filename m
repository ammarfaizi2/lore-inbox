Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288686AbSAUWMO>; Mon, 21 Jan 2002 17:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288675AbSAUWLz>; Mon, 21 Jan 2002 17:11:55 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:42476 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S288686AbSAUWLv>;
	Mon, 21 Jan 2002 17:11:51 -0500
Date: Mon, 21 Jan 2002 14:11:48 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [SCRIPT+PATCH] : wavelan driver move for 2.5.3-pre2
Message-ID: <20020121141148.A9572@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020115181344.A28284@bougret.hpl.hp.com> <Pine.LNX.4.33.0201151854400.1301-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201151854400.1301-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 15, 2002 at 06:55:27PM -0800
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 06:55:27PM -0800, Linus Torvalds wrote:
> 
> On Tue, 15 Jan 2002, Jean Tourrilhes wrote:
> >
> > 	On a related topic : I need to move 3 drivers that I maintain
> > (wavelan.c, wavelan_cs.c and netwave.c) into the directory
> > drivers/net/wireless.
> > 	Do you prefer a *huge* patch, or do you prefer (a small shell
> > script + a small patch) ?
> 
> I'd prefer just the script + small patch, thanks.
> 
> 		Linus

	Hi,

	This shell script and small patch move the 3 driver mentionned
above into the drivers/net/wireless directory (where they will
logically be with their other friends). It is supposed to operate like
this :
		1) First, run the shell script from /usr/src/linux
		2) Second, apply the patch
	One of the "trick" of the operation is that two headers have
to be renamed because of conflicts between the Wavelan ISA and Pcmcia
drivers. Tested on 2.5.3-pre2.
	Would you mind adding that in your kernel ?

	Thanks...

	Jean

P.S. : One more driver to move and I will be able to get rid of
CONFIG_NET_PCMCIA_RADIO from various places...
P.S.2 : Jeff : the trigraph patch will be next.

-----------------------------------------------------------------
#!/bin/sh

# Go in the proper directory. Modify as needed
#cd /usr/src/linux/

# Wavelan ISA driver
mv drivers/net/i82586.h     drivers/net/wireless/
mv drivers/net/wavelan.h    drivers/net/wireless/
mv drivers/net/wavelan.p.h  drivers/net/wireless/
mv drivers/net/wavelan.c    drivers/net/wireless/

# Wavelan Pcmcia driver
# Warning : Rename headers because of conflict with ISA driver
# We use the same conventions as the ISA driver, xxx.p.h is the private header
mv drivers/net/pcmcia/i82593.h      drivers/net/wireless/
mv drivers/net/pcmcia/wavelan.h     drivers/net/wireless/wavelan_cs.h
mv drivers/net/pcmcia/wavelan_cs.h  drivers/net/wireless/wavelan_cs.p.h
mv drivers/net/pcmcia/wavelan_cs.c  drivers/net/wireless/

# Netwave Pcmcia driver
mv drivers/net/pcmcia/netwave_cs.c  drivers/net/wireless/
-----------------------------------------------------------------

diff -u -p -r linux/drivers/net-moved/Config.in linux/drivers/net/Config.in
--- linux/drivers/net-moved/Config.in	Thu Jan 17 10:39:55 2002
+++ linux/drivers/net/Config.in	Thu Jan 17 10:48:59 2002
@@ -292,7 +292,6 @@ comment 'Wireless LAN (non-hamradio)'
 bool 'Wireless LAN (non-hamradio)' CONFIG_NET_RADIO
 if [ "$CONFIG_NET_RADIO" = "y" ]; then
    dep_tristate '  STRIP (Metricom starmode radio IP)' CONFIG_STRIP $CONFIG_INET
-   tristate '  AT&T WaveLAN & DEC RoamAbout DS support' CONFIG_WAVELAN
    tristate '  Aironet Arlan 655 & IC2200 DS support' CONFIG_ARLAN
    tristate '  Aironet 4500/4800 series adapters' CONFIG_AIRONET4500
    dep_tristate '   Aironet 4500/4800 ISA/PCI/PNP/365 support ' CONFIG_AIRONET4500_NONCS $CONFIG_AIRONET4500
diff -u -p -r linux/drivers/net-moved/Makefile linux/drivers/net/Makefile
--- linux/drivers/net-moved/Makefile	Thu Jan 17 10:38:19 2002
+++ linux/drivers/net/Makefile	Thu Jan 17 10:48:59 2002
@@ -166,7 +166,6 @@ obj-$(CONFIG_EEXPRESS) += eexpress.o
 obj-$(CONFIG_EEXPRESS_PRO) += eepro.o
 obj-$(CONFIG_8139CP) += 8139cp.o
 obj-$(CONFIG_8139TOO) += 8139too.o
-obj-$(CONFIG_WAVELAN) += wavelan.o
 obj-$(CONFIG_ARLAN) += arlan.o arlan-proc.o
 obj-$(CONFIG_ZNET) += znet.o
 obj-$(CONFIG_LAN_SAA9730) += saa9730.o
diff -u -p -r linux/drivers/net-moved/pcmcia/Config.in linux/drivers/net/pcmcia/Config.in
--- linux/drivers/net-moved/pcmcia/Config.in	Mon Nov 12 09:35:43 2001
+++ linux/drivers/net/pcmcia/Config.in	Thu Jan 17 10:48:59 2002
@@ -28,8 +28,6 @@ if [ "$CONFIG_NET_PCMCIA" = "y" ]; then
    bool '  Pcmcia Wireless LAN' CONFIG_NET_PCMCIA_RADIO
    if [ "$CONFIG_NET_PCMCIA_RADIO" = "y" ]; then
       dep_tristate '    Aviator/Raytheon 2.4MHz wireless support' CONFIG_PCMCIA_RAYCS $CONFIG_PCMCIA
-      dep_tristate '    Xircom Netwave AirSurfer wireless support' CONFIG_PCMCIA_NETWAVE $CONFIG_PCMCIA
-      dep_tristate '    AT&T/Lucent Wavelan wireless support' CONFIG_PCMCIA_WAVELAN $CONFIG_PCMCIA
       dep_tristate '    Aironet 4500/4800 PCMCIA support' CONFIG_AIRONET4500_CS $CONFIG_AIRONET4500 $CONFIG_PCMCIA
    fi
 fi
diff -u -p -r linux/drivers/net-moved/pcmcia/Makefile linux/drivers/net/pcmcia/Makefile
--- linux/drivers/net-moved/pcmcia/Makefile	Mon Nov 12 09:35:43 2001
+++ linux/drivers/net/pcmcia/Makefile	Thu Jan 17 10:48:59 2002
@@ -27,8 +27,6 @@ obj-$(CONFIG_PCMCIA_AXNET)	+= axnet_cs.o
 
 # 16-bit wireless client drivers
 obj-$(CONFIG_PCMCIA_RAYCS)	+= ray_cs.o
-obj-$(CONFIG_PCMCIA_NETWAVE)	+= netwave_cs.o
-obj-$(CONFIG_PCMCIA_WAVELAN)	+= wavelan_cs.o
 obj-$(CONFIG_AIRONET4500_CS)	+= aironet4500_cs.o
 
 # Cardbus client drivers
diff -u -p -r linux/drivers/net-moved/wireless/Config.in linux/drivers/net/wireless/Config.in
--- linux/drivers/net-moved/wireless/Config.in	Tue Oct  9 15:13:03 2001
+++ linux/drivers/net/wireless/Config.in	Thu Jan 17 10:48:59 2002
@@ -2,6 +2,12 @@
 # Wireless LAN device configuration
 #
 
+comment 'Wireless ISA/PCI cards support' 
+
+# Good old obsolete Wavelan.
+tristate '  AT&T/Lucent old WaveLAN & DEC RoamAbout DS ISA support' CONFIG_WAVELAN
+
+# 802.11b cards
 if [ "$CONFIG_ISA" = "y" -o "$CONFIG_PCI" = "y" ]; then
    tristate '  Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards' CONFIG_AIRO
 fi
@@ -18,8 +24,13 @@ fi
 
 # If Pcmcia is compiled in, offer Pcmcia cards...
 if [ "$CONFIG_PCMCIA" != "n" ]; then
-   comment 'Wireless Pcmcia cards support' 
+   comment 'Wireless Pcmcia/Cardbus cards support' 
+
+# Obsolete cards
+   dep_tristate '  Xircom Netwave AirSurfer Pcmcia wireless support' CONFIG_PCMCIA_NETWAVE $CONFIG_PCMCIA
+   dep_tristate '  AT&T/Lucent old Wavelan Pcmcia wireless support' CONFIG_PCMCIA_WAVELAN $CONFIG_PCMCIA
 
+# 802.11b cards
    dep_tristate '  Hermes PCMCIA card support' CONFIG_PCMCIA_HERMES $CONFIG_HERMES
    tristate '  Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards' CONFIG_AIRO_CS
 fi
diff -u -p -r linux/drivers/net-moved/wireless/Makefile linux/drivers/net/wireless/Makefile
--- linux/drivers/net-moved/wireless/Makefile	Tue Oct  9 15:13:03 2001
+++ linux/drivers/net/wireless/Makefile	Thu Jan 17 10:48:59 2002
@@ -14,6 +14,11 @@ obj-		:=
 # Things that need to export symbols
 export-objs	:= airo.o orinoco.o hermes.o
 
+# Obsolete cards
+obj-$(CONFIG_WAVELAN)		+= wavelan.o
+obj-$(CONFIG_PCMCIA_NETWAVE)	+= netwave_cs.o
+obj-$(CONFIG_PCMCIA_WAVELAN)	+= wavelan_cs.o
+
 obj-$(CONFIG_HERMES)		+= orinoco.o hermes.o
 obj-$(CONFIG_PCMCIA_HERMES)	+= orinoco_cs.o
 obj-$(CONFIG_APPLE_AIRPORT)	+= airport.o
diff -u -p -r linux/drivers/net-moved/wireless/netwave_cs.c linux/drivers/net/wireless/netwave_cs.c
--- linux/drivers/net-moved/wireless/netwave_cs.c	Fri Oct 12 14:21:18 2001
+++ linux/drivers/net/wireless/netwave_cs.c	Thu Jan 17 11:50:00 2002
@@ -61,7 +61,7 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 
-#ifdef CONFIG_NET_PCMCIA_RADIO
+#ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>
 #endif
 
diff -u -p -r linux/drivers/net-moved/wireless/todo.txt linux/drivers/net/wireless/todo.txt
--- linux/drivers/net-moved/wireless/todo.txt	Mon May  7 19:42:14 2001
+++ linux/drivers/net/wireless/todo.txt	Thu Jan 17 10:48:59 2002
@@ -4,21 +4,26 @@
 1) Bring other kernel Wireless LAN drivers here
 	Already done :
 	 o hermes.c/orinoco.c	-> Wavelan IEEE driver + Airport driver
-	Drivers I have control over :
+	 o airo.c/airo_cs.c	-> Ben's Aironet driver
 	 o wavelan.c		-> old Wavelan ISA driver
-	 o wavelan_cs.c		-> old Wavelan Pcmcia driver (warning : header)
+	 o wavelan_cs.c		-> old Wavelan Pcmcia driver
 	 o netwave_cs.c		-> Netwave Pcmcia driver
 	Drivers likely to go :
 	 o ray_cs.c		-> Raytheon/Aviator driver (maintainer MIA)
 	Drivers I have absolutely no control over :
 	 o arlan.c		-> old Aironet Arlan 655 (need to ask Elmer)
 	 o aironet4500_xxx.c	-> Elmer's Aironet driver (need to ask Elmer)
-	 o airo.c/airo_cs.c	-> Ben's Aironet driver (not yet in kernel)
 	 o strip.c		-> Metricom's stuff. Not a wlan. Hum...
 
 	ETA : Kernel 2.5.X
 
 2) Bring new Wireless LAN driver not yet in the kernel there
 	See my web page for details
+
+3) Misc
+	o Mark wavelan, wavelan_cs, netwave_cs drivers as obsolete
+	o Maybe arlan.c, ray_cs.c and strip.c also deserve to be obsolete
+	o Use new Probe/module stuff in wavelan.c
+	o New Wireless Extension API (pending)
 
 	Jean II
diff -u -p -r linux/drivers/net-moved/wireless/wavelan_cs.c linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net-moved/wireless/wavelan_cs.c	Thu Jan 17 10:41:15 2002
+++ linux/drivers/net/wireless/wavelan_cs.c	Thu Jan 17 10:48:59 2002
@@ -4,7 +4,7 @@
  *		Jean II - HPLB '96
  *
  * Reorganisation and extension of the driver.
- * Original copyright follow. See wavelan_cs.h for details.
+ * Original copyright follow. See wavelan_cs.p.h for details.
  *
  * This code is derived from Anthony D. Joseph's code and all the changes here
  * are also under the original copyright below.
@@ -56,7 +56,7 @@
  *
  */
 
-#include "wavelan_cs.h"		/* Private header */
+#include "wavelan_cs.p.h"		/* Private header */
 
 /************************* MISC SUBROUTINES **************************/
 /*
diff -u -p -r linux/drivers/net-moved/wireless/wavelan_cs.h linux/drivers/net/wireless/wavelan_cs.h
--- linux/drivers/net-moved/wireless/wavelan_cs.h	Thu Jan 17 10:41:15 2002
+++ linux/drivers/net/wireless/wavelan_cs.h	Thu Jan 17 10:48:59 2002
@@ -52,8 +52,8 @@
  *       Robert Morris' BSDI driver for the PCMCIA WaveLAN adapter
  */
 
-#ifndef _WAVELAN_H
-#define	_WAVELAN_H
+#ifndef _WAVELAN_CS_H
+#define	_WAVELAN_CS_H
 
 /************************** MAGIC NUMBERS ***************************/
 
@@ -383,4 +383,4 @@ typedef union mm_t
   struct mmr_t	r;	/* Read from the mmc */
 } mm_t;
 
-#endif /* _WAVELAN_H */
+#endif /* _WAVELAN_CS_H */
diff -u -p -r linux/drivers/net-moved/wireless/wavelan_cs.p.h linux/drivers/net/wireless/wavelan_cs.p.h
--- linux/drivers/net-moved/wireless/wavelan_cs.p.h	Thu Jan 17 10:41:15 2002
+++ linux/drivers/net/wireless/wavelan_cs.p.h	Thu Jan 17 11:49:42 2002
@@ -10,8 +10,8 @@
  * be included only on wavelan_cs.c !!!
  */
 
-#ifndef WAVELAN_CS_H
-#define WAVELAN_CS_H
+#ifndef WAVELAN_CS_P_H
+#define WAVELAN_CS_P_H
 
 /************************** DOCUMENTATION **************************/
 /*
@@ -76,7 +76,7 @@
  *	The detection code of the wavelan chech that the first 3
  *	octets of the MAC address fit the company code. This type of
  *	detection work well for AT&T cards (because the AT&T code is
- *	hardcoded in wavelan.h), but of course will fail for other
+ *	hardcoded in wavelan_cs.h), but of course will fail for other
  *	manufacturer.
  *
  *	If you are sure that your card is derived from the wavelan,
@@ -86,7 +86,7 @@
  *		b) With the driver :
  *			o compile the kernel with DEBUG_CONFIG_INFO enabled
  *			o Boot and look the card messages
- *	2) Set your MAC code (3 octets) in MAC_ADDRESSES[][3] (wavelan.h)
+ *	2) Set your MAC code (3 octets) in MAC_ADDRESSES[][3] (wavelan_cs.h)
  *	3) Compile & verify
  *	4) Send me the MAC code - I will include it in the next version...
  *
@@ -111,9 +111,9 @@
 /*
  * wavelan_cs.c :	The actual code for the driver - C functions
  *
- * wavelan_cs.h :	Private header : local types / vars for the driver
+ * wavelan_cs.p.h :	Private header : local types / vars for the driver
  *
- * wavelan.h :		Description of the hardware interface & structs
+ * wavelan_cs.h :	Description of the hardware interface & structs
  *
  * i82593.h :		Description if the Ethernet controller
  */
@@ -428,7 +428,7 @@
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
 
-#ifdef CONFIG_NET_PCMCIA_RADIO
+#ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Wireless extensions */
 #endif
 
@@ -443,7 +443,7 @@
 /* Wavelan declarations */
 #include "i82593.h"	/* Definitions for the Intel chip */
 
-#include "wavelan.h"	/* Others bits of the hardware */
+#include "wavelan_cs.h"	/* Others bits of the hardware */
 
 /************************** DRIVER OPTIONS **************************/
 /*
@@ -821,5 +821,5 @@ MODULE_PARM(do_roaming, "i");
 
 MODULE_LICENSE("GPL");
 
-#endif	/* WAVELAN_CS_H */
+#endif	/* WAVELAN_CS_P_H */
 
