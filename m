Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUCKSiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUCKSiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:38:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:55438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261651AbUCKSiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:38:00 -0500
Date: Thu, 11 Mar 2004 10:37:54 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: James Ketrenos <jketreno@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
Message-Id: <20040311103754.540d9ca5@dell_ss3.pdx.osdl.net>
In-Reply-To: <404E27E6.40200@linux.co.intel.com>
References: <404E27E6.40200@linux.co.intel.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The whole /proc/ipw2100/xxx interface is ugly and a mess.  It doesn't expose anything
really useful that can't be found other ways and it is buggy.  It doesn't handle
more than one device;  I know you don't make hardware with multiple chipsets now but
will that always be true?  Also, it forgets to do properly set module owner. 

If you really have to keep the interface could you consider putting it in sysfs.
Something like /sys/class/net/eth0/ipw2100/xxx with one value per file.
The way to do that is with attribute groups.

The following wrappers might help:

diff -Nru a/include/linux/netdevice.h b/include/linux/netdevice.h
--- a/include/linux/netdevice.h	Thu Mar 11 10:36:47 2004
+++ b/include/linux/netdevice.h	Thu Mar 11 10:36:47 2004
@@ -489,6 +489,20 @@
  */
 #define SET_NETDEV_DEV(net, pdev)	((net)->class_dev.dev = (pdev))
 
+
+static inline netdev_sysfs_add_group(struct net_device *dev,
+				     const struct attribute_group *grp)
+{
+	return sysfs_create_group(&net->class_dev.kobj, grp);
+}
+
+static inline netdev_sysfs_remove_group(struct net_device *dev,
+				     const struct attribute_group *grp)
+{
+	sysfs_remove_group(&net->class_dev.kobj, grp);
+}
+
+
 struct packet_type {
 	unsigned short		type;	/* This is really htons(ether_type).	*/
 	struct net_device		*dev;	/* NULL is wildcarded here		*/

-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
