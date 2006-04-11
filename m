Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWDKJtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWDKJtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 05:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWDKJtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 05:49:46 -0400
Received: from mail.axxeo.de ([82.100.226.146]:34247 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1750704AbWDKJtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 05:49:45 -0400
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: [PATCH] deinline a few large functions in vlan code v2
Date: Tue, 11 Apr 2006 11:49:24 +0200
User-Agent: KMail/1.7.2
Cc: Dave Dillow <dave@thedillows.org>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
References: <200604071628.30486.vda@ilport.com.ua> <1144682807.12177.22.camel@dillow.idleaire.com> <200604111028.54813.vda@ilport.com.ua>
In-Reply-To: <200604111028.54813.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604111149.24862.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

Denis Vlasenko wrote:
> +#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
>  	if(vlan_tx_tag_present(skb)) {
>  		first_txd->processFlags |=
>  		    TYPHOON_TX_PF_INSERT_VLAN | TYPHOON_TX_PF_VLAN_PRIORITY;
> @@ -844,6 +849,7 @@ typhoon_start_tx(struct sk_buff *skb, st
>  		    cpu_to_le32(htons(vlan_tx_tag_get(skb)) <<
>  				TYPHOON_TX_PF_VLAN_TAG_SHIFT);
>  	}
> +#endif

Wouldn't it be much easier to just do

#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
static inline int  vlan_tx_tag_present(...) {
 /** get VLAN tag */
}
#else
static inline  int vlan_tx_tag_present(...) {return 0;}
#endif

in some header file?

Similiar in typhoon.c:

#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
static inline  has_vlan_group(...) {
  /* get VLAN group */
}
#else
static inline  has_vlan_group(...) {return 0;}
#endif

With this and similiar changes in the drivers, 
your patch might be less intrusive and thus more acceptable to maintainers.

Just let the compiler remove the extra code with constant folding and dead
code elemination. The result will be even cleaner code, I think.

What do you think?


Regards

Ingo Oeser
