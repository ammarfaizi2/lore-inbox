Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752033AbWKFSrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbWKFSrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbWKFSrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:47:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:42643 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752026AbWKFSrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:47:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Ff8XSgaq/Yc+jKBslZ+wjustL7DuRCZA260XQOLVcNx7NrsbJroJIsiVtCyOSBTaUCgEGM4rXGlwwRamTd3qqDtHgNQXZa9DZgexoqGWMRJa5xVLi9eNvGJmoRUFNELTv8Re/9mGnFzod968hASlgsWdNQ6fzloCqOcOBR4RnA8=
Date: Mon, 6 Nov 2006 21:46:51 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] hostap_80211_rx(): fix a use-after-free
Message-ID: <20061106184651.GA4972@martell.zuzino.mipt.ru>
References: <20061106142148.GO5778@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106142148.GO5778@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 03:21:48PM +0100, Adrian Bunk wrote:
> This patch fixes a use-after-free for "skb" spotted by the Coverity
> checker.

> --- linux-2.6/drivers/net/wireless/hostap/hostap_80211_rx.c.old
> +++ linux-2.6/drivers/net/wireless/hostap/hostap_80211_rx.c
> @@ -1004,10 +1004,10 @@ void hostap_80211_rx(struct net_device *
>  			if (local->hostapd && local->apdev) {
>  				/* Send IEEE 802.1X frames to the user
>  				 * space daemon for processing */
> -				prism2_rx_80211(local->apdev, skb, rx_stats,
> -						PRISM2_RX_MGMT);
>  				local->apdevstats.rx_packets++;
>  				local->apdevstats.rx_bytes += skb->len;
> +				prism2_rx_80211(local->apdev, skb, rx_stats,
> +						PRISM2_RX_MGMT);
>  				goto rx_exit;

Network drivers set rx_packets and rx_bytes after netif_rx. And last_rx,
too. The trick seems to be to use pkt_len variable.

