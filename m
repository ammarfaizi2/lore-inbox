Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTBUBIs>; Thu, 20 Feb 2003 20:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbTBUBIs>; Thu, 20 Feb 2003 20:08:48 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:42890 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S261292AbTBUBIs>; Thu, 20 Feb 2003 20:08:48 -0500
Date: Thu, 20 Feb 2003 20:18:46 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302210118.h1L1IkKw011688@locutus.cmf.nrl.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: [ATM] who 'owns' the skb created by drivers/atm?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


when one of the atm drivers has a skb ready to pass up to the higher 
layers it may (optionally?) fill in skb->cb.  this usually just holds
a pointer to the atm_vcc that the skb arrived on.  if this skb is
destined for an atm socket, all is well.  the trouble arises when the skb
is bound for the ip layer via lec or clip.  lec or clip just push
the skb up to the ip layer via netif_rx().  sometimes (particularly true
on 64-bit platforms) the ip layer will interpret the skb->cb (for ip
the first 4 bytes of skb->cb are the next hop address which isnt used
much apparently).

its my understanding is that you can't use skb->cb unless you created
the skb.  well atm created the skb and filled in ->cb.  it seems ip
doesn't know its sharing this skb with the atm layer and doesnt clone
the skb in ip_rcv().  there seems to be an implicit understanding that
skb's created by ethernet drivers are 'owned' by the ip layer and shouldnt
touch skb->cb.

i would hazard that the atm drivers are not 'owned' by the ip layer --
any skb's that lec or clip send to the ip layer should first cloned and
the clone passed to the ip layer?
