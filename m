Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262044AbTCVGnP>; Sat, 22 Mar 2003 01:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbTCVGnP>; Sat, 22 Mar 2003 01:43:15 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:9411 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S262044AbTCVGnL>; Sat, 22 Mar 2003 01:43:11 -0500
Message-ID: <3E7C07F9.A7EBBBE@verizon.net>
Date: Fri, 21 Mar 2003 22:51:37 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.65 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, jt@hpl.hp.com
Subject: [PATCH] reduce stack in wireless/airo.c
Content-Type: multipart/mixed;
 boundary="------------03F675B4065EADB2A1CBFA4E"
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [4.64.238.61] at Sat, 22 Mar 2003 00:54:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------03F675B4065EADB2A1CBFA4E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This reduces stack usage in drivers/net/wireless/airo.c by
dynamically allocating 2KB buffers in 2 places.

Patch is to 2.5.65.  Please apply.

~Randy
--------------03F675B4065EADB2A1CBFA4E
Content-Type: text/plain; charset=us-ascii;
 name="airo-stack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="airo-stack.patch"

patch_name:	airo-stack.patch
patch_version:	2003-03-21.22:14:20
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	reduce stack usage in drivers/net/wireless/airo::
		readrids() and writerids();
product:	Linux
product_versions: 2.5.65
changelog:	kmalloc() 2 KB buffers instead of declaring them on stack;
maintainer:	Jean Tourrilhes <jt@hpl.hp.com>
diffstat:	=
 drivers/net/wireless/airo.c |   80 ++++++++++++++++++++++++++++----------------
 1 files changed, 52 insertions(+), 28 deletions(-)


diff -Naur ./drivers/net/wireless/airo.c%RIDS ./drivers/net/wireless/airo.c
--- ./drivers/net/wireless/airo.c%RIDS	Mon Mar 17 13:43:40 2003
+++ ./drivers/net/wireless/airo.c	Fri Mar 21 22:14:01 2003
@@ -5894,6 +5894,7 @@
 #endif /* WIRELESS_EXT */
 
 #ifdef CISCO_EXT
+#define RIDS_SIZE	2048
 /*
  * This just translates from driver IOCTL codes to the command codes to
  * feed to the radio's host interface. Things can be added/deleted
@@ -5902,11 +5903,15 @@
  */
 static int readrids(struct net_device *dev, aironet_ioctl *comp) {
 	unsigned short ridcode;
-	unsigned char iobuf[2048];
+	unsigned char *iobuf;
 	struct airo_info *ai = dev->priv;
+	int ret = 0;
 
 	if (ai->flags & FLAG_FLASHING)
 		return -EIO;
+	iobuf = kmalloc(RIDS_SIZE, GFP_KERNEL);
+	if (!iobuf)
+		return -ENOMEM;
 
 	switch(comp->command)
 	{
@@ -5919,13 +5924,17 @@
 	case AIROGEHTENC:   ridcode = RID_ETHERENCAP;   break;
 	case AIROGWEPKTMP:  ridcode = RID_WEP_TEMP;
 		/* Only super-user can read WEP keys */
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
+		if (!capable(CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			goto rr_free;
+		}
 		break;
 	case AIROGWEPKNV:   ridcode = RID_WEP_PERM;
 		/* Only super-user can read WEP keys */
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
+		if (!capable(CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			goto rr_free;
+		}
 		break;
 	case AIROGSTAT:     ridcode = RID_STATUS;       break;
 	case AIROGSTATSD32: ridcode = RID_STATSDELTA;   break;
@@ -5933,23 +5942,25 @@
 	case AIROGMICSTATS:
 		if (copy_to_user(comp->data, &ai->micstats,
 				 min((int)comp->len,(int)sizeof(ai->micstats))))
-			return -EFAULT;
-		return 0;
+			ret = -EFAULT;
+		goto rr_free;
 	default:
-		return -EINVAL;
-		break;
+		ret = -EINVAL;
+		goto rr_free;
 	}
 
-	PC4500_readrid(ai,ridcode,iobuf,sizeof(iobuf));
+	PC4500_readrid(ai,ridcode,iobuf,RIDS_SIZE);
 	/* get the count of bytes in the rid  docs say 1st 2 bytes is it.
 	 * then return it to the user
 	 * 9/22/2000 Honor user given length
 	 */
 
 	if (copy_to_user(comp->data, iobuf,
-			 min((int)comp->len, (int)sizeof(iobuf))))
-		return -EFAULT;
-	return 0;
+			 min((int)comp->len, (int)RIDS_SIZE)))
+		ret = -EFAULT;
+rr_free:
+	kfree(iobuf);
+	return ret;
 }
 
 /*
@@ -5961,7 +5972,8 @@
 	int  ridcode, enabled;
 	Resp      rsp;
 	static int (* writer)(struct airo_info *, u16 rid, const void *, int);
-	unsigned char iobuf[2048];
+	unsigned char *iobuf;
+	int ret = 0;
 
 	/* Only super-user can write RIDs */
 	if (!capable(CAP_NET_ADMIN))
@@ -5970,6 +5982,10 @@
 	if (ai->flags & FLAG_FLASHING)
 		return -EIO;
 
+	iobuf = kmalloc(RIDS_SIZE, GFP_KERNEL);
+	if (!iobuf)
+		return -ENOMEM;
+
 	ridcode = 0;
 	writer = do_writerid;
 
@@ -5991,8 +6007,8 @@
 		 */
 	case AIROPMACON:
 		if (enable_MAC(ai, &rsp) != 0)
-			return -EIO;
-		return 0;
+			ret = -EIO;
+		goto wr_free;
 
 		/*
 		 * Evidently this code in the airo driver does not get a symbol
@@ -6000,32 +6016,38 @@
 		 */
 	case AIROPMACOFF:
 		disable_MAC(ai);
-		return 0;
+		goto wr_free;
 
 		/* This command merely clears the counts does not actually store any data
 		 * only reads rid. But as it changes the cards state, I put it in the
 		 * writerid routines.
 		 */
 	case AIROPSTCLR:
-		PC4500_readrid(ai,RID_STATSDELTACLEAR,iobuf,sizeof(iobuf));
+		PC4500_readrid(ai,RID_STATSDELTACLEAR,iobuf,RIDS_SIZE);
 
 		enabled = ai->micstats.enabled;
 		memset(&ai->micstats,0,sizeof(ai->micstats));
 		ai->micstats.enabled = enabled;
 
 		if (copy_to_user(comp->data, iobuf,
-				 min((int)comp->len, (int)sizeof(iobuf))))
-			return -EFAULT;
-		return 0;
+				 min((int)comp->len, (int)RIDS_SIZE)))
+			ret = -EFAULT;
+		goto wr_free;
 
 	default:
-		return -EOPNOTSUPP;	/* Blarg! */
+		ret = -EOPNOTSUPP;	/* Blarg! */
+		goto wr_free;
+	}
+
+	if (comp->len > RIDS_SIZE) {
+		ret = -EINVAL;
+		goto wr_free;
 	}
-	if(comp->len > sizeof(iobuf))
-		return -EINVAL;
 
-	if (copy_from_user(iobuf,comp->data,comp->len))
-		return -EFAULT;
+	if (copy_from_user(iobuf,comp->data,comp->len)) {
+		ret = -EFAULT;
+		goto wr_free;
+	}
 
 	if (comp->command == AIROPCFG) {
 		ConfigRid *cfg = (ConfigRid *)iobuf;
@@ -6040,8 +6062,10 @@
 	}
 
 	if((*writer)(ai, ridcode, iobuf,comp->len))
-		return -EIO;
-	return 0;
+		ret = -EIO;
+wr_free:
+	kfree(iobuf);
+	return ret;
 }
 
 /*****************************************************************************

--------------03F675B4065EADB2A1CBFA4E--

