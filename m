Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265418AbSJSAWL>; Fri, 18 Oct 2002 20:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265422AbSJSAV7>; Fri, 18 Oct 2002 20:21:59 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:38876 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S265418AbSJSAUI>;
	Fri, 18 Oct 2002 20:20:08 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.43 Generic HDLC ioctl interface update
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 19 Oct 2002 01:54:24 +0200
Message-ID: <m3iszzjob3.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The attached patch for Linux 2.5.43 solves problems with generic HDLC ioctl.

What it does:
- uses "size" parameter to tell the kernel the max data size to copy to
  userland, and thus doesn't overrun userland buffers. It's required as
  the userland doesn't know the protocol or interface type (nor its config
  data size) in advance.
  We do "get interface type" and "get interface "config" in one ioctl to
  prevent race conditions and avoid additional code complication. In real
  world, both operations are done together anyway.

- simplifies if_settings struct.
- all drivers using this (c101, n2, dscc4, farsync, hdlc protos) are
  updated accordingly.
-- 
Krzysztof Halasa
Network Administrator
If you've sent me email recently and it remains unanswered, please try once
again. HDD crash might have eaten it :-(


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=hdlc-2.5.43.patch

--- linux-2.5.orig/include/linux/if.h	2002-10-01 09:06:58.000000000 +0200
+++ linux-2.5/include/linux/if.h	2002-10-19 00:44:51.000000000 +0200
@@ -96,16 +96,20 @@
 struct if_settings
 {
 	unsigned int type;	/* Type of physical device or protocol */
+	unsigned int size;	/* Size of the data allocated by the caller */
 	union {
 		/* {atm/eth/dsl}_settings anyone ? */
-		union hdlc_settings ifsu_hdlc;
-		union line_settings ifsu_line;
+		raw_hdlc_proto		*raw_hdlc;
+		cisco_proto		*cisco;
+		fr_proto		*fr;
+		fr_proto_pvc		*fr_pvc;
+
+		/* interface settings */
+		sync_serial_settings	*sync;
+		te1_settings		*te1;
 	} ifs_ifsu;
 };
 
-#define ifs_hdlc	ifs_ifsu.ifsu_hdlc
-#define ifs_line	ifs_ifsu.ifsu_line
-
 /*
  * Interface request structure used for socket
  * ioctl's.  All interface ioctl's must have parameter
@@ -135,7 +139,7 @@
 		char	ifru_slave[IFNAMSIZ];	/* Just fits the size */
 		char	ifru_newname[IFNAMSIZ];
 		char *	ifru_data;
-		struct	if_settings *ifru_settings;
+		struct	if_settings ifru_settings;
 	} ifr_ifru;
 };
 
--- linux-2.5.orig/include/linux/hdlc.h	2002-10-01 09:07:50.000000000 +0200
+++ linux-2.5/include/linux/hdlc.h	2002-10-19 01:37:22.000000000 +0200
@@ -12,7 +12,7 @@
 #ifndef __HDLC_H
 #define __HDLC_H
 
-#define GENERIC_HDLC_VERSION 3	/* For synchronization with sethdlc utility */
+#define GENERIC_HDLC_VERSION 4	/* For synchronization with sethdlc utility */
 
 #define CLOCK_DEFAULT   0	/* Default setting */
 #define CLOCK_EXT	1	/* External TX and RX clock - DTE */
--- linux-2.5.orig/drivers/net/wan/hdlc_cisco.c	2002-10-01 09:06:28.000000000 +0200
+++ linux-2.5/drivers/net/wan/hdlc_cisco.c	2002-10-19 01:28:41.000000000 +0200
@@ -247,15 +247,19 @@
 
 int hdlc_cisco_ioctl(hdlc_device *hdlc, struct ifreq *ifr)
 {
-	cisco_proto *cisco_s = &ifr->ifr_settings->ifs_hdlc.cisco;
+	cisco_proto *cisco_s = ifr->ifr_settings.ifs_ifsu.cisco;
 	const size_t size = sizeof(cisco_proto);
 	cisco_proto new_settings;
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
-	switch (ifr->ifr_settings->type) {
+	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings->type = IF_PROTO_CISCO;
+		ifr->ifr_settings.type = IF_PROTO_CISCO;
+		if (ifr->ifr_settings.size < size) {
+			ifr->ifr_settings.size = size; /* data size wanted */
+			return -ENOBUFS;
+		}
 		if (copy_to_user(cisco_s, &hdlc->state.cisco.settings, size))
 			return -EFAULT;
 		return 0;
--- linux-2.5.orig/drivers/net/wan/hdlc_fr.c	2002-10-01 09:06:27.000000000 +0200
+++ linux-2.5/drivers/net/wan/hdlc_fr.c	2002-10-19 01:25:32.000000000 +0200
@@ -778,16 +778,20 @@
 
 int hdlc_fr_ioctl(hdlc_device *hdlc, struct ifreq *ifr)
 {
-	fr_proto *fr_s = &ifr->ifr_settings->ifs_hdlc.fr;
+	fr_proto *fr_s = ifr->ifr_settings.ifs_ifsu.fr;
 	const size_t size = sizeof(fr_proto);
 	fr_proto new_settings;
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	fr_proto_pvc pvc;
 	int result;
 
-	switch (ifr->ifr_settings->type) {
+	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings->type = IF_PROTO_FR;
+		ifr->ifr_settings.type = IF_PROTO_FR;
+		if (ifr->ifr_settings.size < size) {
+			ifr->ifr_settings.size = size; /* data size wanted */
+			return -ENOBUFS;
+		}
 		if (copy_to_user(fr_s, &hdlc->state.fr.settings, size))
 			return -EFAULT;
 		return 0;
@@ -847,12 +851,12 @@
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(&pvc, &ifr->ifr_settings->ifs_hdlc.fr_pvc,
+		if (copy_from_user(&pvc, ifr->ifr_settings.ifs_ifsu.fr_pvc,
 				   sizeof(fr_proto_pvc)))
 			return -EFAULT;
 
 		return fr_pvc(hdlc, pvc.dlci,
-			      ifr->ifr_settings->type == IF_PROTO_FR_ADD_PVC);
+			      ifr->ifr_settings.type == IF_PROTO_FR_ADD_PVC);
 	}
 
 	return -EINVAL;
--- linux-2.5.orig/drivers/net/wan/hdlc_generic.c	2002-10-01 09:06:17.000000000 +0200
+++ linux-2.5/drivers/net/wan/hdlc_generic.c	2002-10-19 01:37:03.000000000 +0200
@@ -38,7 +38,7 @@
 #include <linux/hdlc.h>
 
 
-static const char* version = "HDLC support module revision 1.10";
+static const char* version = "HDLC support module revision 1.11";
 
 
 static int hdlc_change_mtu(struct net_device *dev, int new_mtu)
@@ -95,13 +95,13 @@
 	if (cmd != SIOCWANDEV)
 		return -EINVAL;
 
-	switch(ifr->ifr_settings->type) {
+	switch(ifr->ifr_settings.type) {
 	case IF_PROTO_HDLC:
 	case IF_PROTO_PPP:
 	case IF_PROTO_CISCO:
 	case IF_PROTO_FR:
 	case IF_PROTO_X25:
-		proto = ifr->ifr_settings->type;
+		proto = ifr->ifr_settings.type;
 		break;
 
 	default:
--- linux-2.5.orig/drivers/net/wan/hdlc_ppp.c	2002-10-01 09:06:16.000000000 +0200
+++ linux-2.5/drivers/net/wan/hdlc_ppp.c	2002-10-19 01:25:39.000000000 +0200
@@ -82,9 +82,9 @@
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
-	switch (ifr->ifr_settings->type) {
+	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings->type = IF_PROTO_PPP;
+		ifr->ifr_settings.type = IF_PROTO_PPP;
 		return 0; /* return protocol only, no settable parameters */
 
 	case IF_PROTO_PPP:
--- linux-2.5.orig/drivers/net/wan/hdlc_raw.c	2002-10-01 09:07:06.000000000 +0200
+++ linux-2.5/drivers/net/wan/hdlc_raw.c	2002-10-19 01:28:59.000000000 +0200
@@ -37,15 +37,19 @@
 
 int hdlc_raw_ioctl(hdlc_device *hdlc, struct ifreq *ifr)
 {
-	raw_hdlc_proto *raw_s = &ifr->ifr_settings->ifs_hdlc.raw_hdlc;
+	raw_hdlc_proto *raw_s = ifr->ifr_settings.ifs_ifsu.raw_hdlc;
 	const size_t size = sizeof(raw_hdlc_proto);
 	raw_hdlc_proto new_settings;
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
-	switch (ifr->ifr_settings->type) {
+	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings->type = IF_PROTO_HDLC;
+		ifr->ifr_settings.type = IF_PROTO_HDLC;
+		if (ifr->ifr_settings.size < size) {
+			ifr->ifr_settings.size = size; /* data size wanted */
+			return -ENOBUFS;
+		}
 		if (copy_to_user(raw_s, &hdlc->state.raw_hdlc.settings, size))
 			return -EFAULT;
 		return 0;
--- linux-2.5.orig/drivers/net/wan/n2.c	2002-10-01 09:06:23.000000000 +0200
+++ linux-2.5/drivers/net/wan/n2.c	2002-10-19 01:24:50.000000000 +0200
@@ -246,9 +246,8 @@
 
 static int n2_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	union line_settings *line = &ifr->ifr_settings->ifs_line;
 	const size_t size = sizeof(sync_serial_settings);
-	sync_serial_settings new_line;
+	sync_serial_settings new_line, *line = ifr->ifr_settings.ifs_ifsu.sync;
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	port_t *port = hdlc_to_port(hdlc);
 
@@ -261,10 +260,14 @@
 	if (cmd != SIOCWANDEV)
 		return hdlc_ioctl(dev, ifr, cmd);
 
-	switch(ifr->ifr_settings->type) {
+	switch(ifr->ifr_settings.type) {
 	case IF_GET_IFACE:
-		ifr->ifr_settings->type = IF_IFACE_SYNC_SERIAL;
-		if (copy_to_user(&line->sync, &port->settings, size))
+		ifr->ifr_settings.type = IF_IFACE_SYNC_SERIAL;
+		if (ifr->ifr_settings.size < size) {
+			ifr->ifr_settings.size = size; /* data size wanted */
+			return -ENOBUFS;
+		}
+		if (copy_to_user(line, &port->settings, size))
 			return -EFAULT;
 		return 0;
 
@@ -272,7 +275,7 @@
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(&new_line, &line->sync, size))
+		if (copy_from_user(&new_line, line, size))
 			return -EFAULT;
 
 		if (new_line.clock_type != CLOCK_EXT &&
--- linux-2.5.orig/drivers/net/wan/c101.c	2002-10-01 09:06:22.000000000 +0200
+++ linux-2.5/drivers/net/wan/c101.c	2002-10-19 01:24:56.000000000 +0200
@@ -175,9 +175,8 @@
 
 static int c101_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	union line_settings *line = &ifr->ifr_settings->ifs_line;
 	const size_t size = sizeof(sync_serial_settings);
-	sync_serial_settings new_line;
+	sync_serial_settings new_line, *line = ifr->ifr_settings.ifs_ifsu.sync;
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	port_t *port = hdlc_to_port(hdlc);
 
@@ -190,10 +189,14 @@
 	if (cmd != SIOCWANDEV)
 		return hdlc_ioctl(dev, ifr, cmd);
 
-	switch(ifr->ifr_settings->type) {
+	switch(ifr->ifr_settings.type) {
 	case IF_GET_IFACE:
-		ifr->ifr_settings->type = IF_IFACE_SYNC_SERIAL;
-		if (copy_to_user(&line->sync, &port->settings, size))
+		ifr->ifr_settings.type = IF_IFACE_SYNC_SERIAL;
+		if (ifr->ifr_settings.size < size) {
+			ifr->ifr_settings.size = size; /* data size wanted */
+			return -ENOBUFS;
+		}
+		if (copy_to_user(line, &port->settings, size))
 			return -EFAULT;
 		return 0;
 
@@ -201,7 +204,7 @@
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(&new_line, &line->sync, size))
+		if (copy_from_user(&new_line, line, size))
 			return -EFAULT;
 
 		if (new_line.clock_type != CLOCK_EXT &&
--- linux-2.5.orig/drivers/net/wan/farsync.c	2002-10-01 09:07:31.000000000 +0200
+++ linux-2.5/drivers/net/wan/farsync.c	2002-10-19 01:29:30.000000000 +0200
@@ -1010,11 +1010,11 @@
 fst_set_iface ( struct fst_card_info *card, struct fst_port_info *port,
                 struct ifreq *ifr )
 {
-	union line_settings *line = &ifr->ifr_settings->ifs_line;
         sync_serial_settings sync;
         int i;
 
-        if ( copy_from_user ( &sync, &line->sync, sizeof ( sync )))
+        if (copy_from_user (&sync, ifr->ifr_settings.ifs_ifsu.sync,
+			    sizeof (sync)))
                 return -EFAULT;
 
         if ( sync.loopback )
@@ -1022,7 +1022,7 @@
 
         i = port->index;
 
-        switch ( ifr->ifr_settings->type )
+        switch (ifr->ifr_settings.type)
         {
         case IF_IFACE_V35:
                 FST_WRW ( card, portConfig[i].lineInterface, V35 );
@@ -1067,7 +1067,6 @@
 fst_get_iface ( struct fst_card_info *card, struct fst_port_info *port,
                 struct ifreq *ifr )
 {
-	union line_settings *line = &ifr->ifr_settings->ifs_line;
         sync_serial_settings sync;
         int i;
 
@@ -1078,24 +1077,30 @@
         switch ( port->hwif )
         {
         case V35:
-                ifr->ifr_settings->type = IF_IFACE_V35;
+                ifr->ifr_settings.type = IF_IFACE_V35;
                 break;
         case V24:
-                ifr->ifr_settings->type = IF_IFACE_V24;
+                ifr->ifr_settings.type = IF_IFACE_V24;
                 break;
         case X21:
         default:
-                ifr->ifr_settings->type = IF_IFACE_X21;
+                ifr->ifr_settings.type = IF_IFACE_X21;
                 break;
         }
 
+	if (ifr->ifr_settings.size < sizeof(sync)) {
+		ifr->ifr_settings.size = sizeof(sync); /* data size wanted */
+		return -ENOBUFS;
+	}
+
         i = port->index;
         sync.clock_rate = FST_RDL ( card, portConfig[i].lineSpeed );
         /* Lucky card and linux use same encoding here */
         sync.clock_type = FST_RDB ( card, portConfig[i].internalClock );
         sync.loopback = 0;
 
-        if ( copy_to_user (&line->sync, &sync, sizeof ( sync )))
+        if (copy_to_user (ifr->ifr_settings.ifs_ifsu.sync, &sync,
+			  sizeof(sync)))
                 return -EFAULT;
 
         return 0;
@@ -1221,7 +1226,7 @@
                 return set_conf_from_info ( card, port, &info );
 
         case SIOCWANDEV:
-                switch ( ifr->ifr_settings->type )
+                switch (ifr->ifr_settings.type)
                 {
                 case IF_GET_IFACE:
                         return fst_get_iface ( card, port, ifr );
--- linux-2.5.orig/drivers/net/wan/dscc4.c	2002-10-01 09:06:25.000000000 +0200
+++ linux-2.5/drivers/net/wan/dscc4.c	2002-10-19 01:27:39.000000000 +0200
@@ -1144,7 +1144,7 @@
 
 static int dscc4_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	union line_settings *line = &ifr->ifr_settings->ifs_line;
+	sync_serial_settings *line = ifr->ifr_settings.ifs_ifsu.sync;
 	struct dscc4_dev_priv *dpriv = dscc4_priv(dev);
 	const size_t size = sizeof(dpriv->settings);
 	int ret = 0;
@@ -1155,10 +1155,14 @@
 	if (cmd != SIOCWANDEV)
 		return -EOPNOTSUPP;
 
-	switch(ifr->ifr_settings->type) {
+	switch(ifr->ifr_settings.type) {
 	case IF_GET_IFACE:
-		ifr->ifr_settings->type = IF_IFACE_SYNC_SERIAL;
-		if (copy_to_user(&line->sync, &dpriv->settings, size))
+		ifr->ifr_settings.type = IF_IFACE_SYNC_SERIAL;
+		if (ifr->ifr_settings.size < size) {
+			ifr->ifr_settings.size = size; /* data size wanted */
+			return -ENOBUFS;
+		}
+		if (copy_to_user(line, &dpriv->settings, size))
 			return -EFAULT;
 		break;
 
@@ -1166,7 +1170,7 @@
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(&dpriv->settings, &line->sync, size))
+		if (copy_from_user(&dpriv->settings, line, size))
 			return -EFAULT;
 		ret = dscc4_set_iface(dpriv, dev);
 		break;

--=-=-=--
