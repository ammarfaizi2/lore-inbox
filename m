Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUBNNAk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 08:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUBNNAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 08:00:40 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:27363 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261889AbUBNNAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 08:00:36 -0500
Date: Sat, 14 Feb 2004 13:56:09 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: jt@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 2.6 IrDA] new driver : stir4200
Message-ID: <20040214135609.A19450@electric-eye.fr.zoreil.com>
References: <20040214015059.GA25979@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040214015059.GA25979@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Fri, Feb 13, 2004 at 05:50:59PM -0800
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jean Tourrilhes <jt@bougret.hpl.hp.com> :
[...]
> 	After a long maturation, this is time to send you the latest
> version of the stir4200 USB driver. Initially started by Paul Stewart,
> modified by Martin Diehl and me, and later partially rewriten by
> Stephen Hemminger.

Fix + minor change attached.

--
Ueimor

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stir4200-bad-return-status.patch"


If stir_reset() succeeds, stir_net_open() must not return a success status
code for every failure until irlap_open().


 drivers/net/irda/stir4200.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/net/irda/stir4200.c~stir4200-bad-return-status drivers/net/irda/stir4200.c
--- linux-2.6.3-rc1-mm1/drivers/net/irda/stir4200.c~stir4200-bad-return-status	2004-02-14 13:35:21.000000000 +0100
+++ linux-2.6.3-rc1-mm1-fr/drivers/net/irda/stir4200.c	2004-02-14 13:48:57.000000000 +0100
@@ -913,6 +913,8 @@ static int stir_net_open(struct net_devi
 	if (err)
 		goto err_out1;
 
+	err = -ENOMEM;
+
 	/* Note: Max SIR frame possible is 4273 */
 	stir->tx_data = kmalloc(STIR_FIFO_SIZE, GFP_KERNEL);
 	if (!stir->tx_data) {
@@ -956,7 +958,6 @@ static int stir_net_open(struct net_devi
 	 * Note : will send immediately a speed change...
 	 */
 	sprintf(hwname, "usb#%d", stir->usbdev->devnum);
-	err = -ENOMEM;
 	stir->irlap = irlap_open(netdev, &stir->qos, hwname);
 	if (!stir->irlap) {
 		ERROR("%s(): irlap_open failed\n", __FUNCTION__);

_

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stir4200-late-netif-start-queue.patch"


Defer netif_start_queue() until device opening succeeds.


 drivers/net/irda/stir4200.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/net/irda/stir4200.c~stir4200-late-netif-start-queue drivers/net/irda/stir4200.c
--- linux-2.6.3-rc1-mm1/drivers/net/irda/stir4200.c~stir4200-late-netif-start-queue	2004-02-14 13:35:47.000000000 +0100
+++ linux-2.6.3-rc1-mm1-fr/drivers/net/irda/stir4200.c	2004-02-14 13:36:33.000000000 +0100
@@ -950,8 +950,6 @@ static int stir_net_open(struct net_devi
 		}
 	}
 
-	netif_start_queue(netdev);
-
 	/*
 	 * Now that everything should be initialized properly,
 	 * Open new IrLAP layer instance to take care of us...
@@ -974,6 +972,8 @@ static int stir_net_open(struct net_devi
 		goto err_out4;
 	}
 
+	netif_start_queue(netdev);
+
 	return 0;
 
  err_out4:

_

--TB36FDmn/VVEgNH/--
