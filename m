Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268582AbRG3NES>; Mon, 30 Jul 2001 09:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268584AbRG3NEJ>; Mon, 30 Jul 2001 09:04:09 -0400
Received: from netcore.fi ([193.94.160.1]:53777 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S268582AbRG3NDt>;
	Mon, 30 Jul 2001 09:03:49 -0400
Date: Mon, 30 Jul 2001 16:03:40 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: <kuznet@ms2.inr.ac.ru>
cc: <therapy@endorphin.org>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>, Dave Miller <davem@redhat.com>
Subject: Re: missing icmp errors for udp packets
In-Reply-To: <200107291559.TAA15413@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0107301552230.10196-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 29 Jul 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > So in conclusion:
> >
> > with net.ipv4.icmp_echoreply_rate=0:
>
> Congratulations! That's why I do not see this, forgot to ping before. :-)
>
> The patch is enclosed.

Alexey, there is a tiny problem with your patch.

If you reboot the computer, the _first_ ping/scan attempt will not return
icmp dest unreachable.  All of the rest do.  If the network was quiet
enough, I guess there might be some circumstances where this could be
applicable again..


> --- ../dust/vger3-010728/linux/net/ipv4/icmp.c	Thu Jun 14 22:49:44 2001
> +++ linux/net/ipv4/icmp.c	Sun Jul 29 19:52:55 2001
> @@ -240,12 +240,15 @@
>  int xrlim_allow(struct dst_entry *dst, int timeout)
>  {
>  	unsigned long now;
> +	static int burst;
>
>  	now = jiffies;
>  	dst->rate_tokens += now - dst->rate_last;
>  	dst->rate_last = now;
> -	if (dst->rate_tokens > XRLIM_BURST_FACTOR*timeout)
> -		dst->rate_tokens = XRLIM_BURST_FACTOR*timeout;
> +	if (burst < XRLIM_BURST_FACTOR*timeout)
> +		burst = XRLIM_BURST_FACTOR*timeout;
> +	if (dst->rate_tokens > burst)
> +		dst->rate_tokens = burst;
>  	if (dst->rate_tokens >= timeout) {
>  		dst->rate_tokens -= timeout;
>  		return 1;
>

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords


