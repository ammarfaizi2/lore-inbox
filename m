Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267020AbSKWSXy>; Sat, 23 Nov 2002 13:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbSKWSXy>; Sat, 23 Nov 2002 13:23:54 -0500
Received: from ns.ithnet.com ([217.64.64.10]:39691 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267020AbSKWSXx>;
	Sat, 23 Nov 2002 13:23:53 -0500
Date: Sat, 23 Nov 2002 19:25:47 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Hard Lockup with 2.4.20-rc3 and ISDN (ippp)
Message-Id: <20021123192547.5f084d4e.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0211230908590.23257-100000@chaos.physics.uiowa.edu>
References: <20021123123322.3e6ef7c2.skraw@ithnet.com>
	<Pine.LNX.4.44.0211230908590.23257-100000@chaos.physics.uiowa.edu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2002 09:12:21 -0600 (CST)
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:

> Yup, my bad. Could you confirm that the attached patch which I sent to 
> Marcelo already fixes it?

Hello Kai, hello Marcelo,

I can confirm that below patch you sent fixes the lockup issue that came up
with rc3.

Regards,
Stephan


> -----------------------------------------------------------------------------
> ChangeSet@1.795.1.2, 2002-11-22 15:24:43-06:00, kai@tp1.ruhr-uni-bochum.de
>   ISDN: Fix the fix
>   
>   Argh, I must have been asleep or something. The original patch by Herbert
>   Xu was right, I extended it to cover more error paths and broke it in 
>   doing so. Now fixed again.
> 
>   
> ---------------------------------------------------------------------------
> 
> diff -Nru a/drivers/isdn/isdn_ppp.c b/drivers/isdn/isdn_ppp.c
> --- a/drivers/isdn/isdn_ppp.c	Fri Nov 22 15:29:42 2002
> +++ b/drivers/isdn/isdn_ppp.c	Fri Nov 22 15:29:42 2002
> @@ -1147,7 +1147,7 @@
>  		printk(KERN_ERR "isdn_ppp_xmit: lp->ppp_slot(%d)\n",
>  			mlp->ppp_slot);
>  		kfree_skb(skb);
> -		goto unlock;
> +		goto out;
>  	}
>  	ipts = ippp_table[slot];
>  
> @@ -1155,7 +1155,7 @@
>  		if (ipts->debug & 0x1)
>  			printk(KERN_INFO "%s: IP frame delayed.\n", netdev->name);
>  		retval = 1;
> -		goto unlock;
> +		goto out;
>  	}
>  
>  	switch (ntohs(skb->protocol)) {
> @@ -1169,7 +1169,7 @@
>  			printk(KERN_ERR "isdn_ppp: skipped unsupported protocol:
>  			%#x.\n", 
>  			       skb->protocol);
>  			dev_kfree_skb(skb);
> -			goto unlock;
> +			goto out;
>  	}
>  
>  	lp = isdn_net_get_locked_lp(nd);
> @@ -1336,6 +1336,7 @@
>  
>   unlock:
>  	spin_unlock_bh(&lp->xmit_lock);
> + out:
>  	return retval;
>  }
>  
