Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUDPUS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbUDPUSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:18:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:8142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263756AbUDPUQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:16:44 -0400
Date: Fri, 16 Apr 2004 13:16:33 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: "Paul Rolland" <rol@witbe.net>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [2.6.5] Bad scheduling while atomic
Message-Id: <20040416131633.1bfbfa4c@dell_ss3.pdx.osdl.net>
In-Reply-To: <200404161551.i3GFpD124970@tag.witbe.net>
References: <200404161551.i3GFpD124970@tag.witbe.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bring up/down network devices with lapbether causes scheduling while
atomic (if preempt enabled).

The calls to rcu_read_lock are unnecessary since lapb_device_event 
is called from notifier with the rtnetlink semaphore held, it is
already protected from the labp_devices list changing.

Patch against 2.6.6-rc1

diff -Nru a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
--- a/drivers/net/wan/lapbether.c	Fri Apr 16 11:00:35 2004
+++ b/drivers/net/wan/lapbether.c	Fri Apr 16 11:00:35 2004
@@ -392,6 +392,8 @@
 
 /*
  *	Handle device status changes.
+ *
+ * Called from notifier with RTNL held.
  */
 static int lapbeth_device_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
@@ -402,7 +404,6 @@
 	if (!dev_is_ethdev(dev))
 		return NOTIFY_DONE;
 
-	rcu_read_lock();
 	switch (event) {
 	case NETDEV_UP:
 		/* New ethernet device -> new LAPB interface	 */
@@ -422,7 +423,6 @@
 			lapbeth_free_device(lapbeth);
 		break;
 	}
-	rcu_read_unlock();
 
 	return NOTIFY_DONE;
 }
