Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbTBBK4z>; Sun, 2 Feb 2003 05:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTBBK4z>; Sun, 2 Feb 2003 05:56:55 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49884 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265177AbTBBK4y>; Sun, 2 Feb 2003 05:56:54 -0500
Date: Sun, 2 Feb 2003 12:06:17 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
Message-ID: <20030202110617.GJ6915@fs.tum.de>
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 01:44:49AM -0200, Marcelo Tosatti wrote:

>...
> Summary of changes from v2.4.21-pre3 to v2.4.21-pre4
> ============================================
>...
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>...
>   o fix packet padding on the 3c523
>...

This causes the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.20-full/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=3c523  -c -o 3c523.o 3c523.c
3c523.c:1128: macro `memset' used with just one arg
3c523.c: In function `elmc_send_packet':
3c523.c:1128: parse error before `)'
3c523.c:1128: structure has no member named `xmit'
3c523.c:1128: parse error before `)'
3c523.c:1128: parse error before `)'
3c523.c:1128: parse error before `)'
3c523.c:1128: warning: left-hand operand of comma expression has no effect
3c523.c:1128: warning: left-hand operand of comma expression has no effect
3c523.c:1128: parse error before `:'
make[3]: *** [3c523.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.20-full/drivers/net'

<--  snip  -->


The simple fix (stolen from -ac) is:

--- linux.21pre4/drivers/net/3c523.c	2003-01-29 17:07:45.000000000 +0000
+++ linux.21pre4-ac1/drivers/net/3c523.c	2003-01-09 00:47:04.000000000 +0000
@@ -1125,7 +1125,7 @@
 	len = (ETH_ZLEN < skb->len) ? skb->len : ETH_ZLEN;
 	
 	if(len != skb->len)
-		memset((char *) p->xmit_cbuffs[p->xmit)count], 0, ETH_ZLEN);
+		memset((char *) p->xmit_cbuffs[p->xmit_count], 0, ETH_ZLEN);
 	memcpy((char *) p->xmit_cbuffs[p->xmit_count], (char *) (skb->data), skb->len);
 
 #if (NUM_XMIT_BUFFS == 1)



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

