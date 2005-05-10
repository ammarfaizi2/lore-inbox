Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVEJQ0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVEJQ0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 12:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVEJQ0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 12:26:05 -0400
Received: from apollo.nswebhost.com ([72.9.237.194]:6841 "EHLO
	apollo.nswebhost.com") by vger.kernel.org with ESMTP
	id S261698AbVEJQZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 12:25:56 -0400
MIME-Version: 1.0
Date: Tue, 10 May 2005 17:23:13 +0100
To: james.harper@bendigoit.com.au
Subject: Re: [PATCH] 2.6.11 fix PROMISC/bridging in TLAN driver
Content-Type: text/plain; charset=iso-8859-15; format=flowed
cc: linux-kernel@vger.kernel.org
From: Ian Eperson <ian.eperson@dedf.co.uk>
Organization: DeDf Co
Message-ID: <opsqkigzqeav32i4@mail.dedf.co.uk>
User-Agent: Opera7.03/Win32 M2 build 2670
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - apollo.nswebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dedf.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I'm re-sending this in the hope that someone will pick it up. I have made several attempts to contact the maintainer without success, although none recently.
>
> This has been a problem for me for ages. When using bridging, the driver is switched into promiscuous mode before the link init is complete. The init complete routine then resets the promisc bit on the card so the kernel still thinks the card is in promiscuous mode but the card isn't. doh.
>
> I think this bug only shows up in bridging when the bridge is started at boot time (or something else that sets promisc at the same time the card was started). If promisc is enabled later it works.
>
> Here's a trivial (and hopefully correct) patch that works for me. It just calls the promisc/multicast setup routine after init.
>
> James
>
>
> --- linux/drivers/net/tlan.c 2004-07-05 12:10:31.000000000 +1000 +++ linux-2.4.26-xen0/drivers/net/tlan.c 2004-07-05 11:43:48.000000000 +1000 @@ -2378,6 +2378,7 @@                 TLan_SetTimer( dev, (10*HZ), TLAN_TIMER_FINISH_RESET );                 return;         } + TLan_SetMulticastList(dev);
>
>  } /* TLan_FinishReset */
>
> -
James

My understanding of the operation of the TLAN interface is:

	The driver is initiated and starts autonegotiation (TLan_PhyStartLink).

	At some point later autonegotiation completes (TLan_PhyFinishAutoNeg) and the link becomes active (TLan_FinishReset).

	In TLan_FinishReset TLAN_NET_CMD is set based on TLAN_NET_CMD_NRESET, TLAN_NET_CMD_NWRAP and whether the link is half/full duplex.

	The TLAN_NET_CMD in TLan_FinishReset does not take account of the original state of TLAN_NET_CMD in particular the state of TLAN_NET_CMD_CAF.

This means that if the interface is set to promiscuous mode during the time between initiation and the completion of autonegotiation, the interface will revert to non-promiscuous mode when the link becomes active.

Similarly if autonegotiation restarts (cable disconnected, network goes down) and then the link becomes active again, the promiscuous setting will be lost.

As you say, the problem manifests itself if the ethernet bridging module is being used and is initiated as part of the kernel start up process since bridging operation requires all of the slave interfaces to operate in promiscuous mode.

To solve this problem I think that the TLAN_NET_CMD setting in TLan_FinishReset should depend on the promiscuous flag.  The first few lines of TLan_FinishReset should become something like:

        phy = priv->phy[priv->phyNum];

        data = TLAN_NET_CMD_NRESET | TLAN_NET_CMD_NWRAP;
        if ( priv->tlanFullDuplex ) {
                data |= TLAN_NET_CMD_DUPLEX;
        }
        if ( dev->flags & IFF_PROMISC ) {		/* new test for promiscuous flag */
                data |= TLAN_NET_CMD_CAF;		/* OR in tlans's promiscuity mode bit */
        }
        TLan_DioWrite8( dev->base_addr, TLAN_NET_CMD, data );

Regards



Ian

 
