Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbVJMTX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbVJMTX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbVJMTX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:23:56 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:34679 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751640AbVJMTXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:23:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=eHLzY6yONcCwXKF/LYEwvshKPhbgtQ041DLEFusofuIg368WxKLpVJJ7qJqZ52tGdq3PHWmg5rAiTlEOoHZtkr6gACm9rTp8zC5scFFldSZC277nB2tQMG0cPiw7xydj0ppS9vlNLqaIEq/Bn7EiMie4SNkV+ztchsXulpR7nbs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/14] Big kfree NULL check cleanup - drivers/char
Date: Thu, 13 Oct 2005 21:26:47 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jj@ultra.linux.cz>,
       David Airlie <airlied@linux.ie>, "David S. Miller" <davem@redhat.com>,
       Greg Ungerer <gerg@uclinux.org>, Paul Fulghum <paulkf@microgate.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132126.48240.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the drivers/char/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in drivers/char/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 drivers/char/consolemap.c         |   12 +++++-------
 drivers/char/drm/ffb_context.c    |    6 ++----
 drivers/char/drm/ffb_drv.c        |    4 ++--
 drivers/char/ip2/i2ellis.c        |    4 +---
 drivers/char/istallion.c          |    7 +++----
 drivers/char/n_hdlc.c             |    3 +--
 drivers/char/pcmcia/synclink_cs.c |    3 +--
 drivers/char/rocket.c             |    6 ++----
 drivers/char/selection.c          |    3 +--
 drivers/char/stallion.c           |    6 ++----
 drivers/char/synclink.c           |   10 +++-------
 drivers/char/synclinkmp.c         |    9 +++------
 drivers/char/tty_io.c             |    9 +++------
 13 files changed, 29 insertions(+), 53 deletions(-)

--- linux-2.6.14-rc4-orig/drivers/char/drm/ffb_drv.c	2005-10-11 22:41:05.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/drm/ffb_drv.c	2005-10-12 16:32:28.000000000 +0200
@@ -248,12 +248,12 @@ static void ffb_driver_release(drm_devic
 
 static void ffb_driver_pretakedown(drm_device_t *dev)
 {
-	if (dev->dev_private) kfree(dev->dev_private);
+	kfree(dev->dev_private);
 }
 
 static int ffb_driver_postcleanup(drm_device_t *dev)
 {
-	if (ffb_position != NULL) kfree(ffb_position);
+	kfree(ffb_position);
 	return 0;
 }
 
--- linux-2.6.14-rc4-orig/drivers/char/drm/ffb_context.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/drm/ffb_context.c	2005-10-12 16:33:22.000000000 +0200
@@ -531,10 +531,8 @@ int ffb_driver_rmctx(struct inode *inode
 	if (idx < 0 || idx >= FFB_MAX_CTXS)
 		return -EINVAL;
 
-	if (fpriv->hw_state[idx] != NULL) {
-		kfree(fpriv->hw_state[idx]);
-		fpriv->hw_state[idx] = NULL;
-	}
+	kfree(fpriv->hw_state[idx]);
+	fpriv->hw_state[idx] = NULL;
 	return 0;
 }
 
--- linux-2.6.14-rc4-orig/drivers/char/ip2/i2ellis.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/ip2/i2ellis.c	2005-10-12 16:34:03.000000000 +0200
@@ -106,9 +106,7 @@ iiEllisInit(void)
 static void
 iiEllisCleanup(void)
 {
-	if ( pDelayTimer != NULL ) {
-		kfree ( pDelayTimer );
-	}
+	kfree(pDelayTimer);
 }
 
 //******************************************************************************
--- linux-2.6.14-rc4-orig/drivers/char/synclinkmp.c	2005-10-11 22:41:07.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/synclinkmp.c	2005-10-12 16:34:30.000000000 +0200
@@ -2787,10 +2787,8 @@ static void shutdown(SLMP_INFO * info)
 	del_timer(&info->tx_timer);
 	del_timer(&info->status_timer);
 
-	if (info->tx_buf) {
-		kfree(info->tx_buf);
-		info->tx_buf = NULL;
-	}
+	kfree(info->tx_buf);
+	info->tx_buf = NULL;
 
 	spin_lock_irqsave(&info->lock,flags);
 
@@ -3610,8 +3608,7 @@ int alloc_tmp_rx_buf(SLMP_INFO *info)
 
 void free_tmp_rx_buf(SLMP_INFO *info)
 {
-	if (info->tmp_rx_buf)
-		kfree(info->tmp_rx_buf);
+	kfree(info->tmp_rx_buf);
 	info->tmp_rx_buf = NULL;
 }
 
--- linux-2.6.14-rc4-orig/drivers/char/istallion.c	2005-10-11 22:41:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/istallion.c	2005-10-12 16:35:36.000000000 +0200
@@ -860,10 +860,9 @@ static void __exit istallion_module_exit
 	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
-	if (stli_tmpwritebuf != (char *) NULL)
-		kfree(stli_tmpwritebuf);
-	if (stli_txcookbuf != (char *) NULL)
-		kfree(stli_txcookbuf);
+
+	kfree(stli_tmpwritebuf);
+	kfree(stli_txcookbuf);
 
 	for (i = 0; (i < stli_nrbrds); i++) {
 		if ((brdp = stli_brds[i]) == (stlibrd_t *) NULL)
--- linux-2.6.14-rc4-orig/drivers/char/selection.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/selection.c	2005-10-12 16:35:43.000000000 +0200
@@ -246,8 +246,7 @@ int set_selection(const struct tiocl_sel
 		clear_selection();
 		return -ENOMEM;
 	}
-	if (sel_buffer)
-		kfree(sel_buffer);
+	kfree(sel_buffer);
 	sel_buffer = bp;
 
 	obp = bp;
--- linux-2.6.14-rc4-orig/drivers/char/rocket.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/rocket.c	2005-10-12 16:36:05.000000000 +0200
@@ -2517,10 +2517,8 @@ static void rp_cleanup_module(void)
 		       "rocketport driver\n", -retval);
 	put_tty_driver(rocket_driver);
 
-	for (i = 0; i < MAX_RP_PORTS; i++) {
-		if (rp_table[i])
-			kfree(rp_table[i]);
-	}
+	for (i = 0; i < MAX_RP_PORTS; i++)
+		kfree(rp_table[i]);
 
 	for (i = 0; i < NUM_BOARDS; i++) {
 		if (rcktpt_io_addr[i] <= 0 || is_PCI[i])
--- linux-2.6.14-rc4-orig/drivers/char/stallion.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/stallion.c	2005-10-12 16:37:30.000000000 +0200
@@ -785,8 +785,7 @@ static void __exit stallion_module_exit(
 			"errno=%d\n", -i);
 	class_destroy(stallion_class);
 
-	if (stl_tmpwritebuf != (char *) NULL)
-		kfree(stl_tmpwritebuf);
+	kfree(stl_tmpwritebuf);
 
 	for (i = 0; (i < stl_nrbrds); i++) {
 		if ((brdp = stl_brds[i]) == (stlbrd_t *) NULL)
@@ -804,8 +803,7 @@ static void __exit stallion_module_exit(
 					continue;
 				if (portp->tty != (struct tty_struct *) NULL)
 					stl_hangup(portp->tty);
-				if (portp->tx.buf != (char *) NULL)
-					kfree(portp->tx.buf);
+				kfree(portp->tx.buf);
 				kfree(portp);
 			}
 			kfree(panelp);
--- linux-2.6.14-rc4-orig/drivers/char/tty_io.c	2005-10-11 22:41:08.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/tty_io.c	2005-10-12 16:38:55.000000000 +0200
@@ -1416,14 +1416,11 @@ end_init:
 
 	/* Release locally allocated memory ... nothing placed in slots */
 free_mem_out:
-	if (o_tp)
-		kfree(o_tp);
+	kfree(o_tp);
 	if (o_tty)
 		free_tty_struct(o_tty);
-	if (ltp)
-		kfree(ltp);
-	if (tp)
-		kfree(tp);
+	kfree(ltp);
+	kfree(tp);
 	free_tty_struct(tty);
 
 fail_no_mem:
--- linux-2.6.14-rc4-orig/drivers/char/pcmcia/synclink_cs.c	2005-10-11 22:41:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/pcmcia/synclink_cs.c	2005-10-12 16:39:05.000000000 +0200
@@ -2994,8 +2994,7 @@ int rx_alloc_buffers(MGSLPC_INFO *info)
 
 void rx_free_buffers(MGSLPC_INFO *info)
 {
-	if (info->rx_buf)
-		kfree(info->rx_buf);
+	kfree(info->rx_buf);
 	info->rx_buf = NULL;
 }
 
--- linux-2.6.14-rc4-orig/drivers/char/n_hdlc.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/n_hdlc.c	2005-10-12 16:39:50.000000000 +0200
@@ -264,8 +264,7 @@ static void n_hdlc_release(struct n_hdlc
 		} else
 			break;
 	}
-	if (n_hdlc->tbuf)
-		kfree(n_hdlc->tbuf);
+	kfree(n_hdlc->tbuf);
 	kfree(n_hdlc);
 	
 }	/* end of n_hdlc_release() */
--- linux-2.6.14-rc4-orig/drivers/char/synclink.c	2005-10-11 22:41:07.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/synclink.c	2005-10-12 16:41:14.000000000 +0200
@@ -4015,9 +4015,7 @@ static int mgsl_alloc_intermediate_rxbuf
  */
 static void mgsl_free_intermediate_rxbuffer_memory(struct mgsl_struct *info)
 {
-	if ( info->intermediate_rxbuffer )
-		kfree(info->intermediate_rxbuffer);
-
+	kfree(info->intermediate_rxbuffer);
 	info->intermediate_rxbuffer = NULL;
 
 }	/* end of mgsl_free_intermediate_rxbuffer_memory() */
@@ -4071,10 +4069,8 @@ static void mgsl_free_intermediate_txbuf
 	int i;
 
 	for ( i=0; i<info->num_tx_holding_buffers; ++i ) {
-		if ( info->tx_holding_buffers[i].buffer ) {
-				kfree(info->tx_holding_buffers[i].buffer);
-				info->tx_holding_buffers[i].buffer=NULL;
-		}
+		kfree(info->tx_holding_buffers[i].buffer);
+		info->tx_holding_buffers[i].buffer = NULL;
 	}
 
 	info->get_tx_holding_index = 0;
--- linux-2.6.14-rc4-orig/drivers/char/consolemap.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/consolemap.c	2005-10-12 16:41:59.000000000 +0200
@@ -345,17 +345,15 @@ static void con_release_unimap(struct un
 	for (i = 0; i < 32; i++) {
 		if ((p1 = p->uni_pgdir[i]) != NULL) {
 			for (j = 0; j < 32; j++)
-				if (p1[j])
-					kfree(p1[j]);
+				kfree(p1[j]);
 			kfree(p1);
 		}
 		p->uni_pgdir[i] = NULL;
 	}
-	for (i = 0; i < 4; i++)
-		if (p->inverse_translations[i]) {
-			kfree(p->inverse_translations[i]);
-			p->inverse_translations[i] = NULL;
-		}
+	for (i = 0; i < 4; i++) {
+		kfree(p->inverse_translations[i]);
+		p->inverse_translations[i] = NULL;
+	}
 }
 
 void con_free_unimap(struct vc_data *vc)


