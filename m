Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264947AbSJWMt0>; Wed, 23 Oct 2002 08:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264958AbSJWMt0>; Wed, 23 Oct 2002 08:49:26 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:49296 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S264947AbSJWMtY>;
	Wed, 23 Oct 2002 08:49:24 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.5.44-ac1
References: <Pine.NEB.4.44.0210222147230.1359-100000@mimas.fachschaften.tu-muenchen.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 23 Oct 2002 14:53:41 +0200
In-Reply-To: <Pine.NEB.4.44.0210222147230.1359-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <m3bs5lb9ka.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Adrian Bunk <bunk@fs.tum.de> writes:

> > o	Clean up wan ioctl structures			(Krzysztof Halasa)
> This caused the following compile error:

Ooops... Looks like my make-patch script needs an upgrade.

> --- linux-2.5.44-full-ac/drivers/net/wan/hdlc_x25.c.old	2002-10-22 21:38:32.000000000 +0200
> +++ linux-2.5.44-full-ac/drivers/net/wan/hdlc_x25.c	2002-10-22 21:38:51.000000000 +0200
> @@ -184,9 +184,9 @@
>  	struct net_device *dev = hdlc_to_dev(hdlc);
>  	int result;
> 
> -	switch (ifr->ifr_settings->type) {
> +	switch (ifr->ifr_settings.type) {
>  	case IF_GET_PROTO:
> -		ifr->ifr_settings->type = IF_PROTO_X25;
> +		ifr->ifr_settings.type = IF_PROTO_X25;
>  		return 0; /* return protocol only, no settable parameters */
> 
>  	case IF_PROTO_X25:

Exactly.

The missing part of the patch is attached below.
-- 
Krzysztof Halasa
Network Administrator
If you've sent me email recently and it remains unanswered, please try once
again. HDD crash might have eaten it :-(

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=hdlc-2.5.43-part2.patch

--- linux-2.5.orig/drivers/net/wan/hdlc_x25.c	2002-10-01 09:07:50.000000000 +0200
+++ linux-2.5/drivers/net/wan/hdlc_x25.c	2002-10-19 01:07:57.000000000 +0200
@@ -184,9 +184,9 @@
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
-	switch (ifr->ifr_settings->type) {
+	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings->type = IF_PROTO_X25;
+		ifr->ifr_settings.type = IF_PROTO_X25;
 		return 0; /* return protocol only, no settable parameters */
 
 	case IF_PROTO_X25:
--- linux-2.5.orig/drivers/net/wan/pc300_drv.c	2002-10-01 09:07:40.000000000 +0200
+++ linux-2.5/drivers/net/wan/pc300_drv.c	2002-10-19 01:10:16.000000000 +0200
@@ -2542,7 +2542,7 @@
 	pc300chconf_t *conf = (pc300chconf_t *) & chan->conf;
 	int ch = chan->channel;
 	void *arg = (void *) ifr->ifr_data;
-	union line_settings * line = &ifr->ifr_settings->ifs_line;
+	struct if_settings *settings = &ifr->ifr_settings;
 	uclong scabase = card->hw.scabase;
 
 	if (!capable(CAP_NET_ADMIN))
@@ -2741,13 +2741,19 @@
 			}
 
 		case SIOCWANDEV:
-			switch (ifr->ifr_settings->type) {
+			switch (ifr->ifr_settings.type) {
 				case IF_GET_IFACE:
 				{
 					const size_t size = sizeof(sync_serial_settings);
-					ifr->ifr_settings->type = conf->media;
+					ifr->ifr_settings.type = conf->media;
+					if (ifr->ifr_settings.size < size) {
+						/* data size wanted */
+						ifr->ifr_settings.size = size;
+						return -ENOBUFS;
+					}
 	
-					if (copy_to_user(&line->sync, &conf->phys_settings, size)) {
+					if (copy_to_user(settings->ifs_ifsu.sync,
+							 &conf->phys_settings, size)) {
 						return -EFAULT;
 					}
 					return 0;
@@ -2764,7 +2770,7 @@
 					}
 
 					if (copy_from_user(&conf->phys_settings, 
-									   &line->sync, size)) {
+							   settings->ifs_ifsu.sync, size)) {
 						return -EFAULT;
 					}
 
@@ -2773,7 +2779,7 @@
 							cpc_readb(card->hw.scabase + M_REG(MD2, ch)) | 
 							MD2_LOOP_MIR);
 					}
-					conf->media = ifr->ifr_settings->type;
+					conf->media = ifr->ifr_settings.type;
 					return 0;
 				}
 
@@ -2787,7 +2793,7 @@
 					}
 					
 					if (copy_from_user(&conf->phys_settings, 
-						&line->te1, size)) {
+							   settings->ifs_ifsu.te1, size)) {
 						return -EFAULT;
 					}/* Ignoring HDLC slot_map for a while */
 					
@@ -2796,7 +2802,7 @@
 							cpc_readb(card->hw.scabase + M_REG(MD2, ch)) | 
 							MD2_LOOP_MIR);
 					}
-					conf->media = ifr->ifr_settings->type;
+					conf->media = ifr->ifr_settings.type;
 					return 0;
 				}
 				default:

--=-=-=--
