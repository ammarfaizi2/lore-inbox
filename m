Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVD1WTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVD1WTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVD1WTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:19:33 -0400
Received: from mail.dif.dk ([193.138.115.101]:62947 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262285AbVD1WTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:19:00 -0400
Date: Fri, 29 Apr 2005 00:22:22 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: netdev@oss.sgi.com
Cc: "David S. Miller" <davem@davemloft.net>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Regina Kodato <reginak@cyclades.com>, pc300@cyclades.com,
       Nenad Corbic <ncorbic@sangoma.com>, Henner Eisen <eis@baty.hanse.de>,
       linux-net@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] cleanups in drivers/net/wan/ - kfree of NULL pointer is
 valid
Message-ID: <Pine.LNX.4.62.0504290009310.2476@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kfree(0) is perfectly valid, checking pointers for NULL before calling 
kfree() on them is redundant. The patch below cleans away a few such 
redundant checks (and while I was around some of those bits I couldn't 
stop myself from making a few tiny whitespace changes as well).

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/net/wan/cycx_x25.c   |    8 ++------
 drivers/net/wan/pc300_tty.c  |   27 +++++++++++----------------
 drivers/net/wan/sdla_chdlc.c |   13 ++++---------
 drivers/net/wan/x25_asy.c    |   20 ++++++--------------
 4 files changed, 23 insertions(+), 45 deletions(-)

diff -uprN linux-2.6.12-rc2-mm3-orig/drivers/net/wan/cycx_x25.c linux-2.6.12-rc2-mm3/drivers/net/wan/cycx_x25.c
--- linux-2.6.12-rc2-mm3-orig/drivers/net/wan/cycx_x25.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/net/wan/cycx_x25.c	2005-04-28 23:51:12.000000000 +0200
@@ -436,9 +436,7 @@ static int cycx_wan_new_if(struct wan_de
 	}
 
 	if (err) {
-		if (chan->local_addr)
-			kfree(chan->local_addr);
-
+		kfree(chan->local_addr);
 		kfree(chan);
 		return err;
 	}
@@ -458,9 +456,7 @@ static int cycx_wan_del_if(struct wan_de
 		struct cycx_x25_channel *chan = dev->priv;
 
 		if (chan->svc) {
-			if (chan->local_addr)
-				kfree(chan->local_addr);
-
+			kfree(chan->local_addr);
 			if (chan->state == WAN_CONNECTED)
 				del_timer(&chan->timer);
 		}
diff -uprN linux-2.6.12-rc2-mm3-orig/drivers/net/wan/pc300_tty.c linux-2.6.12-rc2-mm3/drivers/net/wan/pc300_tty.c
--- linux-2.6.12-rc2-mm3-orig/drivers/net/wan/pc300_tty.c	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/net/wan/pc300_tty.c	2005-04-28 23:59:54.000000000 +0200
@@ -400,10 +400,8 @@ static void cpc_tty_close(struct tty_str
 		cpc_tty->buf_rx.last = NULL;
 	}
 	
-	if (cpc_tty->buf_tx) {
-		kfree(cpc_tty->buf_tx);
-		cpc_tty->buf_tx = NULL;
-	}
+	kfree(cpc_tty->buf_tx);
+	cpc_tty->buf_tx = NULL;
 
 	CPC_TTY_DBG("%s: TTY closed\n",cpc_tty->name);
 	
@@ -666,7 +664,7 @@ static void cpc_tty_rx_work(void * data)
 	unsigned long port;
 	int i, j;
 	st_cpc_tty_area *cpc_tty; 
-	volatile st_cpc_rx_buf * buf;
+	volatile st_cpc_rx_buf *buf;
 	char flags=0,flg_rx=1; 
 	struct tty_ldisc *ld;
 
@@ -680,9 +678,9 @@ static void cpc_tty_rx_work(void * data)
 			cpc_tty = &cpc_tty_area[port];
 		
 			if ((buf=cpc_tty->buf_rx.first) != 0) {
-				if(cpc_tty->tty) {
+				if (cpc_tty->tty) {
 					ld = tty_ldisc_ref(cpc_tty->tty);
-					if(ld) {
+					if (ld) {
 						if (ld->receive_buf) {
 							CPC_TTY_DBG("%s: call line disc. receive_buf\n",cpc_tty->name);
 							ld->receive_buf(cpc_tty->tty, (char *)(buf->data), &flags, buf->size);
@@ -691,7 +689,7 @@ static void cpc_tty_rx_work(void * data)
 					}
 				}	
 				cpc_tty->buf_rx.first = cpc_tty->buf_rx.first->next;
-				kfree((unsigned char *)buf);
+				kfree(buf);
 				buf = cpc_tty->buf_rx.first;
 				flg_rx = 1;
 			}
@@ -733,7 +731,7 @@ static void cpc_tty_rx_disc_frame(pc300c
 
 void cpc_tty_receive(pc300dev_t *pc300dev)
 {
-	st_cpc_tty_area    *cpc_tty; 
+	st_cpc_tty_area *cpc_tty; 
 	pc300ch_t *pc300chan = (pc300ch_t *)pc300dev->chan; 
 	pc300_t *card = (pc300_t *)pc300chan->card; 
 	int ch = pc300chan->channel; 
@@ -742,7 +740,7 @@ void cpc_tty_receive(pc300dev_t *pc300de
 	int rx_len, rx_aux; 
 	volatile unsigned char status; 
 	unsigned short first_bd = pc300chan->rx_first_bd;
-	st_cpc_rx_buf	*new=NULL;
+	st_cpc_rx_buf *new = NULL;
 	unsigned char dsr_rx;
 
 	if (pc300dev->cpc_tty == NULL) { 
@@ -762,7 +760,7 @@ void cpc_tty_receive(pc300dev_t *pc300de
 			if (status & DST_EOM) {
 				break;
 			}
-			ptdescr=(pcsca_bd_t __iomem *)(card->hw.rambase+cpc_readl(&ptdescr->next));
+			ptdescr = (pcsca_bd_t __iomem *)(card->hw.rambase+cpc_readl(&ptdescr->next));
 		}
 			
 		if (!rx_len) { 
@@ -771,10 +769,7 @@ void cpc_tty_receive(pc300dev_t *pc300de
 				cpc_writel(card->hw.scabase + DRX_REG(EDAL, ch), 
 						RX_BD_ADDR(ch, pc300chan->rx_last_bd)); 
 			}
-			if (new) {
-				kfree(new);
-				new = NULL;
-			}
+			kfree(new);
 			return; 
 		}
 		
@@ -787,7 +782,7 @@ void cpc_tty_receive(pc300dev_t *pc300de
 			continue;
 		} 
 		
-		new = (st_cpc_rx_buf *) kmalloc(rx_len + sizeof(st_cpc_rx_buf), GFP_ATOMIC);
+		new = (st_cpc_rx_buf *)kmalloc(rx_len + sizeof(st_cpc_rx_buf), GFP_ATOMIC);
 		if (new == 0) {
 			cpc_tty_rx_disc_frame(pc300chan);
 			continue;
diff -uprN linux-2.6.12-rc2-mm3-orig/drivers/net/wan/sdla_chdlc.c linux-2.6.12-rc2-mm3/drivers/net/wan/sdla_chdlc.c
--- linux-2.6.12-rc2-mm3-orig/drivers/net/wan/sdla_chdlc.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/net/wan/sdla_chdlc.c	2005-04-29 00:03:30.000000000 +0200
@@ -3664,15 +3664,10 @@ static void wanpipe_tty_close(struct tty
 		chdlc_disable_comm_shutdown(card);
 		unlock_adapter_irq(&card->wandev.lock,&smp_flags);
 
-		if (card->tty_buf){
-			kfree(card->tty_buf);
-			card->tty_buf=NULL;			
-		}
-
-		if (card->tty_rx){
-			kfree(card->tty_rx);
-			card->tty_rx=NULL;
-		}
+		kfree(card->tty_buf);
+		card->tty_buf = NULL;			
+		kfree(card->tty_rx);
+		card->tty_rx = NULL;
 	}
 	return;
 }
diff -uprN linux-2.6.12-rc2-mm3-orig/drivers/net/wan/x25_asy.c linux-2.6.12-rc2-mm3/drivers/net/wan/x25_asy.c
--- linux-2.6.12-rc2-mm3-orig/drivers/net/wan/x25_asy.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/net/wan/x25_asy.c	2005-04-29 00:08:16.000000000 +0200
@@ -107,13 +107,9 @@ static struct x25_asy *x25_asy_alloc(voi
 static void x25_asy_free(struct x25_asy *sl)
 {
 	/* Free all X.25 frame buffers. */
-	if (sl->rbuff)  {
-		kfree(sl->rbuff);
-	}
+	kfree(sl->rbuff);
 	sl->rbuff = NULL;
-	if (sl->xbuff)  {
-		kfree(sl->xbuff);
-	}
+	kfree(sl->xbuff);
 	sl->xbuff = NULL;
 
 	if (!test_and_clear_bit(SLF_INUSE, &sl->flags)) {
@@ -134,10 +130,8 @@ static int x25_asy_change_mtu(struct net
 	{
 		printk("%s: unable to grow X.25 buffers, MTU change cancelled.\n",
 		       dev->name);
-		if (xbuff != NULL)  
-			kfree(xbuff);
-		if (rbuff != NULL)  
-			kfree(rbuff);
+		kfree(xbuff);
+		kfree(rbuff);
 		return -ENOMEM;
 	}
 
@@ -169,10 +163,8 @@ static int x25_asy_change_mtu(struct net
 
 	spin_unlock_bh(&sl->lock);
 
-	if (xbuff != NULL) 
-		kfree(xbuff);
-	if (rbuff != NULL)
-		kfree(rbuff);
+	kfree(xbuff);
+	kfree(rbuff);
 	return 0;
 }
 


