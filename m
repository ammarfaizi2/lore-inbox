Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277783AbRJLRMc>; Fri, 12 Oct 2001 13:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277781AbRJLRMX>; Fri, 12 Oct 2001 13:12:23 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:32508 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277788AbRJLRMJ>;
	Fri, 12 Oct 2001 13:12:09 -0400
Date: Fri, 12 Oct 2001 10:12:39 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch] Wireless Extension update - part II [second try]
Message-ID: <20011012101239.C20167@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi Linus,

        Followup to my previous Wireless Extension patch. This update
the various wireless LAN drivers that I maintain or that are
unmaintained to the latest Wireless Extensions definitions.
	The main change is the use of the new private ioctl range (cf
previous e-mail).
        Drivers updated :
        o Old Wavelan ISA
        o Old Wavelan Pcmcia
        o Netwave
        o Raylink

        I would also appreciate if this patch could be included after
the first one in your kernel.

        Thanks...

        Jean

diff -u -p linux/drivers/net/wavelan.w11.p.h linux/drivers/net/wavelan.p.h
--- linux/drivers/net/wavelan.w11.p.h	Tue Oct  9 00:32:52 2001
+++ linux/drivers/net/wavelan.p.h	Tue Oct  9 00:39:02 2001
@@ -447,13 +447,13 @@ static const char	*version	= "wavelan.c 
 
 /* ------------------------ PRIVATE IOCTL ------------------------ */
 
-#define SIOCSIPQTHR	SIOCDEVPRIVATE		/* Set quality threshold */
-#define SIOCGIPQTHR	SIOCDEVPRIVATE + 1	/* Get quality threshold */
-#define SIOCSIPLTHR	SIOCDEVPRIVATE + 2	/* Set level threshold */
-#define SIOCGIPLTHR	SIOCDEVPRIVATE + 3	/* Get level threshold */
+#define SIOCSIPQTHR	SIOCIWFIRSTPRIV		/* Set quality threshold */
+#define SIOCGIPQTHR	SIOCIWFIRSTPRIV + 1	/* Get quality threshold */
+#define SIOCSIPLTHR	SIOCIWFIRSTPRIV + 2	/* Set level threshold */
+#define SIOCGIPLTHR	SIOCIWFIRSTPRIV + 3	/* Get level threshold */
 
-#define SIOCSIPHISTO	SIOCDEVPRIVATE + 6	/* Set histogram ranges */
-#define SIOCGIPHISTO	SIOCDEVPRIVATE + 7	/* Get histogram values */
+#define SIOCSIPHISTO	SIOCIWFIRSTPRIV + 6	/* Set histogram ranges */
+#define SIOCGIPHISTO	SIOCIWFIRSTPRIV + 7	/* Get histogram values */
 
 /****************************** TYPES ******************************/
 
diff -u -p linux/drivers/net/wavelan.w11.c linux/drivers/net/wavelan.c
--- linux/drivers/net/wavelan.w11.c	Tue Oct  9 00:32:08 2001
+++ linux/drivers/net/wavelan.c	Tue Oct  9 00:38:50 2001
@@ -2059,6 +2059,10 @@ static int wavelan_ioctl(struct net_devi
 			range.max_qual.qual = MMR_SGNL_QUAL;
 			range.max_qual.level = MMR_SIGNAL_LVL;
 			range.max_qual.noise = MMR_SILENCE_LVL;
+			range.avg_qual.qual = MMR_SGNL_QUAL; /* Always max */
+			/* Need to get better values for those two */
+			range.avg_qual.level = 30;
+			range.avg_qual.noise = 8;
 
 			range.num_bitrates = 1;
 			range.bitrate[0] = 2000000;	/* 2 Mb/s */
diff -u -p linux/drivers/net/pcmcia/wavelan_cs.w11.h linux/drivers/net/pcmcia/wavelan_cs.h
--- linux/drivers/net/pcmcia/wavelan_cs.w11.h	Tue Oct  9 00:36:29 2001
+++ linux/drivers/net/pcmcia/wavelan_cs.h	Tue Oct  9 00:42:05 2001
@@ -465,13 +465,20 @@ static const char *version = "wavelan_cs
 
 /* ------------------------ PRIVATE IOCTL ------------------------ */
 
-#define SIOCSIPQTHR	SIOCDEVPRIVATE		/* Set quality threshold */
-#define SIOCGIPQTHR	SIOCDEVPRIVATE + 1	/* Get quality threshold */
-#define SIOCSIPROAM     SIOCDEVPRIVATE + 2      /* Set roaming state */
-#define SIOCGIPROAM     SIOCDEVPRIVATE + 3      /* Get roaming state */
+/* Wireless Extension Backward compatibility - Jean II
+ * If the new wireless device private ioctl range is not defined,
+ * default to standard device private ioctl range */
+#ifndef SIOCIWFIRSTPRIV
+#define SIOCIWFIRSTPRIV	SIOCDEVPRIVATE
+#endif /* SIOCIWFIRSTPRIV */
 
-#define SIOCSIPHISTO	SIOCDEVPRIVATE + 6	/* Set histogram ranges */
-#define SIOCGIPHISTO	SIOCDEVPRIVATE + 7	/* Get histogram values */
+#define SIOCSIPQTHR	SIOCIWFIRSTPRIV		/* Set quality threshold */
+#define SIOCGIPQTHR	SIOCIWFIRSTPRIV + 1	/* Get quality threshold */
+#define SIOCSIPROAM     SIOCIWFIRSTPRIV + 2	/* Set roaming state */
+#define SIOCGIPROAM     SIOCIWFIRSTPRIV + 3	/* Get roaming state */
+
+#define SIOCSIPHISTO	SIOCIWFIRSTPRIV + 6	/* Set histogram ranges */
+#define SIOCGIPHISTO	SIOCIWFIRSTPRIV + 7	/* Get histogram values */
 
 /*************************** WaveLAN Roaming  **************************/
 #ifdef WAVELAN_ROAMING		/* Conditional compile, see above in options */
diff -u -p linux/drivers/net/pcmcia/wavelan_cs.w11.c linux/drivers/net/pcmcia/wavelan_cs.c
--- linux/drivers/net/pcmcia/wavelan_cs.w11.c	Tue Oct  9 00:36:23 2001
+++ linux/drivers/net/pcmcia/wavelan_cs.c	Tue Oct  9 00:42:28 2001
@@ -2269,6 +2269,12 @@ wavelan_ioctl(struct net_device *	dev,	/
 	  range.max_qual.qual = MMR_SGNL_QUAL;
 	  range.max_qual.level = MMR_SIGNAL_LVL;
 	  range.max_qual.noise = MMR_SILENCE_LVL;
+#if WIRELESS_EXT > 11
+	  range.avg_qual.qual = MMR_SGNL_QUAL; /* Always max */
+	  /* Need to get better values for those two */
+	  range.avg_qual.level = 30;
+	  range.avg_qual.noise = 8;
+#endif /* WIRELESS_EXT > 11 */
 
 #if WIRELESS_EXT > 7
 	  range.num_bitrates = 1;
diff -u -p linux/drivers/net/pcmcia/netwave_cs.w11.c linux/drivers/net/pcmcia/netwave_cs.c
--- linux/drivers/net/pcmcia/netwave_cs.w11.c	Tue Oct  9 00:37:26 2001
+++ linux/drivers/net/pcmcia/netwave_cs.c	Tue Oct  9 00:44:11 2001
@@ -269,8 +269,15 @@ static dev_link_t *dev_list;
    because they generally can't be allocated dynamically.
 */
 
-#define SIOCGIPSNAP	SIOCDEVPRIVATE		/* Site Survey Snapshot */
-/*#define SIOCGIPQTHR	SIOCDEVPRIVATE + 1*/
+/* Wireless Extension Backward compatibility - Jean II
+ * If the new wireless device private ioctl range is not defined,
+ * default to standard device private ioctl range */
+#ifndef SIOCIWFIRSTPRIV
+#define SIOCIWFIRSTPRIV	SIOCDEVPRIVATE
+#endif /* SIOCIWFIRSTPRIV */
+
+#define SIOCGIPSNAP	SIOCIWFIRSTPRIV		/* Site Survey Snapshot */
+/*#define SIOCGIPQTHR	SIOCIWFIRSTPRIV + 1*/
 
 #define MAX_ESA 10
 
diff -u -p linux/drivers/net/pcmcia/ray_cs.w11.c linux/drivers/net/pcmcia/ray_cs.c
--- linux/drivers/net/pcmcia/ray_cs.w11.c	Tue Oct  9 00:37:36 2001
+++ linux/drivers/net/pcmcia/ray_cs.c	Tue Oct  9 00:45:52 2001
@@ -1451,9 +1451,12 @@ static int ray_dev_ioctl(struct net_devi
 #endif	/* WIRELESS_SPY */
 
       /* ------------------ PRIVATE IOCTL ------------------ */
-#define SIOCSIPFRAMING	SIOCDEVPRIVATE		/* Set framing mode */
-#define SIOCGIPFRAMING	SIOCDEVPRIVATE + 1	/* Get framing mode */
-#define SIOCGIPCOUNTRY	SIOCDEVPRIVATE + 3	/* Get country code */
+#ifndef SIOCIWFIRSTPRIV
+#define SIOCIWFIRSTPRIV	SIOCDEVPRIVATE
+#endif /* SIOCIWFIRSTPRIV */
+#define SIOCSIPFRAMING	SIOCIWFIRSTPRIV		/* Set framing mode */
+#define SIOCGIPFRAMING	SIOCIWFIRSTPRIV + 1	/* Get framing mode */
+#define SIOCGIPCOUNTRY	SIOCIWFIRSTPRIV + 3	/* Get country code */
     case SIOCSIPFRAMING:
       if(!capable(CAP_NET_ADMIN))	/* For private IOCTLs, we need to check permissions */
 	{
