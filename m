Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUIAP6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUIAP6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbUIAP6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:58:19 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:58290 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267254AbUIAPvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:43 -0400
Date: Wed, 1 Sep 2004 16:51:20 +0100
Message-Id: <200409011551.i81FpKTj000595@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix potential leaks in pc300_tty driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that 'new' can be allocated, and next time around
the loop, if something goes wrong, we lose the reference..

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/wan/pc300_tty.c linux-2.6/drivers/net/wan/pc300_tty.c
--- bk-linus/drivers/net/wan/pc300_tty.c	2004-07-14 00:00:48.000000000 +0100
+++ linux-2.6/drivers/net/wan/pc300_tty.c	2004-08-23 14:08:15.000000000 +0100
@@ -789,6 +789,10 @@ void cpc_tty_receive(pc300dev_t *pc300de
 				cpc_writel(card->hw.scabase + DRX_REG(EDAL, ch), 
 						RX_BD_ADDR(ch, pc300chan->rx_last_bd)); 
 			}
+			if (new) {
+				kfree(new);
+				new = NULL;
+			}
 			return; 
 		}
 		
@@ -834,7 +838,8 @@ void cpc_tty_receive(pc300dev_t *pc300de
 						cpc_tty->name);
 				cpc_tty_rx_disc_frame(pc300chan);
 				rx_len = 0;
-				kfree((unsigned char *)new);
+				kfree(new);
+				new = NULL;
 				break; /* read next frame - while(1) */
 			}
 
@@ -843,7 +848,8 @@ void cpc_tty_receive(pc300dev_t *pc300de
 				cpc_tty_rx_disc_frame(pc300chan);
 				stats->rx_dropped++; 
 				rx_len = 0; 
-				kfree((unsigned char *)new);
+				kfree(new);
+				new = NULL;
 				break; /* read next frame - while(1) */
 			}
 
