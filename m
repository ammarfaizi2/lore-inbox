Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269621AbUJLLm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbUJLLm1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269648AbUJLLm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:42:26 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:38298 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269621AbUJLLjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:39:45 -0400
Message-ID: <416BC26B.6090603@kolivas.org>
Date: Tue, 12 Oct 2004 21:39:23 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, davem@redhat.com
Subject: [PATCH] netconsole support for b44
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF1B4BCC7BECD9961E09478F3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF1B4BCC7BECD9961E09478F3
Content-Type: multipart/mixed;
 boundary="------------000801080201010709070804"

This is a multi-part message in MIME format.
--------------000801080201010709070804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds poll support to the b44 driver to allow netconsole 
support. Style lifted straight from 8139too.c

here is the dmesg output with it in place:

netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears flaky, waiting 10 seconds
b44: eth0: Link is down.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.
netconsole: network logging started

output confirmed by netcat on other system.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

--------------000801080201010709070804
Content-Type: text/x-patch;
 name="b44poll.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="b44poll.diff"

Index: linux-2.6.9-rc4-ck1/drivers/net/b44.c
===================================================================
--- linux-2.6.9-rc4-ck1.orig/drivers/net/b44.c	2004-10-11 16:15:59.000000000 +1000
+++ linux-2.6.9-rc4-ck1/drivers/net/b44.c	2004-10-12 21:18:39.492813689 +1000
@@ -97,6 +97,10 @@ MODULE_DEVICE_TABLE(pci, b44_pci_tbl);
 static void b44_halt(struct b44 *);
 static void b44_init_rings(struct b44 *);
 static void b44_init_hw(struct b44 *);
+static int b44_poll(struct net_device *dev, int *budget);
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void b44_poll_controller(struct net_device *dev);
+#endif
 
 static inline unsigned long br32(const struct b44 *bp, unsigned long reg)
 {
@@ -1297,6 +1301,19 @@ err_out_free:
 }
 #endif
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ * Polling receive - used by netconsole and other diagnostic tools
+ * to allow network i/o with interrupts disabled.
+ */
+static void b44_poll_controller(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	b44_interrupt (dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
+
 static int b44_close(struct net_device *dev)
 {
 	struct b44 *bp = netdev_priv(dev);
@@ -1793,6 +1810,9 @@ static int __devinit b44_init_one(struct
 	dev->poll = b44_poll;
 	dev->weight = 64;
 	dev->watchdog_timeo = B44_TX_TIMEOUT;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = b44_poll_controller;
+#endif
 	dev->change_mtu = b44_change_mtu;
 	dev->irq = pdev->irq;
 	SET_ETHTOOL_OPS(dev, &b44_ethtool_ops);

--------------000801080201010709070804--

--------------enigF1B4BCC7BECD9961E09478F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBa8JuZUg7+tp6mRURAluDAJ9ETtCgIW2cVujxoZJmSD3hxzYHTgCgkgxl
J8kFfVLNaPiAkmKJb745Q04=
=PnF3
-----END PGP SIGNATURE-----

--------------enigF1B4BCC7BECD9961E09478F3--
