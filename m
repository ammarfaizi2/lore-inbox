Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287804AbSBCWIJ>; Sun, 3 Feb 2002 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287816AbSBCWHy>; Sun, 3 Feb 2002 17:07:54 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:23973 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S287804AbSBCWH3>;
	Sun, 3 Feb 2002 17:07:29 -0500
Date: Sun, 3 Feb 2002 23:06:52 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        davem@redhat.com
Subject: Re: [PATCH] Generic HDLC patch for 2.5.3
Message-ID: <20020203230652.D12963@fafner.intra.cogenit.fr>
In-Reply-To: <20020202190242.C1740@havoc.gtf.org> <E16XAnc-00010K-00@the-village.bc.nu> <20020202200332.A3740@havoc.gtf.org> <20020203181302.C12963@fafner.intra.cogenit.fr> <20020203124614.A10139@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020203124614.A10139@havoc.gtf.org>; from garzik@havoc.gtf.org on Sun, Feb 03, 2002 at 12:46:14PM -0500
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <garzik@havoc.gtf.org> :
> I like.  This patch much improves things.
> 
> "SIOCDEVICE" as a constant is unacceptable, so it would need to be
> SIOCWANDEVICE or something similar.
> 
> SIOCETHTOOL, for example, is an ioctl which actually provides
> sub-ioctls, so that is probably a good model to follow.

Actually that's what hdlc patch does: SIOCDEVICE is the main ioctl with
sub-ioctl IF_IFACE_SYNC_SERIAL, IF_GET_PROTO, IF_PROTO_{RAW/CISCO/FR/PPP/X25}.

Regarding SIOCETHTOOL, is netdev_ethtool_ioctl() weak typing a work in 
progress ?

Try #2:
- what about SIOCWANDEV ?
- drivers updated

diff -burpN linux-2.5.3-kh/drivers/net/wan/Config.in linux-2.5.3/drivers/net/wan/Config.in
--- linux-2.5.3-kh/drivers/net/wan/Config.in	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/Config.in	Sun Feb  3 21:00:02 2002
@@ -37,7 +37,7 @@ if [ "$CONFIG_WAN" = "y" ]; then
 # The Etinc driver has not been tested as non-modular yet.
 #
 
-   dep_tristate '  Etinc PCISYNC serial board support (EXPERIMENTAL)' CONFIG_DSCC4 m
+   dep_tristate '  Etinc PCISYNC serial board support (EXPERIMENTAL)' CONFIG_DSCC4
 
 
 #
diff -burpN linux-2.5.3-kh/drivers/net/wan/c101.c linux-2.5.3/drivers/net/wan/c101.c
--- linux-2.5.3-kh/drivers/net/wan/c101.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/c101.c	Sun Feb  3 22:04:51 2002
@@ -24,6 +24,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
+#include <linux/hdlc/ioctl.h>
 #include <linux/hdlc.h>
 #include <linux/delay.h>
 #include <asm/io.h>
@@ -31,8 +32,8 @@
 #include "hd64570.h"
 
 
-static const char* version = "Moxa C101 driver version: 1.09";
-static const char* devname = "C101";
+static const char version[] = "Moxa C101 driver version: 1.09";
+static const char devname[] = "C101";
 
 #define C101_PAGE 0x1D00
 #define C101_DTR 0x1E00
@@ -179,9 +180,10 @@ static int c101_close(struct net_device 
 
 static int c101_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
+	struct hdlc_settings *hdlc_s = &ifr->ifr_settings.ifs_hdlc;
+	const size_t size = sizeof(sync_serial_settings);
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	port_t *port = hdlc_to_port(hdlc);
-	const size_t size = sizeof(sync_serial_settings);
 
 #ifdef CONFIG_HDLC_DEBUG_RINGS
 	if (cmd == SIOCDEVPRIVATE) {
@@ -189,31 +191,21 @@ static int c101_ioctl(struct net_device 
 		return 0;
 	}
 #endif
-	if (cmd != SIOCDEVICE)
+	if (cmd != SIOCWANDEV)
 		return hdlc_ioctl(dev, ifr, cmd);
 
 	switch(ifr->ifr_settings.type) {
 	case IF_GET_IFACE:
 		ifr->ifr_settings.type = IF_IFACE_SYNC_SERIAL;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return interface type only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
-				 &port->settings, size))
+		if (copy_to_user(&hdlc_s->hdlcs_sync, &port->settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_IFACE_SYNC_SERIAL:
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (ifr->ifr_settings.data_length != size)
-			return -ENOMEM;	/* incorrect data length */
-
-		if (copy_from_user(&port->settings,
-				   ifr->ifr_settings.data, size))
+		if (copy_from_user(&port->settings, &hdlc_s->hdlcs_sync, size))
 			return -EFAULT;
 		/* FIXME - put sanity checks here */
 		return c101_set_iface(port);
diff -burpN linux-2.5.3-kh/drivers/net/wan/dscc4.c linux-2.5.3/drivers/net/wan/dscc4.c
--- linux-2.5.3-kh/drivers/net/wan/dscc4.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/dscc4.c	Sun Feb  3 21:59:12 2002
@@ -112,6 +112,7 @@
 #include <linux/skbuff.h>
 #include <linux/delay.h>
 #include <net/syncppp.h>
+#include <linux/hdlc/ioctl.h>
 #include <linux/hdlc.h>
 
 /* Version */
@@ -1065,37 +1066,29 @@ static int dscc4_set_clock(struct net_de
 
 static int dscc4_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
+	struct hdlc_settings *hdlc_s = &ifr->ifr_settings.ifs_hdlc;
 	struct dscc4_dev_priv *dpriv = dscc4_priv(dev);
-	struct if_settings *if_s = &ifr->ifr_settings;
 	const size_t size = sizeof(dpriv->settings);
 	int ret = 0;
 
         if (dev->flags & IFF_UP)
                 return -EBUSY;
 
-	if (cmd != SIOCDEVICE)
+	if (cmd != SIOCWANDEV)
 		return -EOPNOTSUPP;
 
 	switch(ifr->ifr_settings.type) {
 	case IF_GET_IFACE:
-		if_s->type = IF_IFACE_SYNC_SERIAL;
-		if (if_s->data_length == 0)
-			return 0;
-		if (if_s->data_length < size)
-			return -ENOMEM;
-		if (copy_to_user(if_s->data, &dpriv->settings, size))
+		ifr->ifr_settings.type = IF_IFACE_SYNC_SERIAL;
+		if (copy_to_user(&hdlc_s->hdlcs_sync, &dpriv->settings, size))
 			return -EFAULT;
-		if_s->data_length = size;
 		break;
 
 	case IF_IFACE_SYNC_SERIAL:
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (if_s->data_length != size)
-			return -ENOMEM;
-
-		if (copy_from_user(&dpriv->settings, if_s->data, size))
+		if (copy_from_user(&dpriv->settings, &hdlc_s->hdlcs_sync, size))
 			return -EFAULT;
 		ret = dscc4_set_iface(dev);
 		break;
diff -burpN linux-2.5.3-kh/drivers/net/wan/farsync.c linux-2.5.3/drivers/net/wan/farsync.c
--- linux-2.5.3-kh/drivers/net/wan/farsync.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/farsync.c	Sun Feb  3 21:52:16 2002
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <asm/uaccess.h>
 #include <linux/if.h>
+#include <linux/hdlc/ioctl.h>
 #include <linux/hdlc.h>
 
 #include "farsync.h"
@@ -1013,18 +1014,12 @@ static int
 fst_set_iface ( struct fst_card_info *card, struct fst_port_info *port,
                 struct ifreq *ifr )
 {
+	struct hdlc_settings *hdlc_s = &ifr->ifr_settings.ifs_hdlc;
         sync_serial_settings sync;
         int i;
 
-        if ( ifr->ifr_settings.data_length != sizeof ( sync ))
-        {
-                return -ENOMEM;
-        }
-
-        if ( copy_from_user ( &sync, ifr->ifr_settings.data, sizeof ( sync )))
-        {
+        if ( copy_from_user ( &sync, &hdlc_s->hdlcs_sync, sizeof ( sync )))
                 return -EFAULT;
-        }
 
         if ( sync.loopback )
                 return -EINVAL;
@@ -1076,6 +1071,7 @@ static int
 fst_get_iface ( struct fst_card_info *card, struct fst_port_info *port,
                 struct ifreq *ifr )
 {
+	struct hdlc_settings *hdlc_s = &ifr->ifr_settings.ifs_hdlc;
         sync_serial_settings sync;
         int i;
 
@@ -1096,15 +1092,6 @@ fst_get_iface ( struct fst_card_info *ca
                 ifr->ifr_settings.type = IF_IFACE_X21;
                 break;
         }
-        if ( ifr->ifr_settings.data_length == 0 )
-        {
-                return 0;       /* only type requested */
-        }
-
-        if ( ifr->ifr_settings.data_length < sizeof ( sync ))
-        {
-                return -ENOMEM;
-        }
 
         i = port->index;
         sync.clock_rate = FST_RDL ( card, portConfig[i].lineSpeed );
@@ -1112,12 +1099,9 @@ fst_get_iface ( struct fst_card_info *ca
         sync.clock_type = FST_RDB ( card, portConfig[i].internalClock );
         sync.loopback = 0;
 
-        if ( copy_to_user ( ifr->ifr_settings.data, &sync, sizeof ( sync )))
-        {
+        if ( copy_to_user (&hdlc_s->hdlcs_sync, &sync, sizeof ( sync )))
                 return -EFAULT;
-        }
 
-        ifr->ifr_settings.data_length = sizeof ( sync );
         return 0;
 }
 
@@ -1240,7 +1224,7 @@ fst_ioctl ( struct net_device *dev, stru
 
                 return set_conf_from_info ( card, port, &info );
 
-        case SIOCDEVICE:
+        case SIOCWANDEV:
                 switch ( ifr->ifr_settings.type )
                 {
                 case IF_GET_IFACE:
diff -burpN linux-2.5.3-kh/drivers/net/wan/hdlc_cisco.c linux-2.5.3/drivers/net/wan/hdlc_cisco.c
--- linux-2.5.3-kh/drivers/net/wan/hdlc_cisco.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/hdlc_cisco.c	Sun Feb  3 22:03:35 2002
@@ -25,6 +25,7 @@
 #include <linux/lapb.h>
 #include <linux/rtnetlink.h>
 #include <linux/hdlc.h>
+#include <linux/hdlc/ioctl.h>
 
 
 #define CISCO_MULTICAST		0x8F	/* Cisco multicast address */
@@ -247,6 +248,7 @@ static void cisco_close(hdlc_device *hdl
 
 int hdlc_cisco_ioctl(hdlc_device *hdlc, struct ifreq *ifr)
 {
+	cisco_proto *cisco_s = &ifr->ifr_settings.ifs_hdlc.hdlcs_cisco;
 	const size_t size = sizeof(cisco_proto);
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
@@ -254,14 +256,8 @@ int hdlc_cisco_ioctl(hdlc_device *hdlc, 
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
 		ifr->ifr_settings.type = IF_PROTO_CISCO;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return protocol only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
-				 &hdlc->state.cisco.settings, size))
+		if (copy_to_user(cisco_s, &hdlc->state.cisco.settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_PROTO_CISCO:
@@ -271,11 +267,7 @@ int hdlc_cisco_ioctl(hdlc_device *hdlc, 
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (ifr->ifr_settings.data_length != size)
-			return -ENOMEM;	/* incorrect data length */
-			
-		if (copy_from_user(&hdlc->state.cisco.settings,
-				   ifr->ifr_settings.data, size))
+		if (copy_from_user(&hdlc->state.cisco.settings, cisco_s, size))
 			return -EFAULT;
 
 		/* FIXME - put sanity checks here */
diff -burpN linux-2.5.3-kh/drivers/net/wan/hdlc_fr.c linux-2.5.3/drivers/net/wan/hdlc_fr.c
--- linux-2.5.3-kh/drivers/net/wan/hdlc_fr.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/hdlc_fr.c	Sun Feb  3 22:03:22 2002
@@ -25,6 +25,7 @@
 #include <linux/lapb.h>
 #include <linux/rtnetlink.h>
 #include <linux/hdlc.h>
+#include <linux/hdlc/ioctl.h>
 
 
 __inline__ pvc_device* find_pvc(hdlc_device *hdlc, u16 dlci)
@@ -776,6 +777,7 @@ static void fr_destroy(hdlc_device *hdlc
 
 int hdlc_fr_ioctl(hdlc_device *hdlc, struct ifreq *ifr)
 {
+	fr_proto *fr_s = &ifr->ifr_settings.ifs_hdlc.hdlcs_fr;
 	const size_t size = sizeof(fr_proto);
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	fr_proto_pvc pvc;
@@ -784,14 +786,8 @@ int hdlc_fr_ioctl(hdlc_device *hdlc, str
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
 		ifr->ifr_settings.type = IF_PROTO_FR;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return protocol only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
-				 &hdlc->state.fr.settings, size))
+		if (copy_to_user(fr_s, &hdlc->state.fr.settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_PROTO_FR:
@@ -801,11 +797,7 @@ int hdlc_fr_ioctl(hdlc_device *hdlc, str
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (ifr->ifr_settings.data_length != size)
-			return -ENOMEM;	/* incorrect data length */
-
-		if (copy_from_user(&hdlc->state.fr.settings,
-				   ifr->ifr_settings.data, size))
+		if (copy_from_user(&hdlc->state.fr.settings, fr_s, size))
 			return -EFAULT;
 
 		/* FIXME - put sanity checks here */
@@ -839,7 +831,7 @@ int hdlc_fr_ioctl(hdlc_device *hdlc, str
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(&pvc, ifr->ifr_settings.data,
+		if (copy_from_user(&pvc, &ifr->ifr_settings.ifs_hdlc.hdlcs_pvc,
 				   sizeof(fr_proto_pvc)))
 			return -EFAULT;
 
diff -burpN linux-2.5.3-kh/drivers/net/wan/hdlc_generic.c linux-2.5.3/drivers/net/wan/hdlc_generic.c
--- linux-2.5.3-kh/drivers/net/wan/hdlc_generic.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/hdlc_generic.c	Sun Feb  3 21:53:04 2002
@@ -38,7 +37,7 @@
 #include <linux/hdlc.h>
 
 
-static const char* version = "HDLC support module revision 1.08";
+static const char version[] = "HDLC support module revision 1.08";
 
 
 static int hdlc_change_mtu(struct net_device *dev, int new_mtu)
@@ -72,7 +71,7 @@ int hdlc_ioctl(struct net_device *dev, s
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	unsigned int proto;
 
-	if (cmd != SIOCDEVICE)
+	if (cmd != SIOCWANDEV)
 		return -EINVAL;
 
 	switch(ifr->ifr_settings.type) {
@@ -102,6 +101,7 @@ int hdlc_ioctl(struct net_device *dev, s
 	case IF_PROTO_FR:	return hdlc_fr_ioctl(hdlc, ifr);
 #endif
 #ifdef CONFIG_HDLC_X25
+
 	case IF_PROTO_X25:	return hdlc_x25_ioctl(hdlc, ifr);
 #endif
 	default:		return -ENOSYS;
diff -burpN linux-2.5.3-kh/drivers/net/wan/hdlc_ppp.c linux-2.5.3/drivers/net/wan/hdlc_ppp.c
--- linux-2.5.3-kh/drivers/net/wan/hdlc_ppp.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/hdlc_ppp.c	Sun Feb  3 16:52:30 2002
@@ -25,6 +25,7 @@
 #include <linux/lapb.h>
 #include <linux/rtnetlink.h>
 #include <linux/hdlc.h>
+#include <linux/hdlc/ioctl.h>
 
 
 static int ppp_open(hdlc_device *hdlc)
@@ -85,7 +86,6 @@ int hdlc_ppp_ioctl(hdlc_device *hdlc, st
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
 		ifr->ifr_settings.type = IF_PROTO_PPP;
-		ifr->ifr_settings.data_length = 0;
 		return 0; /* return protocol only, no settable parameters */
 
 	case IF_PROTO_PPP:
@@ -95,8 +95,7 @@ int hdlc_ppp_ioctl(hdlc_device *hdlc, st
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (ifr->ifr_settings.data_length != 0)
-			return -EINVAL;	/* no settable parameters */
+		/* no settable parameters */
 
 		hdlc_detach(hdlc);
 
diff -burpN linux-2.5.3-kh/drivers/net/wan/hdlc_raw.c linux-2.5.3/drivers/net/wan/hdlc_raw.c
--- linux-2.5.3-kh/drivers/net/wan/hdlc_raw.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/hdlc_raw.c	Sun Feb  3 22:03:11 2002
@@ -25,6 +25,7 @@
 #include <linux/lapb.h>
 #include <linux/rtnetlink.h>
 #include <linux/hdlc.h>
+#include <linux/hdlc/ioctl.h>
 
 
 static void raw_rx(struct sk_buff *skb)
@@ -37,21 +38,16 @@ static void raw_rx(struct sk_buff *skb)
 
 int hdlc_raw_ioctl(hdlc_device *hdlc, struct ifreq *ifr)
 {
-	const size_t size = sizeof(hdlc_proto);
+	raw_proto *raw_s = &ifr->ifr_settings.ifs_hdlc.hdlcs_raw;
+	const size_t size = sizeof(raw_proto);
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
 		ifr->ifr_settings.type = IF_PROTO_HDLC;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return protocol only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
-				 &hdlc->state.hdlc.settings, size))
+		if (copy_to_user(raw_s, &hdlc->state.raw.settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_PROTO_HDLC:
@@ -61,18 +57,15 @@ int hdlc_raw_ioctl(hdlc_device *hdlc, st
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (ifr->ifr_settings.data_length != size)
-			return -ENOMEM;	/* incorrect data length */
-
-		if (copy_from_user(&hdlc->state.hdlc.settings,
-				   ifr->ifr_settings.data, size))
+		if (copy_from_user(&hdlc->state.raw.settings, raw_s, size))
 			return -EFAULT;
 
+
 		/* FIXME - put sanity checks here */
 		hdlc_detach(hdlc);
 
-		result=hdlc->attach(hdlc, hdlc->state.hdlc.settings.encoding,
-				    hdlc->state.hdlc.settings.parity);
+		result=hdlc->attach(hdlc, hdlc->state.raw.settings.encoding,
+				    hdlc->state.raw.settings.parity);
 		if (result) {
 			hdlc->proto = -1;
 			return result;
diff -burpN linux-2.5.3-kh/drivers/net/wan/hdlc_x25.c linux-2.5.3/drivers/net/wan/hdlc_x25.c
--- linux-2.5.3-kh/drivers/net/wan/hdlc_x25.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/hdlc_x25.c	Sun Feb  3 16:31:35 2002
@@ -25,6 +25,8 @@
 #include <linux/lapb.h>
 #include <linux/rtnetlink.h>
 #include <linux/hdlc.h>
+#include <linux/hdlc/ioctl.h>
+
 
 /* These functions are callbacks called by LAPB layer */
 
@@ -187,7 +189,6 @@ int hdlc_x25_ioctl(hdlc_device *hdlc, st
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
 		ifr->ifr_settings.type = IF_PROTO_X25;
-		ifr->ifr_settings.data_length = 0;
 		return 0; /* return protocol only, no settable parameters */
 
 	case IF_PROTO_X25:
@@ -196,9 +197,6 @@ int hdlc_x25_ioctl(hdlc_device *hdlc, st
 
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
-
-		if (ifr->ifr_settings.data_length != 0)
-			return -EINVAL;	/* no settable parameters */
 
 		hdlc_detach(hdlc);
 
diff -burpN linux-2.5.3-kh/drivers/net/wan/n2.c linux-2.5.3/drivers/net/wan/n2.c
--- linux-2.5.3-kh/drivers/net/wan/n2.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/n2.c	Sun Feb  3 22:05:04 2002
@@ -30,13 +30,14 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/netdevice.h>
+#include <linux/hdlc/ioctl.h>
 #include <linux/hdlc.h>
 #include <asm/io.h>
 #include "hd64570.h"
 
 
-static const char* version = "SDL RISCom/N2 driver version: 1.09";
-static const char* devname = "RISCom/N2";
+static const char version[] = "SDL RISCom/N2 driver version: 1.09";
+static const char devname[] = "RISCom/N2";
 
 #define USE_WINDOWSIZE 16384
 #define USE_BUS16BITS 1
@@ -250,9 +251,10 @@ static int n2_close(struct net_device *d
 
 static int n2_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
+	struct hdlc_settings *hdlc_s = &ifr->ifr_settings.ifs_hdlc;
+	const size_t size = sizeof(sync_serial_settings);
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	port_t *port = hdlc_to_port(hdlc);
-	const size_t size = sizeof(sync_serial_settings);
 
 #ifdef CONFIG_HDLC_DEBUG_RINGS
 	if (cmd == SIOCDEVPRIVATE) {
@@ -260,31 +262,21 @@ static int n2_ioctl(struct net_device *d
 		return 0;
 	}
 #endif
-	if (cmd != SIOCDEVICE)
+	if (cmd != SIOCWANDEV)
 		return hdlc_ioctl(dev, ifr, cmd);
 
 	switch(ifr->ifr_settings.type) {
 	case IF_GET_IFACE:
 		ifr->ifr_settings.type = IF_IFACE_SYNC_SERIAL;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return interface type only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
-				 &port->settings, size))
+		if (copy_to_user(&hdlc_s->hdlcs_sync, &port->settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_IFACE_SYNC_SERIAL:
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (ifr->ifr_settings.data_length != size)
-			return -ENOMEM;	/* incorrect data length */
-
-		if (copy_from_user(&port->settings,
-				   ifr->ifr_settings.data, size))
+		if (copy_from_user(&port->settings, &hdlc_s->hdlcs_sync, size))
 			return -EFAULT;
 		/* FIXME - put sanity checks here */
 		return n2_set_iface(port);
diff -burpN linux-2.5.3-kh/include/linux/hdlc/ioctl.h linux-2.5.3/include/linux/hdlc/ioctl.h
--- linux-2.5.3-kh/include/linux/hdlc/ioctl.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.3/include/linux/hdlc/ioctl.h	Sun Feb  3 21:46:11 2002
@@ -0,0 +1,61 @@
+#ifndef __HDLC_IOCTL_H__
+#define __HDLC_IOCTL_H__
+
+typedef struct { 
+	unsigned int clock_rate; /* bits per second */
+	unsigned int clock_type; /* internal, external, TX-internal etc. */
+	unsigned short loopback;
+} sync_serial_settings;          /* V.35, V.24, X.21 */
+
+typedef struct { 
+	unsigned int clock_rate; /* bits per second */
+	unsigned int clock_type; /* internal, external, TX-internal etc. */
+	unsigned short loopback;
+	unsigned int slot_map;
+} te1_settings;                  /* T1, E1 */
+
+typedef struct {
+	unsigned short encoding;
+	unsigned short parity;
+} raw_proto;
+
+typedef struct {
+	unsigned int t391;
+	unsigned int t392;
+	unsigned int n391;
+	unsigned int n392;
+	unsigned int n393;
+	unsigned short lmi;
+	unsigned short dce; /* 1 for DCE (network side) operation */
+} fr_proto;
+
+typedef struct {
+	unsigned int dlci;
+} fr_proto_pvc;          /* for creating/deleting FR PVCs */
+
+typedef struct {
+    unsigned int interval;
+    unsigned int timeout;
+} cisco_proto;
+
+/* PPP doesn't need any info now - supply length = 0 to ioctl */
+
+struct hdlc_settings {
+	union {
+		raw_proto		raw;
+		cisco_proto		cisco;
+		fr_proto		fr;
+		fr_proto_pvc		fr_pvc;
+		sync_serial_settings	sync;
+		te1_settings		te1;
+	} hdlcs_hdlcu;
+};
+
+#define hdlcs_raw	hdlcs_hdlcu.raw
+#define hdlcs_cisco	hdlcs_hdlcu.cisco
+#define hdlcs_fr	hdlcs_hdlcu.fr
+#define hdlcs_pvc	hdlcs_hdlcu.fr_pvc
+#define hdlcs_sync	hdlcs_hdlcu.sync
+#define hdlcs_te1	hdlcs_hdlcu.te1
+
+#endif /* __HDLC_IOCTL_H__ */
diff -burpN linux-2.5.3-kh/include/linux/hdlc.h linux-2.5.3/include/linux/hdlc.h
--- linux-2.5.3-kh/include/linux/hdlc.h	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/include/linux/hdlc.h	Sun Feb  3 21:56:35 2002
@@ -18,20 +18,6 @@
 #define CLOCK_TXINT	3	/* Internal TX and external RX clock */
 #define CLOCK_TXFROMRX	4	/* TX clock derived from external RX clock */
 
-typedef struct {
-	unsigned int clock_rate; /* bits per second */
-	unsigned int clock_type; /* internal, external, TX-internal etc. */
-	unsigned short loopback;
-}sync_serial_settings;		/* V.35, V.24, X.21 */
-
-typedef struct {
-	unsigned int clock_rate; /* bits per second */
-	unsigned int clock_type; /* internal, external, TX-internal etc. */
-	unsigned short loopback;
-	unsigned int slot_map;
-}te1_settings;			/* T1, E1 */
-
-
 
 #define ENCODING_DEFAULT	0 /* Default (current) setting */
 #define ENCODING_NRZ		1
@@ -50,47 +36,19 @@ typedef struct {
 #define PARITY_CRC32_PR0_CCITT	6 /* CRC32, initial value 0x00000000 */
 #define PARITY_CRC32_PR1_CCITT	7 /* CRC32, initial value 0xFFFFFFFF */
 
-typedef struct {
-	unsigned short encoding;
-	unsigned short parity;
-}hdlc_proto;
-
-
 #define LMI_DEFAULT		0 /* Default (current) setting */
 #define LMI_NONE		1 /* No LMI, all PVCs are static */
 #define LMI_ANSI		2 /* ANSI Annex D */
 #define LMI_CCITT		3 /* ITU-T Annex A */
 
-typedef struct {
-	unsigned int t391;
-	unsigned int t392;
-	unsigned int n391;
-	unsigned int n392;
-	unsigned int n393;
-	unsigned short lmi;
-	unsigned short dce;	/* 1 for DCE (network side) operation */
-}fr_proto;
-
-typedef struct {
-	unsigned int dlci;
-}fr_proto_pvc;			/* for creating/deleting FR PVCs */
-
-
-typedef struct {
-	unsigned int interval;
-	unsigned int timeout;
-}cisco_proto;
-
-
-/* PPP doesn't need any info now - supply length = 0 to ioctl */
-
-
 #ifdef __KERNEL__
 
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/hdlc/ioctl.h>
 #include <net/syncppp.h>
 
+
 #define HDLC_MAX_MTU 1500	/* Ethernet 1500 bytes */
 #define HDLC_MAX_MRU (HDLC_MAX_MTU + 10) /* max 10 bytes for FR */
 
@@ -251,8 +209,8 @@ typedef struct hdlc_device_struct {
 		}cisco;
 
 		struct {
-			hdlc_proto settings;
-		}hdlc;
+			raw_proto settings;
+		}raw;
 
 		struct {
 			struct ppp_device pppdev;
diff -burpN linux-2.5.3-kh/include/linux/if.h linux-2.5.3/include/linux/if.h
--- linux-2.5.3-kh/include/linux/if.h	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/include/linux/if.h	Sun Feb  3 21:56:31 2002
@@ -21,6 +21,7 @@
 
 #include <linux/types.h>		/* for "__kernel_caddr_t" et al	*/
 #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
+#include <linux/hdlc/ioctl.h>
 
 /* Standard interface flags (netdevice->flags). */
 #define	IFF_UP		0x1		/* interface is up		*/
@@ -95,10 +96,13 @@ struct ifmap 
 struct if_settings
 {
 	unsigned int type;	/* Type of physical device or protocol */
-	unsigned int data_length; /* device/protocol data length */
-	void * data;		/* pointer to data, ignored if length = 0 */
+	union {
+		/* {atm/eth/dsl}_settings anyone ? */
+		struct hdlc_settings ifsu_hdlc;
+	} ifs_ifsu;
 };
 
+#define ifs_hdlc	ifs_ifsu.ifsu_hdlc
 
 /*
  * Interface request structure used for socket
diff -burpN linux-2.5.3-kh/include/linux/sockios.h linux-2.5.3/include/linux/sockios.h
--- linux-2.5.3-kh/include/linux/sockios.h	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/include/linux/sockios.h	Sun Feb  3 21:51:00 2002
@@ -81,7 +81,7 @@
 #define SIOCGMIIREG	0x8948		/* Read MII PHY register.	*/
 #define SIOCSMIIREG	0x8949		/* Write MII PHY register.	*/
 
-#define SIOCDEVICE	0x894A		/* get/set netdev parameters	*/
+#define SIOCWANDEV	0x894A		/* get/set netdev parameters	*/
 
 /* ARP cache control calls. */
 		    /*  0x8950 - 0x8952  * obsolete calls, don't re-use */
diff -burpN linux-2.5.3-kh/net/core/dev.c linux-2.5.3/net/core/dev.c
--- linux-2.5.3-kh/net/core/dev.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/net/core/dev.c	Sun Feb  3 21:51:21 2002
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

<URL:http://www.cogenit.fr/dscc4/hdlc-S3> contains the patch against 2.5.3.
Good night.

-- 
Ueimor
