Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316159AbSEJWzM>; Fri, 10 May 2002 18:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSEJWzL>; Fri, 10 May 2002 18:55:11 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:61120 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316159AbSEJWzJ>;
	Fri, 10 May 2002 18:55:09 -0400
Date: Fri, 10 May 2002 15:55:09 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.15] : Wireless ctitical fix
Message-ID: <20020510155509.E14407@bougret.hpl.hp.com>
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

	Jeff,

	The following patch fix a off-by-one error that can result in
a crash (plus other cosmetic changes). Tested on 2.5.15. Would you
mind forwarding that to Linus ?
	Thanks...

	Jean

------------------------------------------------------

diff -u -p linux/net/core/wireless.v3.c linux/net/core/wireless.c
--- linux/net/core/wireless.v3.c	Fri May 10 15:45:56 2002
+++ linux/net/core/wireless.c	Fri May 10 15:48:42 2002
@@ -28,11 +28,13 @@
  *
  * v3 - 19.12.01 - Jean II
  *	o Make sure we don't go out of standard_ioctl[] in ioctl_standard_call
- *	o Fix /proc/net/wireless to handle __u8 to __s8 change in iwqual
  *	o Add event dispatcher function
  *	o Add event description
  *	o Propagate events as rtnetlink IFLA_WIRELESS option
  *	o Generate event on selected SET requests
+ *
+ * v4 - 18.04.01 - Jean II
+ *	o Fix stupid off by one in iw_ioctl_description : IW_ESSID_MAX_SIZE + 1
  */
 
 /***************************** INCLUDES *****************************/
@@ -122,13 +124,13 @@ static const struct iw_ioctl_description
 	/* SIOCGIWSCAN */
 	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_SCAN_MAX_DATA, 0},
 	/* SIOCSIWESSID */
-	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE, IW_DESCR_FLAG_EVENT},
+	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE + 1, IW_DESCR_FLAG_EVENT},
 	/* SIOCGIWESSID */
-	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE, IW_DESCR_FLAG_DUMP},
+	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE + 1, IW_DESCR_FLAG_DUMP},
 	/* SIOCSIWNICKN */
-	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE, 0},
+	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE + 1, 0},
 	/* SIOCGIWNICKN */
-	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE, 0},
+	{ IW_HEADER_TYPE_POINT, 0, 1, 0, IW_ESSID_MAX_SIZE + 1, 0},
 	/* -- hole -- */
 	{ IW_HEADER_TYPE_NULL, 0, 0, 0, 0, 0},
 	/* -- hole -- */
diff -u -p linux/include/net/iw_handler.v3.h linux/include/net/iw_handler.h
--- linux/include/net/iw_handler.v3.h	Fri May 10 15:46:51 2002
+++ linux/include/net/iw_handler.h	Fri May 10 15:48:06 2002
@@ -245,7 +245,8 @@
 /* Wrapper level flags */
 #define IW_DESCR_FLAG_DUMP	0x0001	/* Not part of the dump command */
 #define IW_DESCR_FLAG_EVENT	0x0002	/* Generate an event on SET */
-#define IW_DESCR_FLAG_RESTRICT	0x0004	/* GET request is ROOT only */
+#define IW_DESCR_FLAG_RESTRICT	0x0004	/* GET : request is ROOT only */
+				/* SET : Omit payload from generated iwevent */
 /* Driver level flags */
 #define IW_DESCR_FLAG_WAIT	0x0100	/* Wait for driver event */
 
