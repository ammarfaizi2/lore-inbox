Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbUBJHbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUBJHbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:31:06 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:32405 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265686AbUBJHbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:31:03 -0500
Date: Tue, 10 Feb 2004 16:30:23 +0900 (JST)
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: [PATCH] packet_sendmsg_spkt incorrectly truncates an interface name
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, maeda.naoaki@jp.fujitsu.com
Message-id: <20040210.163023.112606425.maeda@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: Mew version 2.2 on Emacs 20.3 / Mule 4.0 (HANANOEN)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I renamed a network interface name with long name such as heartbeat.eth1,
DHCP client failed to assign an IP address to the interface. 

Problem is that packet_sendmsg_spkt() truncates an interface name 
by 12 characters. That is why the following dev_get_by_name() fails to find
the corresponding net_device structure.

Obviously, max name length of a network interface name is IFNAMESIZ-1, 
which is 15. I can not come up with any reasonable reason that
packet_sendmsg_spkt() should truncate the interface name by 12.
I guess it is just a trivial bug.

The following patch fix the problem.

Thanks,
Naoaki

diff -Naur linux-2.6.2.org/net/packet/af_packet.c linux-2.6.2/net/packet/af_packet.c
--- linux-2.6.2.org/net/packet/af_packet.c	2004-02-10 15:29:14.160320269 +0900
+++ linux-2.6.2/net/packet/af_packet.c	2004-02-10 15:29:52.656413548 +0900
@@ -311,7 +311,7 @@
 	 *	Find the device first to size check it 
 	 */
 
-	saddr->spkt_device[13] = 0;
+	saddr->spkt_device[IFNAMSIZ-1] = 0;
 	dev = dev_get_by_name(saddr->spkt_device);
 	err = -ENODEV;
 	if (dev == NULL)
