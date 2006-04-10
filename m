Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWDJF3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWDJF3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWDJF3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:29:49 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20433 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750780AbWDJF3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:29:48 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] deinline a few large functions in vlan code
Date: Mon, 10 Apr 2006 08:28:20 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, jgarzik@pobox.com
References: <200604071628.30486.vda@ilport.com.ua> <20060407.132511.09521964.davem@davemloft.net>
In-Reply-To: <20060407.132511.09521964.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604100828.20994.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 23:25, David S. Miller wrote:
> From: Denis Vlasenko <vda@ilport.com.ua>
> Date: Fri, 7 Apr 2006 16:28:30 +0300
> 
> > What should be done with this?
> > 1) Should I add respective select statements into Kconfigs
> >    of those drivers?
> > 2) Make vlan_dev non-modular?
> > 3) Move functions to another .c file?
> 
> 4) Leave it inline.

Ok, I will leave them alone for now.

BTW, does it make any sense for a network driver to call
these functions in non-VLAN-enbled kernel?

IOW: shouldn't calls to these functions sit in
#if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
block? For example, typhoon.c:

                spin_lock(&tp->state_lock);
+#if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
                if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
                        vlan_hwaccel_receive_skb(new_skb, tp->vlgrp,
                                                 ntohl(rx->vlanTag) & 0xffff);
                else
+#endif
                        netif_receive_skb(new_skb);
                spin_unlock(&tp->state_lock);

Same for s2io.c, chelsio/sge.c, etc...
--
vda
