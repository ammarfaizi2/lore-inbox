Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263797AbTDDRnW (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbTDDQke (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 11:40:34 -0500
Received: from [12.148.143.187] ([12.148.143.187]:42994 "EHLO
	sendmail.intrusion.com") by vger.kernel.org with ESMTP
	id S263834AbTDDQgP (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 11:36:15 -0500
Message-ID: <636A9B29EA94BC4194D844C27A3B1AAB03FC7D15@mercury.intrusion.com>
From: "Corbett, David" <corbett@intrusion.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Jeff Garzik'" <jgarzik@pobox.com>
Subject: RE: sis900 driver in 2.4.20 - "start_xmit" function - buffer full
	?
Date: Fri, 4 Apr 2003 10:41:08 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking at the sis900.c in the 2.4.20 kernel. I ran across something 
that doesn't look right. (Yes, I plan to fix it and test it, but I haven't
had time to do that yet - I've been busy!!!) I thought that I would 
present the issue here. Perhaps the author of the code for this area
will be able to shed some light on whether there is something wrong with 
this code (or something wrong with me?! :-)

It appears that in sis900_start_xmit(), we erroneously detect the
transmit buffer full condition. Moreover, this function *always* 
thinks that the transmit buffer is full.

Here is the block from sis900_start_xmit, starting at line 1525:

      sis_priv->cur_tx ++;
	index_cur_tx = sis_priv->cur_tx;
	index_dirty_tx = sis_priv->dirty_tx;

	for (count_dirty_tx = 0; index_cur_tx != index_dirty_tx;
index_dirty_tx++)
		count_dirty_tx ++;

	if (index_cur_tx == index_dirty_tx) {
		/* dirty_tx is met in the cycle of cur_tx, buffer full */
		sis_priv->tx_full = 1;
		netif_stop_queue(net_dev);
	} else if (count_dirty_tx < NUM_TX_DESC) { 
		/* Typical path, tell upper layer that more transmission is
possible */
		netif_start_queue(net_dev);
	} else {
		/* buffer full, tell upper layer no more transmission */
		sis_priv->tx_full = 1;
		netif_stop_queue(net_dev);
	}

==================================================================

Here is a copy of the block above, where I have added some big
ugly comments:

static int
sis900_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
{
      {snip...}
	
      sis_priv->cur_tx ++;
	index_cur_tx = sis_priv->cur_tx;
	index_dirty_tx = sis_priv->dirty_tx;

	for (count_dirty_tx = 0; index_cur_tx != index_dirty_tx;
index_dirty_tx++)
		count_dirty_tx ++;
      
      // MY BIG FAT UGLY COMMENTS: Here, we have completed the for loop.
      // That for loop made sure that index_cur_tx is equal to 
      // index_dirty_tx. Thus, the condition in the "if" below will 
      // always be true. The other clauses are never used. We
      // will never take the "Typical path". Isn't this a problem?
      
	if (index_cur_tx == index_dirty_tx) {
		/* dirty_tx is met in the cycle of cur_tx, buffer full */
		sis_priv->tx_full = 1;
		netif_stop_queue(net_dev);
	} else if (count_dirty_tx < NUM_TX_DESC) { 
		/* Typical path, tell upper layer that more transmission is
possible */
		netif_start_queue(net_dev);
	} else {
		/* buffer full, tell upper layer no more transmission */
		sis_priv->tx_full = 1;
		netif_stop_queue(net_dev);
	}

==================================================================

I believe I know how this should be fixed; however, I will defer to the
masters.
I wanted to inform the community of this problem ASAP.
I hope that this helps. 

Regards,

David Corbett
