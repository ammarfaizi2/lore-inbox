Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293274AbSBQSg2>; Sun, 17 Feb 2002 13:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293269AbSBQSfw>; Sun, 17 Feb 2002 13:35:52 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:29138 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S293265AbSBQSfj>;
	Sun, 17 Feb 2002 13:35:39 -0500
Date: Sun, 17 Feb 2002 19:31:31 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: khc@pm.waw.pl, davem@redhat.com, torvalds@transmeta.com,
        jgarzik@mandrakesoft.com
Subject: [PATCH] HDLC patch for 2.5.5 (3/3)
Message-ID: <20020217193131.E14629@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[3/3]:
- some devices are converted (c101.c/dscc4.c/farsync.c/n2.c).


diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/c101.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/c101.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/c101.c	Sun Feb 17 17:44:14 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/c101.c	Sun Feb 17 17:49:26 2002
@@ -179,9 +179,10 @@ static int c101_close(struct net_device 
 
 static int c101_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
+	struct hdlc_settings *hdlc_s = &ifr->ifr_settings->ifs_hdlc;
+	const size_t size = sizeof(sync_serial_settings);
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	port_t *port = hdlc_to_port(hdlc);
-	const size_t size = sizeof(sync_serial_settings);
 
 #ifdef CONFIG_HDLC_DEBUG_RINGS
 	if (cmd == SIOCDEVPRIVATE) {
@@ -192,28 +193,18 @@ static int c101_ioctl(struct net_device 
 	if (cmd != SIOCWANDEV)
 		return hdlc_ioctl(dev, ifr, cmd);
 
-	switch(ifr->ifr_settings.type) {
+	switch(ifr->ifr_settings->type) {
 	case IF_GET_IFACE:
-		ifr->ifr_settings.type = IF_IFACE_SYNC_SERIAL;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return interface type only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
-				 &port->settings, size))
+		ifr->ifr_settings->type = IF_IFACE_SYNC_SERIAL;
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
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/dscc4.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/dscc4.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/dscc4.c	Sun Feb 17 17:44:14 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/dscc4.c	Sun Feb 17 17:49:26 2002
@@ -1065,8 +1065,8 @@ static int dscc4_set_clock(struct net_de
 
 static int dscc4_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
+	struct hdlc_settings *hdlc_s = &ifr->ifr_settings->ifs_hdlc;
 	struct dscc4_dev_priv *dpriv = dscc4_priv(dev);
-	struct if_settings *if_s = &ifr->ifr_settings;
 	const size_t size = sizeof(dpriv->settings);
 	int ret = 0;
 
@@ -1076,26 +1076,18 @@ static int dscc4_ioctl(struct net_device
 	if (cmd != SIOCWANDEV)
 		return -EOPNOTSUPP;
 
-	switch(ifr->ifr_settings.type) {
+	switch(ifr->ifr_settings->type) {
 	case IF_GET_IFACE:
-		if_s->type = IF_IFACE_SYNC_SERIAL;
-		if (if_s->data_length == 0)
-			return 0;
-		if (if_s->data_length < size)
-			return -ENOMEM;
-		if (copy_to_user(if_s->data, &dpriv->settings, size))
+		ifr->ifr_settings->type = IF_IFACE_SYNC_SERIAL;
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
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/farsync.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/farsync.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/farsync.c	Sun Feb 17 17:44:14 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/farsync.c	Sun Feb 17 17:49:26 2002
@@ -1013,25 +1013,19 @@ static int
 fst_set_iface ( struct fst_card_info *card, struct fst_port_info *port,
                 struct ifreq *ifr )
 {
+	struct hdlc_settings *hdlc_s = &ifr->ifr_settings->ifs_hdlc;
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
 
         i = port->index;
 
-        switch ( ifr->ifr_settings.type )
+        switch ( ifr->ifr_settings->type )
         {
         case IF_IFACE_V35:
                 FST_WRW ( card, portConfig[i].lineInterface, V35 );
@@ -1076,6 +1070,7 @@ static int
 fst_get_iface ( struct fst_card_info *card, struct fst_port_info *port,
                 struct ifreq *ifr )
 {
+	struct hdlc_settings *hdlc_s = &ifr->ifr_settings->ifs_hdlc;
         sync_serial_settings sync;
         int i;
 
@@ -1086,25 +1081,16 @@ fst_get_iface ( struct fst_card_info *ca
         switch ( port->hwif )
         {
         case V35:
-                ifr->ifr_settings.type = IF_IFACE_V35;
+                ifr->ifr_settings->type = IF_IFACE_V35;
                 break;
         case V24:
-                ifr->ifr_settings.type = IF_IFACE_V24;
+                ifr->ifr_settings->type = IF_IFACE_V24;
                 break;
         case X21:
         default:
-                ifr->ifr_settings.type = IF_IFACE_X21;
+                ifr->ifr_settings->type = IF_IFACE_X21;
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
@@ -1112,12 +1098,9 @@ fst_get_iface ( struct fst_card_info *ca
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
 
@@ -1241,7 +1224,7 @@ fst_ioctl ( struct net_device *dev, stru
                 return set_conf_from_info ( card, port, &info );
 
         case SIOCWANDEV:
-                switch ( ifr->ifr_settings.type )
+                switch ( ifr->ifr_settings->type )
                 {
                 case IF_GET_IFACE:
                         return fst_get_iface ( card, port, ifr );
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/n2.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/n2.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/n2.c	Sun Feb 17 17:44:14 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/n2.c	Sun Feb 17 17:49:26 2002
@@ -250,9 +250,10 @@ static int n2_close(struct net_device *d
 
 static int n2_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
+	struct hdlc_settings *hdlc_s = &ifr->ifr_settings->ifs_hdlc;
+	const size_t size = sizeof(sync_serial_settings);
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	port_t *port = hdlc_to_port(hdlc);
-	const size_t size = sizeof(sync_serial_settings);
 
 #ifdef CONFIG_HDLC_DEBUG_RINGS
 	if (cmd == SIOCDEVPRIVATE) {
@@ -263,28 +264,18 @@ static int n2_ioctl(struct net_device *d
 	if (cmd != SIOCWANDEV)
 		return hdlc_ioctl(dev, ifr, cmd);
 
-	switch(ifr->ifr_settings.type) {
+	switch(ifr->ifr_settings->type) {
 	case IF_GET_IFACE:
-		ifr->ifr_settings.type = IF_IFACE_SYNC_SERIAL;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return interface type only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
-				 &port->settings, size))
+		ifr->ifr_settings->type = IF_IFACE_SYNC_SERIAL;
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
