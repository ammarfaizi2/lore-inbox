Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293339AbSCKO4W>; Mon, 11 Mar 2002 09:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310141AbSCKO4N>; Mon, 11 Mar 2002 09:56:13 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:57612 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293339AbSCKO4A>; Mon, 11 Mar 2002 09:56:00 -0500
Message-Id: <200203111453.g2BErjq05659@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dave Jones <davej@suse.de>
Subject: [PATCH] -ENOCOMPILE: 2.5.6-pre2 <*> 3c505 "EtherLink Plus" support
Date: Mon, 11 Mar 2002 16:53:00 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<*> 3c505 "EtherLink Plus" support
==================================
gcc -D__KERNEL__ -I/.share/usr/src/linux-2.5.6-pre2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i386   -DKBUILD_BASENAME=3c505  -c -o 3c505.o 3c505.c
3c505.c:1362: redefinition of `netdev_ethtool_ioctl'
3c505.c:1172: `netdev_ethtool_ioctl' previously defined here
3c505.c:1417: redefinition of `netdev_ioctl'
3c505.c:1227: `netdev_ioctl' previously defined here
{standard input}: Assembler messages:
{standard input}:4028: Error: Symbol netdev_ethtool_ioctl already defined.
{standard input}:4316: Error: Symbol netdev_ioctl already defined.
make[3]: *** [3c505.o] Error 1
make[3]: Leaving directory `/.share/usr/src/linux-2.5.6-pre2/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/.share/usr/src/linux-2.5.6-pre2/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/.share/usr/src/linux-2.5.6-pre2/drivers'
make: *** [_dir_drivers] Error 2

--- linux-2.5.6-pre2/drivers/net/3c505.c.orig	Wed Feb 20 00:11:03 2002
+++ linux-2.5.6-pre2/drivers/net/3c505.c	Mon Mar 11 16:21:42 2002
@@ -1350,86 +1350,6 @@
 	}
 }
 
-/**
- * netdev_ethtool_ioctl: Handle network interface SIOCETHTOOL ioctls
- * @dev: network interface on which out-of-band action is to be performed
- * @useraddr: userspace address to which data is to be read and returned
- *
- * Process the various commands of the SIOCETHTOOL interface.
- */
-
-static int netdev_ethtool_ioctl (struct net_device *dev, void *useraddr)
-{
-	u32 ethcmd;
-
-	/* dev_ioctl() in ../../net/core/dev.c has already checked
-	   capable(CAP_NET_ADMIN), so don't bother with that here.  */
-
-	if (get_user(ethcmd, (u32 *)useraddr))
-		return -EFAULT;
-
-	switch (ethcmd) {
-
-	case ETHTOOL_GDRVINFO: {
-		struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
-		strcpy (info.driver, DRV_NAME);
-		strcpy (info.version, DRV_VERSION);
-		sprintf(info.bus_info, "ISA 0x%lx", dev->base_addr);
-		if (copy_to_user (useraddr, &info, sizeof (info)))
-			return -EFAULT;
-		return 0;
-	}
-
-	/* get message-level */
-	case ETHTOOL_GMSGLVL: {
-		struct ethtool_value edata = {ETHTOOL_GMSGLVL};
-		edata.data = debug;
-		if (copy_to_user(useraddr, &edata, sizeof(edata)))
-			return -EFAULT;
-		return 0;
-	}
-	/* set message-level */
-	case ETHTOOL_SMSGLVL: {
-		struct ethtool_value edata;
-		if (copy_from_user(&edata, useraddr, sizeof(edata)))
-			return -EFAULT;
-		debug = edata.data;
-		return 0;
-	}
-
-	default:
-		break;
-	}
-
-	return -EOPNOTSUPP;
-}
-
-/**
- * netdev_ioctl: Handle network interface ioctls
- * @dev: network interface on which out-of-band action is to be performed
- * @rq: user request data
- * @cmd: command issued by user
- *
- * Process the various out-of-band ioctls passed to this driver.
- */
-
-static int netdev_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
-{
-	int rc = 0;
-
-	switch (cmd) {
-	case SIOCETHTOOL:
-		rc = netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
-		break;
-
-	default:
-		rc = -EOPNOTSUPP;
-		break;
-	}
-
-	return rc;
-}
- 
 
 /******************************************************
  *
