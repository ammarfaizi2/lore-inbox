Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWDTNLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWDTNLa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDTNLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:11:30 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:25319 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750908AbWDTNL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:11:29 -0400
Date: Thu, 20 Apr 2006 15:11:22 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: borntrae@de.ibm.com, akpm@osdl.org, shemminger@osdl.org, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       fpavlic@de.ibm.com, davem@sunset.davemloft.net
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
Message-ID: <20060420131122.GB9452@osiris.boeblingen.de.ibm.com>
References: <20060408100213.GA9412@osiris.boeblingen.de.ibm.com> <20060408031235.5d1989df.akpm@osdl.org> <200604191245.48458.borntrae@de.ibm.com> <20060419.131237.49371772.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419.131237.49371772.davem@davemloft.net>
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As spinlock debugging still does not work with the qeth driver I
> > want to pick up the discussion.
> 
> Does something like the patch below work?
> 
> But this all begs the question, what happens if you want to
> dig into the internals of a protocol which is built modular and
> hasn't been loaded yet?
> 
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 93dcbe1..8169f25 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -95,8 +95,9 @@ #define postcore_initcall(fn)		__define_
>  #define arch_initcall(fn)		__define_initcall("3",fn)
>  #define subsys_initcall(fn)		__define_initcall("4",fn)
>  #define fs_initcall(fn)			__define_initcall("5",fn)
> -#define device_initcall(fn)		__define_initcall("6",fn)
> -#define late_initcall(fn)		__define_initcall("7",fn)
> +#define net_initcall(fn)		__define_initcall("6",fn)
> +#define device_initcall(fn)		__define_initcall("7",fn)
> +#define late_initcall(fn)		__define_initcall("8",fn)
>  
>  #define __initcall(fn) device_initcall(fn)
>  
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index dc206f1..9803a57 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1257,7 +1257,7 @@ out_unregister_udp_proto:
>  	goto out;
>  }
>  
> -module_init(inet_init);
> +net_initcall(inet_init);

That's exactly the same thing that I tried to. It didn't work for me since I
saw "sometimes" the described rcu_update latencies.
Today I was able to boot the machine 30 times and just saw it once... Not very
helpful for debugging this :(
Btw.: I guess the linker scripts need an update too, so that the new
.initcall8.init section doesn't get discarded.
