Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVCZON6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVCZON6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 09:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVCZON5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 09:13:57 -0500
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:43201 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S262088AbVCZONr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 09:13:47 -0500
Message-ID: <42456E1B.9070000@stud.feec.vutbr.cz>
Date: Sat, 26 Mar 2005 15:13:47 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Julien Wajsberg <julien.wajsberg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
References: <2a0fbc59050325145935a05521@mail.gmail.com>	 <1111792854.23430.32.camel@mindpipe> <2a0fbc5905032516174f064e23@mail.gmail.com>
In-Reply-To: <2a0fbc5905032516174f064e23@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------050602070009030802050007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050602070009030802050007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Julien Wajsberg wrote:
> Good point... I just tried, but forcedeth doesn't support netpoll. If
> you have a pointer, I could try to implement it ;-)

Can you try the attached patch for forcedeth?
It compiles for me, but I don't have nForce hardware to test it.

Michal

--------------050602070009030802050007
Content-Type: text/plain;
 name="forcedeth-netpoll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="forcedeth-netpoll.patch"

--- linux-2.6.12-rc1/drivers/net/forcedeth.c.orig	2005-03-26 15:00:12.000000000 +0100
+++ linux-2.6.12-rc1/drivers/net/forcedeth.c	2005-03-26 15:08:56.000000000 +0100
@@ -1480,6 +1480,13 @@ static void nv_do_nic_poll(unsigned long
 	enable_irq(dev->irq);
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void nv_poll_controller(struct net_device *dev)
+{
+	nv_do_nic_poll((long) dev);
+}
+#endif
+
 static void nv_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
 	struct fe_priv *np = get_nvpriv(dev);
@@ -1962,6 +1969,9 @@ static int __devinit nv_probe(struct pci
 	dev->get_stats = nv_get_stats;
 	dev->change_mtu = nv_change_mtu;
 	dev->set_multicast_list = nv_set_multicast;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = nv_poll_controller;
+#endif
 	SET_ETHTOOL_OPS(dev, &ops);
 	dev->tx_timeout = nv_tx_timeout;
 	dev->watchdog_timeo = NV_WATCHDOG_TIMEO;

--------------050602070009030802050007--
