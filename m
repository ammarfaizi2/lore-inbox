Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbSISNTR>; Thu, 19 Sep 2002 09:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268110AbSISNTR>; Thu, 19 Sep 2002 09:19:17 -0400
Received: from dsl093-058-082.blt1.dsl.speakeasy.net ([66.93.58.82]:26100 "EHLO
	beohost.scyld.com") by vger.kernel.org with ESMTP
	id <S268100AbSISNTM>; Thu, 19 Sep 2002 09:19:12 -0400
Date: Thu, 19 Sep 2002 09:23:58 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: netdev@oss.sgi.com, Jason Lunz <lunz@falooley.org>,
       Richard Gooch <rgooch@ras.ucalgary.ca>,
       "Patrick R. McManus" <mcmanus@ducksong.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.20-pre sundance.c update
In-Reply-To: <3D89519C.1020809@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0209190903050.29420-100000@beohost.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Jeff Garzik wrote:

> Attached is the patch I have against 2.4.20-pre-latest, to start fixing 
> from as a baseline.

diff -Nru a/drivers/net/sundance.c b/drivers/net/sundance.c
> --- a/drivers/net/sundance.c	Thu Sep 19 00:22:26 2002
> +++ b/drivers/net/sundance.c	Thu Sep 19 00:22:26 2002
...
>  /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
> -static int max_interrupt_work = 30;
> +static int max_interrupt_work = 0;

Please don't change the semantics of module parameters.  All of my PCI
network drivers have used this name for years with the same semantics.
Arbitrarily changing is A Bad Thing.

> static int mtu;

Get rid of this.  See the MTU setting code in my driver release.

>     bonding and packet priority, and more than 128 requires modifying the
>     Tx error recovery.
>     Large receive rings merely waste memory. */
> -#define TX_RING_SIZE	16
> -#define TX_QUEUE_LEN	10		/* Limit ring entries actually used.  */
> -#define RX_RING_SIZE	32
> +#define TX_RING_SIZE	64
> +#define TX_QUEUE_LEN	(TX_RING_SIZE - 1) /* Limit ring entries actually used.  */

Did you miss reading the comment?  A Tx ring size of 64 is a bad idea.
Increasing the Rx ring size is fine, considering that most current
machines have plenty of memory and the kernel hasn't always been good
about keeping skbuffs available.

+MODULE_PARM(flowctrl, "i");

Flow control should be negotiated, not set.

> -	TxThreshold = 0x3c,
> +	TxStartThresh = 0x3c,
> +	RxEarlyThresh = 0x3e,

[[ Many other name changes omitted ]]

Why change the symbolic names for the registers?

> 	/* Frequently used values: keep some adjacent for cache effect. */
> 	spinlock_t lock;
> +	spinlock_t rx_lock;					/* Group with Tx control cache line. */

Uhmmm, again, read the comment.  This comment was originally with the
'txlock' variable

 	} else if (dev->mc_count) {
 		struct dev_mc_list *mclist;
-		memset(mc_filter, 0, sizeof(mc_filter));
+		int bit;
+		int index;
+		int crc;
+		memset (mc_filter, 0, sizeof (mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
-			 i++, mclist = mclist->next) {
-			set_bit(ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x3f,
-					mc_filter);
+		     i++, mclist = mclist->next) {
+			crc = ether_crc_le (ETH_ALEN, mclist->dmi_addr);
+			for (index=0, bit=0; bit < 6; bit++, crc <<= 1)
+				if (crc & 0x80000000) index |= 1 << bit;
+			mc_filter[index/16] |= (1 << (index % 16));
 		}

Uhhmmm, perhaps calling a function to do the wrong-endian CRC and then
bit-reversing the result is not an improved way to do this?  That's why
there needs to be two Ethernet CRC functions -- so that you don't
need to bit bit-reverse the result.


-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

