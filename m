Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266153AbUGOJPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUGOJPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 05:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUGOJPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 05:15:15 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:33284 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266153AbUGOJO5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 05:14:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Adrian Bunk <bunk@fs.tum.de>, cramerj@intel.com, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com
Subject: Re: [2.6 patch] e1000_main.c: fix inline compile errors
Date: Thu, 15 Jul 2004 12:13:59 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20040714210121.GN7308@fs.tum.de>
In-Reply-To: <20040714210121.GN7308@fs.tum.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200407151213.59568.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 July 2004 00:01, Adrian Bunk wrote:
>  /**
> + * e1000_rx_checksum - Receive Checksum Offload for 82543
> + * @adapter: board private structure
> + * @rx_desc: receive descriptor
> + * @sk_buff: socket buffer with received data
> + **/
> +
> +static inline void
> +e1000_rx_checksum(struct e1000_adapter *adapter,
> +                  struct e1000_rx_desc *rx_desc,
> +                  struct sk_buff *skb)
> +{
> +	/* 82543 or newer only */
> +	if((adapter->hw.mac_type < e1000_82543) ||
> +	/* Ignore Checksum bit is set */
> +	(rx_desc->status & E1000_RXD_STAT_IXSM) ||
> +	/* TCP Checksum has not been calculated */
> +	(!(rx_desc->status & E1000_RXD_STAT_TCPCS))) {
> +		skb->ip_summed = CHECKSUM_NONE;
> +		return;
> +	}
> +
> +	/* At this point we know the hardware did the TCP checksum */
> +	/* now look at the TCP checksum error bit */
> +	if(rx_desc->errors & E1000_RXD_ERR_TCPE) {
> +		/* let the stack verify checksum errors */
> +		skb->ip_summed = CHECKSUM_NONE;
> +		adapter->hw_csum_err++;
> +	} else {
> +	/* TCP checksum is good */
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		adapter->hw_csum_good++;
> +	}
> +}
> +
> +/**
>   * e1000_clean_rx_irq - Send received data up the network stack,
>   * @adapter: board private structure
>   **/

As you go thru them, consider removing inline keyword for
such large functions.


> @@ -2580,41 +2616,6 @@
>  	return E1000_SUCCESS;
>  }
>
> -/**
> - * e1000_rx_checksum - Receive Checksum Offload for 82543
> - * @adapter: board private structure
> - * @rx_desc: receive descriptor
> - * @sk_buff: socket buffer with received data
> - **/
> -
> -static inline void
> -e1000_rx_checksum(struct e1000_adapter *adapter,
> -                  struct e1000_rx_desc *rx_desc,
> -                  struct sk_buff *skb)
> -{
> -	/* 82543 or newer only */
> -	if((adapter->hw.mac_type < e1000_82543) ||
> -	/* Ignore Checksum bit is set */
> -	(rx_desc->status & E1000_RXD_STAT_IXSM) ||
> -	/* TCP Checksum has not been calculated */
> -	(!(rx_desc->status & E1000_RXD_STAT_TCPCS))) {
> -		skb->ip_summed = CHECKSUM_NONE;
> -		return;
> -	}
> -
> -	/* At this point we know the hardware did the TCP checksum */
> -	/* now look at the TCP checksum error bit */
> -	if(rx_desc->errors & E1000_RXD_ERR_TCPE) {
> -		/* let the stack verify checksum errors */
> -		skb->ip_summed = CHECKSUM_NONE;
> -		adapter->hw_csum_err++;
> -	} else {
> -	/* TCP checksum is good */
> -		skb->ip_summed = CHECKSUM_UNNECESSARY;
> -		adapter->hw_csum_good++;
> -	}
> -}
> -

--
vda
