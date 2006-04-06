Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWDFKYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWDFKYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 06:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWDFKYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 06:24:48 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:30470 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932096AbWDFKYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 06:24:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=At1b4gV5eWoMNZsgEIphHOIeaQqsyGdsjeEC5/Pu5GbP1GBJcAsnB/rAUi6GOAtdpxuNS8RVxVcXc35ihYBai/Cn6fbf5DXJ2wOeswyZ+UpkZSslUkRidyHgjjorMyg3/+GtrKIGviz1xGcqci7k+Xeowio94zP0GEOprtlMdKs=
Date: Thu, 6 Apr 2006 12:24:31 +0200
From: Janos Farkas <chexum+dev@gmail.com>
To: David Daney <ddaney@avtrex.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       pgf@foxharp.boston.ma.us, freek@macfreek.nl
Subject: Re: Broadcast ARP packets on link local addresses (Version2).
Message-ID: <priv$efbe06144502$2d51735f79@200604.gmail.com>
Mail-Followup-To: David Daney <ddaney@avtrex.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pgf@foxharp.boston.ma.us,
	freek@macfreek.nl
References: <17460.13568.175877.44476@dl2.hq2.avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17460.13568.175877.44476@dl2.hq2.avtrex.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-04-05 at 14:22:08, David Daney wrote:
> The changes in this version are that it tests the source IP address
> instead of the destination.  The test now matches the test described
> in the RFC.  Also a small cleanup as suggested by Herbert Xu.
>
> Some comments on the first version of the patch suggested that I do
> 'X' instead.  Where 'X' was behavior different than that REQUIRED by
> the RFC (the RFC's always seem to capitalize the word 'required').
>
> The reason that I implemented the behavior required by the RFC is so
> that a device running the kernel can pass compliance tests that
> mandate RFC compliance.

Sorry for chiming in this late in the discussion, but...  Shouldn't it
be more correct to not depend on the ip address of the used network,
but to use the "scope" parameter of the given address?

Example

# ip ad sh
...
N: eth0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether ...
    inet 169.254.3.3/16 brd 169.254.255.255 scope link eth0
    inet ... scope global eth0

The only drawback is that the scope is usually set manually, and maybe
some tools don't handle it right now, since it's available since just a
few years :)  Scopes, when set right, also may do some appropriate
magic, as I understand, like selecting the correct the source address,
and not allowing link-local addresses to reach out to other scopes.
(Which is also mentioned in the RFC, but this strictness prevent
transparent NAT of clients to the internet.)

I did not look however, whether the scope is available on the place the
patch is modifying currently.  Does the idea look sane to anyone else?

> +        /* If link local address (169.254.0.0/16) we must broadcast
> +         * the ARP packet.  See RFC 3927 section 2.5 for details. */
> +     if ((src_ip & htonl(0xFFFF0000UL)) == htonl(0xA9FE0000UL))
> +             dest_hw = NULL;

Janos
