Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUHLAwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUHLAwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUHLAub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:50:31 -0400
Received: from [203.178.140.15] ([203.178.140.15]:11787 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S268516AbUHLAlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:41:32 -0400
Date: Thu, 12 Aug 2004 09:42:06 +0900 (JST)
Message-Id: <20040812.094206.42261287.yoshfuji@linux-ipv6.org>
To: bunk@fs.tum.de, davem@redhat.com
Cc: SteveW@ACM.org, emserrat@geocities.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: 2.6: DECNET compile errors with SYSCTL=n
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040811224015.GP26174@fs.tum.de>
References: <20040811224015.GP26174@fs.tum.de>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <20040811224015.GP26174@fs.tum.de> (at Thu, 12 Aug 2004 00:40:15 +0200), Adrian Bunk <bunk@fs.tum.de> says:

> I'm getting the following compile errors in 2.6.8-rc4-mm1 (but it 
> doesn't seem to be specific to -mm) with CONFIG_SYSCTL=n:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> net/built-in.o(.text+0x1685e9): In function `dn_route_output_slow':
> : undefined reference to `dn_dev_get_default'
:

Please try this patch. Thanks.
Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== net/decnet/dn_dev.c 1.23 vs edited =====
--- 1.23/net/decnet/dn_dev.c	2004-08-08 15:43:41 +09:00
+++ edited/net/decnet/dn_dev.c	2004-08-12 09:34:56 +09:00
@@ -247,21 +247,6 @@
 	}, {0}}
 };
 
-static inline __u16 mtu2blksize(struct net_device *dev)
-{
-	u32 blksize = dev->mtu;
-	if (blksize > 0xffff)
-		blksize = 0xffff;
-
-	if (dev->type == ARPHRD_ETHER ||
-	    dev->type == ARPHRD_PPP ||
-	    dev->type == ARPHRD_IPGRE ||
-	    dev->type == ARPHRD_LOOPBACK)
-		blksize -= 2;
-
-	return (__u16)blksize;
-}
-
 static void dn_dev_sysctl_register(struct net_device *dev, struct dn_dev_parms *parms)
 {
 	struct dn_dev_sysctl_table *t;
@@ -314,52 +299,6 @@
 	}
 }
 
-struct net_device *dn_dev_get_default(void)
-{
-	struct net_device *dev;
-	read_lock(&dndev_lock);
-	dev = decnet_default_device;
-	if (dev) {
-		if (dev->dn_ptr)
-			dev_hold(dev);
-		else
-			dev = NULL;
-	}
-	read_unlock(&dndev_lock);
-	return dev;
-}
-
-int dn_dev_set_default(struct net_device *dev, int force)
-{
-	struct net_device *old = NULL;
-	int rv = -EBUSY;
-	if (!dev->dn_ptr)
-		return -ENODEV;
-	write_lock(&dndev_lock);
-	if (force || decnet_default_device == NULL) {
-		old = decnet_default_device;
-		decnet_default_device = dev;
-		rv = 0;
-	}
-	write_unlock(&dndev_lock);
-	if (old)
-		dev_put(dev);
-	return rv;
-}
-
-static void dn_dev_check_default(struct net_device *dev)
-{
-	write_lock(&dndev_lock);
-	if (dev == decnet_default_device) {
-		decnet_default_device = NULL;
-	} else {
-		dev = NULL;
-	}
-	write_unlock(&dndev_lock);
-	if (dev)
-		dev_put(dev);
-}
-
 static int dn_forwarding_proc(ctl_table *table, int write, 
 				struct file *filep,
 				void __user *buffer,
@@ -454,6 +393,21 @@
 
 #endif /* CONFIG_SYSCTL */
 
+static inline __u16 mtu2blksize(struct net_device *dev)
+{
+	u32 blksize = dev->mtu;
+	if (blksize > 0xffff)
+		blksize = 0xffff;
+
+	if (dev->type == ARPHRD_ETHER ||
+	    dev->type == ARPHRD_PPP ||
+	    dev->type == ARPHRD_IPGRE ||
+	    dev->type == ARPHRD_LOOPBACK)
+		blksize -= 2;
+
+	return (__u16)blksize;
+}
+
 static struct dn_ifaddr *dn_dev_alloc_ifa(void)
 {
 	struct dn_ifaddr *ifa;
@@ -633,6 +587,52 @@
 	if (copy_to_user(arg, ifr, DN_IFREQ_SIZE))
 		ret = -EFAULT;
 	goto done;
+}
+
+struct net_device *dn_dev_get_default(void)
+{
+	struct net_device *dev;
+	read_lock(&dndev_lock);
+	dev = decnet_default_device;
+	if (dev) {
+		if (dev->dn_ptr)
+			dev_hold(dev);
+		else
+			dev = NULL;
+	}
+	read_unlock(&dndev_lock);
+	return dev;
+}
+
+int dn_dev_set_default(struct net_device *dev, int force)
+{
+	struct net_device *old = NULL;
+	int rv = -EBUSY;
+	if (!dev->dn_ptr)
+		return -ENODEV;
+	write_lock(&dndev_lock);
+	if (force || decnet_default_device == NULL) {
+		old = decnet_default_device;
+		decnet_default_device = dev;
+		rv = 0;
+	}
+	write_unlock(&dndev_lock);
+	if (old)
+		dev_put(dev);
+	return rv;
+}
+
+static void dn_dev_check_default(struct net_device *dev)
+{
+	write_lock(&dndev_lock);
+	if (dev == decnet_default_device) {
+		decnet_default_device = NULL;
+	} else {
+		dev = NULL;
+	}
+	write_unlock(&dndev_lock);
+	if (dev)
+		dev_put(dev);
 }
 
 static struct dn_dev *dn_dev_by_index(int ifindex)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
