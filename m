Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262200AbSJISPQ>; Wed, 9 Oct 2002 14:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSJISPQ>; Wed, 9 Oct 2002 14:15:16 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:26066 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262200AbSJISPO>;
	Wed, 9 Oct 2002 14:15:14 -0400
Message-ID: <3DA4735A.4020402@candelatech.com>
Date: Wed, 09 Oct 2002 11:20:10 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Looking for testers with these NICs
References: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua> <20021009171452.GA9682@www.kroptech.com> <200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On 9 October 2002 15:14, Adam Kropelin wrote:
> 
>>On Wed, Oct 09, 2002 at 07:31:17PM -0200, Denis Vlasenko wrote:
>>
>>>ewrk3.c
>>
>>I've got a few of these laying around. Send whatever patches you want
>>tested and I'll give it a shot.
> 
> 
> Please do your best in trying to break it, especially since you say you have
> more than one. Can you plug them all in one box?
> 
> I'd suggest SMP/preempt heavy IO. Is there stress test software for NICs?
> What is pktgen?

pktgen will definately stress the nics.  Try sending to yourself
as well so you can test the pkt receive code..it's normally the weakest.

Ben

> --
> vda
> 
> diff -u --recursive linux-2.5.40org/drivers/net/ewrk3.c linux-2.5.40/drivers/net/ewrk3.c
> --- linux-2.5.40org/drivers/net/ewrk3.c	Tue Oct  1 05:06:58 2002
> +++ linux-2.5.40/drivers/net/ewrk3.c	Thu Oct  3 12:09:46 2002
> @@ -930,6 +930,7 @@
>  	spin_unlock(&lp->hw_lock);
>  }
> 
> +/* Called with lp->hw_lock held */
>  static int ewrk3_rx(struct net_device *dev)
>  {
>  	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
> @@ -1055,8 +1056,9 @@
>  }
> 
>  /*
> -   ** Buffer sent - check for TX buffer errors.
> - */
> +** Buffer sent - check for TX buffer errors.
> +** Called with lp->hw_lock held
> +*/
>  static int ewrk3_tx(struct net_device *dev)
>  {
>  	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
> @@ -1631,6 +1633,7 @@
>  	u_long iobase = dev->base_addr;
>  	int i, j, status = 0;
>  	u_char csr;
> +	unsigned long flags;
>  	union ewrk3_addr {
>  		u_char addr[HASH_TABLE_LEN * ETH_ALEN];
>  		u_short val[(HASH_TABLE_LEN * ETH_ALEN) >> 1];
> @@ -1745,19 +1748,26 @@
>  		}
> 
>  		break;
> -	case EWRK3_GET_STATS:	/* Get the driver statistics */
> -		cli();
> -		ioc->len = sizeof(lp->pktStats);
> -		if (copy_to_user(ioc->data, &lp->pktStats, ioc->len))
> -			status = -EFAULT;
> -		sti();
> +	case EWRK3_GET_STATS: { /* Get the driver statistics */
> +		typeof(lp->pktStats) *tmp_stats =
> +        		kmalloc(sizeof(lp->pktStats), GFP_KERNEL);
> +		if (!tmp_stats) return -ENOMEM;
> +
> +		spin_lock_irqsave(&lp->hw_lock, flags);
> +		memcpy(tmp_stats, &lp->pktStats, sizeof(lp->pktStats));
> +		spin_unlock_irqrestore(&lp->hw_lock, flags);
> 
> +		ioc->len = sizeof(lp->pktStats);
> +		if (copy_to_user(ioc->data, tmp_stats, sizeof(lp->pktStats)))
> +    			status = -EFAULT;
> +		kfree(tmp_stats);
>  		break;
> +	}
>  	case EWRK3_CLR_STATS:	/* Zero out the driver statistics */
>  		if (capable(CAP_NET_ADMIN)) {
> -			cli();
> +			spin_lock_irqsave(&lp->hw_lock, flags);
>  			memset(&lp->pktStats, 0, sizeof(lp->pktStats));
> -			sti();
> +			spin_unlock_irqrestore(&lp->hw_lock,flags);
>  		} else {
>  			status = -EPERM;
>  		}
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


