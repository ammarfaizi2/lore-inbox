Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263427AbVCEAno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbVCEAno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263512AbVCEAjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:39:49 -0500
Received: from palrel10.hp.com ([156.153.255.245]:992 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263522AbVCEA03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:26:29 -0500
Date: Fri, 4 Mar 2005 16:26:21 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] stir4200 turnaround calculation fix
Message-ID: <20050305002621.GD23895@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir261_stir_turn.diff :
~~~~~~~~~~~~~~~~~~~~
		<Patch from John K. Luebs>
	o [CORRECT] Proper turnaround computations in the stir4200 driver
	o [CORRECT] Take care of Tx packet without IrDA metadata (speed)
Signed-off-by: John K. Luebs <jkluebs@lu...>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/drivers/net/irda/stir4200.d0.c  linux/drivers/net/irda/stir4200.c
--- linux/drivers/net/irda/stir4200.d0.c	Mon Feb  7 16:35:45 2005
+++ linux/drivers/net/irda/stir4200.c	Mon Feb  7 16:37:25 2005
@@ -671,7 +671,8 @@ static void turnaround_delay(const struc
 		return;
 
 	do_gettimeofday(&now);
-	us -= (now.tv_sec - stir->rx_time.tv_sec) * USEC_PER_SEC;
+	if (now.tv_sec - stir->rx_time.tv_sec > 0)
+		us -= USEC_PER_SEC;
 	us -= now.tv_usec - stir->rx_time.tv_usec;
 	if (us < 10)
 		return;
@@ -787,7 +788,7 @@ static int stir_transmit_thread(void *ar
 				stir_send(stir, skb);
 			dev_kfree_skb(skb);
 
-			if (stir->speed != new_speed) {
+			if ((new_speed != -1) && (stir->speed != new_speed)) {
 				if (fifo_txwait(stir, -1) ||
 				    change_speed(stir, new_speed))
 					break;
