Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWDUPkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWDUPkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWDUPkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:40:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:7059 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932326AbWDUPkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:40:12 -0400
Date: Fri, 21 Apr 2006 17:40:06 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Dale Farnsworth <dale@farnsworth.org>
Subject: [PATCH] mv643xx_eth: provide sysfs class device symlink
Message-ID: <20060421154006.GA12026@suse.de>
References: <20060311003428.GA17309@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060311003428.GA17309@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Mar 11, Olaf Hering wrote:

> Why is the /sys/class/net/eth0/device symlink not created for the
> mv643xx_eth driver? Does this work for other platform device drivers?
> Seems to work for the ps2 keyboard at least.

The SET_NETDEV_DEV has to be done before a call to register_netdev. With
the new patch below, the device symlink for the platform device was created.
Unfortunately, after the 4 ls commands, the network connection died. No
idea if the box crashed or if something else broke, lost remote access.



Provide sysfs 'device' in /class/net/ethN
Also, set module owner field, like pcnet32 driver does.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 drivers/net/mv643xx_eth.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.17-rc2/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.6.17-rc2.orig/drivers/net/mv643xx_eth.c
+++ linux-2.6.17-rc2/drivers/net/mv643xx_eth.c
@@ -1419,6 +1419,8 @@ static int mv643xx_eth_probe(struct plat
 	mv643xx_eth_update_pscr(dev, &cmd);
 	mv643xx_set_settings(dev, &cmd);
 
+	SET_MODULE_OWNER(dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
 	err = register_netdev(dev);
 	if (err)
 		goto out;




-- 

olaf@cantaloupe:~> l /sys/class/net/
total 0
drwxr-xr-x 3 root root 0 2006-04-21 17:14 eth0/
drwxr-xr-x 3 root root 0 2006-04-21 17:14 eth1/
drwxr-xr-x 3 root root 0 2006-04-21 17:14 lo/
drwxr-xr-x 3 root root 0 2006-04-21 17:15 sit0/
olaf@cantaloupe:~> l /sys/class/net/eth0/
total 0
-r--r--r-- 1 root root 4096 2006-04-21 17:14 addr_len
-r--r--r-- 1 root root 4096 2006-04-21 17:14 address
-r--r--r-- 1 root root 4096 2006-04-21 17:14 broadcast
-r--r--r-- 1 root root 4096 2006-04-21 17:14 carrier
lrwxrwxrwx 1 root root    0 2006-04-21 17:14 device -> ../../../devices/platform/mv643xx_eth.1/
-r--r--r-- 1 root root 4096 2006-04-21 17:14 features
-rw-r--r-- 1 root root 4096 2006-04-21 17:14 flags
-r--r--r-- 1 root root 4096 2006-04-21 17:14 ifindex
-r--r--r-- 1 root root 4096 2006-04-21 17:14 iflink
-rw-r--r-- 1 root root 4096 2006-04-21 17:14 mtu
drwxr-xr-x 2 root root    0 2006-04-21 17:14 statistics/
-rw-r--r-- 1 root root 4096 2006-04-21 17:14 tx_queue_len
-r--r--r-- 1 root root 4096 2006-04-21 17:14 type
--w------- 1 root root 4096 2006-04-21 17:14 uevent
-rw-r--r-- 1 root root 4096 2006-04-21 17:14 weight
olaf@cantaloupe:~> l /sys/class/net/eth1/
total 0
-r--r--r-- 1 root root 4096 2006-04-21 17:14 addr_len
-r--r--r-- 1 root root 4096 2006-04-21 17:14 address
-r--r--r-- 1 root root 4096 2006-04-21 17:14 broadcast
-r--r--r-- 1 root root 4096 2006-04-21 17:14 carrier
lrwxrwxrwx 1 root root    0 2006-04-21 17:14 device -> ../../../devices/pci0000:00/0000:00:0d.0/
-r--r--r-- 1 root root 4096 2006-04-21 17:14 features
-rw-r--r-- 1 root root 4096 2006-04-21 17:14 flags
-r--r--r-- 1 root root 4096 2006-04-21 17:14 ifindex
-r--r--r-- 1 root root 4096 2006-04-21 17:14 iflink
-rw-r--r-- 1 root root 4096 2006-04-21 17:14 mtu
drwxr-xr-x 2 root root    0 2006-04-21 17:14 statistics/
-rw-r--r-- 1 root root 4096 2006-04-21 17:14 tx_queue_len
-r--r--r-- 1 root root 4096 2006-04-21 17:14 type
--w------- 1 root root 4096 2006-04-21 17:14 uevent
-rw-r--r-- 1 root root 4096 2006-04-21 17:14 weight
olaf@cantaloupe:~> l /sys/class/net/eth*/device
lrwxrwxrwx 1 root root 0 2006-04-21 17:14 /sys/class/net/eth0/device -> ../../../devices/platform/mv643xx_eth.1/
lrwxrwxrwx 1 root root 0 2006-04-21 17:14 /sys/class/net/eth1/device -> ../../../devices/pci0000:00/0000:00:0d.0/
olaf@cantaloupe:~> 




