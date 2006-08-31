Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWHaXp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWHaXp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWHaXp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:45:29 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:5303
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932486AbWHaXp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:45:28 -0400
Subject: Re: [Patch] Uninitialized variable in drivers/net/wan/syncppp.c
From: Paul Fulghum <paulkf@microgate.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1157066002.13592.3.camel@alice>
References: <1157066002.13592.3.camel@alice>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 18:45:13 -0500
Message-Id: <1157067913.2634.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 01:13 +0200, Eric Sesterhenn wrote:

> --- linux-2.6.18-rc5/drivers/net/wan/syncppp.c.orig	2006-09-01 00:55:08.000000000 +0200
> +++ linux-2.6.18-rc5/drivers/net/wan/syncppp.c	2006-09-01 00:55:45.000000000 +0200
> @@ -505,14 +505,15 @@ static void sppp_lcp_input (struct sppp 
>  			skb->len, h);
>  		break;
>  	case LCP_CONF_REQ:
> -		if (len < 4) {
> +		if (len <= 4) {
>  			if (sp->pp_flags & PP_DEBUG)
>  				printk (KERN_DEBUG"%s: invalid lcp configure request packet length: %d bytes\n",
>  					dev->name, len);
>  			break;
>  		}
> -		if (len>4 && !sppp_lcp_conf_parse_options (sp, h, len, &rmagic))
> +		if (!sppp_lcp_conf_parse_options (sp, h, len, &rmagic))
>  			goto badreq;
> +
>  		if (rmagic == sp->lcp.magic) {
>  			/* Local and remote magics equal -- loopback? */
>  			if (sp->pp_loopcnt >= MAXALIVECNT*5) {

This is not correct.

>From RFC1661:
Valid LCP configuration requests can have zero options (len == 4).
If the magic number option is not included in the LCP CFG REQ,
then the magic number should be treated as zero.

The correct fix is to initialize rmagic to zero before
the if (len>4 && !sppp_lcp_conf_parse_options()) line.

--
Paul


