Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287436AbSBCROC>; Sun, 3 Feb 2002 12:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287432AbSBCRNy>; Sun, 3 Feb 2002 12:13:54 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:20898 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S287436AbSBCRNk>;
	Sun, 3 Feb 2002 12:13:40 -0500
Date: Sun, 3 Feb 2002 18:13:02 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        davem@redhat.com
Subject: Re: [PATCH] Generic HDLC patch for 2.5.3
Message-ID: <20020203181302.C12963@fafner.intra.cogenit.fr>
In-Reply-To: <20020202190242.C1740@havoc.gtf.org> <E16XAnc-00010K-00@the-village.bc.nu> <20020202200332.A3740@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020202200332.A3740@havoc.gtf.org>; from garzik@havoc.gtf.org on Sat, Feb 02, 2002 at 08:03:32PM -0500
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <garzik@havoc.gtf.org> :
[...]
> Ok...   SIOC[GS]WANDEVICE or somesuch?
> It could be made more portable and still say generic, IMHO.

Try #1 on top of Krzysztof's patch:

diff -burpN linux-2.5.3-kh/drivers/net/wan/hdlc_cisco.c linux-2.5.3/drivers/net/wan/hdlc_cisco.c
--- linux-2.5.3-kh/drivers/net/wan/hdlc_cisco.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/hdlc_cisco.c	Sun Feb  3 16:31:05 2002
@@ -25,6 +25,7 @@
 #include <linux/lapb.h>
 #include <linux/rtnetlink.h>
 #include <linux/hdlc.h>
+#include <linux/hdlc/ioctl.h>
 
 
 #define CISCO_MULTICAST		0x8F	/* Cisco multicast address */
@@ -254,14 +255,9 @@ int hdlc_cisco_ioctl(hdlc_device *hdlc, 
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
 		ifr->ifr_settings.type = IF_PROTO_CISCO;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return protocol only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
+		if (copy_to_user(&ifr->ifr_settings.ifs_hdlc.hdlcs_cisco,
 				 &hdlc->state.cisco.settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_PROTO_CISCO:
@@ -271,11 +267,8 @@ int hdlc_cisco_ioctl(hdlc_device *hdlc, 
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (ifr->ifr_settings.data_length != size)
-			return -ENOMEM;	/* incorrect data length */
-			
 		if (copy_from_user(&hdlc->state.cisco.settings,
-				   ifr->ifr_settings.data, size))
+				   &ifr->ifr_settings.ifs_hdlc.hdlcs_cisco, size))
 			return -EFAULT;
 
 		/* FIXME - put sanity checks here */
diff -burpN linux-2.5.3-kh/drivers/net/wan/hdlc_fr.c linux-2.5.3/drivers/net/wan/hdlc_fr.c
--- linux-2.5.3-kh/drivers/net/wan/hdlc_fr.c	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/drivers/net/wan/hdlc_fr.c	Sun Feb  3 17:18:15 2002
@@ -25,6 +25,7 @@
 #include <linux/lapb.h>
 #include <linux/rtnetlink.h>
 #include <linux/hdlc.h>
+#include <linux/hdlc/ioctl.h>
 
 
 __inline__ pvc_device* find_pvc(hdlc_device *hdlc, u16 dlci)
@@ -784,14 +785,9 @@ int hdlc_fr_ioctl(hdlc_device *hdlc, str
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
 		ifr->ifr_settings.type = IF_PROTO_FR;
-		if (ifr->ifr_settings.data_length == 0)
-			return 0; /* return protocol only */
-		if (ifr->ifr_settings.data_length < size)
-			return -ENOMEM;	/* buffer too small */
-		if (copy_to_user(ifr->ifr_settings.data,
+		if (copy_to_user(&ifr->ifr_settings.ifs_hdlc.hdlcs_fr,
 				 &hdlc->state.fr.settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_PROTO_FR:
@@ -801,11 +797,8 @@ int hdlc_fr_ioctl(hdlc_device *hdlc, str
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (ifr->ifr_settings.data_length != size)
-			return -ENOMEM;	/* incorrect data length */
-
 		if (copy_from_user(&hdlc->state.fr.settings,
-				   ifr->ifr_settings.data, size))
+				   &ifr->ifr_settings.ifs_hdlc.hdlcs_fr, size))
 			return -EFAULT;
 
 		/* FIXME - put sanity checks here */
@@ -839,7 +832,8 @@ int hdlc_fr_ioctl(hdlc_device *hdlc, str
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(&pvc, ifr->ifr_settings.data,
+		if (copy_from_user(&pvc, 
+				   &ifr->ifr_settings.ifs_hdlc.hdlcs_pvc,
 				   sizeof(fr_proto_pvc)))
 			return -EFAULT;
 
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
+++ linux-2.5.3/drivers/net/wan/hdlc_raw.c	Sun Feb  3 17:20:12 2002
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
+		if (copy_to_user(&ifr->ifr_settings.ifs_hdlc.hdlcs_raw,
+				 &hdlc->state.raw.settings, size))
 			return -EFAULT;
-		ifr->ifr_settings.data_length = size;
 		return 0;
 
 	case IF_PROTO_HDLC:
@@ -61,18 +57,16 @@ int hdlc_raw_ioctl(hdlc_device *hdlc, st
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (ifr->ifr_settings.data_length != size)
-			return -ENOMEM;	/* incorrect data length */
-
-		if (copy_from_user(&hdlc->state.hdlc.settings,
-				   ifr->ifr_settings.data, size))
+		if (copy_from_user(&hdlc->state.raw.settings,
+				   &ifr->ifr_settings.ifs_hdlc.hdlcs_raw, size))
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
 
diff -burpN linux-2.5.3-kh/include/linux/hdlc/ioctl.h linux-2.5.3/include/linux/hdlc/ioctl.h
--- linux-2.5.3-kh/include/linux/hdlc/ioctl.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.3/include/linux/hdlc/ioctl.h	Sun Feb  3 16:51:31 2002
@@ -0,0 +1,44 @@
+#ifndef __HDLC_IOCTL_H__
+#define __HDLC_IOCTL_H__
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
+		raw_proto	raw;
+		cisco_proto	cisco;
+		fr_proto	fr;
+		fr_proto_pvc	fr_pvc;
+	} hdlcs_hdlcu;
+};
+
+#define hdlcs_raw	hdlcs_hdlcu.raw
+#define hdlcs_cisco	hdlcs_hdlcu.cisco
+#define hdlcs_fr	hdlcs_hdlcu.fr
+#define hdlcs_pvc	hdlcs_hdlcu.fr_pvc
+
+#endif /* __HDLC_IOCTL_H__ */
diff -burpN linux-2.5.3-kh/include/linux/hdlc.h linux-2.5.3/include/linux/hdlc.h
--- linux-2.5.3-kh/include/linux/hdlc.h	Sun Feb  3 18:03:26 2002
+++ linux-2.5.3/include/linux/hdlc.h	Sun Feb  3 17:35:45 2002
@@ -50,47 +50,19 @@ typedef struct {
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
 
@@ -251,8 +223,8 @@ typedef struct hdlc_device_struct {
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
+++ linux-2.5.3/include/linux/if.h	Sun Feb  3 17:15:13 2002
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

Then turn SIOCDEVICE into whatever seems appropriate.

See <URL:http://www.cogenit.fr/dscc4/hdlc-S2> for a modified version of
Krzysztof's patch (172ko).

-- 
Ueimor
