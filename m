Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293263AbSBQSdH>; Sun, 17 Feb 2002 13:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293261AbSBQScs>; Sun, 17 Feb 2002 13:32:48 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:21458 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S293256AbSBQSck>;
	Sun, 17 Feb 2002 13:32:40 -0500
Date: Sun, 17 Feb 2002 19:30:05 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: khc@pm.waw.pl, davem@redhat.com, torvalds@transmeta.com,
        jgarzik@mandrakesoft.com
Subject: [PATCH] HDLC patch for 2.5.5 (0/3)
Message-ID: <20020217193005.B14629@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

  the following patches try and address some of the previously
made remarks:
- avoid variable sized ifreq (Krzysztof Halasa);
- avoid untyped data in ifreq (Jeff Garzik);
- SIOCDEVICE/SIOCWANDEV, hdlc/raw_hdlc (ma pomme).

It's built on top of Krzysztof Halasa's patch applied to 2.5.5-pre1
(ftp://ftp.pm.waw.pl/pub/Linux/hdlc/experimental/hdlc-2.5.3.patch.gz).

[0/3]:
- SIOCDEVICE -> SIOCWANDEV conversion
- hdlc_proto -> raw_hdlc_proto

[1/3]:
- struct if_settings in struct ifreq becomes struct if_settings *;
- anonymous data pointer in struct if_settings is now a pointer to a
  union of struct containing l2 parameters. These structs can be of
  arbitrary size. So far, hdlc_settings is the only one available;
- struct hdlc_settings is declared in (new) include/linux/hdlc/ioctl.h.
  The underlying settings (raw hdlc, cisco, fr) are moved from
  include/linux/hdlc.h to here;
- shortcuts for accessing protocol specific settings are defined in
  include/linux/hdlc/ioctl.h (shamelessly inspired from 
  #define ifr_map ifr_ifru.ifru_map and friends).

[2/3]:
- conversion of drivers/net/wan/hdlc_xxx.c files.

[3/3]:
- some device are converted (c101.c/dscc4.c/farsync.c/n2.c).

Remarks:
- As hdlc_{raw/cisco/fr/x25} doesn't need knowledge of struct ifreq, I would 
happily pass them a pointer to a struct if_settings. This way the 2 stage 
ioctl would be clearer imho.
- It compiles but I have to sacrifice a disk for 2.5 before it can be claimed
to work (TM).
- Patches are archived at <http://www.cogenit.fr/dscc4/hdlc-api/2.5.5-pre1/>.

Comments/code welcome.


diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/c101.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/c101.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/c101.c	Sun Feb 17 17:39:27 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/c101.c	Sun Feb 17 17:32:59 2002
@@ -189,7 +189,7 @@ static int c101_ioctl(struct net_device 
 		return 0;
 	}
 #endif
-	if (cmd != SIOCDEVICE)
+	if (cmd != SIOCWANDEV)
 		return hdlc_ioctl(dev, ifr, cmd);
 
 	switch(ifr->ifr_settings.type) {
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/dscc4.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/dscc4.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/dscc4.c	Sun Feb 17 17:39:27 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/dscc4.c	Sun Feb 17 17:32:59 2002
@@ -1073,7 +1073,7 @@ static int dscc4_ioctl(struct net_device
         if (dev->flags & IFF_UP)
                 return -EBUSY;
 
-	if (cmd != SIOCDEVICE)
+	if (cmd != SIOCWANDEV)
 		return -EOPNOTSUPP;
 
 	switch(ifr->ifr_settings.type) {
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/farsync.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/farsync.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/farsync.c	Sun Feb 17 17:39:27 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/farsync.c	Sun Feb 17 17:32:59 2002
@@ -1240,7 +1240,7 @@ fst_ioctl ( struct net_device *dev, stru
 
                 return set_conf_from_info ( card, port, &info );
 
-        case SIOCDEVICE:
+        case SIOCWANDEV:
                 switch ( ifr->ifr_settings.type )
                 {
                 case IF_GET_IFACE:
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_generic.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_generic.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_generic.c	Sun Feb 17 17:39:27 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_generic.c	Sun Feb 17 17:33:07 2002
@@ -72,7 +72,7 @@ int hdlc_ioctl(struct net_device *dev, s
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	unsigned int proto;
 
-	if (cmd != SIOCDEVICE)
+	if (cmd != SIOCWANDEV)
 		return -EINVAL;
 
 	switch(ifr->ifr_settings.type) {
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_raw.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_raw.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_raw.c	Sun Feb 17 17:39:21 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_raw.c	Sun Feb 17 17:37:48 2002
@@ -49,7 +49,7 @@ int hdlc_raw_ioctl(hdlc_device *hdlc, st
 		if (ifr->ifr_settings.data_length < size)
 			return -ENOMEM;	/* buffer too small */
 		if (copy_to_user(ifr->ifr_settings.data,
-				 &hdlc->state.hdlc.settings, size))
+				 &hdlc->state.raw_hdlc.settings, size))
 			return -EFAULT;
 		ifr->ifr_settings.data_length = size;
 		return 0;
@@ -64,15 +64,15 @@ int hdlc_raw_ioctl(hdlc_device *hdlc, st
 		if (ifr->ifr_settings.data_length != size)
 			return -ENOMEM;	/* incorrect data length */
 
-		if (copy_from_user(&hdlc->state.hdlc.settings,
+		if (copy_from_user(&hdlc->state.raw_hdlc.settings,
 				   ifr->ifr_settings.data, size))
 			return -EFAULT;
 
 		/* FIXME - put sanity checks here */
 		hdlc_detach(hdlc);
 
-		result=hdlc->attach(hdlc, hdlc->state.hdlc.settings.encoding,
-				    hdlc->state.hdlc.settings.parity);
+		result=hdlc->attach(hdlc, hdlc->state.raw_hdlc.settings.encoding,
+				    hdlc->state.raw_hdlc.settings.parity);
 		if (result) {
 			hdlc->proto = -1;
 			return result;
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/n2.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/n2.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/n2.c	Sun Feb 17 17:39:27 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/n2.c	Sun Feb 17 17:32:59 2002
@@ -260,7 +260,7 @@ static int n2_ioctl(struct net_device *d
 		return 0;
 	}
 #endif
-	if (cmd != SIOCDEVICE)
+	if (cmd != SIOCWANDEV)
 		return hdlc_ioctl(dev, ifr, cmd);
 
 	switch(ifr->ifr_settings.type) {
diff -burpN linux-2.5.5-pre1-kh/include/linux/hdlc.h linux-2.5.5-pre1-ma_pomme/include/linux/hdlc.h
--- linux-2.5.5-pre1-kh/include/linux/hdlc.h	Sun Feb 17 17:39:24 2002
+++ linux-2.5.5-pre1-ma_pomme/include/linux/hdlc.h	Sun Feb 17 17:38:27 2002
@@ -53,7 +53,7 @@ typedef struct {
 typedef struct {
 	unsigned short encoding;
 	unsigned short parity;
-}hdlc_proto;
+}raw_hdlc_proto;
 
 
 #define LMI_DEFAULT		0 /* Default (current) setting */
@@ -251,8 +251,8 @@ typedef struct hdlc_device_struct {
 		}cisco;
 
 		struct {
-			hdlc_proto settings;
-		}hdlc;
+			raw_hdlc_proto settings;
+		}raw_hdlc;
 
 		struct {
 			struct ppp_device pppdev;
diff -burpN linux-2.5.5-pre1-kh/include/linux/sockios.h linux-2.5.5-pre1-ma_pomme/include/linux/sockios.h
--- linux-2.5.5-pre1-kh/include/linux/sockios.h	Sun Feb 17 17:39:27 2002
+++ linux-2.5.5-pre1-ma_pomme/include/linux/sockios.h	Sun Feb 17 16:39:23 2002
@@ -81,7 +81,7 @@
 #define SIOCGMIIREG	0x8948		/* Read MII PHY register.	*/
 #define SIOCSMIIREG	0x8949		/* Write MII PHY register.	*/
 
-#define SIOCDEVICE	0x894A		/* get/set netdev parameters	*/
+#define SIOCWANDEV	0x894A		/* get/set netdev parameters	*/
 
 /* ARP cache control calls. */
 		    /*  0x8950 - 0x8952  * obsolete calls, don't re-use */
diff -burpN linux-2.5.5-pre1-kh/net/core/dev.c linux-2.5.5-pre1-ma_pomme/net/core/dev.c
--- linux-2.5.5-pre1-kh/net/core/dev.c	Sun Feb 17 17:39:27 2002
+++ linux-2.5.5-pre1-ma_pomme/net/core/dev.c	Sun Feb 17 16:40:52 2002
@@ -2111,7 +2111,7 @@ static int dev_ifsioc(struct ifreq *ifr,
 			    cmd == SIOCGMIIPHY ||
 			    cmd == SIOCGMIIREG ||
 			    cmd == SIOCSMIIREG ||
-			    cmd == SIOCDEVICE) {
+			    cmd == SIOCWANDEV) {
 				if (dev->do_ioctl) {
 					if (!netif_device_present(dev))
 						return -ENODEV;
@@ -2277,7 +2277,7 @@ int dev_ioctl(unsigned int cmd, void *ar
 		 */	
 		 
 		default:
-			if (cmd == SIOCDEVICE ||
+			if (cmd == SIOCWANDEV ||
 			    (cmd >= SIOCDEVPRIVATE &&
 			     cmd <= SIOCDEVPRIVATE + 15)) {
 				dev_load(ifr.ifr_name);
