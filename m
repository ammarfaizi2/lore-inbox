Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTIHWQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTIHWQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:16:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12776 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263698AbTIHWPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:15:43 -0400
Message-ID: <3F5CFF7E.1090005@pobox.com>
Date: Mon, 08 Sep 2003 18:15:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Sven-Haegar Koch <haegar@sdinet.de>
CC: netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: ifconfig up/down problem
References: <Pine.LNX.4.56.0309090004100.24700@space.comunit.de>
In-Reply-To: <Pine.LNX.4.56.0309090004100.24700@space.comunit.de>
Content-Type: multipart/mixed;
 boundary="------------030300040602060006010804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030300040602060006010804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sven-Haegar Koch wrote:
> hi...
> 
> Short: ifconfig ethX down locks
> 
> Kernel: 2.4.22-bk12 (same problem with 2.4.23-pre3)
> eth0: eepro100
> eth1: orinoco_cs (orinoco mini-pci)
> System: Toshiba Satellite Pro 4600 Laptop, P3 700Mhz
> 
> Just after booting, no X startet yet, interface not yet initialized:
> 
> aurora:~# ifconfig eth1 down
> aurora:~# ifconfig eth1 up
> aurora:~# ifconfig eth1 down
> aurora:~# ifconfig eth1 up
> aurora:~# ifconfig eth1 down
> <--lock here, shell does not return, even ctrl-c does not help
> 
> haegar@aurora:~$ ps axl|grep ifconfig
> 4     0  1041  1035   9   0  1448  404 dev_cl S    pts/0      0:00 ifconfig eth1
> 
> top shows ifconfig consuming 100% cpu, 100% system
> 
> The same happens with eth0, there it takes only two up/down cycles,
> perhaps because it is already configured with ipv4+ipv6 addresses, and the
> same happens using '/sbin/ip link set eth0 up/down' too.
> 
> Kernel 2.4.20-pre2-ac3 is ok (my last kernel, running for month')



Does the attached patch fix it?

	Jeff



--------------030300040602060006010804
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Mon Sep  8 18:14:36 2003
+++ b/net/core/dev.c	Mon Sep  8 18:14:36 2003
@@ -851,7 +851,11 @@
 	 * engine, but this requires more changes in devices. */
 
 	smp_mb__after_clear_bit(); /* Commit netif_running(). */
-	netif_poll_disable(dev);
+	while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
+		/* No hurry. */
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(1);
+	}
 
 	/*
 	 *	Call the device specific close. This cannot fail.

--------------030300040602060006010804--

