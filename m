Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbUAMWYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUAMWXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:23:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:62158 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265865AbUAMWXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:23:12 -0500
Date: Tue, 13 Jan 2004 14:22:04 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.X] SIOCSIFNAME wilcard suppor & name validation
Message-Id: <20040113142204.0b41403b.shemminger@osdl.org>
In-Reply-To: <20040112234332.GA1785@bougret.hpl.hp.com>
References: <20040112234332.GA1785@bougret.hpl.hp.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an enhanced version of the previous patch.
It adds both the wildcard support that Jean did, and validation of network
device names.

It doesn't check the error return from class_device_rename because
that will not fail unless object or name are null.

diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Tue Jan 13 14:20:51 2004
+++ b/net/core/dev.c	Tue Jan 13 14:20:51 2004
@@ -621,6 +621,21 @@
 }
 
 /**
+ *	dev_valid_name - check if name is okay for network device
+ *	@name: name string
+ *
+ *	Network device names need to be valid file names to
+ *	to allow sysfs to work
+ */
+int dev_valid_name(const char *name)
+{
+	return !(*name == '\0' 
+		 || !strcmp(name, ".")
+		 || !strcmp(name, "..")
+		 || strchr(name, '/'));
+}
+
+/**
  *	dev_alloc_name - allocate a name for a device
  *	@dev: device
  *	@name: name format string
@@ -660,6 +675,41 @@
 	return -ENFILE;	/* Over 100 of the things .. bail out! */
 }
 
+
+/**
+ *	dev_change_name - change name of a device
+ *	@dev: device
+ *	@name: name (or format string) must be at least IFNAMSIZ
+ *
+ *	Change name of a device, can pass format strings "eth%d".
+ *	for wildcarding.
+ */
+int dev_change_name(struct net_device *dev, char *newname)
+{
+	ASSERT_RTNL();
+
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	if (!dev_valid_name(newname))
+		return -EINVAL;
+
+	if (strchr(newname, '%')) {
+		int err = dev_alloc_name(dev, newname);
+		if (err)
+			return err;
+		strcpy(newname, dev->name);
+	}
+	else if (__dev_get_by_name(newname))
+		return -EEXIST;
+	else
+		strlcpy(dev->name, newname, IFNAMSIZ);
+
+	class_device_rename(&dev->class_dev, dev->name);
+	notifier_call_chain(&netdev_chain, NETDEV_CHANGENAME, dev);
+	return 0;
+}
+
 /**
  *	dev_alloc - allocate a network device and name
  *	@name: name format string
@@ -2359,20 +2409,8 @@
 			return 0;
 
 		case SIOCSIFNAME:
-			if (dev->flags & IFF_UP)
-				return -EBUSY;
 			ifr->ifr_newname[IFNAMSIZ-1] = '\0';
-			if (__dev_get_by_name(ifr->ifr_newname))
-				return -EEXIST;
-			err = class_device_rename(&dev->class_dev, 
-						  ifr->ifr_newname);
-			if (!err) {
-				strlcpy(dev->name, ifr->ifr_newname, IFNAMSIZ);
-
-				notifier_call_chain(&netdev_chain,
-						    NETDEV_CHANGENAME, dev);
-			}
-			return err;
+			return dev_change_name(dev, ifr->ifr_newname);
 
 		/*
 		 *	Unknown or private ioctl
@@ -2505,6 +2543,7 @@
 		 */
 		case SIOCGMIIPHY:
 		case SIOCGMIIREG:
+		case SIOCSIFNAME:
 			if (!capable(CAP_NET_ADMIN))
 				return -EPERM;
 			dev_load(ifr.ifr_name);
@@ -2536,7 +2575,6 @@
 		case SIOCDELMULTI:
 		case SIOCSIFHWBROADCAST:
 		case SIOCSIFTXQLEN:
-		case SIOCSIFNAME:
 		case SIOCSMIIREG:
 		case SIOCBONDENSLAVE:
 		case SIOCBONDRELEASE:
@@ -2685,6 +2723,11 @@
 				ret = -EIO;
 			goto out_err;
 		}
+	}
+ 
+	if (!dev_valid_name(dev->name)) {
+		ret = -EINVAL;
+		goto out_err;
 	}
 
 	dev->ifindex = dev_new_index();
