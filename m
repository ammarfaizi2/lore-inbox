Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVB1OIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVB1OIC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVB1OGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:06:24 -0500
Received: from lumumba.luc.ac.be ([193.190.9.252]:62990 "EHLO
	lumumba.luc.ac.be") by vger.kernel.org with ESMTP id S261611AbVB1OBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:01:45 -0500
Date: Mon, 28 Feb 2005 15:01:45 +0100
From: Panagiotis Issaris <takis@lumumba.luc.ac.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SA9730 cleanup or fix
Message-ID: <20050228150145.C32550@lumumba.luc.ac.be>
Reply-To: panagiotis.issaris@mech.kuleuven.ac.be
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

In the SAA9730 driver the lan_saa9730_start() function always returns
zero which makes the if/return code unnecessary.

The first patch removes this check.

In case it is suspected that the lan_saa9730_start() function might be
modified in the future, causing it to be possible to return values other
then zero, then the second patch -replacing the previous one- fixes the
problem that in that case the requested irq is not being freed.

Both patches apply to 2.6.11-rc5-bk2.

With friendly regards,
Takis
-- 
OpenPGP key: http://lumumba.luc.ac.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pi-20050228T134601-linux-saa9730.diff"

diff -uprN linux-2.6.11-rc5-bk2/drivers/net/saa9730.c linux-2.6.11-rc5-bk2-pi/drivers/net/saa9730.c
--- linux-2.6.11-rc5-bk2/drivers/net/saa9730.c	2005-02-28 13:44:53.000000000 +0100
+++ linux-2.6.11-rc5-bk2-pi/drivers/net/saa9730.c	2005-02-28 13:45:23.000000000 +0100
@@ -815,9 +815,8 @@ static int lan_saa9730_open(struct net_d
 	evm_saa9730_enable_lan_int(lp);
 
 	/* Start the LAN controller */
-	if (lan_saa9730_start(lp))
-		return -1;
-
+	lan_saa9730_start(lp);
+	
 	netif_start_queue(dev);
 
 	return 0;

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pi-20050228T145542-linux-saa9730.diff"

diff -uprN linux-2.6.11-rc5-bk2/drivers/net/saa9730.c linux-2.6.11-rc5-bk2-pi/drivers/net/saa9730.c
--- linux-2.6.11-rc5-bk2/drivers/net/saa9730.c	2005-02-28 13:44:53.000000000 +0100
+++ linux-2.6.11-rc5-bk2-pi/drivers/net/saa9730.c	2005-02-28 14:56:17.000000000 +0100
@@ -816,8 +816,11 @@ static int lan_saa9730_open(struct net_d
 
 	/* Start the LAN controller */
 	if (lan_saa9730_start(lp))
+	{
+		free_irq(dev->irq, (void *) dev);
 		return -1;
-
+	}
+	
 	netif_start_queue(dev);
 
 	return 0;

--NzB8fVQJ5HfG6fxh--
