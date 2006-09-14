Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWINJwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWINJwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 05:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWINJwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 05:52:10 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:49422 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1751517AbWINJwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 05:52:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAEfBCEWLawIN
X-IronPort-AV: i="4.09,163,1157320800"; 
   d="scan'208"; a="3063102:sNHT35506048"
Date: Thu, 14 Sep 2006 11:52:05 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Philip Craig <philipc@snapgear.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
       Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH] EtherIP tunnel driver (RFC 3378)
Message-ID: <20060914095205.GA23405@zlug.org>
References: <20060911204129.GA28929@zlug.org> <4508AE92.1090202@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4508AE92.1090202@snapgear.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 11:21:22AM +1000, Philip Craig wrote:
> Joerg Roedel wrote:
> > +	 To configure tunnels an extra tool is required. You can download
> > +	 it from http://zlug.fh-zwickau.de/~joro/projects/ under the
> > +	 EtherIP section. If unsure, say N.
> 
> To obtain a list of tunnels, this tool calls SIOCGETTUNNEL
> (SIOCDEVPRIVATE + 0) for every device in /proc/net/dev. I don't think
> this is safe, but I don't have a solution for you.

You are right. But this is the way the ipip driver does it. In the case
of ipip it is safe, because it is visible as a tunnel interface to
userspace. But my driver registers its devices as Ethernet (it has to,
otherwise the devices will not be usable in a bridge). There is no safe
way to distinguish between real Ethernet devices and devices registered
by my driver. I think about implementing an ioctl to fetch a list of
all EtherIP tunnel devices from the driver.

> Is there a reason why you have a separate tool rather than modifying
> iproute2?

I wrote an own tool for testing. At development I wanted to concentrate
on the driver and not how to modify iproute2. But when the driver
becomes stable and may be included I will add it to iproute2.

> I don't know if you are aware of this older etherip patch by Lennert
> Buytenhek: http://www.wantstofly.org/~buytenh/etherip/

I found this patch after I wrote my own and read the discussions
about it. The patch by Lennert Buytenhek has the same problem of
identifing tunnel devices. Futhermore, his driver handles ICMP and cares
about the payload of the Ethernet packet it transmits (it looks, if the
payload ist IPv4 or IPv6). Further it is configurable to set the DF flag
in outgoing packets. First I think the handling of layer 3 protocols is
beyond the scope of tunnel which transmits layer 2 packets. Second this
behavior may break the transport of non-IP payload in the Ethernet
packets since the Ethernet payload protocol may not know the concept of
a path MTU and needs the full Ethernet MTU of 1500. This is the reason
my driver never sets the DF flag in outgoing packets.

Regards,
	Joerg Roedel
