Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263413AbTCNQ72>; Fri, 14 Mar 2003 11:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263419AbTCNQ72>; Fri, 14 Mar 2003 11:59:28 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:9886 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263413AbTCNQ7Y>; Fri, 14 Mar 2003 11:59:24 -0500
Date: Fri, 14 Mar 2003 18:09:53 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: Benjamin Reed <breed@users.sourceforge.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix stack usage for drivers/net/wireless/airo.c
Message-ID: <20030314170953.GG23161@wohnheim.fh-wedel.de>
References: <20030314160108.GE27154@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030314160108.GE27154@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 March 2003 17:01:08 +0100, Joern Engel wrote:
> 
> This patch moves a 2k buffer from stack to heap in readrids() and
> writerids(). The #define is ugly, I agree. But the functions
> themselves could use some cleanup anyway.

Take two.
Randy's right about sizeof(*char) _not_ being 4k or 2k or whatever I
hope it will be this time. Darn that stupid compiler! ;)

Jörn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law

--- linux-2.5.64/drivers/net/wireless/airo.c	Wed Mar 12 14:16:38 2003
+++ linux-2.5.64-i2o/drivers/net/wireless/airo.c	Fri Mar 14 17:32:02 2003
@@ -5894,6 +5894,11 @@
 #endif /* WIRELESS_EXT */
 
 #ifdef CISCO_EXT
+
+#define ret(val) do { kfree(iobuf); return(val); } while(0)
+
+/* FIXME: should the below go into some header file? */
+#define RIDS_BUFSIZE 2048
 /*
  * This just translates from driver IOCTL codes to the command codes to
  * feed to the radio's host interface. Things can be added/deleted
@@ -5902,12 +5907,16 @@
  */
 static int readrids(struct net_device *dev, aironet_ioctl *comp) {
 	unsigned short ridcode;
-	unsigned char iobuf[2048];
+	unsigned char *iobuf;
 	struct airo_info *ai = dev->priv;
 
 	if (ai->flags & FLAG_FLASHING)
 		return -EIO;
 
+	iobuf = kmalloc(RIDS_BUFSIZE, GFP_KERNEL);
+	if (!iobuf)
+		return -ENOMEM;
+
 	switch(comp->command)
 	{
 	case AIROGCAP:      ridcode = RID_CAPABILITIES; break;
@@ -5920,12 +5929,12 @@
 	case AIROGWEPKTMP:  ridcode = RID_WEP_TEMP;
 		/* Only super-user can read WEP keys */
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
+			ret(-EPERM);
 		break;
 	case AIROGWEPKNV:   ridcode = RID_WEP_PERM;
 		/* Only super-user can read WEP keys */
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
+			ret(-EPERM);
 		break;
 	case AIROGSTAT:     ridcode = RID_STATUS;       break;
 	case AIROGSTATSD32: ridcode = RID_STATSDELTA;   break;
@@ -5933,23 +5942,23 @@
 	case AIROGMICSTATS:
 		if (copy_to_user(comp->data, &ai->micstats,
 				 min((int)comp->len,(int)sizeof(ai->micstats))))
-			return -EFAULT;
-		return 0;
+			ret(-EFAULT);
+		ret(0);
 	default:
-		return -EINVAL;
+		ret(-EINVAL);
 		break;
 	}
 
-	PC4500_readrid(ai,ridcode,iobuf,sizeof(iobuf));
+	PC4500_readrid(ai,ridcode,iobuf,RIDS_BUFSIZE);
 	/* get the count of bytes in the rid  docs say 1st 2 bytes is it.
 	 * then return it to the user
 	 * 9/22/2000 Honor user given length
 	 */
 
 	if (copy_to_user(comp->data, iobuf,
-			 min((int)comp->len, (int)sizeof(iobuf))))
-		return -EFAULT;
-	return 0;
+			 min((int)comp->len, RIDS_BUFSIZE)))
+		ret(-EFAULT);
+	ret(0);
 }
 
 /*
@@ -5961,7 +5970,7 @@
 	int  ridcode, enabled;
 	Resp      rsp;
 	static int (* writer)(struct airo_info *, u16 rid, const void *, int);
-	unsigned char iobuf[2048];
+	unsigned char *iobuf;
 
 	/* Only super-user can write RIDs */
 	if (!capable(CAP_NET_ADMIN))
@@ -5970,6 +5979,10 @@
 	if (ai->flags & FLAG_FLASHING)
 		return -EIO;
 
+	iobuf = kmalloc(RIDS_BUFSIZE, GFP_KERNEL);
+	if (!iobuf)
+		return -ENOMEM;
+
 	ridcode = 0;
 	writer = do_writerid;
 
@@ -5991,8 +6004,8 @@
 		 */
 	case AIROPMACON:
 		if (enable_MAC(ai, &rsp) != 0)
-			return -EIO;
-		return 0;
+			ret(-EIO);
+		ret(0);
 
 		/*
 		 * Evidently this code in the airo driver does not get a symbol
@@ -6000,32 +6013,32 @@
 		 */
 	case AIROPMACOFF:
 		disable_MAC(ai);
-		return 0;
+		ret(0);
 
 		/* This command merely clears the counts does not actually store any data
 		 * only reads rid. But as it changes the cards state, I put it in the
 		 * writerid routines.
 		 */
 	case AIROPSTCLR:
-		PC4500_readrid(ai,RID_STATSDELTACLEAR,iobuf,sizeof(iobuf));
+		PC4500_readrid(ai,RID_STATSDELTACLEAR,iobuf,RIDS_BUFSIZE);
 
 		enabled = ai->micstats.enabled;
 		memset(&ai->micstats,0,sizeof(ai->micstats));
 		ai->micstats.enabled = enabled;
 
 		if (copy_to_user(comp->data, iobuf,
-				 min((int)comp->len, (int)sizeof(iobuf))))
-			return -EFAULT;
-		return 0;
+				 min((int)comp->len, RIDS_BUFSIZE)))
+			ret(-EFAULT);
+		ret(0);
 
 	default:
-		return -EOPNOTSUPP;	/* Blarg! */
+		ret(-EOPNOTSUPP);	/* Blarg! */
 	}
-	if(comp->len > sizeof(iobuf))
-		return -EINVAL;
+	if(comp->len > RIDS_BUFSIZE)
+		ret(-EINVAL);
 
 	if (copy_from_user(iobuf,comp->data,comp->len))
-		return -EFAULT;
+		ret(-EFAULT);
 
 	if (comp->command == AIROPCFG) {
 		ConfigRid *cfg = (ConfigRid *)iobuf;
@@ -6040,9 +6053,10 @@
 	}
 
 	if((*writer)(ai, ridcode, iobuf,comp->len))
-		return -EIO;
-	return 0;
+		ret(-EIO);
+	ret(0);
 }
+#undef ret
 
 /*****************************************************************************
  * Ancillary flash / mod functions much black magic lurkes here              *
