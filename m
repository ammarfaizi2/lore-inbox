Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751754AbWEaR1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWEaR1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 13:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWEaR1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 13:27:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751752AbWEaR1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 13:27:07 -0400
Date: Wed, 31 May 2006 10:26:49 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Amnon Aaronsohn <bla@cs.huji.ac.il>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't automatically drop packets from 0.0.0.0/8
Message-ID: <20060531102649.652f24b5@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.56.0605311958070.8718@duke.cs.huji.ac.il>
References: <Pine.LNX.4.56.0605311958070.8718@duke.cs.huji.ac.il>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 20:07:34 +0300 (IDT)
Amnon Aaronsohn <bla@cs.huji.ac.il> wrote:

> For some reason linux drops all incoming packets which have a source
> address in the 0.0.0.0/8 range, although these are valid addresses. The
> attached patch fixes this. (It still drops packets coming from 0.0.0.0
> since that's a special address.)
> 
> Signed-off-by: Amnon Aaronsohn <bla@cs.huji.ac.il>
> ---
> 
> --- linux-2.6.16.18/net/ipv4/route.c.old	2006-05-30 08:57:42.000000000 +0300
> +++ linux-2.6.16.18/net/ipv4/route.c	2006-05-30 08:58:22.000000000 +0300
> @@ -1935,7 +1935,7 @@ static int ip_route_input_slow(struct sk
>  	/* Accept zero addresses only to limited broadcast;
>  	 * I even do not know to fix it or not. Waiting for complains :-)
>  	 */
> -	if (ZERONET(saddr))
> +	if (saddr == 0)
>  		goto martian_source;
> 
>  	if (BADCLASS(daddr) || ZERONET(daddr) || LOOPBACK(daddr))

Per RFC1122:
           (a)  { 0, 0 }

                 This host on this network.  MUST NOT be sent, except as
                 a source address as part of an initialization procedure
                 by which the host learns its own IP address.

                 See also Section 3.3.6 for a non-standard use of {0,0}.

            (b)  { 0, <Host-number> }

                 Specified host on this network.  It MUST NOT be sent,
                 except as a source address as part of an initialization
                 procedure by which the host learns its full IP address.

So it looks like existing code is correct in dropping packets. Net zero
is intended only for protocols like BOOTP broadcasts.
