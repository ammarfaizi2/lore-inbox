Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275852AbRJaXmx>; Wed, 31 Oct 2001 18:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRJaXmo>; Wed, 31 Oct 2001 18:42:44 -0500
Received: from c1419467-a.sttln1.wa.home.com ([65.4.225.76]:896 "EHLO
	zarathustra.saavie.org") by vger.kernel.org with ESMTP
	id <S275852AbRJaXma>; Wed, 31 Oct 2001 18:42:30 -0500
Date: Wed, 31 Oct 2001 15:43:08 -0800
From: Neil Spring <nspring@zarathustra.saavie.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP ECN bits and TCP_RESERVED_BITS macro
Message-ID: <20011031154305.A11081@cs.washington.edu>
In-Reply-To: <20011031152717.A25584@morinfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011031152717.A25584@morinfr.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The line in your patch:

> -#define TCP_HP_BITS (~(TCP_RESERVED_BITS|TCP_FLAG_PSH)|TCP_FLAG_ECE|TCP_FLAG_CWR)
> +#define TCP_HP_BITS (~(TCP_RESERVED_BITS|TCP_FLAG_PSH))

is, I believe, a very bad idea.  This preprocessor constant
is used so that exceptional ECN processing (to handle ECE
or CWR) can be done on the slow path.  This change would
almost certainly break Linux's ECN implementation.

> 2) netfilter: 

I see no "2" patch to netfilter code.

-neil


On Wed, Oct 31, 2001 at 03:27:17PM +0100, Guillaume Morin wrote:
> Hi folks,
> 
> As most people here know, RFC3168 adds two new bits to the TCP header
> (ECE and CWR). Those were reserved in RFC793 (standard for TCP).
> 
> Since RFC3168 is an proposed standard and ECN is now used widely on
> Linux systems, I'd like to suggest the modification of the
> TCP_RESERVED_BITS. This change seems logical wrt
> 
> include/linux/tcp.h the tcphdr struct :
>     __u16   doff:4,
> 	        res1:4,
> 	        cwr:1,  
> 	        ece:1,
> 
> This change is pretty harmless, since, this macro is used in
> 
> 1) include/net/tcp_ecn.h. I've patched the related part even if it would
> have work without. It is just cleaner.
> 
> 2) netfilter: 
>  - in the LOG target, it won't break them. I'll submit patches
>    to netfilter-devel to display TCP ECN bits just like any other TCP flags
>    (which will ease the LOG readings)
>  - In the unclean target where the current value breaks the module.
> 
> Patch against 2.4.14-pre6
> 
> 
> diff -uNr linux/include/linux/tcp.h linux-new-tcprb/include/linux/tcp.h
> --- linux/include/linux/tcp.h	Sat Apr 28 00:48:20 2001
> +++ linux-new-tcprb/include/linux/tcp.h	Wed Oct 31 14:51:40 2001
> @@ -110,7 +110,7 @@
>  	TCP_FLAG_RST = __constant_htonl(0x00040000), 
>  	TCP_FLAG_SYN = __constant_htonl(0x00020000), 
>  	TCP_FLAG_FIN = __constant_htonl(0x00010000),
> -	TCP_RESERVED_BITS = __constant_htonl(0x0FC00000),
> +	TCP_RESERVED_BITS = __constant_htonl(0x0F000000),
>  	TCP_DATA_OFFSET = __constant_htonl(0xF0000000)
>  }; 
>  
> diff -uNr linux/include/net/tcp_ecn.h linux-new-tcprb/include/net/tcp_ecn.h
> --- linux/include/net/tcp_ecn.h	Wed Oct 31 14:57:53 2001
> +++ linux-new-tcprb/include/net/tcp_ecn.h	Wed Oct 31 14:50:46 2001
> @@ -3,7 +3,7 @@
>  
>  #include <net/inet_ecn.h>
>  
> -#define TCP_HP_BITS (~(TCP_RESERVED_BITS|TCP_FLAG_PSH)|TCP_FLAG_ECE|TCP_FLAG_CWR)
> +#define TCP_HP_BITS (~(TCP_RESERVED_BITS|TCP_FLAG_PSH))
>  
>  #define	TCP_ECN_OK		1
>  #define TCP_ECN_QUEUE_CWR	2
> 
> 
> All comments welcome.
> 
> -- 
> Guillaume Morin <guillaume@morinfr.org>
> 
>          Do you worry that you're not liked ? How long till you break
>                                 (Our Lady Peace)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
