Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270479AbTHSO5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270452AbTHSO5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:57:44 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S270448AbTHSOz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:55:57 -0400
Date: Tue, 19 Aug 2003 16:54:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Richard Underwood <richard@aspectgroup.co.uk>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'David S. Miller'" <davem@redhat.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, willy@w.ods.org,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-ID: <20030819145403.GA3407@alpha.home.local>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 19, 2003 at 03:34:43PM +0100, Richard Underwood wrote:
> 	As an example, I have a router/firewall for the office that has two
> interface cards, both with perfectly valid internal addresses - these
> addresses aren't used anywhere else on the network.
> 
> 	Two of the interfaces are: 172.20.240.2/24 and 172.24.0.1/16. My
> default gateway is 172.20.240.1 and there aren't any other non-interface
> routes. If I do:
> 
> # arp -d 172.24.0.80
> # ping -I 172.20.240.2 172.24.0.80
> 
> 	I see:
> 
> 16:18:40.856328 arp who-has 172.24.0.80 tell 172.20.240.2
> 16:18:40.856431 arp reply 172.24.0.80 is-at 0:50:da:44:f:37
> 
> 	Now, since 172.24.0.80 is a Linux box, it's happily adding
> 172.20.240.2 into its ARP table and reply to it, hence the reply.
> 
> 	But if I was to do this in the other direction (arp -d 172.20.240.1;
> ping -I 172.24.0.1 172.20.240.1) then I'd lose connectivity over my default
> route because 172.20.240.1 won't accept ARP packets from IP numbers not on
> the connected subnet. The <incomplete> ARP entry will block any further ARP
> requests from valid IP numbers.

This is exactly the case I calmly discussed privately with David then Alexey.
Both explained me that in fact, the remote host shouldn't be filtering the ARP
requests based on the source IP they provide, but agreed that it seems to be a
general trend today. Alexey proposed a slight change which can at least solve
this very common case by preventing the system from using the local address as
a source IP if it is not on the interface through which the request is sent.

Obviously it will not solve all very special cases, which people can work
around with arptables, but it will solve this common one.

Cheers,
Willy

