Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUHBKDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUHBKDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUHBKDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:03:42 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:30881 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S266391AbUHBKDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:03:37 -0400
Date: Mon, 2 Aug 2004 13:03:15 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <Pine.LNX.4.44.0408021234290.15888-100000@silmu.st.jyu.fi>
Message-ID: <Pine.LNX.4.44.0408021301030.17420-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Mon, 02 Aug 2004 13:03:19 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to mention that it was quite hard to crash the driver with that 
/* Clear out errors and receive interrupts */-patch. Took about 15minutes 
everytime, when normally it takes about 2mins.

On Mon, 2 Aug 2004, Pasi Sjoholm wrote:

> With both patch applied and RTL8139DEBUG = 1 I couldn't make the driver 
> crash but without DEBUG it did crash. I assume that it has something to 
> with fact that syslog did take so much io-bandwidth. (a couple of minutes log 
> was ~1GB =))
> 
> But without: 
> 
> --
> @@ -2024,17 +2024,17 @@ static int rtl8139_rx(struct net_device
> 
>                 cur_rx = (cur_rx + rx_size + 4 + 3) & ~3;
>                 RTL_W16 (RxBufPtr, (u16) (cur_rx - 16));
> +       }
> 
> -               /* Clear out errors and receive interrupts */
> -               status = RTL_R16 (IntrStatus) & RxAckBits;
> -               if (likely(status != 0)) {
> -                       if (unlikely(status & (RxFIFOOver | RxOverflow))) 
> {
> -                               tp->stats.rx_errors++;
>  -                               if (status & RxFIFOOver)
> -                                       tp->stats.rx_fifo_errors++;
> -                       }
> -                       RTL_W16_F (IntrStatus, RxAckBits);
> +       /* Clear out errors and receive interrupts */
> +       status = RTL_R16 (IntrStatus) & RxAckBits;
> +       if (likely(status != 0)) {
> +               if (unlikely(status & (RxFIFOOver | RxOverflow))) {
> +                       tp->stats.rx_errors++;
> +                       if (status & RxFIFOOver)
> +                               tp->stats.rx_fifo_errors++;
>                 }
> +               RTL_W16_F (IntrStatus, RxAckBits);
>         }
> 
>   done:
> --
> 
> the driver crashed... even with debug-option was turned on.
> Everytime the ksoftirqd started to take cpu-time there were this line in 
> the logs:

