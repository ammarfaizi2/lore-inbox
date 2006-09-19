Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWISPkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWISPkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWISPkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:40:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:22540 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751598AbWISPkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:40:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=AD4mtOOCJ1EQh8dR94hl6ssowG8397h6dn0k8lSAOV6NjDg125rue4LDHF5/YGAZSdP25OrnT4g5TcvjNKEw8/yv03cqoZivf24MyLfC9ZwXtsdp6Wlrq3fsGBmTKHyVEDR2LuBe3b6pjLh04Jzm+lrOh3CcyQSx6jwMqeSfKhQ=
Date: Tue, 19 Sep 2006 17:39:03 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: [-mm patch] missing class_dev to dev conversions
Message-ID: <20060919173902.GB751@slug>
References: <20060919012848.4482666d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919012848.4482666d.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 01:28:48AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc7/2.6.18-rc7-mm1/
> 
Greg,

There are some net drivers that didn't get their class_device converted to
device, as introduced by the gregkh-driver-network-class_device-to-device
patch.
The arm defconfig build thus fails with the following message:

drivers/net/smc91x.c: In function `smc_ethtool_getdrvinfo':
drivers/net/smc91x.c:1713: error: structure has no member named
`class_dev'
make[2]: *** [drivers/net/smc91x.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

The following patch fixes at91_ether.c, etherh.c, smc911x.c and smc91x.c.

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/drivers/net/arm/at91_ether.c b/drivers/net/arm/at91_ether.c
index 95b28aa..0662a72 100644
--- a/drivers/net/arm/at91_ether.c
+++ b/drivers/net/arm/at91_ether.c
@@ -645,7 +645,7 @@ static void at91ether_get_drvinfo(struct
 {
 	strlcpy(info->driver, DRV_NAME, sizeof(info->driver));
 	strlcpy(info->version, DRV_VERSION, sizeof(info->version));
-	strlcpy(info->bus_info, dev->class_dev.dev->bus_id, sizeof(info->bus_info));
+	strlcpy(info->bus_info, dev->dev.parent->bus_id, sizeof(info->bus_info));
 }
 
 static const struct ethtool_ops at91ether_ethtool_ops = {
diff --git a/drivers/net/arm/etherh.c b/drivers/net/arm/etherh.c
index 4ae9897..218380a 100644
--- a/drivers/net/arm/etherh.c
+++ b/drivers/net/arm/etherh.c
@@ -580,7 +580,7 @@ static void etherh_get_drvinfo(struct ne
 {
 	strlcpy(info->driver, DRV_NAME, sizeof(info->driver));
 	strlcpy(info->version, DRV_VERSION, sizeof(info->version));
-	strlcpy(info->bus_info, dev->class_dev.dev->bus_id,
+	strlcpy(info->bus_info, dev->dev.parent->bus_id,
 		sizeof(info->bus_info));
 }
 
diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index a621b17..b5aafb0 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -1653,7 +1653,7 @@ smc911x_ethtool_getdrvinfo(struct net_de
 {
 	strncpy(info->driver, CARDNAME, sizeof(info->driver));
 	strncpy(info->version, version, sizeof(info->version));
-	strncpy(info->bus_info, dev->class_dev.dev->bus_id, sizeof(info->bus_info));
+	strncpy(info->bus_info, dev->dev.parent->bus_id, sizeof(info->bus_info));
 }
 
 static int smc911x_ethtool_nwayreset(struct net_device *dev)
diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index d7e5643..810157d 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -1710,7 +1710,7 @@ smc_ethtool_getdrvinfo(struct net_device
 {
 	strncpy(info->driver, CARDNAME, sizeof(info->driver));
 	strncpy(info->version, version, sizeof(info->version));
-	strncpy(info->bus_info, dev->class_dev.dev->bus_id, sizeof(info->bus_info));
+	strncpy(info->bus_info, dev->dev.parent->bus_id, sizeof(info->bus_info));
 }
 
 static int smc_ethtool_nwayreset(struct net_device *dev)
