Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293264AbSBQSfi>; Sun, 17 Feb 2002 13:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293267AbSBQSf2>; Sun, 17 Feb 2002 13:35:28 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:26578 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S293264AbSBQSfQ>;
	Sun, 17 Feb 2002 13:35:16 -0500
Date: Sun, 17 Feb 2002 19:31:10 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: khc@pm.waw.pl, davem@redhat.com, torvalds@transmeta.com,
        jgarzik@mandrakesoft.com
Subject: [PATCH] HDLC patch for 2.5.5 (2/3)
Message-ID: <20020217193110.D14629@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[2/3]:
- conversion of drivers/net/wan/hdlc_xxx.c files.


diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_cisco.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_cisco.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_cisco.c	Sun Feb 17 17:39:21 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_cisco.c	Sun Feb 17 17:46:49 2002
@@ -247,21 +247,16 @@ static void cisco_close(hdlc_device *hdl
 
 int hdlc_cisco_ioctl(hdlc_device *hdlc, struct ifreq *ifr)
 {
+	cisco_proto *cisco_s = &ifr->ifr_settings->ifs_hdlc.hdlcs_cisco;
 	const size_t size = sizeof(cisco_proto);
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
-	switch (ifr->ifr_settings.type) {
+	switch (ifr->ifr_settings->type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings.type = IF_PROTO_CISCO;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return protocol only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
-				 &hdlc->state.cisco.settings, size))
+		ifr->ifr_settings->type = IF_PROTO_CISCO;
+		if (copy_to_user(cisco_s, &hdlc->state.cisco.settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_PROTO_CISCO:
@@ -271,11 +266,7 @@ int hdlc_cisco_ioctl(hdlc_device *hdlc, 
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
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_fr.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_fr.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_fr.c	Sun Feb 17 17:39:21 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_fr.c	Sun Feb 17 17:46:49 2002
@@ -776,22 +776,17 @@ static void fr_destroy(hdlc_device *hdlc
 
 int hdlc_fr_ioctl(hdlc_device *hdlc, struct ifreq *ifr)
 {
+	fr_proto *fr_s = &ifr->ifr_settings->ifs_hdlc.hdlcs_fr;
 	const size_t size = sizeof(fr_proto);
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	fr_proto_pvc pvc;
 	int result;
 
-	switch (ifr->ifr_settings.type) {
+	switch (ifr->ifr_settings->type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings.type = IF_PROTO_FR;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return protocol only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
-				 &hdlc->state.fr.settings, size))
+		ifr->ifr_settings->type = IF_PROTO_FR;
+		if (copy_to_user(fr_s, &hdlc->state.fr.settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_PROTO_FR:
@@ -801,11 +796,7 @@ int hdlc_fr_ioctl(hdlc_device *hdlc, str
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
@@ -839,12 +830,12 @@ int hdlc_fr_ioctl(hdlc_device *hdlc, str
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(&pvc, ifr->ifr_settings.data,
+		if (copy_from_user(&pvc, &ifr->ifr_settings->ifs_hdlc.hdlcs_pvc,
 				   sizeof(fr_proto_pvc)))
 			return -EFAULT;
 
 		return fr_pvc(hdlc, pvc.dlci,
-			      ifr->ifr_settings.type == IF_PROTO_FR_ADD_PVC);
+			      ifr->ifr_settings->type == IF_PROTO_FR_ADD_PVC);
 	}
 
 	return -EINVAL;
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_generic.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_generic.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_generic.c	Sun Feb 17 17:44:14 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_generic.c	Sun Feb 17 17:46:49 2002
@@ -75,13 +75,13 @@ int hdlc_ioctl(struct net_device *dev, s
 	if (cmd != SIOCWANDEV)
 		return -EINVAL;
 
-	switch(ifr->ifr_settings.type) {
+	switch(ifr->ifr_settings->type) {
 	case IF_PROTO_HDLC:
 	case IF_PROTO_PPP:
 	case IF_PROTO_CISCO:
 	case IF_PROTO_FR:
 	case IF_PROTO_X25:
-		proto = ifr->ifr_settings.type;
+		proto = ifr->ifr_settings->type;
 		break;
 
 	default:
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_ppp.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_ppp.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_ppp.c	Sun Feb 17 17:39:21 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_ppp.c	Sun Feb 17 17:46:49 2002
@@ -82,10 +82,9 @@ int hdlc_ppp_ioctl(hdlc_device *hdlc, st
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
-	switch (ifr->ifr_settings.type) {
+	switch (ifr->ifr_settings->type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings.type = IF_PROTO_PPP;
-		ifr->ifr_settings.data_length = 0;
+		ifr->ifr_settings->type = IF_PROTO_PPP;
 		return 0; /* return protocol only, no settable parameters */
 
 	case IF_PROTO_PPP:
@@ -95,8 +94,7 @@ int hdlc_ppp_ioctl(hdlc_device *hdlc, st
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (ifr->ifr_settings.data_length != 0)
-			return -EINVAL;	/* no settable parameters */
+		/* no settable parameters */
 
 		hdlc_detach(hdlc);
 
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_raw.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_raw.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_raw.c	Sun Feb 17 17:44:14 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_raw.c	Sun Feb 17 17:46:49 2002
@@ -37,21 +37,15 @@ static void raw_rx(struct sk_buff *skb)
 
 int hdlc_raw_ioctl(hdlc_device *hdlc, struct ifreq *ifr)
 {
-	const size_t size = sizeof(hdlc_proto);
+	raw_hdlc_proto *raw_s = &ifr->ifr_settings->ifs_hdlc.hdlcs_raw;
+	const size_t size = sizeof(raw_hdlc_proto);
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
-	switch (ifr->ifr_settings.type) {
+	switch (ifr->ifr_settings->type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings.type = IF_PROTO_HDLC;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return protocol only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
-				 &hdlc->state.raw_hdlc.settings, size))
+		if (copy_to_user(raw_s, &hdlc->state.raw_hdlc.settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_PROTO_HDLC:
@@ -61,12 +55,9 @@ int hdlc_raw_ioctl(hdlc_device *hdlc, st
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (ifr->ifr_settings.data_length != size)
-			return -ENOMEM;	/* incorrect data length */
-
-		if (copy_from_user(&hdlc->state.raw_hdlc.settings,
-				   ifr->ifr_settings.data, size))
+		if (copy_from_user(&hdlc->state.raw_hdlc.settings, raw_s, size))
 			return -EFAULT;
+
 
 		/* FIXME - put sanity checks here */
 		hdlc_detach(hdlc);
diff -burpN linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_x25.c linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_x25.c
--- linux-2.5.5-pre1-kh/drivers/net/wan/hdlc_x25.c	Sun Feb 17 17:39:21 2002
+++ linux-2.5.5-pre1-ma_pomme/drivers/net/wan/hdlc_x25.c	Sun Feb 17 17:46:49 2002
@@ -184,10 +184,9 @@ int hdlc_x25_ioctl(hdlc_device *hdlc, st
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
-	switch (ifr->ifr_settings.type) {
+	switch (ifr->ifr_settings->type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings.type = IF_PROTO_X25;
-		ifr->ifr_settings.data_length = 0;
+		ifr->ifr_settings->type = IF_PROTO_X25;
 		return 0; /* return protocol only, no settable parameters */
 
 	case IF_PROTO_X25:
@@ -196,9 +195,6 @@ int hdlc_x25_ioctl(hdlc_device *hdlc, st
 
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
-
-		if (ifr->ifr_settings.data_length != 0)
-			return -EINVAL;	/* no settable parameters */
 
 		hdlc_detach(hdlc);
 
